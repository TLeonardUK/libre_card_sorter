from datetime import datetime
import json
import sqlite3
import requests
import time
import os
import threading
import io
from PIL import Image

class Card:
    card_id = None
    card_name = None
    data_url = None
    front_image_url = None
    back_image_url = None
    front_image_path = None
    back_image_path = None

image_directory = "images"

# Images are stored pre-sized for CLIP ViT-B/32.
image_size = (224, 224)
image_extension = "jpg"
image_jpeg_quality = 95
image_background_color = (0, 0, 0)
build_in_memory = True
force_redownload = False

print(datetime.now())

db = sqlite3.connect(":memory:" if build_in_memory else "dataset.db" )
db.execute("CREATE TABLE IF NOT EXISTS cards(id, name, front_image_path, back_image_path, data_url)")
db.execute("CREATE UNIQUE INDEX IF NOT EXISTS 'card_id_index' ON 'cards' ('id' ASC)")

pending_cards = []
pending_cards_lock = threading.Lock()

finished_cards = []
finished_cards_lock = threading.Lock()

threads_active = 0
threads_active_lock = threading.Lock()

# Grab all the data we care about out of the file.
def FindNeededCards():
    global pending_cards
    global image_directory

    with open("scryfall.jsonl", "r") as file:

        file.seek(0, os.SEEK_END)
        total_length = file.tell()
        file.seek(0, os.SEEK_SET)

        print("Finding new cards ...")
        while True:
            line = file.readline()
            if (line == ""):
                break

            data = json.loads(line)
            if (data["object"] != "card"):
                pass

            progress = (float(file.tell()) / float(total_length)) * 100.0

            card = Card()

            try:
                card.card_id = data["id"]
                card.data_url = data["uri"]
                card.card_name = data['name']
                comment_index = card.card_name.find("//")
                if (comment_index >= 0):
                    card.card_name = card.card_name[:comment_index].strip()
            except:
                #print(json.dumps(data, indent=4))
                print(f"Failed to get basic information")
                break

            # Remove card entry if it already exists
            res = db.execute(f"DELETE FROM cards WHERE id='{card.card_id}'")

            # Grab the front image (and back image if double-sided)
            card.front_image_url = ""
            card.back_image_url = ""
            card.front_image_path = ""
            card.back_image_path = ""

            try:
                if ("image_uris" not in data):
                    card.front_image_url = data["card_faces"][0]["image_uris"]["png"]
                    card.back_image_url = data["card_faces"][1]["image_uris"]["png"]
                    card.front_image_path = f"{image_directory}/{card.card_id[0:2]}/{card.card_id}_front.{image_extension}"
                    card.back_image_path = f"{image_directory}/{card.card_id[0:2]}/{card.card_id}_back.{image_extension}"
                else:
                    card.front_image_url = data["image_uris"]["png"]
                    card.back_image_url = ""
                    card.front_image_path = f"{image_directory}/{card.card_id[0:2]}/{card.card_id}_front.{image_extension}"
                    card.back_image_path = ""
            except:
                #print(json.dumps(data, indent=4))
                print(f"No card images available, skipping: {card.card_name}")
                continue

            pending_cards.append(card)
            #print(f"[%.2f %%] Found card '{card.card_name}'" % progress)

        print(f"Found {len(pending_cards)} cards to add, starting download.")

# Converts a downloaded image into the training format
def ResizeImage(image):
    # Fill transparent corners with a solid background
    if (image.mode in ("RGBA", "LA", "P")):
        image = image.convert("RGBA")
        background = Image.new("RGB", image.size, image_background_color)
        background.paste(image, mask=image.getchannel("A"))
        image = background
    else:
        image = image.convert("RGB")

    return image.resize(image_size, Image.Resampling.LANCZOS)

# Downloads an image, resizes it and saves it to a local location, returns False on failure
def DownloadFile(from_path, to_path):
    headers = {
        'User-Agent': 'MTG Card Sorter',
        'From': 'me@timleonard.uk'
    }

    if (from_path == ""):
        return True

    # Already downloaded.
    if (os.path.exists(to_path) and not force_redownload):
        return True

    try:
        to_dir = os.path.dirname(to_path)
        if not os.path.exists(to_dir):
            os.makedirs(to_dir)
    except FileExistsError:
        pass

    try:
        response = requests.get(from_path, headers=headers)
        response.raise_for_status()
        image = ResizeImage(Image.open(io.BytesIO(response.content)))
        image.save(to_path, "JPEG", quality=image_jpeg_quality)
        return True
    except Exception as e:
        print(f"Failed to download '{from_path}': {e}")
        return False

# Download pending cards.
def DownloadPendingCardsWorker():
    global pending_cards
    global pending_cards_lock
    global finished_cards
    global finished_cards_lock
    global threads_active
    global threads_active_lock

    while True:
        next_card = None
        with pending_cards_lock:
            if (len(pending_cards) > 0):
                idx = len(pending_cards) - 1
                next_card = pending_cards[idx]
                pending_cards.pop(idx)

        if (next_card == None):
            break

        front_ok = DownloadFile(next_card.front_image_url, next_card.front_image_path)
        back_ok = DownloadFile(next_card.back_image_url, next_card.back_image_path)

        # Only add cards with all images present, failed cards are retried on the next run
        if (front_ok and back_ok):
            with finished_cards_lock:
                finished_cards.append(next_card)

    with threads_active_lock:
        threads_active -= 1

def DownloadPendingCards():
    global db
    global threads_active
    global threads_active_lock
    global pending_cards
    global finished_cards
    global finished_cards_lock

    cards_processed = 0
    start_card_count = len(pending_cards)

    threads = []
    threads_active = 256;
    for n in range(threads_active):
        t = threading.Thread(target=DownloadPendingCardsWorker)
        t.start()
        threads.append(t)

    while True:
        next_card = None
        with finished_cards_lock:
            if (len(finished_cards) > 0):
                idx = len(finished_cards) - 1
                next_card = finished_cards[idx]
                finished_cards.pop(idx)

        if (next_card != None):
            # Insert into database.
            card_name_escaped = next_card.card_name.replace("'", "''")
            db.execute(f"INSERT INTO cards VALUES('{next_card.card_id}', '{card_name_escaped}', '{next_card.front_image_path}', '{next_card.back_image_path}', '{next_card.data_url}')")
            db.commit()

            cards_processed += 1
            progress = (float(cards_processed) / float(start_card_count)) * 100.0
            print(f"[%.2f %%] Card inserted '{next_card.card_name}'" % progress)
        elif (threads_active <= 0):
            print("Finished download.")
            break


# Get running!
FindNeededCards()
DownloadPendingCards()

if (build_in_memory):
    if (os.path.exists('dataset.db')):
        os.remove('dataset.db')
    db.execute(f"vacuum main into 'dataset.db'")

db.close()

print(datetime.now())
