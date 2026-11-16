# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

# Run by a packaged build's launcher before Main.py. The package leaves out torch, its GPU libraries, the models and the
# card database, as together they're several GB and which torch build a machine can use depends on its GPU, so they're
# downloaded here on first run. Exits with 0 once everything is in place.

import ctypes
import hashlib
import json
import os
import re
import sys
import tempfile
from PyQt6.QtCore import QProcess
from PyQt6.QtGui import QIcon
from PyQt6.QtWidgets import QApplication, QHBoxLayout, QLabel, QPlainTextEdit, QProgressBar, QPushButton, QVBoxLayout, QWidget
from Settings import Settings

PACKAGE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SETUP_DIR = os.path.join(PACKAGE_DIR, "setup")
PACKAGES_INSTALLED_PATH = os.path.join(PACKAGE_DIR, "python", "packages_installed")

# Pinned so an upstream change can't stop the models matching the embeddings in the card database.
MODELS = [
    (Settings.CARD_INFERENCE_MODEL_PATH, "openai/clip-vit-base-patch32", "3d74acf9a28c67741b2f4f2ea7635f0aaf6f0268", "CLIPModel", "CLIPProcessor"),
    (Settings.CARD_OCR_MODEL_PATH, "microsoft/trocr-base-printed", "93450be3f1ed40a930690d951ef3932687cc1892", "VisionEncoderDecoderModel", "TrOCRProcessor"),
]

CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR = 75
CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR = 76

