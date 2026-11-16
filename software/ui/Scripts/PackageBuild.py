# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

# Packages the UI into a standalone folder, Builds/<version>/, that runs without Python or the repository. The version
# is Settings.VERSION. The package holds a Python runtime with only PyQt installed and the app; Bootstrap.py downloads
# the rest on first run: pinned versions of what's installed in the UI's virtual environment, so it must be run with
# that, the models, and the latest card database on the main branch of the repository's GitHub remote:
#
#   cd software/ui
#   .venv/bin/python Scripts/PackageBuild.py

import argparse
import fnmatch
import hashlib
import importlib.metadata
import json
import os
import platform
import re
import shutil
import stat
import subprocess
import sys
import tarfile
import tempfile
import urllib.parse
import urllib.request
import zipfile

UI_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, UI_DIR)

from Settings import Settings, TRAINING_DIR

APP_NAME = "LibreCardSorter"

# A relocatable build of CPython. Its minor version must match the virtual environment's, as the pinned packages are
# built for it.
PYTHON_RUNTIME_URL = "https://github.com/astral-sh/python-build-standalone/releases/download/20261110/cpython-3.15.2+20261110-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz"
PYTHON_RUNTIME_VERSION = (3, 15)

# Torch only uses triton to compile models, which the app doesn't; without it torch runs as normal, and it's ~1GB.
EXCLUDED_PACKAGES = ["pip", "triton"]

# The parts of the UI folder that aren't the app.
NON_APP_FILES = [".venv", ".vscode", "Builds", "Scripts", "__pycache__", "requirements.txt", "requirements-lock.txt"]

# The virtual environment's exact packages, written by each build so the GitHub release workflow can recreate it.
LOCK_PATH = os.path.join(UI_DIR, "requirements-lock.txt")

# The plugins QtGui and QtWidgets use; the rest are for other Qt modules.
QT_PLUGIN_DIRS = ["egldeviceintegrations", "generic", "iconengines", "imageformats", "platforminputcontexts", "platforms", "platformthemes", "wayland-decoration-client", "wayland-graphics-integration-client", "wayland-shell-integration", "xcbglintegrations"]

# Runs the package's Python as the launcher does, seeing only its own packages, not the user's (~/.local) or PYTHONPATH.
def run_runtime_python(arguments, environment_overrides={}, **options):
    environment = dict(os.environ, PYTHONNOUSERSITE="1", **environment_overrides)
    environment.pop("PYTHONPATH", None)
    environment.pop("PYTHONHOME", None)
    return subprocess.run(arguments, env=environment, check=True, **options)

QT_MODULE_PATTERN = re.compile(r"PyQt6\.(Qt\w+)|from PyQt6 import ([\w, ]+)")

def write_lock(packages):
    cuda_tag = packages["torch"].partition("+")[2]
    with open(LOCK_PATH, "w") as file:
        file.write("# Written by Scripts/PackageBuild.py from the UI's virtual environment; recreate it with:\n")
        file.write("#   python -m venv .venv && .venv/bin/python -m pip install -r requirements-lock.txt\n")
        file.write(f"--extra-index-url https://download.pytorch.org/whl/{cuda_tag}\n")
        for name in sorted(packages, key=str.lower):
            file.write(f"{name}=={packages[name]}\n")

def installed_packages():
    packages = {}
    for distribution in importlib.metadata.distributions():
        name = distribution.metadata["Name"]
        if (name.lower() not in EXCLUDED_PACKAGES):
            packages[name] = distribution.version
    return packages

# Pinned so an upstream change can't stop the models matching the embeddings in the card database.
MODELS = [
    (Settings.CARD_INFERENCE_MODEL_PATH, "openai/clip-vit-base-patch32", "3d74acf9a28c67741b2f4f2ea7635f0aaf6f0268", "CLIPModel", "CLIPProcessor"),
    (Settings.CARD_OCR_MODEL_PATH, "microsoft/trocr-base-printed", "93450be3f1ed40a930690d951ef3932687cc1892", "VisionEncoderDecoderModel", "TrOCRProcessor"),
]

