# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

# Abstract class for all sources of card-information. There should
# be one per dataset type.
class CardSource:

    def __init__(self):
        pass

    def get_card_info(self, id, data_url):
        # Implement in derived classes
        return None

    def get_dataset_name(self):
        # Implement in derived classes
        return ""