from PyQt6.QtCore import QSize
from PyQt6.QtWidgets import QDialog, QDialogButtonBox, QScrollArea, QVBoxLayout

from Utils.QtWidgets import QtPropertyGrid

class SettingsWindow(QDialog):

    def __init__(self, settings, parent=None):
        super().__init__(parent)

        self.settings = settings

        self.setWindowTitle("Settings")
        self.setMinimumSize(QSize(600, 700))

        layout = QVBoxLayout(self)

        self.property_grid = QtPropertyGrid()
        self.property_grid.set_target(self.settings, None)
        self.property_grid.on_property_changed.add(self.__property_changed)

        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setWidget(self.property_grid)
        layout.addWidget(scroll_area)

        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Close)
        buttons.rejected.connect(self.close)
        layout.addWidget(buttons)

    def __property_changed(self, obj, key, value):
        self.settings.save()
