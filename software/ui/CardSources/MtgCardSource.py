# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

import io
import os
import json
import urllib.request
import requests
import json 
from Sorting.CardIdentification import CardInfo
from Sorting.CardSourcing import CardSource
from Sorting.CardSchema import CardFieldName, CardFieldType, find_card_field

SCRYFALL_FIELD_KEYS = {
    CardFieldName.RARITY:             ["rarity"],
    CardFieldName.SET:                ["set"],
    CardFieldName.SET_NAME:           ["set_name"],
    CardFieldName.TYPE_LINE:          ["type_line"],
    CardFieldName.MANA_COST:          ["mana_cost"],
    CardFieldName.POWER:              ["power"],
    CardFieldName.TOUGHNESS:          ["toughness"],
    CardFieldName.FLAVOR_TEXT:        ["flavor_text"],
    CardFieldName.COLORS:             ["colors"],
    CardFieldName.KEYWORDS:           ["keywords"],
    CardFieldName.FINISHES:           ["finishes"],
    CardFieldName.PRICE_USD_FOIL:     ["prices", "usd_foil"],
    CardFieldName.PRICE_USD_NONFOIL:  ["prices", "usd"],
}

# Class for retrieving magic-the-gather card information
class MtgCardSource(CardSource):

    def get_dataset_name(self):
        return "mtg"
    
    def get_card_info(self, id, data_url):
        headers = {
            'User-Agent': 'MTG Card Sorter',
            'From': 'me@timleonard.uk'
        }      

        info = None
        try:
            response = requests.get(data_url, headers=headers)
            response.raise_for_status()            
            data = json.loads(response.content.decode("utf-8"))

            info = CardInfo()
            info.id = data["id"]
            info.name = data["name"]

            try:
                if ("image_uris" not in data):       
                    info.preview_image_url = data["card_faces"][0]["image_uris"]["png"]
                else:                
                    info.preview_image_url = data["image_uris"]["png"]
            except:
                print(f"No preview image available for card '{info.name}'")
                
            for field_name, keys in SCRYFALL_FIELD_KEYS.items():
                field = find_card_field(field_name)

                value = data
                for key in keys:
                    if (value != None):
                        value = value.get(key)

                if (field.type == CardFieldType.NUMBER):
                    info.attributes[field.name] = (float(value) if value != None else 0.0)
                elif (field.type == CardFieldType.LIST):
                    info.attributes[field.name] = (list(value) if value != None else [])
                else:
                    info.attributes[field.name] = (value if value != None else "")

        except Exception as e:
            print(f"Failed to card data '{data_url}': {e}")
            return None

        return info
        