# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

import Utils.Strings as Strings

from enum import Enum

from Utils.Events import Event

from PyQt6.QtCore import QSize, Qt, QTimer, QRectF, QRect
from PyQt6 import QtCore
from PyQt6.QtGui import (
    QAction, 
    QIcon, 
    QPixmap, 
    QIntValidator, 
    QDoubleValidator, 
    QCursor,
    QResizeEvent,
    QPainter,
    QPen,
    QColor
)
from PyQt6 import QtCore, QtGui

from PyQt6.QtWidgets import (
    QVBoxLayout,
    QHBoxLayout,
    QWidget,
    QLabel,
    QWidget,
    QGridLayout,
    QSizePolicy,
    QLineEdit,
    QSpacerItem,
    QComboBox,
    QCheckBox,
    QToolButton
)

class QtAspectRatioLabel(QLabel):
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._pixmap = None
        self.setAlignment(Qt.AlignmentFlag.AlignCenter)
    
    def setPixmap(self, pixmap: QPixmap):
        self._pixmap = pixmap
        super().setPixmap(self._scaled_pixmap())
    
    def resizeEvent(self, event: QResizeEvent):
        if self._pixmap and not self._pixmap.isNull():
            super().setPixmap(self._scaled_pixmap())
        super().resizeEvent(event)
    
    def _scaled_pixmap(self) -> QPixmap:
        return QPixmap() if self._pixmap == None else self._pixmap.scaled(
            self.size(),
            Qt.AspectRatioMode.KeepAspectRatio,
            Qt.TransformationMode.SmoothTransformation,
        )
        
class QtRectangleOverlayLabel(QLabel):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        self.rectangle_bounds = QRectF(0.25, 0.25, 0.5, 0.5)
        
    def set_rectangle_bounds(self, left, top, width, height):
        self.rectangle_bounds = QRectF(left, top, width, height)
        self.repaint()
        
    def paintEvent(self, event):
        super().paintEvent(event)
        painter = QPainter(self)
        painter.setRenderHint(QPainter.RenderHint.Antialiasing)
        
        pen = QPen()
        pen.setWidth(2)
        pen.setColor(QColor("red"))
        painter.setPen(pen)

        rect = QRect(int(self.width() * self.rectangle_bounds.x()), 
                     int(self.height() * self.rectangle_bounds.y()), 
                     int(self.width() * self.rectangle_bounds.width()), 
                     int(self.height() * self.rectangle_bounds.height())).normalized()
        painter.drawRect(rect)
        painter.end()            
        
