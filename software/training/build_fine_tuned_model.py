import torch
import torch.nn as nn
import torch.optim as optim
import matplotlib.pyplot as plt
import torch.nn.functional as F
import numpy as np
import os
from torch.utils.data import DataLoader, Dataset
from torchvision import transforms
from transformers import CLIPProcessor, CLIPModel
from PIL import Image
from collections import defaultdict
import sqlite3
import threading
from datetime import datetime
from torch.utils.tensorboard import SummaryWriter
from tqdm import tqdm

base_dir = os.path.dirname(os.path.abspath(__file__))
combined_dataset_filename = os.path.join(base_dir, "dataset.db")
output_model_dir = os.path.join(base_dir, "models", "clip-finetuned")
log_dir = os.path.join(base_dir, "logs", "clip-finetuned", datetime.now().strftime("%Y_%m_%d-%H_%M_%S"))
log_frequency = 10
device = "cuda" if torch.cuda.is_available() else "cpu"
print(f"Using device: {device}")

batch_size = 96
num_workers = 8

# Mixed precision: bf16 where supported, otherwise fp16 with gradient scaling
use_amp = device == "cuda"
use_bf16 = use_amp and torch.cuda.is_bf16_supported()
amp_dtype = torch.bfloat16 if use_bf16 else torch.float16
scaler = torch.amp.GradScaler("cuda", enabled=use_amp and not use_bf16)

model = CLIPModel.from_pretrained("openai/clip-vit-base-patch32").to(device)
processor = CLIPProcessor.from_pretrained("openai/clip-vit-base-patch32")
optimizer = optim.AdamW(model.parameters(), lr=1e-5)

# Load dataset
image_paths = []
image_captions = []

dataset_db = sqlite3.connect(combined_dataset_filename)
res = dataset_db.execute("SELECT name, front_image_path, back_image_path FROM cards")

while (True):
    card = res.fetchone()
    if (card is None):
        break

    if (card[1] != ""):
        image_paths.append(os.path.join(base_dir, card[1]))
        image_captions.append(card[0])
    if (card[2] != ""):
        image_paths.append(os.path.join(base_dir, card[2]))
        image_captions.append(card[0])

print(f"Dataset size: {len(image_paths)} image-caption pairs")

# Load into compatible dataset class
class CLIPDataset(Dataset):
    def __init__(self, image_paths, image_captions, processor):
        self.image_paths = image_paths
        self.image_captions = image_captions
        self.processor = processor

    def __len__(self):
        return len(self.image_paths)

    def __getitem__(self, idx):
        image = Image.open(self.image_paths[idx]).convert("RGB")
        caption = self.image_captions[idx]

        inputs = self.processor(
            text = caption,
            images = image,
            return_tensors = "pt",
            padding = "max_length",
            max_length = 77,
            truncation = True
        )

        return { key: val.squeeze(0) for key, val in inputs.items() }


dataset = CLIPDataset(image_paths, image_captions, processor)
loader = DataLoader(
    dataset,
    batch_size=batch_size,
    shuffle=True,
    num_workers=num_workers,
    pin_memory=(device == "cuda"),
    persistent_workers=True,
    multiprocessing_context="fork"
)

def clip_contrastive_loss(image_embeds, text_embeds, temperature=0.07):
    image_embeds = F.normalize(image_embeds, p=2, dim=-1)
    text_embeds = F.normalize(text_embeds, p=2, dim=-1)

    logits_per_image = torch.matmul(image_embeds, text_embeds.T) / temperature
    logits_per_text = logits_per_image.T

    batch_size = image_embeds.size(0)
    labels = torch.arange(batch_size).to(image_embeds.device)

    loss_i = F.cross_entropy(logits_per_image, labels)
    loss_t = F.cross_entropy(logits_per_text, labels)

    return (loss_i + loss_t) / 2

# Setup logger so we can view progress
writer = SummaryWriter(log_dir)
print(f"Logging to {log_dir}")

# Training loop
num_epochs = 10
global_step = 0
for epoch in range(num_epochs):
    model.train()
    total_loss = 0

    progress = tqdm(loader, desc=f"Epoch {epoch + 1}/{num_epochs}", unit="batch")
    for step, batch in enumerate(progress, start=1):
        pixel_values = batch['pixel_values'].to(device, non_blocking=True)
        input_ids = batch['input_ids'].to(device, non_blocking=True)
        attention_mask = batch['attention_mask'].to(device, non_blocking=True)

        with torch.autocast(device_type="cuda", dtype=amp_dtype, enabled=use_amp):
            outputs = model(
                pixel_values=pixel_values,
                input_ids=input_ids,
                attention_mask=attention_mask,
                return_loss=False
            )

            image_embeds = outputs.image_embeds
            text_embeds = outputs.text_embeds

            loss = clip_contrastive_loss(image_embeds, text_embeds)

        optimizer.zero_grad()
        scaler.scale(loss).backward()
        scaler.step(optimizer)
        scaler.update()

        loss_value = loss.item()
        total_loss += loss_value
        global_step += 1

        progress.set_postfix(loss=f"{loss_value:.3f}", avg=f"{total_loss / step:.3f}")

        if (global_step % log_frequency == 0):
            writer.add_scalar("train/loss", loss_value, global_step)
            writer.add_scalar("train/lr", optimizer.param_groups[0]["lr"], global_step)

    average_loss = total_loss / len(loader)
    writer.add_scalar("train/epoch_loss", average_loss, epoch + 1)
    writer.flush()
    print(f"Epoch {epoch + 1}/{num_epochs}, Average loss: {average_loss:.4f}")

    # Save latest checkpoint, overwriting the previous epoch's
    checkpoint_dir = os.path.join(output_model_dir, "checkpoint_latest")
    model.save_pretrained(checkpoint_dir)
    processor.save_pretrained(checkpoint_dir)
    print(f"Saved epoch {epoch + 1} checkpoint to {checkpoint_dir}")

writer.close()

# Save fine-tuned model
model.save_pretrained(output_model_dir)
processor.save_pretrained(output_model_dir)
print(f"Saved fine-tuned model to {output_model_dir}")
