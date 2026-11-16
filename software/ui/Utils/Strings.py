# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

def identifier_to_title(identifier):
    words = []
    for word in identifier.split("_"):
        words.append(word.capitalize())
    return " ".join(words)
