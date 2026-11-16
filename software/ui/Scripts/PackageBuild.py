# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

# Packages the UI into a standalone folder, Builds/<version>/, that runs without Python or the repository. The version
# is Settings.VERSION. The package holds a Python runtime with only PyQt installed and the app; Bootstrap.py downloads
# the rest on first run: pinned versions of what's installed in the UI's virtual environment, so it must be run with
# that, and the card database as committed to the repository's GitHub remote, so it must be pushed first:
#
#   cd software/ui
#   .venv/bin/python Scripts/PackageBuild.py

import argparse
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
import urllib.request

UI_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, UI_DIR)

from Settings import Settings

APP_NAME = "LibreCardSorter"

# A relocatable build of CPython. Its minor version must match the virtual environment's, as the pinned packages are
# built for it.
PYTHON_RUNTIME_URL = "https://github.com/astral-sh/python-build-standalone/releases/download/20261110/cpython-3.15.2+20261110-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz"
PYTHON_RUNTIME_VERSION = (3, 15)

# Torch only uses triton to compile models, which the app doesn't; without it torch runs as normal, and it's ~1GB.
EXCLUDED_PACKAGES = ["pip", "triton"]

# The parts of the UI folder that aren't the app.
NON_APP_FILES = [".venv", ".vscode", "Builds", "Scripts", "__pycache__", "requirements.txt"]

# The plugins QtGui and QtWidgets use; the rest are for other Qt modules.
QT_PLUGIN_DIRS = ["egldeviceintegrations", "generic", "iconengines", "imageformats", "platforminputcontexts", "platforms", "platformthemes", "wayland-decoration-client", "wayland-graphics-integration-client", "wayland-shell-integration", "xcbglintegrations"]

QT_MODULE_PATTERN = re.compile(r"PyQt6\.(Qt\w+)|from PyQt6 import ([\w, ]+)")

def installed_packages():
    packages = {}
    for distribution in importlib.metadata.distributions():
        name = distribution.metadata["Name"]
        if (name.lower() not in EXCLUDED_PACKAGES):
            packages[name] = distribution.version
    return packages

def write_requirements(path, index_url, packages):
    with open(path, "w") as file:
        file.write(f"--index-url {index_url}\n")
        file.write("--extra-index-url https://pypi.org/simple\n")
        for name in sorted(packages, key=str.lower):
            file.write(f"{name}=={packages[name]}\n")

# One set of requirements with the virtual environment's CUDA build of torch, for machines whose GPU it supports, and
# one with the CPU build in its place, for everything else.
def write_variants(setup_dir, packages):
    import torch

    cuda_tag = packages["torch"].partition("+")[2]
    if (not cuda_tag.startswith("cu")):
        raise RuntimeError(f"Expected a CUDA build of torch in the virtual environment, found {packages['torch']}")

    compute_capabilities = []
    for arch in torch.cuda.get_arch_list():
        if (arch.startswith("sm_")):
            digits = re.match(r"\d+", arch[3:]).group()
            compute_capabilities.append((int(digits[:-1]), int(digits[-1])))

    cpu_packages = {}
    for name in packages:
        if (name.lower().startswith("nvidia-") or name.lower().startswith("cuda-")):
            continue
        cpu_packages[name] = packages[name].replace(f"+{cuda_tag}", "+cpu")

    write_requirements(os.path.join(setup_dir, f"{cuda_tag}.txt"), f"https://download.pytorch.org/whl/{cuda_tag}", packages)
    write_requirements(os.path.join(setup_dir, "cpu.txt"), "https://download.pytorch.org/whl/cpu", cpu_packages)
    variants = [
        {"requirements": f"{cuda_tag}.txt", "cuda_driver_major_version": int(torch.version.cuda.split(".")[0]), "compute_capability": min(compute_capabilities)},
        {"requirements": "cpu.txt"},
    ]
    with open(os.path.join(setup_dir, "variants.json"), "w") as file:
        json.dump(variants, file, indent=4)

# The database is stored with Git LFS, so its contents are served at GitHub's media URL for the commit that last
# changed it. That commit is checked to be pushed, and the database unchanged since, so the package gets the database
# it was built and tested with.
def write_database_download(setup_dir):
    database_path = Settings.CARD_INFERENCE_DATABASE_PATH
    def git(*arguments):
        return subprocess.run(["git", *arguments], cwd=os.path.dirname(database_path), capture_output=True, text=True, check=True).stdout.strip()

    if (git("status", "--porcelain", "--", database_path)):
        raise RuntimeError(f"{database_path} has uncommitted changes; commit and push it first.")
    commit = git("log", "-1", "--format=%H", "--", database_path)
    if (not git("branch", "--remotes", "--contains", commit)):
        raise RuntimeError(f"The commit with the current card database ({commit}) hasn't been pushed; push it first.")
    repository = re.fullmatch(r"(?:https://github\.com/|git@github\.com:)(.+?)(?:\.git)?", git("remote", "get-url", "origin")).group(1)
    repository_path = git("ls-files", "--full-name", database_path)

    digest = hashlib.sha256()
    with open(database_path, "rb") as file:
        for chunk in iter(lambda: file.read(1024 * 1024), b""):
            digest.update(chunk)
    database = {
        "url": f"https://media.githubusercontent.com/media/{repository}/{commit}/{repository_path}",
        "sha256": digest.hexdigest(),
        "size": os.path.getsize(database_path),
    }
    with open(os.path.join(setup_dir, "database.json"), "w") as file:
        json.dump(database, file, indent=4)

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
# Runs first-run setup, which downloads what the package leaves out, then the app.
DIR="$(dirname "$(readlink -f "$0")")"
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
    write_database_download(setup_dir)
    install_python_runtime(app_dir)
    python = os.path.join(app_dir, "python", "bin", "python3")

    packages = installed_packages()
    write_variants(setup_dir, packages)

    # PyQt is installed up front, as the first-run setup's window needs it.
    qt_packages = []
    for name in packages:
        if (name.lower().startswith("pyqt6")):
            qt_packages.append(f"{name}=={packages[name]}")
    subprocess.run([python, "-m", "pip", "install", "--no-deps", "--no-cache-dir", "--disable-pip-version-check", "--no-warn-script-location"] + qt_packages, check=True)
    site_packages_dir = subprocess.run([python, "-c", "import sysconfig; print(sysconfig.get_path('purelib'))"], capture_output=True, text=True, check=True).stdout.strip()
    prune_qt(site_packages_dir)

    shutil.copytree(UI_DIR, os.path.join(app_dir, "app"), ignore=shutil.ignore_patterns(*NON_APP_FILES))
    write_launcher(app_dir)

    print(f"Built version {Settings.VERSION} in {app_dir}")
    if (not args.no_zip):
        zip_build(build_dir)
    return 0

if __name__ == "__main__":
    sys.exit(main())
