import io
import sqlite3
import os
import sys

import numpy as np
import torch
import torch.nn.functional as F
from PIL import Image
from torch.utils.data import DataLoader, Dataset
from transformers import CLIPModel, CLIPProcessor

datasets = [ "mtg" ]
combined_dataset_filename = "dataset.db"
training_csv_filename = "training.csv"
clean = True

# Model used to generate the image embeddings stored alongside each card for image-to-image matching
embedding_model = "openai/clip-vit-base-patch32"
embedding_model_path = "models/clip-vit-base-patch32"
embedding_batch_size = 512
embedding_num_workers = 16

def ResizeImage(image):
    # Fill transparent corners with a solid background
    if (image.mode in ("RGBA", "LA", "P")):
        image = image.convert("RGBA")
        background = Image.new("RGB", image.size, (0, 0, 0))
        background.paste(image, mask=image.getchannel("A"))
        image = background
    else:
        image = image.convert("RGB")

    return image.resize((224, 224), Image.Resampling.LANCZOS)

class EmbeddingImages(Dataset):
    def __init__(self, paths, processor):
        self.paths = paths
        self.processor = processor

    def __len__(self):
        return len(self.paths)

    def __getitem__(self, idx):
        image = ResizeImage(Image.open(self.paths[idx]))
        return self.processor(images=image, return_tensors="pt")["pixel_values"][0]

# Generates a normalized float16 embedding for every card face and stores them as blobs in the cards table
def GenerateEmbeddings(db):
    device = "cuda" if torch.cuda.is_available() else "cpu"
    dtype = torch.float16 if device == "cuda" else torch.float32
    model = CLIPModel.from_pretrained(embedding_model_path, local_files_only=True).to(device, dtype).eval()
    processor = CLIPProcessor.from_pretrained(embedding_model_path, local_files_only=True)

    faces = []
    for card_id, front_image_path, back_image_path in db.execute("SELECT id, front_image_path, back_image_path FROM cards"):
        if (front_image_path != ""):
            faces.append((card_id, "front_embedding", front_image_path))
        if (back_image_path != ""):
            faces.append((card_id, "back_embedding", back_image_path))

    # "fork" is set explicitly as newer Python versions default to "forkserver",
    # which would re-run this whole script in every worker.
    loader = DataLoader(
        EmbeddingImages([face[2] for face in faces], processor),
        batch_size=embedding_batch_size,
        num_workers=embedding_num_workers,
        multiprocessing_context="fork"
    )

    embeddings = []
    with torch.no_grad():
        for batch in loader:
            output = model.get_image_features(pixel_values=batch.to(device, dtype))
            output = output if isinstance(output, torch.Tensor) else output.pooler_output
            embeddings.extend(F.normalize(output.float(), dim=-1).cpu().numpy().astype("<f2"))
            print(f"\rEmbedding images {len(embeddings)}/{len(faces)}", end="")
    print()

    for column in ("front_embedding", "back_embedding"):
        db.executemany(
            f"UPDATE cards SET {column}=? WHERE id=?",
            [ (embedding.tobytes(), face[0]) for face, embedding in zip(faces, embeddings) if face[1] == column ]
        )

    db.execute("CREATE TABLE IF NOT EXISTS metadata(key PRIMARY KEY, value)")
    db.executemany("INSERT OR REPLACE INTO metadata VALUES(?, ?)", [
        ("embedding_model", embedding_model),
        ("embedding_dim", str(len(embeddings[0]))),
        ("embedding_dtype", "float16")
    ])
    db.commit()

build_combined = False
if (os.path.exists(combined_dataset_filename)):
    if (clean):
        os.remove(combined_dataset_filename)
        build_combined = True
else:
    build_combined = True

if (build_combined):
    print("Building combined dataset ...")
    db = sqlite3.connect(":memory:")
    db.execute("CREATE TABLE IF NOT EXISTS cards(id, dataset, name, front_image_path, back_image_path, data_url, front_embedding, back_embedding)")
    db.execute("CREATE UNIQUE INDEX IF NOT EXISTS 'card_id_index' ON 'cards' ('id' ASC)")

    for dataset_name in datasets:
        filename = f"./datasets/{dataset_name}/dataset.db"
        if (not os.path.exists(filename)):
            print(f"Expected dataset not found: {filename}")
            sys.exit(0)

        print(f"+ {dataset_name}")

        dataset_dir = f"datasets/{dataset_name}"

        dataset_db = sqlite3.connect(filename)
        res = dataset_db.execute("SELECT id, name, front_image_path, back_image_path, data_url FROM cards")

        while (True):
            card = res.fetchone()
            if (card is None):
                break

            front_image_path = (dataset_dir + "/" + card[2]) if card[2] != "" else ""
            back_image_path = (dataset_dir + "/" + card[3]) if card[3] != "" else ""

            card_name_escaped = card[1].replace("'", "''")
            db.execute(f"INSERT INTO cards VALUES('{card[0]}', '{dataset_name}', '{card_name_escaped}', '{front_image_path}', '{back_image_path}', '{card[4]}', NULL, NULL)")
            db.commit()

        dataset_db.close()

    print("Generating image embeddings ...")
    GenerateEmbeddings(db)

    print("Saving database to disk")
    db.execute(f"vacuum main into '{combined_dataset_filename}'")
    db.close()

#print("Generating training csv ...")
#with open(training_csv_filename, "w") as file:
#    file.write("filepath,caption\n")
#
#    card_data = []
#
#    for dataset_name in datasets:
#        filename = f"./datasets/{dataset_name}/dataset.db"
#        dataset_dir = f"datasets/{dataset_name}"
#
#        dataset_db = sqlite3.connect(filename)
#        res = dataset_db.execute("SELECT id, name, front_image_path, back_image_path, data_url FROM cards")
#
#        while (True):
#            card = res.fetchone()
#            if (card is None):
#                break
#
#            if (card[2] != ""):
#                card_data.append([ card[1], os.getcwd() + "/" + dataset_dir + "/" + card[2] ])
#            if (card[3] != ""):
#                card_data.append([ card[1], os.getcwd() + "/" + dataset_dir + "/" + card[3] ])
#
#    for card in card_data:
#        file.write(f"\"{card[1]}\", \"{card[0]}\"\n")
#
#print("Finetuning model ...")

