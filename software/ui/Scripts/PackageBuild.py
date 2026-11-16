# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

# Packages the UI for the platform it's run on, into Builds/LibreCardSorter-<version>-<platform>-<arch>.<ext> (an
# AppImage on Linux, a zip on Windows, a disk image on macOS) that runs without Python or the repository, leaving the
# folder it's made from in Builds/<version>/. The version is Settings.VERSION. The package holds a Python runtime with
# only PyQt installed and the app; Bootstrap.py downloads the rest on first run: the packages, resolved here for the
# platform from the versions pinned in requirements-lock.json, the models, and the latest card database on the main
# branch of the repository's GitHub remote.
#
#   cd software/ui
#   .venv/bin/python Scripts/PackageBuild.py
#
# Run with the UI's virtual environment (a CUDA build of torch on Linux), it first rewrites requirements-lock.json from
# it. Anywhere else (e.g. the GitHub release workflow) it only needs PyQt installed.

import argparse
import fnmatch
import hashlib
import importlib.metadata
import json
import os
import platform
import plistlib
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

# A relocatable build of CPython for each platform. Its minor version must match the lock's, as the pinned packages
# are for it.
PYTHON_RUNTIME_URL = "https://github.com/astral-sh/python-build-standalone/releases/download/20261110/cpython-3.15.2+20261110-{target}-install_only_stripped.tar.gz"
PYTHON_RUNTIME_VERSION = "3.15"

# For each platform the package is built for: its name in the package's filename, its Python runtime and where the
# runtime's python is, and whether there's a CUDA build of torch for it (there's none for macOS).
PLATFORMS = {
    ("linux", "x86_64"): {"name": "linux-x86_64", "runtime": "x86_64-unknown-linux-gnu", "python": "python/bin/python3", "cuda": True},
    ("win32", "AMD64"): {"name": "windows-x86_64", "runtime": "x86_64-pc-windows-msvc", "python": "python/python.exe", "cuda": True},
    ("darwin", "arm64"): {"name": "macos-arm64", "runtime": "aarch64-apple-darwin", "python": "python/bin/python3", "cuda": False},
}

# Torch only uses triton to compile models, which the app doesn't; without it torch runs as normal, and it's ~1GB.
EXCLUDED_PACKAGES = ["pip", "triton"]

# The parts of the UI folder that aren't the app.
NON_APP_FILES = [".venv", ".vscode", "Builds", "Scripts", "__pycache__", "requirements.txt", "requirements-lock.json"]

# The virtual environment's top-level requirements (from requirements.txt) and exact packages, with what its CUDA
# build of torch needs, so packages can be built for any platform from the versions it was tested with.
LOCK_PATH = os.path.join(UI_DIR, "requirements-lock.json")

def canonical_name(name):
    return re.sub(r"[-_.]+", "-", name).lower()

def write_lock():
    import torch

    packages = {}
    for distribution in importlib.metadata.distributions():
        if (canonical_name(distribution.metadata["Name"]) not in EXCLUDED_PACKAGES):
            packages[canonical_name(distribution.metadata["Name"])] = distribution.version

    requirements = []
    with open(os.path.join(UI_DIR, "requirements.txt")) as file:
        for line in file:
            line = line.strip()
            if (line and not line.startswith("#") and not line.startswith("-")):
                requirements.append(canonical_name(re.match(r"[\w.-]+", line).group()))

    compute_capabilities = []
    # The architectures torch was built for, which unlike torch.cuda.get_arch_list() doesn't need a GPU to tell.
    for arch in torch._C._cuda_getArchFlags().split():
        if (arch.startswith("sm_")):
            digits = re.match(r"\d+", arch[3:]).group()
            compute_capabilities.append((int(digits[:-1]), int(digits[-1])))

    lock = {
        "python": f"{sys.version_info[0]}.{sys.version_info[1]}",
        "requirements": sorted(requirements),
        "packages": dict(sorted(packages.items())),
        "torch_cuda": {"tag": packages["torch"].partition("+")[2], "driver_major_version": int(torch.version.cuda.split(".")[0]), "compute_capability": min(compute_capabilities)},
    }
    with open(LOCK_PATH, "w") as file:
        json.dump(lock, file, indent=4)

