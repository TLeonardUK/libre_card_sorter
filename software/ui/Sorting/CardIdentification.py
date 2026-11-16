# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

import io
import os
import re
import json
import sqlite3
import time
import difflib
import numpy as np
import torch
import torch.nn.functional as F
from pathlib import Path
from threading import Thread
from PIL import Image
from transformers import CLIPModel, CLIPProcessor, TrOCRProcessor, VisionEncoderDecoderModel
from Settings import Settings
from Sorting.CardSourcing import CardSource
import Utils.Network as Network

# Contains information about the card, cached to disk to avoid polling online services.
class CardInfo:

    def __init__(self):

        # ID of the card in the database
        self.id = ""

        # Human-readable name
        self.name = ""
        
        # Attributes, differs by card game type
        self.attributes = {}

        # Url of the preview image for the card.
        self.preview_image_url = None
        
# Info about the identified card including identification details - confidence and such.
class CardIdentity:

    def __init__(self):

        # 0-1 of how confident this is the correctly identified card
        self.confidence = 1

        # If the card is upside down in the dispenser
        self.flipped = False

        # CardInfo instance for the recognized card. Or None if card identity is unknown.
        self.info = None

        # If this card is foil or not. identify_card doesn't calculate this
        # as it requires multiple images, call identify_foil to fill this value in.
        self.is_foil = False
        
        # Full size preview of the card image
        self.preview_image = None

# Disk cache used to store card info
class CardInfoCache:

    def __init__(self, settings):
        self.__settings = None    
        self.__sources = []
        self.__settings = settings
        if (not os.path.isdir(Settings.CARD_INFO_CACHE_PATH)):
            os.makedirs(Settings.CARD_INFO_CACHE_PATH)

    def add_card_source(self, dataset_name, source):
        dataset_path = os.path.join(Settings.CARD_INFO_CACHE_PATH, f"{dataset_name}")
        if (not os.path.isdir(dataset_path)):
            os.makedirs(dataset_path)
        self.__sources.append((dataset_name, source))

        for file_name in os.listdir(dataset_path):
            self.__remove_if_expired(os.path.join(dataset_path, file_name))

    # Card info such as prices changes over time, so it is refreshed once it's this old.
    def __remove_if_expired(self, path):
        max_age_seconds = max(24, self.__settings.card_info_cache_hours) * 60 * 60
        if (os.path.isfile(path) and time.time() - os.path.getmtime(path) > max_age_seconds):
            os.remove(path)

    def find(self, dataset_name, id, data_url):
        path = os.path.join(Settings.CARD_INFO_CACHE_PATH, f"{dataset_name}/{id}.json")
        self.__remove_if_expired(path)
        if (os.path.isfile(path)):
            card_info = CardInfo()
            card_info.__dict__.update(json.loads(Path(path).read_text()))
            return card_info

        # Try and get the card info from all the sources available for the dataset.
        card_info = None
        for key, value in self.__sources:
            if (key == dataset_name):
                card_info = value.get_card_info(id, data_url)
                if (card_info != None):
                    break

        # Store the resulting info in the cache.
        if (card_info != None):
            json_data = json.dumps(card_info.__dict__)
            data = Path(path).write_text(json_data)

        return card_info

def get_card_image_path(card_id):
    return os.path.join(Settings.CARD_IMAGE_CACHE_PATH, f"{card_id[0:2]}/{card_id}.png")

# Disk cache used to store card images
class CardImageCache:

    def __init__(self, settings):
        self.__settings = None    
        self.__settings = settings

    def find(self, card_id, image_url):
        path = get_card_image_path(card_id)
        if (not os.path.isfile(path)):
            if (not Network.download_file(image_url, path) or not os.path.isfile(path)):
                return None
            
        img = Image.open(path)
        img.load()
        return img
    
