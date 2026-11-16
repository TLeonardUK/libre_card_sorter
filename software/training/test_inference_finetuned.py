"""Throw-away test: match an image against every card name (image-to-text) using the fine-tuned CLIP model.

Usage: python test_inference_finetuned.py <image> [--top 10] [--model path] [--db path]
"""
import argparse
import os
import sqlite3

import torch
import torch.nn.functional as F
from PIL import Image
from transformers import CLIPModel, CLIPProcessor

base_dir = os.path.dirname(os.path.abspath(__file__))

parser = argparse.ArgumentParser()
parser.add_argument("image")
parser.add_argument("--top", type=int, default=10)
parser.add_argument("--model", default=os.path.join(base_dir, "models", "clip-finetuned"))
parser.add_argument("--db", default=os.path.join(base_dir, "dataset.db"))
args = parser.parse_args()

def resize_image(image):
    # Fill transparent corners with a solid background
    if (image.mode in ("RGBA", "LA", "P")):
        image = image.convert("RGBA")
        background = Image.new("RGB", image.size, (0, 0, 0))
        background.paste(image, mask=image.getchannel("A"))
        image = background
    else:
        image = image.convert("RGB")

    return image.resize((224, 224), Image.Resampling.LANCZOS)

def features(out):
    return out if isinstance(out, torch.Tensor) else out.pooler_output

device = "cuda" if torch.cuda.is_available() else "cpu"
model = CLIPModel.from_pretrained(args.model).to(device).eval()
processor = CLIPProcessor.from_pretrained(args.model)

names = [row[0] for row in sqlite3.connect(args.db).execute("SELECT DISTINCT name FROM cards ORDER BY name")]

chunks = []
with torch.no_grad():
    for i in range(0, len(names), 512):
        inputs = processor(text=names[i:i + 512], return_tensors="pt", padding=True, truncation=True, max_length=77).to(device)
        chunks.append(F.normalize(features(model.get_text_features(**inputs)), dim=-1))
        print(f"\rEmbedding names {min(i + 512, len(names))}/{len(names)}", end="")
print()
text_embeds = torch.cat(chunks)

with torch.no_grad():
    inputs = processor(images=resize_image(Image.open(args.image)), return_tensors="pt").to(device)
    image_embed = F.normalize(features(model.get_image_features(**inputs)), dim=-1)

similarity = (image_embed @ text_embeds.T).squeeze(0)
probs = (similarity * model.logit_scale.exp()).softmax(dim=0)
top = similarity.topk(args.top)

print(f"\nTop {args.top} matches for {args.image}:")
for rank, (score, idx) in enumerate(zip(top.values.tolist(), top.indices.tolist()), start=1):
    print(f"{rank:2d}. {score:.4f}  (p={probs[idx]:.3f})  {names[idx]}")
