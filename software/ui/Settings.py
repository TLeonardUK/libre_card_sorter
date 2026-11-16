# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

import io
import os
import json
import pickle
from pathlib import Path
from PyQt6.QtCore import QStandardPaths

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Bumped for each release; packaged builds are named after it.
VERSION = "0.1.0"

SAVE_DIR = os.path.join(QStandardPaths.writableLocation(QStandardPaths.StandardLocation.GenericDataLocation), "libre-card-sorter")

# A packaged build (see Scripts/PackageBuild.py), which has its first-run setup's list of downloads beside the app, is
# read-only, so setup downloads into a folder per version beside the app's settings, including the training folder's
# models and card database.
IS_PACKAGED = os.path.exists(os.path.join(BASE_DIR, "..", "setup", "setup.json"))
RUNTIME_DIR = os.path.join(SAVE_DIR, "runtime", VERSION) if (IS_PACKAGED) else None
TRAINING_DIR = os.path.join(RUNTIME_DIR, "training") if (IS_PACKAGED) else os.path.join(BASE_DIR, "../training")

# Contains general global settings of the project
class Settings:

    VERSION = VERSION

    # CLIP model used to recognize cards
    CARD_INFERENCE_MODEL_PATH = os.path.abspath(os.path.join(TRAINING_DIR, "models/clip-vit-base-patch32"))

    # Database containing information about cards and their embeddings.
    CARD_INFERENCE_DATABASE_PATH = os.path.abspath(os.path.join(TRAINING_DIR, "dataset.db"))

    # OCR model used to read card titles when the CLIP match isn't confident.
    CARD_OCR_MODEL_PATH = os.path.abspath(os.path.join(TRAINING_DIR, "models/trocr-base-printed"))

    # Folder used to cache card data
    CARD_INFO_CACHE_PATH = os.path.abspath(os.path.join(SAVE_DIR, "cache/card-info/"))

    # Folder used to cache card images
    CARD_IMAGE_CACHE_PATH = os.path.abspath(os.path.join(SAVE_DIR, "cache/card-images/"))

    # Icon shown on the app's windows
    APP_ICON_PATH = os.path.abspath(os.path.join(BASE_DIR, "Resources/app_icon.svg"))

    # Path to save settings in
    SETTINGS_PATH = os.path.abspath(os.path.join(SAVE_DIR, "settings.bin"))

    FIELD_DESCRIPTION = {
        "card_sorter_ip_address":                           "IP address of the card sorter.",
        "connection_port":                                  "Port the card sorter's server listens on.",
        "auto_connect":                                     "Connects to the card sorter on startup and keeps retrying, waiting up to 30 seconds between attempts, until connected or Disconnect is clicked.",
        "card_probability_confidence_gap":                  "Difference between the best and second best scored card that represents full confidence.",
        "card_probability_unknown_confidence_threshold":    "Any identified card with a confidence below this is considered unknown.",
        "card_ocr_title_height":                            "Fraction of the card image's height, from the top, that contains the title.",
        "card_ocr_minimum_match_ratio":                     "How closely (0-1) the OCR'd title must match a card name to be accepted.",
        "card_foil_pixel_shift_threshold":                  "How much a pixel's colour must shift between two differently lit images to count as foil sheen.",
        "card_foil_area_threshold":                         "Fraction of the card (0-1) that must show foil sheen for it to count as foil.",
        "card_foil_minimum_brightness":                     "Pixels darker than this (0-255) in any of the foil images are ignored, as their colour is mostly noise.",
        "card_info_cache_hours":                            "How many hours cached card info (e.g. prices) is kept before it's downloaded again. Minimum 24, to limit requests to the card data provider.",
        "skip_unneeded_foil_check":                         "Skips the foil check (extra captures per card) when no workflow rule uses Is Foil or Price USD. Cards are then listed as non-foil unless only printed in foil.",
        "x_feed_rate":                                      "How fast the X axis moves (mm/min).",
        "y_feed_rate":                                      "How fast the Y axis moves (mm/min).",
        "z_feed_rate":                                      "How fast the Z axis moves (mm/min).",
        "x_max_feed_rate":                                  "Maximum speed of the X axis (mm/s), which caps the X feed rate.",
        "y_max_feed_rate":                                  "Maximum speed of the Y axis (mm/s), which caps the Y feed rate.",
        "z_max_feed_rate":                                  "Maximum speed of the Z axis (mm/s), which caps the Z feed rate.",
        "x_max_acceleration":                               "Maximum acceleration of the X axis (mm/s²).",
        "y_max_acceleration":                               "Maximum acceleration of the Y axis (mm/s²).",
        "z_max_acceleration":                               "Maximum acceleration of the Z axis (mm/s²).",
        "acceleration":                                     "Acceleration of moves (mm/s²), limited per axis by the maximums above.",
        "x_load_position":                                  "Position on the X axis (mm) that cards are loaded from.",
        "bin_count":                                        "How many bins are on the machine. Takes effect after a restart.",
        "x_bin_offset":                                     "Position on the X axis (mm) of the first bin.",
        "x_bin_stride":                                     "Distance on the X axis (mm) between each bin.",
        "x_axis_range":                                     "Length of travel of the X axis (mm).",
        "y_axis_range":                                     "Length of travel of the Y axis (mm). The magazine is empty once the stack is lifted past this.",
        "card_thickness":                                   "Thickness of a card (mm), used to estimate how many cards are left in the magazine.",
        "z_dispense_grip_card_distance":                    "How far the Z axis moves (mm) to push the card part way out, so the funnel grips it.",
        "z_dispense_feed_card_distance":                    "How far the Z axis moves (mm) to push the rest of the card out.",
        "y_dispense_card_backoff_distance":                 "How far the Y axis moves (mm) between the two Z pushes, so the next card isn't fed with it.",
        "y_load_approach_distance":                         "How far below the previous card (mm) the stack is raised to at full speed before probing for the next one.",
        "z_park_distance":                                  "How far the Z axis moves back (mm) to park the roller.",
        "webcam_crop_left":                                 "Left edge of the webcam crop, as a fraction of the frame width.",
        "webcam_crop_right":                                "Right edge of the webcam crop, as a fraction of the frame width.",
        "webcam_crop_top":                                  "Top edge of the webcam crop, as a fraction of the frame height.",
        "webcam_crop_bottom":                               "Bottom edge of the webcam crop, as a fraction of the frame height.",
        "webcam_exposure":                                  "Exposure of the webcam.",
        "webcam_brightness":                                "Brightness (0-255) of the LEDs lighting the card for webcam captures.",
        "webcam_focus":                                     "Focus of the webcam.",
        "webcam_white_balance":                             "White balance of the webcam (K).",
        "verbose":                                          "Includes a lot of debugging information in the log output."
    }

    FIELD_GROUPS = [
        ("Connection",          ["card_sorter_ip_address", "connection_port", "auto_connect"]),
        ("Card Identification", ["card_probability_confidence_gap", "card_probability_unknown_confidence_threshold", "card_ocr_title_height", "card_ocr_minimum_match_ratio", "card_info_cache_hours"]),
        ("Foil Detection",      ["skip_unneeded_foil_check", "card_foil_pixel_shift_threshold", "card_foil_area_threshold", "card_foil_minimum_brightness"]),
        ("Motion",              ["acceleration"]),
        ("X Axis",              ["x_feed_rate", "x_max_feed_rate", "x_max_acceleration", "x_axis_range", "x_load_position"]),
        ("Bins",                ["bin_count", "x_bin_offset", "x_bin_stride"]),
        ("Y Axis",              ["y_feed_rate", "y_max_feed_rate", "y_max_acceleration", "y_axis_range", "y_load_approach_distance", "y_dispense_card_backoff_distance", "card_thickness"]),
        ("Z Axis",              ["z_feed_rate", "z_max_feed_rate", "z_max_acceleration", "z_dispense_grip_card_distance", "z_dispense_feed_card_distance", "z_park_distance"]),
        ("Webcam",              ["webcam_exposure", "webcam_focus", "webcam_white_balance", "webcam_brightness", "webcam_crop_left", "webcam_crop_right", "webcam_crop_top", "webcam_crop_bottom"]),
        ("Debugging",           ["verbose"]),
    ]

    def __init__(self):

        # Workflows the user has configured
        self.workflows = [ ]

        self.card_sorter_ip_address = "10.69.40.10"
        self.card_probability_confidence_gap = 0.03
        self.card_probability_unknown_confidence_threshold = 0.7
        self.card_ocr_title_height = 0.09
        self.card_ocr_minimum_match_ratio = 0.8
        self.card_foil_pixel_shift_threshold = 0.25
        self.card_foil_area_threshold = 0.024
        self.card_foil_minimum_brightness = 50
        self.skip_unneeded_foil_check = True
        self.card_info_cache_hours = 24

        self.x_feed_rate = 42000
        self.y_feed_rate = 15000#
        self.z_feed_rate = 15000
        self.x_max_feed_rate = 700
        self.y_max_feed_rate = 60
        self.z_max_feed_rate = 20000
        self.x_max_acceleration = 8000
        self.y_max_acceleration = 2000
        self.z_max_acceleration = 2000
        self.acceleration = 8000
        self.x_load_position = 75
        self.bin_count = 7
        self.x_bin_offset = 4
        self.x_bin_stride = 81
        self.x_axis_range = 500
        self.y_axis_range = 271.5
        self.card_thickness = 0.31

        self.z_dispense_grip_card_distance = 50
        self.z_dispense_feed_card_distance = 300
        self.y_dispense_card_backoff_distance = -40
        self.y_load_approach_distance = 2
        self.z_park_distance = 35

        self.webcam_crop_left = 0.2925
        self.webcam_crop_right = 0.8
        self.webcam_crop_top = 0.025
        self.webcam_crop_bottom = 0.992
        self.webcam_exposure = 200
        self.webcam_brightness = 255
        self.webcam_focus = 64
        self.webcam_white_balance = 4200

        self.verbose = False

        self.connection_port = 8321
        self.auto_connect = True

    def __setstate__(self, state):
        self.__init__()
        # Settings that no longer exist are dropped so they don't show up in the settings window.
        for key, value in state.items():
            if (key in self.__dict__):
                self.__dict__[key] = value

    def load():
        if (os.path.isfile(Settings.SETTINGS_PATH)):
            obj = pickle.load(open(Settings.SETTINGS_PATH, 'rb'))
            return obj
        else:
            return Settings()

    def save(self):
        settings_dir = os.path.dirname(self.SETTINGS_PATH)
        if (not os.path.isdir(settings_dir)):
            os.makedirs(settings_dir)

        pickle.dump(self, open(self.SETTINGS_PATH, 'wb'))