def is_ui_virtual_environment():
    return os.path.realpath(sys.prefix) == os.path.realpath(os.path.join(UI_DIR, ".venv"))

# Runs the package's Python as the launcher does, seeing only its own packages, not the user's or PYTHONPATH.
def run_runtime_python(arguments, environment_overrides={}, **options):
    environment = dict(os.environ, PYTHONNOUSERSITE="1", **environment_overrides)
    environment.pop("PYTHONPATH", None)
    environment.pop("PYTHONHOME", None)
    return subprocess.run(arguments, env=environment, check=True, **options)

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

def file_sha256(path):
    digest = hashlib.sha256()
    with open(path, "rb") as file:
        for chunk in iter(lambda: file.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()

# Builds packages without their optional compiled extensions, which would be built against the build machine's
# libraries (e.g. PyYAML's against libyaml, which GitHub's runners have), so may not run on the users'.
WHEEL_BUILD_ENVIRONMENT = {"PYYAML_FORCE_LIBYAML": "0"}

# Asks pip which wheels it would download for the requirements, for the runtime's platform, without downloading them.
# The lock's versions constrain every package it has, so the platform gets the versions that were tested, plus any
# it needs that the lock's platform doesn't. A package with no wheel for it is built into one here and shipped in the
# package, as setup installs offline. PyQt is left out, as the package already has it.
def resolve_wheels(python, index_urls, requirements, constraints, wheels_dir):
    with tempfile.TemporaryDirectory() as work_dir:
        requirements_path = os.path.join(work_dir, "requirements.txt")
        constraints_path = os.path.join(work_dir, "constraints.txt")
        report_path = os.path.join(work_dir, "report.json")
        with open(requirements_path, "w") as file:
            file.write(f"--index-url {index_urls[0]}\n")
            for index_url in index_urls[1:]:
                file.write(f"--extra-index-url {index_url}\n")
            for requirement in requirements:
                file.write(f"{requirement}\n")
        with open(constraints_path, "w") as file:
            for constraint in constraints:
                file.write(f"{constraint}\n")
        run_runtime_python([python, "-m", "pip", "install", "--dry-run", "--ignore-installed", "--quiet", "--disable-pip-version-check", "--report", report_path, "-r", requirements_path, "-c", constraints_path])
        with open(report_path) as file:
            report = json.load(file)

    wheels = []
    for item in report["install"]:
        name = canonical_name(item["metadata"]["name"])
        if (name in EXCLUDED_PACKAGES or name.startswith("pyqt6")):
            continue
        url = item["download_info"]["url"]
        file_name = os.path.basename(urllib.parse.unquote(url))
        if (file_name.endswith(".whl")):
            print(f"Resolved {file_name}")
            wheels.append({"name": file_name, "url": url, "sha256": item["download_info"]["archive_info"]["hashes"]["sha256"], "size": download_size(url)})
            continue

        with tempfile.TemporaryDirectory() as build_dir:
            run_runtime_python([python, "-m", "pip", "wheel", "--no-deps", "--quiet", "--disable-pip-version-check", "--wheel-dir", build_dir, url], WHEEL_BUILD_ENVIRONMENT)
            file_name = os.listdir(build_dir)[0]
            os.makedirs(wheels_dir, exist_ok=True)
            # Kept from the first variant that needs it, as a rebuild needn't be byte-identical to match its hash.
            if (not os.path.exists(os.path.join(wheels_dir, file_name))):
                shutil.copy2(os.path.join(build_dir, file_name), os.path.join(wheels_dir, file_name))
        print(f"Built {file_name}")
        path = os.path.join(wheels_dir, file_name)
        # Compiled code would be built against this machine's libraries, so may not run on the users'.
        with zipfile.ZipFile(path) as wheel:
            for member in wheel.namelist():
                if (member.endswith(".so") or member.endswith(".pyd") or member.endswith(".dylib")):
                    raise RuntimeError(f"{file_name} was built with compiled code ({member}), which may not run on other machines.")
        wheels.append({"name": file_name, "sha256": file_sha256(path), "size": os.path.getsize(path)})
    return wheels

# Where there's a CUDA build of torch, one set of wheels with it, for machines whose GPU it supports, and one with the
# CPU build in its place, for everything else; otherwise just the standard build.
def package_variants(lock, target, python, wheels_dir):
    torch_version = lock["packages"]["torch"].partition("+")[0]
    torchvision_version = lock["packages"]["torchvision"].partition("+")[0]
    constraints = []
    for name in lock["packages"]:
        if (name not in ["torch", "torchvision"]):
            constraints.append(f"{name}=={lock['packages'][name]}")

    def requirements(torch_suffix):
        lines = []
        for name in lock["requirements"]:
            if (name == "torch"):
                lines.append(f"torch=={torch_version}{torch_suffix}")
            elif (name == "torchvision"):
                lines.append(f"torchvision=={torchvision_version}{torch_suffix}")
            elif (not name.startswith("pyqt6")):
                lines.append(f"{name}=={lock['packages'][name]}")
        return lines

    # Also macOS's builds, some of which (e.g. torchvision's) are only there.
    cpu_index_urls = ["https://download.pytorch.org/whl/cpu", "https://pypi.org/simple"]
    if (not target["cuda"]):
        return [{"wheels": resolve_wheels(python, cpu_index_urls, requirements(""), constraints, wheels_dir)}]

    cuda = lock["torch_cuda"]
    cuda_index_urls = [f"https://download.pytorch.org/whl/{cuda['tag']}", "https://pypi.org/simple"]
    return [
        {"cuda_driver_major_version": cuda["driver_major_version"], "compute_capability": cuda["compute_capability"], "wheels": resolve_wheels(python, cuda_index_urls, requirements(f"+{cuda['tag']}"), constraints, wheels_dir)},
        {"wheels": resolve_wheels(python, cpu_index_urls, requirements("+cpu"), constraints, wheels_dir)},
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
def write_setup(setup_dir, lock, target, python):
    setup = {
        "variants": package_variants(lock, target, python, os.path.join(setup_dir, "wheels")),
        "database": database_download(),
        "models": model_downloads(),
    }
    with open(os.path.join(setup_dir, "setup.json"), "w") as file:
        json.dump(setup, file, indent=4)

def install_python_runtime(package_dir, target):
    url = PYTHON_RUNTIME_URL.replace("{target}", target["runtime"])
    with tempfile.TemporaryDirectory() as download_dir:
        archive_path = os.path.join(download_dir, "python.tar.gz")
        print(f"Downloading {url}")
        urllib.request.urlretrieve(url, archive_path)
        with tarfile.open(archive_path) as archive:
            archive.extractall(package_dir, filter="data")

QT_MODULE_PATTERN = re.compile(r"PyQt6\.(Qt\w+)|from PyQt6 import ([\w, ]+)")

# The plugins QtGui and QtWidgets use on each platform; the rest are for other Qt modules.
QT_PLUGIN_DIRS = ["egldeviceintegrations", "generic", "iconengines", "imageformats", "platforminputcontexts", "platforms", "platformthemes", "styles", "wayland-decoration-client", "wayland-graphics-integration-client", "wayland-shell-integration", "xcbglintegrations"]

def used_qt_modules():
    modules = set()
    for root, dirs, files in os.walk(UI_DIR):
        for name in list(dirs):
            if (name in NON_APP_FILES):
                dirs.remove(name)
        for name in files:
            if (not name.endswith(".py")):
                continue
            with open(os.path.join(root, name), encoding="utf-8") as file:
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

# PyQt's wheels hold all of Qt, but the app uses a few of its modules; this keeps those modules and the plugins they
# use, and on Linux, where ldd can tell, only the Qt libraries any of them link to.
def prune_qt(site_packages_dir):
    pyqt_dir = os.path.join(site_packages_dir, "PyQt6")
    qt_dir = os.path.join(pyqt_dir, "Qt6")
    plugins_dir = os.path.join(qt_dir, "plugins")

    modules = used_qt_modules()
    for name in os.listdir(pyqt_dir):
        path = os.path.join(pyqt_dir, name)
        if (os.path.isfile(path) and name.startswith("Qt") and name.split(".")[0] not in modules):
            os.remove(path)
    # Qt's libraries are in bin on Windows, lib elsewhere.
    for name in os.listdir(qt_dir):
        if (name not in ["bin", "lib", "plugins"]):
            remove_path(os.path.join(qt_dir, name))
    for name in os.listdir(plugins_dir):
        if (name not in QT_PLUGIN_DIRS):
            remove_path(os.path.join(plugins_dir, name))
    if (sys.platform != "linux"):
        return

    lib_dir = os.path.join(qt_dir, "lib")
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

# Builds the folder a package is made from: the runtime, PyQt, the setup's downloads list and the app.
def build_package_dir(package_dir, lock, target):
    os.makedirs(os.path.join(package_dir, "setup"))
    install_python_runtime(package_dir, target)
    python = os.path.join(package_dir, target["python"])

    # PyQt is installed up front, as the first-run setup's window needs it.
    qt_packages = []
    for name in lock["packages"]:
        if (name.startswith("pyqt6")):
            qt_packages.append(f"{name}=={lock['packages'][name]}")
    run_runtime_python([python, "-m", "pip", "install", "--no-deps", "--no-cache-dir", "--disable-pip-version-check", "--no-warn-script-location"] + qt_packages)
    site_packages_dir = run_runtime_python([python, "-c", "import sysconfig; print(sysconfig.get_path('purelib'))"], capture_output=True, text=True).stdout.strip()
    prune_qt(site_packages_dir)
    write_setup(os.path.join(package_dir, "setup"), lock, target, python)

    app_source_dir = os.path.join(package_dir, "app")
    shutil.copytree(UI_DIR, app_source_dir, ignore=shutil.ignore_patterns(*NON_APP_FILES))
    # The app and the runtime are compiled now, as Python can't save its compiled copies into a read-only package (or,
    # on macOS, without breaking its signature), so would redo it each run.
    run_runtime_python([python, "-m", "compileall", "-q", package_dir])
    return site_packages_dir

def write_executable(path, text):
    with open(path, "w", newline="\n") as file:
        file.write(text)
    os.chmod(path, os.stat(path).st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)

APPIMAGETOOL_URL = "https://github.com/AppImage/appimagetool/releases/download/1.9.1/appimagetool-x86_64.AppImage"

# Each platform's launcher just starts app/Launch.py, with Python kept to the package's own packages, not the user's
# or PYTHONPATH.
APP_RUN = """#!/bin/sh
HERE="${APPDIR:-$(dirname "$(readlink -f "$0")")}"
exec "$HERE/python/bin/python3" -s -E "$HERE/app/Launch.py" "$@"
"""

DESKTOP_ENTRY = """[Desktop Entry]
Type=Application
Name=Libre Card Sorter
Exec=AppRun
Icon=libre-card-sorter
Categories=Utility;
Terminal=false
"""

def build_linux_package(build_dir, package_path, lock, target):
    app_dir = os.path.join(build_dir, f"{APP_NAME}.AppDir")
    build_package_dir(app_dir, lock, target)
    write_executable(os.path.join(app_dir, "AppRun"), APP_RUN)
    with open(os.path.join(app_dir, "libre-card-sorter.desktop"), "w") as file:
        file.write(DESKTOP_ENTRY)
    shutil.copy2(Settings.APP_ICON_PATH, os.path.join(app_dir, "libre-card-sorter.svg"))
    os.symlink("libre-card-sorter.svg", os.path.join(app_dir, ".DirIcon"))

    print(f"Building {package_path}")
    with tempfile.TemporaryDirectory() as tool_dir:
        tool_path = os.path.join(tool_dir, "appimagetool")
        urllib.request.urlretrieve(APPIMAGETOOL_URL, tool_path)
        os.chmod(tool_path, stat.S_IRWXU)
        # Extracted rather than mounted, as FUSE isn't available everywhere it's built (e.g. GitHub's runners).
        subprocess.run([tool_path, app_dir, package_path], env=dict(os.environ, APPIMAGE_EXTRACT_AND_RUN="1", ARCH="x86_64"), check=True)

# Run by the Windows launcher, from the zip appended to it; argv[0] is the launcher.
WINDOWS_LAUNCHER_MAIN = """import os, runpy, sys
app_dir = os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), "app")
sys.path.insert(0, app_dir)
runpy.run_path(os.path.join(app_dir, "Launch.py"), run_name="__main__")
"""

# The launcher pip makes .exe scripts with, which runs the Python named on the line after it (relative to itself, with
# <launcher_dir>) on the zip after that. pythonw.exe, as it's a GUI app, so has no console window.
def write_windows_launcher(path, site_packages_dir):
    with open(os.path.join(site_packages_dir, "pip", "_vendor", "distlib", "w64.exe"), "rb") as file:
        launcher = file.read()
    script = tempfile.SpooledTemporaryFile()
    with zipfile.ZipFile(script, "w") as archive:
        archive.writestr("__main__.py", WINDOWS_LAUNCHER_MAIN)
    script.seek(0)
    with open(path, "wb") as file:
        file.write(launcher)
        file.write(b'#!"<launcher_dir>\\python\\pythonw.exe" -s -E\n')
        file.write(script.read())

def build_windows_package(build_dir, package_path, lock, target):
    package_dir = os.path.join(build_dir, APP_NAME)
    site_packages_dir = build_package_dir(package_dir, lock, target)
    write_windows_launcher(os.path.join(package_dir, f"{APP_NAME}.exe"), site_packages_dir)

    print(f"Building {package_path}")
    shutil.make_archive(package_path[:-len(".zip")], "zip", root_dir=build_dir, base_dir=APP_NAME)

MACOS_LAUNCHER = """#!/bin/sh
RESOURCES="$(cd "$(dirname "$0")/../Resources" && pwd)"
exec "$RESOURCES/python/bin/python3" -s -E "$RESOURCES/app/Launch.py" "$@"
"""

# Renders the app's icon at the sizes macOS wants, into its icon format.
def write_macos_icon(path):
    os.environ["QT_QPA_PLATFORM"] = "offscreen"
    from PyQt6.QtCore import QSize
    from PyQt6.QtGui import QGuiApplication, QImageReader

    app = QGuiApplication([])
    with tempfile.TemporaryDirectory() as work_dir:
        iconset_dir = os.path.join(work_dir, "AppIcon.iconset")
        os.makedirs(iconset_dir)
        for size in [16, 32, 128, 256, 512]:
            for scale in [1, 2]:
                reader = QImageReader(Settings.APP_ICON_PATH)
                reader.setScaledSize(QSize(size * scale, size * scale))
                image = reader.read()
                if (image.isNull()):
                    raise RuntimeError(f"Couldn't render {Settings.APP_ICON_PATH}: {reader.errorString()}")
                image.save(os.path.join(iconset_dir, f"icon_{size}x{size}{'@2x' if (scale == 2) else ''}.png"))
        subprocess.run(["iconutil", "-c", "icns", "-o", path, iconset_dir], check=True)

def build_macos_package(build_dir, package_path, lock, target):
    image_dir = os.path.join(build_dir, "image")
    contents_dir = os.path.join(image_dir, f"{APP_NAME}.app", "Contents")
    build_package_dir(os.path.join(contents_dir, "Resources"), lock, target)
    os.makedirs(os.path.join(contents_dir, "MacOS"))
    write_executable(os.path.join(contents_dir, "MacOS", APP_NAME), MACOS_LAUNCHER)
    write_macos_icon(os.path.join(contents_dir, "Resources", "AppIcon.icns"))
    info = {
        "CFBundleName": "Libre Card Sorter",
        "CFBundleDisplayName": "Libre Card Sorter",
        "CFBundleIdentifier": "io.github.tleonarduk.librecardsorter",
        "CFBundleVersion": Settings.VERSION,
        "CFBundleShortVersionString": Settings.VERSION,
        "CFBundleExecutable": APP_NAME,
        "CFBundleIconFile": "AppIcon",
        "CFBundlePackageType": "APPL",
        # The oldest macOS torch's wheels support.
        "LSMinimumSystemVersion": "14.0",
        "NSHighResolutionCapable": True,
    }
    with open(os.path.join(contents_dir, "Info.plist"), "wb") as file:
        plistlib.dump(info, file)
    # Apple silicon Macs won't run unsigned code; without a developer certificate this is signed ad hoc, which they run
    # once the user allows it in System Settings' Privacy & Security.
    subprocess.run(["codesign", "--force", "--deep", "--sign", "-", os.path.dirname(contents_dir)], check=True)
    # So the disk image shows the app beside Applications, to drag it into.
    os.symlink("/Applications", os.path.join(image_dir, "Applications"))

    print(f"Building {package_path}")
    subprocess.run(["hdiutil", "create", "-volname", "Libre Card Sorter", "-srcfolder", image_dir, "-format", "UDZO", "-ov", package_path], check=True)

PACKAGE_BUILDERS = {
    "linux-x86_64": (build_linux_package, "AppImage"),
    "windows-x86_64": (build_windows_package, "zip"),
    "macos-arm64": (build_macos_package, "dmg"),
}

def main():
    parser = argparse.ArgumentParser(description="Packages the UI for the platform it's run on.")
    parser.add_argument("--force", action="store_true", help="Replace an existing build of this version.")
    args = parser.parse_args()

    target = PLATFORMS.get((sys.platform, platform.machine()))
    if (not target):
        print(f"Packages can't be built for {sys.platform} on {platform.machine()}; only for {', '.join(PACKAGE_BUILDERS)}.")
        return 1

    if (is_ui_virtual_environment()):
        write_lock()
    with open(LOCK_PATH) as file:
        lock = json.load(file)
    if (lock["python"] != PYTHON_RUNTIME_VERSION):
        print(f"The lock's packages are for Python {lock['python']}, but PYTHON_RUNTIME_URL is for {PYTHON_RUNTIME_VERSION}; update PYTHON_RUNTIME_URL to match.")
        return 1

    builder, extension = PACKAGE_BUILDERS[target["name"]]
    build_dir = os.path.join(UI_DIR, "Builds", Settings.VERSION)
    package_path = os.path.join(UI_DIR, "Builds", f"{APP_NAME}-{Settings.VERSION}-{target['name']}.{extension}")
    if (os.path.exists(build_dir) or os.path.exists(package_path)):
        if (not args.force):
            print(f"A build of version {Settings.VERSION} already exists in {os.path.dirname(build_dir)}. Bump Settings.VERSION, or pass --force to replace it.")
            return 1
        if (os.path.exists(build_dir)):
            shutil.rmtree(build_dir)
        if (os.path.exists(package_path)):
            os.remove(package_path)

    builder(build_dir, package_path, lock, target)
    print(f"Built {package_path}")
    return 0

if __name__ == "__main__":
    sys.exit(main())
