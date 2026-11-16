# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

import requests
import os
import io
import threading

# Downloads an file to disk
def download_file(from_path, to_path):
    headers = {
        'User-Agent': 'MTG Card Sorter',
        'From': 'me@timleonard.uk'
    }

    if (from_path == ""):
        return True

    try:
        to_dir = os.path.dirname(to_path)
        if not os.path.exists(to_dir):
            os.makedirs(to_dir)
    except FileExistsError:
        pass
    
    print(f"Downloading: {from_path}")

    try:
        response = requests.get(from_path, headers=headers)
        response.raise_for_status()
        
        if response.status_code == 200:
            # Written beside the file and renamed when complete, so an interrupted download or another thread fetching
            # the same file never leaves a partial one in its place.
            temp_path = f"{to_path}.{os.getpid()}.{threading.get_ident()}.tmp"
            with open(temp_path, 'wb') as f:
                for chunk in response.iter_content(chunk_size=1024):
                    if chunk:
                        f.write(chunk)
            os.replace(temp_path, to_path)
        else:
            print(f"Failed to download (status {response.status_code}): {from_path}")
    except Exception as e:
        print(f"Failed to download '{from_path}': {e}")
        return False
    
    return True