# Files in a model's repository that transformers doesn't need, being for other frameworks or documentation.
MODEL_UNUSED_FILES = [".gitattributes", "*.md", "*.msgpack", "*.h5", "*.onnx", "*.ot"]

def request(url, method="GET"):
    return urllib.request.urlopen(urllib.request.Request(url, method=method, headers={"User-Agent": "libre-card-sorter-build"}))

def download_size(url):
    with request(url, "HEAD") as response:
        return int(response.headers["Content-Length"])

def download_sha256(url):
    digest = hashlib.sha256()
    with request(url) as response:
        for chunk in iter(lambda: response.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()

def write_requirements(path, index_url, packages):
    with open(path, "w") as file:
        file.write(f"--index-url {index_url}\n")
        file.write("--extra-index-url https://pypi.org/simple\n")
        for name in sorted(packages, key=str.lower):
            file.write(f"{name}=={packages[name]}\n")

# Builds packages without their optional compiled extensions, which would be built against the build machine's
# libraries (e.g. PyYAML's against libyaml, which GitHub's runners have), so may not run on the users'.
WHEEL_BUILD_ENVIRONMENT = {"PYYAML_FORCE_LIBYAML": "0"}

def file_sha256(path):
    digest = hashlib.sha256()
    with open(path, "rb") as file:
        for chunk in iter(lambda: file.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()

# Asks pip which wheel it would download for each package, for the runtime's platform, without downloading them. A
# package with no wheel for it is built into one here and shipped in the package, as setup installs offline.
def resolve_wheels(python, index_url, packages, wheels_dir):
    with tempfile.TemporaryDirectory() as work_dir:
        requirements_path = os.path.join(work_dir, "requirements.txt")
        report_path = os.path.join(work_dir, "report.json")
        write_requirements(requirements_path, index_url, packages)
        run_runtime_python([python, "-m", "pip", "install", "--dry-run", "--ignore-installed", "--no-deps", "--quiet", "--disable-pip-version-check", "--report", report_path, "-r", requirements_path])
        with open(report_path) as file:
            report = json.load(file)

    wheels = []
    for item in report["install"]:
        url = item["download_info"]["url"]
        name = os.path.basename(urllib.parse.unquote(url))
        if (name.endswith(".whl")):
            print(f"Resolved {name}")
            wheels.append({"name": name, "url": url, "sha256": item["download_info"]["archive_info"]["hashes"]["sha256"], "size": download_size(url)})
            continue

        with tempfile.TemporaryDirectory() as build_dir:
            run_runtime_python([python, "-m", "pip", "wheel", "--no-deps", "--quiet", "--disable-pip-version-check", "--wheel-dir", build_dir, url], WHEEL_BUILD_ENVIRONMENT)
            name = os.listdir(build_dir)[0]
            os.makedirs(wheels_dir, exist_ok=True)
            # Kept from the first variant that needs it, as a rebuild needn't be byte-identical to match its hash.
            if (not os.path.exists(os.path.join(wheels_dir, name))):
                shutil.copy2(os.path.join(build_dir, name), os.path.join(wheels_dir, name))
        print(f"Built {name}")
        path = os.path.join(wheels_dir, name)
        # Compiled code would be built against this machine's libraries, so may not run on the users'.
        with zipfile.ZipFile(path) as wheel:
            for member in wheel.namelist():
                if (member.endswith(".so")):
                    raise RuntimeError(f"{name} was built with compiled code ({member}), which may not run on other machines.")
        wheels.append({"name": name, "sha256": file_sha256(path), "size": os.path.getsize(path)})
    return wheels

# One set of wheels with the virtual environment's CUDA build of torch, for machines whose GPU it supports, and one
# with the CPU build in its place, for everything else. PyQt is left out, as the package already has it.
def package_variants(python, packages, wheels_dir):
    import torch

    cuda_tag = packages["torch"].partition("+")[2]
    if (not cuda_tag.startswith("cu")):
        raise RuntimeError(f"Expected a CUDA build of torch in the virtual environment, found {packages['torch']}")

    compute_capabilities = []
    # The architectures torch was built for, which unlike torch.cuda.get_arch_list() doesn't need a GPU to tell.
    for arch in torch._C._cuda_getArchFlags().split():
        if (arch.startswith("sm_")):
            digits = re.match(r"\d+", arch[3:]).group()
            compute_capabilities.append((int(digits[:-1]), int(digits[-1])))

    cuda_packages = {}
    cpu_packages = {}
    for name in packages:
        if (name.lower().startswith("pyqt6")):
            continue
        cuda_packages[name] = packages[name]
        if (not name.lower().startswith("nvidia-") and not name.lower().startswith("cuda-")):
            cpu_packages[name] = packages[name].replace(f"+{cuda_tag}", "+cpu")

    return [
        {"cuda_driver_major_version": int(torch.version.cuda.split(".")[0]), "compute_capability": min(compute_capabilities), "wheels": resolve_wheels(python, f"https://download.pytorch.org/whl/{cuda_tag}", cuda_packages, wheels_dir)},
        {"wheels": resolve_wheels(python, "https://download.pytorch.org/whl/cpu", cpu_packages, wheels_dir)},
    ]

# The database is stored with Git LFS, and setup downloads whatever's latest on the main branch of the repository's
# GitHub remote, checked against the hash in its LFS pointer there. Its size there now only weights the overall
# progress; it's read from the pointer, so the build doesn't need the database itself.
def database_download():
    database_path = Settings.CARD_INFERENCE_DATABASE_PATH
    def git(*arguments):
        return subprocess.run(["git", *arguments], cwd=os.path.dirname(database_path), capture_output=True, text=True, check=True).stdout.strip()

    repository = re.fullmatch(r"(?:https://github\.com/|git@github\.com:)(.+?)(?:\.git)?", git("remote", "get-url", "origin")).group(1)
    repository_path = git("ls-files", "--full-name", database_path)
    git("fetch", "--quiet", "origin", "main")
    if (not git("ls-tree", "--full-tree", "origin/main", "--", repository_path)):
        raise RuntimeError(f"{repository_path} isn't on origin's main branch, which first-run setup downloads it from.")
    pointer = git("show", f"origin/main:{repository_path}")
    return {
        "pointer_url": f"https://raw.githubusercontent.com/{repository}/main/{repository_path}",
        "url": f"https://media.githubusercontent.com/media/{repository}/main/{repository_path}",
        "estimated_size": int(re.search(r"^size (\d+)$", pointer, re.MULTILINE).group(1)),
    }

def model_downloads():
    models = []
    for path, repository, revision, model_class, processor_class in MODELS:
        with request(f"https://huggingface.co/api/models/{repository}/revision/{revision}?blobs=true") as response:
            siblings = json.load(response)["siblings"]

        names = []
        for sibling in siblings:
            unused = False
            for pattern in MODEL_UNUSED_FILES:
                if (fnmatch.fnmatch(sibling["rfilename"], pattern)):
                    unused = True
            if (not unused):
                names.append(sibling["rfilename"])
        has_safetensors = False
        for name in names:
            if (name.endswith(".safetensors")):
                has_safetensors = True

        files = []
        for sibling in siblings:
            name = sibling["rfilename"]
            if (name not in names or (has_safetensors and name.endswith(".bin"))):
                continue
            url = f"https://huggingface.co/{repository}/resolve/{revision}/{name}"
            # Hugging Face only lists hashes of files stored with LFS; the rest are small enough to hash here.
            sha256 = sibling["lfs"]["sha256"] if (sibling.get("lfs")) else download_sha256(url)
            files.append({"name": name, "url": url, "sha256": sha256, "size": sibling["size"]})
        print(f"Resolved {repository}")
        models.append({"path": os.path.relpath(path, TRAINING_DIR), "model_class": model_class, "processor_class": processor_class, "files": files})
    return models

# Everything first-run setup downloads, with each file's size so it can show overall progress, and hash to check it.
def write_setup(setup_dir, python, packages):
    setup = {
        "variants": package_variants(python, packages, os.path.join(setup_dir, "wheels")),
        "database": database_download(),
        "models": model_downloads(),
    }
    with open(os.path.join(setup_dir, "setup.json"), "w") as file:
        json.dump(setup, file, indent=4)

def install_python_runtime(app_dir):
    with tempfile.TemporaryDirectory() as download_dir:
        archive_path = os.path.join(download_dir, "python.tar.gz")
        print(f"Downloading {PYTHON_RUNTIME_URL}")
        urllib.request.urlretrieve(PYTHON_RUNTIME_URL, archive_path)
        with tarfile.open(archive_path) as archive:
            archive.extractall(app_dir, filter="data")

def used_qt_modules():
    modules = set()
    for root, dirs, files in os.walk(UI_DIR):
        for name in list(dirs):
            if (name in NON_APP_FILES):
                dirs.remove(name)
        for name in files:
            if (not name.endswith(".py")):
                continue
            with open(os.path.join(root, name)) as file:
                text = file.read()
            for match in QT_MODULE_PATTERN.finditer(text):
                if (match.group(1)):
                    modules.add(match.group(1))
                else:
                    for module in match.group(2).split(","):
                        modules.add(module.strip())
    return modules

def remove_path(path):
    if (os.path.isdir(path)):
        shutil.rmtree(path)
    else:
        os.remove(path)

# PyQt's wheels hold all of Qt, but the app uses a few of its modules; this keeps those modules, the plugins they use
# and the Qt libraries any of them link to.
def prune_qt(site_packages_dir):
    pyqt_dir = os.path.join(site_packages_dir, "PyQt6")
    qt_dir = os.path.join(pyqt_dir, "Qt6")
    lib_dir = os.path.join(qt_dir, "lib")
    plugins_dir = os.path.join(qt_dir, "plugins")

    modules = used_qt_modules()
    for name in os.listdir(pyqt_dir):
        path = os.path.join(pyqt_dir, name)
        if (os.path.isfile(path) and name.startswith("Qt") and name.split(".")[0] not in modules):
            os.remove(path)
    for name in os.listdir(qt_dir):
        if (name not in ["lib", "plugins"]):
            remove_path(os.path.join(qt_dir, name))
    for name in os.listdir(plugins_dir):
        if (name not in QT_PLUGIN_DIRS):
            remove_path(os.path.join(plugins_dir, name))

    binaries = []
    for name in os.listdir(pyqt_dir):
        if (name.endswith(".so")):
            binaries.append(os.path.join(pyqt_dir, name))
    for root, dirs, files in os.walk(plugins_dir):
        for name in files:
            binaries.append(os.path.join(root, name))

    # ldd lists every library a binary needs, including indirectly.
    needed = set()
    for binary in binaries:
        output = subprocess.run(["ldd", binary], capture_output=True, text=True, check=True).stdout
        for line in output.splitlines():
            parts = line.split(" => ")
            if (len(parts) == 2 and os.path.realpath(parts[1].split(" (")[0].strip()).startswith(os.path.realpath(lib_dir))):
                needed.add(os.path.basename(parts[1].split(" (")[0].strip()))
    for name in os.listdir(lib_dir):
        if (name not in needed):
            remove_path(os.path.join(lib_dir, name))

LAUNCHER = """#!/bin/sh
# Runs first-run setup, which downloads what the package leaves out, then the app. Python is kept to the package's own
# packages, not the user's (~/.local) or PYTHONPATH, which setup's steps and pip inherit.
DIR="$(dirname "$(readlink -f "$0")")"
unset PYTHONPATH PYTHONHOME
export PYTHONNOUSERSITE=1
"$DIR/python/bin/python3" "$DIR/app/Bootstrap.py" && exec "$DIR/python/bin/python3" "$DIR/app/Main.py" "$@"
"""

def write_launcher(app_dir):
    path = os.path.join(app_dir, APP_NAME)
    with open(path, "w") as file:
        file.write(LAUNCHER)
    os.chmod(path, os.stat(path).st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)

# The zip sits beside the build's folder, named the same, and holds that folder.
def zip_build(build_dir):
    zip_path = f"{build_dir}.zip"
    print(f"Zipping to {zip_path}")
    if (os.path.exists(zip_path)):
        os.remove(zip_path)
    shutil.make_archive(build_dir, "zip", root_dir=os.path.dirname(build_dir), base_dir=os.path.basename(build_dir))
    print(f"Zipped to {zip_path}")

def main():
    parser = argparse.ArgumentParser(description="Packages the UI into a standalone build.")
    parser.add_argument("--force", action="store_true", help="Replace an existing build of this version.")
    parser.add_argument("--no-zip", action="store_true", help="Skip zipping the build, e.g. to try it out first.")
    parser.add_argument("--zip-only", action="store_true", help="Zip an existing build of this version (e.g. one built with --no-zip) without rebuilding it.")
    args = parser.parse_args()

    build_dir = os.path.join(UI_DIR, "Builds", Settings.VERSION)
    zip_path = f"{build_dir}.zip"
    if (args.zip_only):
        if (not os.path.isdir(build_dir)):
            print(f"There's no build of version {Settings.VERSION} in {os.path.dirname(build_dir)} to zip.")
            return 1
        zip_build(build_dir)
        return 0

    if (sys.platform != "linux" or platform.machine() != "x86_64"):
        print("Only x86-64 Linux builds are supported so far.")
        return 1
    if (sys.version_info[:2] != PYTHON_RUNTIME_VERSION):
        print(f"The virtual environment runs Python {sys.version_info[0]}.{sys.version_info[1]}, but PYTHON_RUNTIME_URL is for {PYTHON_RUNTIME_VERSION[0]}.{PYTHON_RUNTIME_VERSION[1]}; update PYTHON_RUNTIME_URL to match.")
        return 1

    if (os.path.exists(build_dir) or os.path.exists(zip_path)):
        if (not args.force):
            print(f"A build of version {Settings.VERSION} already exists in {os.path.dirname(build_dir)}. Bump Settings.VERSION, or pass --force to replace it.")
            return 1
        if (os.path.exists(build_dir)):
            shutil.rmtree(build_dir)
        if (os.path.exists(zip_path)):
            os.remove(zip_path)

    app_dir = os.path.join(build_dir, APP_NAME)
    setup_dir = os.path.join(app_dir, "setup")
    os.makedirs(setup_dir)
    install_python_runtime(app_dir)
    python = os.path.join(app_dir, "python", "bin", "python3")

    packages = installed_packages()
    write_lock(packages)

    # PyQt is installed up front, as the first-run setup's window needs it.
    qt_packages = []
    for name in packages:
        if (name.lower().startswith("pyqt6")):
            qt_packages.append(f"{name}=={packages[name]}")
    run_runtime_python([python, "-m", "pip", "install", "--no-deps", "--no-cache-dir", "--disable-pip-version-check", "--no-warn-script-location"] + qt_packages)
    site_packages_dir = run_runtime_python([python, "-c", "import sysconfig; print(sysconfig.get_path('purelib'))"], capture_output=True, text=True).stdout.strip()
    prune_qt(site_packages_dir)
    write_setup(setup_dir, python, packages)

    shutil.copytree(UI_DIR, os.path.join(app_dir, "app"), ignore=shutil.ignore_patterns(*NON_APP_FILES))
    write_launcher(app_dir)

    print(f"Built version {Settings.VERSION} in {app_dir}")
    if (not args.no_zip):
        zip_build(build_dir)
    return 0

if __name__ == "__main__":
    sys.exit(main())