# Class is responsible for taking an image of a card and identifying 
# what it is and retrieving information about it.
class CardIdentifier:

    class CardMetadata:
        def __init__(self):
            self.name = None
            self.id = None
            self.dataset = None
            self.data_url = None

    def __init__(self, settings):

        self.__settings = None

        self.__device = None
        self.__data_type = None
        self.__model = None
        self.__processor = None

        self.__ocr_model = None
        self.__ocr_processor = None

        self.__database = None
        self.__unique_card_names = []
        self.__card_names = []
        self.__card_metadata = []
        self.__card_name_indices = None
        self.__card_reference_embeds = []
        self.__card_face_indices_by_name = {}
        self.__ocr_comparable_card_names = []

        self.__settings = settings
        self.__cache = CardInfoCache(settings)
        self.__image_cache = CardImageCache(settings)

        self.__models_loaded = False

    def __load_models(self):
        if self.__models_loaded:
            return
        
        self.__models_loaded = True
        
        # Load the CLIP model we are going to use for identification
        self.__device = "cuda" if torch.cuda.is_available() else "cpu"
        self.__data_type = torch.float16 if self.__device == "cuda" else torch.float32
        self.__model = CLIPModel.from_pretrained(Settings.CARD_INFERENCE_MODEL_PATH, local_files_only=True).to(self.__device, self.__data_type).eval()
        self.__processor = CLIPProcessor.from_pretrained(Settings.CARD_INFERENCE_MODEL_PATH, local_files_only=True)

        # Load the OCR model used to read card titles
        self.__ocr_model = VisionEncoderDecoderModel.from_pretrained(Settings.CARD_OCR_MODEL_PATH, local_files_only=True).to(self.__device, self.__data_type).eval()
        self.__ocr_processor = TrOCRProcessor.from_pretrained(Settings.CARD_OCR_MODEL_PATH, local_files_only=True)

        # Load the database containing all our combined dataset card info.
        self.__database = sqlite3.connect(Settings.CARD_INFERENCE_DATABASE_PATH)

        # Get all reference embeddings.
        embeddings = []
        result = self.__database.execute("SELECT name, dataset, id, front_embedding, back_embedding, data_url FROM cards")
        for name, dataset, id, front_embedding, back_embedding, data_url in result:
            if (front_embedding):
                meta = self.CardMetadata()
                meta.name = name
                meta.dataset = dataset
                meta.id = id
                meta.data_url = data_url
                self.__card_metadata.append(meta)
                self.__card_names.append(name)
                embeddings.append(front_embedding)

            if (back_embedding):
                meta = self.CardMetadata()
                meta.name = name
                meta.dataset = dataset
                meta.id = id
                meta.data_url = data_url
                self.__card_metadata.append(meta)
                self.__card_names.append(name)
                embeddings.append(back_embedding)
            
            self.__unique_card_names.append(name)

        self.__unique_card_names = sorted(set(self.__unique_card_names))

        name_index = {}
        for i, name in enumerate(self.__unique_card_names):
            name_index[name] = i

        card_name_indices = []
        for name in self.__card_names:
            card_name_indices.append(name_index[name])
        self.__card_name_indices = torch.tensor(card_name_indices, device=self.__device)

        for i, name in enumerate(self.__card_names):
            if (name not in self.__card_face_indices_by_name):
                self.__card_face_indices_by_name[name] = []
            self.__card_face_indices_by_name[name].append(i)

        # Names that reduce to a couple of characters (e.g. "X") would closely match any short misread.
        for name in self.__unique_card_names:
            comparable_name = self.__ocr_comparable_text(name)
            if (len(comparable_name) >= 3):
                self.__ocr_comparable_card_names.append((comparable_name, name))

        self.__card_reference_embeds = torch.from_numpy(np.frombuffer(b"".join(embeddings), dtype="<f2") \
                                                     .reshape(len(embeddings), -1).copy())            \
                                                     .to(self.__device, self.__data_type)              \
                                                     
                                                                                                      
    def add_card_source(self, dataset_name, source):
        self.__cache.add_card_source(dataset_name, source)

    def __format_image(self, image):
        # Ensure image is in the same format as our original embeddings
        if (image.mode in ("RGBA", "LA", "P")):
            image = image.convert("RGBA")
            background = Image.new("RGB", image.size, (0, 0, 0))
            background.paste(image, mask=image.getchannel("A"))
            image = background
        else:
            image = image.convert("RGB")
        return image.resize((224, 224), Image.Resampling.LANCZOS)

    def __tensor_features(self, out):
        return out if isinstance(out, torch.Tensor) else out.pooler_output

    def __get_similarity(self, image):
        image_embed = None
        with torch.no_grad():
            inputs = self.__processor(images=image, return_tensors="pt")
            pixel_data = inputs["pixel_values"].to(self.__device, self.__data_type)
            image_embed = F.normalize(self.__tensor_features(self.__model.get_image_features(pixel_values=pixel_data)), dim=-1)

        return (image_embed @ self.__card_reference_embeds.T).squeeze(0).float()

    def __get_index_and_confidence(self, image):
        similarity = self.__get_similarity(image)
        name_scores = torch.full((len(self.__unique_card_names),), -1.0, device=self.__device).scatter_reduce(0, self.__card_name_indices, similarity, "amax")

        best_name_scores = name_scores.topk(2).values
        confidence = min((best_name_scores[0] - best_name_scores[1]).item() / self.__settings.card_probability_confidence_gap, 1.0)

        best_index = similarity.argmax().item()

        return (best_index, confidence)

    def __ocr_comparable_text(self, text):
        # OCR reads the title in capitals and picks up the mana cost as brackets, symbols and digits.
        text = re.sub(r"[^a-z' ,-]", " ", text.lower())
        return re.sub(r"\s+", " ", text).strip(" ,-")

    def __get_index_and_confidence_for_ocr(self, image):
        title_height = int(image.height * self.__settings.card_ocr_title_height)
        title = image.crop((0, 0, image.width, title_height))

        title = title.resize((title.width * 4, title.height * 4), Image.Resampling.LANCZOS)

        with torch.no_grad():
            pixel_data = self.__ocr_processor(images=title, return_tensors="pt")["pixel_values"].to(self.__device, self.__data_type)
            generated_ids = self.__ocr_model.generate(pixel_data, max_new_tokens=24)
        text = self.__ocr_comparable_text(self.__ocr_processor.batch_decode(generated_ids, skip_special_tokens=True)[0])

        if (len(text.replace(" ", "")) < 3):
            return (-1, 0.0)

        best_ratio = 0.0
        best_name = None
        matcher = difflib.SequenceMatcher()
        matcher.set_seq2(text)
        for comparable_name, name in self.__ocr_comparable_card_names:
            matcher.set_seq1(comparable_name)
            if (matcher.real_quick_ratio() > best_ratio and matcher.quick_ratio() > best_ratio):
                ratio = matcher.ratio()
                if (ratio > best_ratio):
                    best_ratio = ratio
                    best_name = name

        if (best_ratio < self.__settings.card_ocr_minimum_match_ratio):
            return (-1, 0.0)

        # OCR only gives the name, so pick the printing that looks most like the image.
        face_indices = torch.tensor(self.__card_face_indices_by_name[best_name], device=self.__device)
        similarity = self.__get_similarity(image)
        best_index = face_indices[similarity[face_indices].argmax()].item()

        return (best_index, best_ratio)

    def identify_card(self, image):

        self.__load_models()

        formatted_image = self.__format_image(image)

        # Get confidence of normal image
        (index, confidence) = self.__get_index_and_confidence(formatted_image)

        # Get confidence of flipped index.
        flipped_image = formatted_image.transpose(method=Image.ROTATE_180)
        (flipped_index, flipped_confidence) = self.__get_index_and_confidence(flipped_image)

        # Select the best match of the two
        best_index = index
        best_confidence = confidence
        is_flipped = False
        if (flipped_confidence > confidence):
            best_index = flipped_index
            best_confidence = flipped_confidence
            is_flipped = True

        # If confidence is still low, try and do a OCR match.
        if (best_confidence < self.__settings.card_probability_unknown_confidence_threshold):
            (ocr_index, ocr_confidence) = self.__get_index_and_confidence_for_ocr(formatted_image)
            if (ocr_index >= 0):
                best_index = ocr_index
                best_confidence = ocr_confidence            
            (flipped_ocr_index, flipped_ocr_confidence) = self.__get_index_and_confidence_for_ocr(flipped_image)
            if (flipped_ocr_confidence >= 0 and flipped_ocr_confidence > ocr_confidence):
                best_index = flipped_ocr_index
                best_confidence = flipped_ocr_confidence
                is_flipped = True

        # Don't identify card if below threshold.
        if (best_confidence < self.__settings.card_probability_unknown_confidence_threshold):
            return None

        # Return the result
        metadata = self.__card_metadata[best_index]

        info = self.__cache.find(metadata.dataset, metadata.id, metadata.data_url)
        if (info == None):
            return None

        identity = CardIdentity()
        identity.confidence = best_confidence
        identity.info = info
        identity.flipped = is_flipped
        def load_preview_image():
            identity.preview_image = self.__image_cache.find(metadata.id, info.preview_image_url)
        Thread(target=load_preview_image, daemon=True).start()

        return identity

    # Takes multiple images of the same card with different lighting
    # and determines if it is a foil card or not.
    def identify_foil(self, images):
        
        self.__load_models()
        
        # Averaging down to a small size smooths out sensor noise, which would otherwise look like colour shifting.
        size = (64, int(64 * images[0].height / images[0].width))

        chromaticities = []
        usable = []
        for image in images:
            rgb = np.asarray(image.convert("RGB").resize(size, Image.Resampling.BOX), dtype=np.float32)

            # Dark pixels have too little signal for a meaningful colour, and blown-out glare has lost its colour entirely.
            usable.append((rgb.mean(axis=2) > self.__settings.card_foil_minimum_brightness) & (rgb.max(axis=2) < 250))

            # Colour with brightness divided out, so the shading from each LED's direction cancels and only colour change remains.
            chromaticities.append(rgb / (rgb.sum(axis=2, keepdims=True) + 1))

        # A foil's rainbow sheen shifts colour as the light moves; printed ink and the gloss on non-foil cards only change brightness.
        # Images are compared in pairs because the sheen's bright spots move with the light, so on dark cards a pixel is rarely
        # bright in every image. Sheen covers broad patches, whereas dark saturated ink (e.g. red art) only shifts in scattered
        # pixels, so the score is the fraction of the whole card that shifts.
        sheen = np.zeros(usable[0].shape, dtype=bool)
        for i in range(len(images)):
            for j in range(i + 1, len(images)):
                colour_shift = np.abs(chromaticities[i] - chromaticities[j]).sum(axis=2)
                sheen |= (colour_shift > self.__settings.card_foil_pixel_shift_threshold) & usable[i] & usable[j]
        sheen_fraction = sheen.mean()

        return bool(sheen_fraction > self.__settings.card_foil_area_threshold)



