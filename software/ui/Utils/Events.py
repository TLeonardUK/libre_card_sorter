# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

class Event:
    def __init__(self):
        self.__listeners = []

    def add(self, value):
        self.__listeners.append(value)

    def remove(self, value):
        self.__listeners.remove(value)

    def invoke(self, *args):
        for value in self.__listeners:
            value(*args)