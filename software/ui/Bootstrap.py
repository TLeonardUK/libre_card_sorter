# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

# Run by a packaged build's launcher (AppRun) before Main.py. The package leaves out torch, its GPU libraries, the models and the
# card database, as together they're several GB and which torch build a machine can use depends on its GPU, so they're
# downloaded here on first run, as listed in setup/setup.json by the build. Exits with 0 once everything is in place.

import ctypes
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import urllib.request
from PyQt6.QtCore import QProcess
from PyQt6.QtGui import QIcon
from PyQt6.QtWidgets import QApplication, QHBoxLayout, QLabel, QPlainTextEdit, QProgressBar, QPushButton, QVBoxLayout, QWidget
from Settings import Settings, RUNTIME_DIR, TRAINING_DIR

# The package is read-only, so everything setup downloads goes in the runtime folder the launcher gives it, with the
# packages in a folder the launcher puts on Python's path.
PACKAGE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SETUP_DIR = os.path.join(PACKAGE_DIR, "setup")
BUNDLED_WHEELS_DIR = os.path.join(SETUP_DIR, "wheels")
DOWNLOADED_WHEELS_DIR = os.path.join(RUNTIME_DIR, "wheels")
PACKAGES_DIR = os.path.join(RUNTIME_DIR, "packages")
PACKAGES_INSTALLED_PATH = os.path.join(RUNTIME_DIR, "packages_installed")

CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR = 75
CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR = 76

# Printed by each step as it downloads, for the window to show; the numbers are bytes through the whole step.
PROGRESS_PATTERN = re.compile(r"Progress (\d+) of (\d+)")

def load_setup():
    with open(os.path.join(SETUP_DIR, "setup.json")) as file:
        return json.load(file)

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
def choose_variant(setup):
    for variant in setup["variants"]:
        if ("cuda_driver_major_version" not in variant):
            return variant
        if (is_cuda_device_supported(variant["cuda_driver_major_version"], variant["compute_capability"])):
            return variant

def model_path(model):
    return os.path.join(TRAINING_DIR, model["path"])

def are_packages_installed():
    return os.path.exists(PACKAGES_INSTALLED_PATH)

def is_database_downloaded():
    return os.path.exists(Settings.CARD_INFERENCE_DATABASE_PATH)

def missing_models(setup):
    models = []
    for model in setup["models"]:
        if (not os.path.exists(model_path(model))):
            models.append(model)
    return models

def files_size(files):
    size = 0
    for file in files:
        size += file["size"]
    return size

def open_url(url):
    return urllib.request.urlopen(urllib.request.Request(url, headers={"User-Agent": "libre-card-sorter"}), timeout=60)

# Downloads each file to its path, checking its hash. Each is written beside its path and moved in once it's complete
# and checked, so a file that's there is complete, and an interrupted download carries on from the next file. Files the
# package ships, which have no URL, are already there.
def download_files(files, paths):
    total = files_size(files)
    done = 0
    for file, path in zip(files, paths):
        if (not os.path.exists(path)):
            print(f"Downloading {file['name']}")
            os.makedirs(os.path.dirname(path), exist_ok=True)
            temp_path = f"{path}.download"
            digest = hashlib.sha256()
            downloaded = 0
            with open_url(file["url"]) as response, open(temp_path, "wb") as output:
                for chunk in iter(lambda: response.read(1024 * 1024), b""):
                    output.write(chunk)
                    digest.update(chunk)
                    downloaded += len(chunk)
                    print(f"Progress {done + min(downloaded, file['size'])} of {total}")
            if (digest.hexdigest() != file["sha256"]):
                os.remove(temp_path)
                raise RuntimeError(f"{file['name']} didn't download correctly (its hash doesn't match).")
            os.replace(temp_path, path)
        done += file["size"]
        print(f"Progress {done} of {total}")