class QtPropertyGrid(QWidget):
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)                
        self.__property_layout = QGridLayout(self)
        self.__collapsed_groups = set()
        self.__group_widgets = {}
        self.set_target(None, None)
        
        self.on_property_changed = Event()
            
    def __on_combo_box_changed(self, index):
        combo_box = self.sender()
        property_name = combo_box.property("property_name")
        new_property_value = self.__field_choices[property_name][index]
        
        setattr(self.__target_object, property_name, new_property_value)
                
        self.on_property_changed.invoke(self.__target_object, property_name, new_property_value)

        self.set_target(self.__target_object, self.__target_metadata)
                    
    def __on_line_edit_changed(self, new_property_value):
        line_edit = self.sender()
        property_name = line_edit.property("property_name")
        property_value = getattr(self.__target_object, property_name)
        
        try:
            if (isinstance(property_value, int)):
                new_property_value = int(new_property_value)
            elif (isinstance(property_value, float)):
                new_property_value = float(new_property_value)
        except ValueError:
            return
                
        setattr(self.__target_object, property_name, new_property_value)
        
        self.on_property_changed.invoke(self.__target_object, property_name, new_property_value)
            
    def __on_check_box_changed(self, state):
        check_box = self.sender()
        property_name = check_box.property("property_name")
        new_property_value = check_box.isChecked()

        setattr(self.__target_object, property_name, new_property_value)

        self.on_property_changed.invoke(self.__target_object, property_name, new_property_value)

    # Objects can sort their fields into groups with FIELD_GROUPS, a list of (title, [field names]); fields it doesn't
    # list go in an "Other" group after them.
    def __ordered_fields(self, obj):
        ordered_fields = []
        if (not hasattr(obj, "FIELD_GROUPS")):
            for key in dir(obj):
                ordered_fields.append((None, key))
            return ordered_fields

        grouped_keys = set()
        for title, keys in getattr(obj, "FIELD_GROUPS"):
            for key in keys:
                if (hasattr(obj, key)):
                    ordered_fields.append((title, key))
                    grouped_keys.add(key)
        for key in dir(obj):
            if (key not in grouped_keys):
                ordered_fields.append(("Other", key))
        return ordered_fields

    def __add_group_header(self, title, row_index):
        header = QToolButton(self)
        header.setText(title)
        header.setToolButtonStyle(Qt.ToolButtonStyle.ToolButtonTextBesideIcon)
        header.setAutoRaise(True)
        header.setCheckable(True)
        header.setChecked(title not in self.__collapsed_groups)
        header.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)
        header.setProperty("group_title", title)
        header_font = header.font()
        header_font.setBold(True)
        header.setFont(header_font)
        header.toggled.connect(self.__on_group_toggled)
        self.__property_layout.addWidget(header, row_index, 0, 1, 2)
        self.__group_widgets[title] = (header, [])

    def __show_group(self, title, is_expanded):
        header, widgets = self.__group_widgets[title]
        header.setArrowType(Qt.ArrowType.DownArrow if is_expanded else Qt.ArrowType.RightArrow)
        for widget in widgets:
            widget.setVisible(is_expanded)

    def __on_group_toggled(self, is_expanded):
        title = self.sender().property("group_title")
        if (is_expanded):
            self.__collapsed_groups.discard(title)
        else:
            self.__collapsed_groups.add(title)
        self.__show_group(title, is_expanded)

    def __add_field_widget(self, group, widget, *args):
        self.__property_layout.addWidget(widget, *args)
        if (group != None):
            self.__group_widgets[group][1].append(widget)

    def target_metadata(self):
        return self.__target_metadata
            
    def set_target(self, obj, metadata):
        self.__target_object = obj
        self.__target_metadata = metadata
        self.__field_choices = {}
        self.__group_widgets = {}
        
        for i in reversed(range(self.__property_layout.count())): 
            widget = self.__property_layout.takeAt(i).widget()
            if (widget != None):
                widget.deleteLater()
    
        if (self.__target_object == None):
            return
        
        
        field_descriptions = getattr(obj, "FIELD_DESCRIPTION") if hasattr(obj, "FIELD_DESCRIPTION") else {}
        
        row_index = 0
        current_group = None
        for group, key in self.__ordered_fields(obj):
        
            if (key.startswith("_")):
                continue
            if callable(getattr(obj, key)):
                continue
            if (key.isupper()):
                continue
        
            value = getattr(obj, key)

            # Objects can limit a field to a set of values with get_field_choices(key).
            choices = None
            if (hasattr(obj, "get_field_choices")):
                choices = obj.get_field_choices(key)
            if (choices == None and isinstance(value, Enum)):
                choices = []
                for member in value.__class__:
                    choices.append(member)
                    
            validator = None
            if (choices != None):
                pass
            elif (hasattr(obj, "is_number_field") and obj.is_number_field(key)):
                validator = QDoubleValidator()
                validator.setRange(-100000.0, 100000.0, -1)
            elif (isinstance(value, bool)):
                pass
            elif (isinstance(value, int)):
                validator = QIntValidator()
                validator.setRange(-100000, 100000)
            elif (isinstance(value, float)):
                validator = QDoubleValidator()
                validator.setRange(-100000.0, 100000.0, -1)
            elif (isinstance(value, Enum)):
                pass
            elif (isinstance(value, str)):
                pass
            else:
                continue
            
            if (group != current_group):
                current_group = group
                self.__add_group_header(group, row_index)
                row_index += 1

            label_box_widget = QWidget()
            label_box_widget.setAutoFillBackground(True)
            label_box_widget.setContentsMargins(5, 5, 5, 5)    
            label_box_widget.setMinimumHeight(35)
            label_box_widget.setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Minimum) 
            bg_pallete = label_box_widget.palette()
            bg_pallete.setColor(label_box_widget.backgroundRole(), bg_pallete.color(label_box_widget.backgroundRole()).darker(120))            
            label_box_widget.setPalette(bg_pallete)
                    
            label_box = QVBoxLayout(label_box_widget)
            label_box.setContentsMargins(0, 0, 0, 0)    
                   
            label = QLabel(self)
            label.setText(Strings.identifier_to_title(key))
            label.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum) 
            label.setAlignment(Qt.AlignmentFlag.AlignLeft)                    
            label_box.addWidget(label)

            if (key in field_descriptions):                
                comment_label = QLabel(self)
                comment_label.setText(field_descriptions[key])
                comment_label.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum) 
                comment_label.setAlignment(Qt.AlignmentFlag.AlignLeft)          
                comment_label.setWordWrap(True)
                comment_label.setMaximumWidth(250)          
                comment_font = comment_label.font()
                comment_font.setPointSize(int(comment_font.pointSize() * 0.85))
                comment_label.setFont(comment_font)
                comment_pallete = comment_label.palette()
                comment_pallete.setColor(comment_label.foregroundRole(), comment_pallete.color(comment_label.foregroundRole()).darker(200))            
                comment_label.setPalette(comment_pallete)
                # Grid rows don't grow to fit wrapped text by themselves, which clips longer descriptions.
                comment_label.setMinimumHeight(comment_label.heightForWidth(comment_label.maximumWidth()))
                label_box.addWidget(comment_label) 
            
            self.__add_field_widget(group, label_box_widget, row_index, 0)            

            if (isinstance(value, bool)):
                check_box = QCheckBox()
                check_box.setChecked(value)
                check_box.setProperty("property_name", key)
                check_box.checkStateChanged.connect(self.__on_check_box_changed)
                self.__add_field_widget(group, check_box, row_index, 1, 1, 1, Qt.AlignmentFlag.AlignTop)
            elif (choices != None):
                self.__field_choices[key] = choices
                combo_edit = QComboBox()
                combo_edit.setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Minimum) 
                combo_edit.setMaximumHeight(32)
                for choice in choices:
                    if (isinstance(choice, Enum)):
                        combo_edit.addItem(Strings.identifier_to_title(choice.name))
                    else:
                        combo_edit.addItem(str(choice))
                    if (choice == value):
                        combo_edit.setCurrentIndex(combo_edit.count() - 1)
                combo_edit.setProperty("property_name", key)
                combo_edit.currentIndexChanged.connect(self.__on_combo_box_changed)
                self.__add_field_widget(group, combo_edit, row_index, 1, 1, 1, Qt.AlignmentFlag.AlignTop)
            else:
                line_edit = QLineEdit()
                line_edit.setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Minimum) 
                line_edit.setMaximumHeight(32)
                line_edit.setMaxLength(64);        
                line_edit.setText(str(value))
                line_edit.setValidator(validator)
                line_edit.setProperty("property_name", key)
                line_edit.textChanged.connect(self.__on_line_edit_changed)
                self.__add_field_widget(group, line_edit, row_index, 1, 1, 1, Qt.AlignmentFlag.AlignTop)
            
            row_index += 1

        for title in self.__group_widgets:
            self.__show_group(title, title not in self.__collapsed_groups)
                    
        spacer = QSpacerItem(1, 1, QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Expanding)
        self.__property_layout.addItem(spacer, row_index, 0)
        spacer = QSpacerItem(1, 1, QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Expanding)
        self.__property_layout.addItem(spacer, row_index, 1)