# Asks the NVIDIA driver directly, as torch isn't installed yet.
def is_cuda_device_supported(driver_major_version, compute_capability):
    try:
        cuda = ctypes.CDLL("libcuda.so.1")
    except OSError:
        return False

    version = ctypes.c_int()
    device = ctypes.c_int()
    major = ctypes.c_int()
    minor = ctypes.c_int()
    if (cuda.cuInit(0) != 0 or cuda.cuDriverGetVersion(ctypes.byref(version)) != 0 or cuda.cuDeviceGet(ctypes.byref(device), 0) != 0):
        return False
    cuda.cuDeviceGetAttribute(ctypes.byref(major), CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR, device)
    cuda.cuDeviceGetAttribute(ctypes.byref(minor), CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR, device)
    return (version.value // 1000 >= driver_major_version and (major.value, minor.value) >= tuple(compute_capability))

# The first variant the machine can run, listed by the build with the GPU ones first.
def choose_variant():
    with open(os.path.join(SETUP_DIR, "variants.json")) as file:
        variants = json.load(file)
    for variant in variants:
        if ("cuda_driver_major_version" not in variant):
            return variant
        if (is_cuda_device_supported(variant["cuda_driver_major_version"], variant["compute_capability"])):
            return variant

def are_packages_installed():
    return os.path.exists(PACKAGES_INSTALLED_PATH)

def mark_packages_installed():
    with open(PACKAGES_INSTALLED_PATH, "w") as file:
        file.write("")

def are_models_downloaded():
    for path, repository, revision, model_class, processor_class in MODELS:
        if (not os.path.exists(path)):
            return False
    return True

def is_database_downloaded():
    return os.path.exists(Settings.CARD_INFERENCE_DATABASE_PATH)

def download_database():
    import requests

    with open(os.path.join(SETUP_DIR, "database.json")) as file:
        database = json.load(file)
    path = Settings.CARD_INFERENCE_DATABASE_PATH
    os.makedirs(os.path.dirname(path), exist_ok=True)
    print(f"Downloading {database['url']}")

    # Written beside the database and moved in once it's complete and checked, so an interrupted or corrupt download
    # is started again.
    temp_path = f"{path}.download"
    digest = hashlib.sha256()
    downloaded = 0
    with requests.get(database["url"], stream=True, timeout=60) as response:
        response.raise_for_status()
        with open(temp_path, "wb") as file:
            for chunk in response.iter_content(chunk_size=1024 * 1024):
                file.write(chunk)
                digest.update(chunk)
                downloaded += len(chunk)
                print(f"Progress {downloaded} of {database['size']}")
    if (digest.hexdigest() != database["sha256"]):
        os.remove(temp_path)
        raise RuntimeError("The downloaded card database doesn't match the one this version was built with.")
    os.replace(temp_path, path)
    print("Saved the card database")

def download_models():
    os.environ["HF_HUB_DISABLE_PROGRESS_BARS"] = "1"
    import torch
    import transformers
    transformers.utils.logging.disable_progress_bar()

    for path, repository, revision, model_class, processor_class in MODELS:
        if (os.path.exists(path)):
            continue
        print(f"Downloading {repository}")
        os.makedirs(os.path.dirname(path), exist_ok=True)

        # Assembled beside its destination and moved in once complete, so an interrupted download is started again.
        with tempfile.TemporaryDirectory(dir=os.path.dirname(path)) as work_dir:
            cache_dir = os.path.join(work_dir, "cache")
            model_dir = os.path.join(work_dir, "model")
            # Halves the model's size. The app runs it in float16 on the GPU anyway, so its results there are unchanged.
            model = getattr(transformers, model_class).from_pretrained(repository, revision=revision, cache_dir=cache_dir, dtype=torch.float16)
            model.save_pretrained(model_dir)
            processor = getattr(transformers, processor_class).from_pretrained(repository, revision=revision, cache_dir=cache_dir)
            processor.save_pretrained(model_dir)
            os.replace(model_dir, path)
        print(f"Saved {repository}")

class SetupStep:
    def __init__(self, description, arguments, on_success):
        self.description = description
        self.arguments = arguments
        self.on_success = on_success

def setup_steps():
    steps = []
    if (not are_packages_installed()):
        variant = choose_variant()
        description = "Installing packages with NVIDIA GPU support" if ("cuda_driver_major_version" in variant) else "Installing packages (no supported NVIDIA GPU found, so cards are identified on the CPU)"
        requirements = os.path.join(SETUP_DIR, variant["requirements"])
        arguments = ["-u", "-m", "pip", "install", "--no-deps", "--no-cache-dir", "--disable-pip-version-check", "--no-warn-script-location", "--progress-bar", "raw", "-r", requirements]
        steps.append(SetupStep(description, arguments, mark_packages_installed))
    if (not is_database_downloaded()):
        steps.append(SetupStep("Downloading the card database", ["-u", os.path.abspath(__file__), "--download-database"], None))
    if (not are_models_downloaded()):
        steps.append(SetupStep("Downloading the card recognition models", ["-u", os.path.abspath(__file__), "--download-models"], None))
    return steps

# The format pip prints with --progress-bar raw, which the database download prints too.
PROGRESS_PATTERN = re.compile(r"Progress (\d+) of (\d+)")

class SetupWindow(QWidget):
    def __init__(self, steps):
        super().__init__()
        self.__steps = steps
        self.__step_index = 0
        self.__output = ""

        self.setWindowTitle("Libre Card Sorter Setup")
        self.resize(720, 420)

        intro = QLabel("Downloading what the card sorter needs to identify cards. This only happens on the first run, and can take a while.")
        intro.setWordWrap(True)
        self.__step_label = QLabel()
        self.__step_label.setWordWrap(True)
        self.__progress_bar = QProgressBar()
        self.__log = QPlainTextEdit()
        self.__log.setReadOnly(True)
        self.__log.setMaximumBlockCount(2000)
        self.__retry_button = QPushButton("Retry")
        self.__retry_button.clicked.connect(self.__start_step)
        self.__retry_button.hide()
        quit_button = QPushButton("Quit")
        quit_button.clicked.connect(self.close)

        buttons = QHBoxLayout()
        buttons.addStretch()
        buttons.addWidget(self.__retry_button)
        buttons.addWidget(quit_button)
        layout = QVBoxLayout(self)
        layout.addWidget(intro)
        layout.addWidget(self.__step_label)
        layout.addWidget(self.__progress_bar)
        layout.addWidget(self.__log)
        layout.addLayout(buttons)

        self.__process = QProcess(self)
        self.__process.setProcessChannelMode(QProcess.ProcessChannelMode.MergedChannels)
        self.__process.readyReadStandardOutput.connect(self.__read_output)
        self.__process.finished.connect(self.__step_finished)
        self.__start_step()

    def __start_step(self):
        step = self.__steps[self.__step_index]
        self.__retry_button.hide()
        self.__step_label.setText(f"Step {self.__step_index + 1} of {len(self.__steps)}: {step.description}")
        self.__progress_bar.setRange(0, 0)
        self.__output = ""
        self.__process.start(sys.executable, step.arguments)

    def __read_output(self):
        self.__output += bytes(self.__process.readAllStandardOutput()).decode(errors="replace")
        lines = self.__output.split("\n")
        self.__output = lines.pop()
        for line in lines:
            line = line.rstrip()
            match = PROGRESS_PATTERN.fullmatch(line)
            if (match):
                # In KiB, as a download's size in bytes can overflow the progress bar's int.
                self.__progress_bar.setRange(0, int(match.group(2)) // 1024)
                self.__progress_bar.setValue(int(match.group(1)) // 1024)
            elif (line):
                self.__progress_bar.setRange(0, 0)
                self.__log.appendPlainText(line)

    def __step_finished(self, exit_code, exit_status):
        if (exit_status != QProcess.ExitStatus.NormalExit or exit_code != 0):
            self.__step_label.setText(f"Step {self.__step_index + 1} of {len(self.__steps)} failed: {self.__steps[self.__step_index].description}. Check your internet connection and disk space, then retry.")
            self.__progress_bar.setRange(0, 1)
            self.__progress_bar.setValue(0)
            self.__retry_button.show()
            return

        step = self.__steps[self.__step_index]
        if (step.on_success):
            step.on_success()
        self.__step_index += 1
        if (self.__step_index < len(self.__steps)):
            self.__start_step()
        else:
            self.close()

def main():
    if ("--download-models" in sys.argv):
        download_models()
        return 0
    if ("--download-database" in sys.argv):
        download_database()
        return 0

    steps = setup_steps()
    if (not steps):
        return 0

    app = QApplication(sys.argv)
    app.setWindowIcon(QIcon(Settings.APP_ICON_PATH))
    window = SetupWindow(steps)
    window.show()
    app.exec()
    return 0 if (are_packages_installed() and is_database_downloaded() and are_models_downloaded()) else 1

if __name__ == "__main__":
    sys.exit(main())