# Wheels the package ships (built by the build, having none to download) are in the package; the rest are downloaded.
def wheel_paths(setup):
    paths = []
    for wheel in choose_variant(setup)["wheels"]:
        paths.append(os.path.join(DOWNLOADED_WHEELS_DIR if ("url" in wheel) else BUNDLED_WHEELS_DIR, wheel["name"]))
    return paths

def download_packages(setup):
    download_files(choose_variant(setup)["wheels"], wheel_paths(setup))

def install_packages(setup):
    # --upgrade replaces what an interrupted install left, rather than skipping it.
    arguments = [sys.executable, "-m", "pip", "install", "--no-index", "--no-deps", "--upgrade", "--target", PACKAGES_DIR, "--disable-pip-version-check", "--no-warn-script-location"]
    subprocess.run(arguments + wheel_paths(setup), check=True)
    with open(PACKAGES_INSTALLED_PATH, "w") as file:
        file.write("")
    shutil.rmtree(DOWNLOADED_WHEELS_DIR)

# Always the latest database on the repository's main branch; its Git LFS pointer there gives its hash and size.
def download_database(setup):
    with open_url(setup["database"]["pointer_url"]) as response:
        pointer = response.read().decode()
    database = {
        "name": "the card database",
        "url": setup["database"]["url"],
        "sha256": re.search(r"^oid sha256:(\w+)$", pointer, re.MULTILINE).group(1),
        "size": int(re.search(r"^size (\d+)$", pointer, re.MULTILINE).group(1)),
    }
    download_files([database], [Settings.CARD_INFERENCE_DATABASE_PATH])

def download_models(setup):
    import torch
    import transformers
    transformers.utils.logging.disable_progress_bar()

    models = missing_models(setup)
    files = []
    paths = []
    for model in models:
        for file in model["files"]:
            files.append(file)
            paths.append(os.path.join(f"{model_path(model)}.download", file["name"]))
    download_files(files, paths)

    for model in models:
        path = model_path(model)
        download_dir = f"{path}.download"
        print(f"Saving {model['path']}")
        # Saved beside its destination and moved in once complete, so an interrupted save is done again.
        with tempfile.TemporaryDirectory(dir=os.path.dirname(path)) as work_dir:
            model_dir = os.path.join(work_dir, "model")
            # Halves the model's size. The app runs it in float16 on the GPU anyway, so its results there are unchanged.
            getattr(transformers, model["model_class"]).from_pretrained(download_dir, dtype=torch.float16).save_pretrained(model_dir)
            getattr(transformers, model["processor_class"]).from_pretrained(download_dir).save_pretrained(model_dir)
            os.replace(model_dir, path)
        shutil.rmtree(download_dir)

STEP_FUNCTIONS = {
    "download-packages": download_packages,
    "install-packages": install_packages,
    "download-database": download_database,
    "download-models": download_models,
}

class SetupStep:
    # The weight is the step's share of the overall progress, in bytes downloaded.
    def __init__(self, description, name, weight):
        self.description = description
        self.name = name
        self.weight = weight

def setup_steps(setup):
    steps = []
    if (not are_packages_installed()):
        variant = choose_variant(setup)
        if ("cuda_driver_major_version" in variant):
            steps.append(SetupStep("Downloading packages with NVIDIA GPU support", "download-packages", files_size(variant["wheels"])))
        else:
            steps.append(SetupStep("Downloading packages (no supported NVIDIA GPU found, so cards are identified on the CPU)", "download-packages", files_size(variant["wheels"])))
        steps.append(SetupStep("Installing packages", "install-packages", 0))
    if (not is_database_downloaded()):
        steps.append(SetupStep("Downloading the card database", "download-database", setup["database"]["estimated_size"]))
    models = missing_models(setup)
    if (models):
        size = 0
        for model in models:
            size += files_size(model["files"])
        steps.append(SetupStep("Downloading the card recognition models", "download-models", size))
    return steps

