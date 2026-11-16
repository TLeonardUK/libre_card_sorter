# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

# Started by a packaged build's launcher on every platform (see Scripts/PackageBuild.py), with Python kept to the
# package's own packages, not the user's or PYTHONPATH. Runs first-run setup, then the app with the packages it
# downloaded.

import os
import runpy
import subprocess
import sys
from Settings import RUNTIME_DIR

APP_DIR = os.path.dirname(os.path.abspath(__file__))
PACKAGES_DIR = os.path.join(RUNTIME_DIR, "packages")

def main():
    # For setup's steps and pip, which it starts without the launcher's options.
    os.environ.pop("PYTHONHOME", None)
    os.environ["PYTHONNOUSERSITE"] = "1"
    os.environ["PYTHONPATH"] = PACKAGES_DIR
    if (subprocess.run([sys.executable, os.path.join(APP_DIR, "Bootstrap.py")]).returncode != 0):
        return

    sys.path.insert(1, PACKAGES_DIR)
    sys.argv[0] = os.path.join(APP_DIR, "Main.py")
    runpy.run_path(sys.argv[0], run_name="__main__")

if __name__ == "__main__":
    main()