class SetupWindow(QWidget):
    def __init__(self, steps):
        super().__init__()
        self.__steps = steps
        self.__step_index = 0
        self.__output = ""
        self.__total_weight = 0
        for step in steps:
            self.__total_weight += step.weight

        self.setWindowTitle("Libre Card Sorter Setup")
        self.resize(720, 460)

        intro = QLabel("Downloading dependencies. This only happens on first run, and can take a while.")
        intro.setWordWrap(True)
        self.__overall_label = QLabel()
        self.__overall_bar = QProgressBar()
        self.__step_label = QLabel()
        self.__step_label.setWordWrap(True)
        self.__step_bar = QProgressBar()
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
        layout.addWidget(self.__overall_label)
        layout.addWidget(self.__overall_bar)
        layout.addWidget(self.__step_label)
        layout.addWidget(self.__step_bar)
        layout.addWidget(self.__log)
        layout.addLayout(buttons)

        self.__process = QProcess(self)
        self.__process.setProcessChannelMode(QProcess.ProcessChannelMode.MergedChannels)
        self.__process.readyReadStandardOutput.connect(self.__read_output)
        self.__process.finished.connect(self.__step_finished)
        self.__start_step()

    def __set_overall_progress(self, step_fraction):
        done = 0
        for step in self.__steps[:self.__step_index]:
            done += step.weight
        done += self.__steps[self.__step_index].weight * step_fraction
        # In KiB, as the total in bytes can overflow the progress bar's int.
        self.__overall_bar.setRange(0, max(1, self.__total_weight // 1024))
        self.__overall_bar.setValue(int(done) // 1024)
        self.__overall_label.setText(f"Overall: {done / 1e9:.2f} of {self.__total_weight / 1e9:.2f} GB")

    def __start_step(self):
        step = self.__steps[self.__step_index]
        self.__retry_button.hide()
        self.__step_label.setText(f"Step {self.__step_index + 1} of {len(self.__steps)}: {step.description}")
        self.__step_bar.setRange(0, 0)
        self.__set_overall_progress(0)
        self.__output = ""
        self.__process.start(sys.executable, ["-u", os.path.abspath(__file__), step.name])

    def __read_output(self):
        self.__output += bytes(self.__process.readAllStandardOutput()).decode(errors="replace")
        lines = self.__output.split("\n")
        self.__output = lines.pop()
        for line in lines:
            line = line.rstrip()
            match = PROGRESS_PATTERN.fullmatch(line)
            if (match):
                done = int(match.group(1))
                total = max(1, int(match.group(2)))
                self.__step_bar.setRange(0, max(1, total // 1024))
                self.__step_bar.setValue(done // 1024)
                self.__set_overall_progress(done / total)
            elif (line):
                self.__log.appendPlainText(line)

    def __step_finished(self, exit_code, exit_status):
        if (exit_status != QProcess.ExitStatus.NormalExit or exit_code != 0):
            self.__step_label.setText(f"Step {self.__step_index + 1} of {len(self.__steps)} failed: {self.__steps[self.__step_index].description}. The log below says why; check your internet connection and disk space, then retry.")
            self.__step_bar.setRange(0, 1)
            self.__step_bar.setValue(0)
            self.__retry_button.show()
            return

        self.__step_index += 1
        if (self.__step_index < len(self.__steps)):
            self.__start_step()
        else:
            self.close()

def main():
    setup = load_setup()
    if (len(sys.argv) > 1):
        STEP_FUNCTIONS[sys.argv[1]](setup)
        return 0

    steps = setup_steps(setup)
    if (not steps):
        return 0

    app = QApplication(sys.argv)
    app.setWindowIcon(QIcon(Settings.APP_ICON_PATH))
    window = SetupWindow(steps)
    window.show()
    app.exec()
    return 0 if (not setup_steps(setup)) else 1

if __name__ == "__main__":
    sys.exit(main())
