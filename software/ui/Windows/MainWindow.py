# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

import csv
import sys
import time

from Sorting.CardSorting import CardSorter, CardSorterState, CardSorterNotIdleException
from Sorting.CardIdentification import CardIdentifier, CardSource, get_card_image_path
from Workflow.Workflows import Workflow, WorkflowBin, WorkflowCardArchetype, WorkflowCardArchetypeRule, WorkflowCardArchetypeRuleOperator, WorkflowMatchBehaviour, WorkflowExecutionState
from Workflow.WorkflowExecution import WorkflowExecutor, WorkflowExecutorRunState, WorkflowExecutorInvalidStateException
from Settings import Settings
from Sorting.CardSchema import CardBoolean, CardFieldName, CardRarity

from CardSources.MtgCardSource import MtgCardSource

from Windows.SettingsWindow import SettingsWindow

from Utils.QtWidgets import QtAspectRatioLabel, QtPropertyGrid, QtRectangleOverlayLabel

from PIL import Image, ImageQt

from PyQt6.QtCore import QSize, Qt, QTimer, QUrl
from PyQt6 import QtCore
from PyQt6.QtGui import (
    QAction, 
    QIcon, 
    QPixmap, 
    QIntValidator,
    QDoubleValidator, 
    QCursor
)
from PyQt6.QtWidgets import (
    QApplication, 
    QMainWindow, 
    QPushButton,
    QToolBar,
    QStatusBar,
    QVBoxLayout,
    QWidget,
    QSplitter,
    QTreeWidget,
    QTreeWidgetItem,
    QLineEdit,
    QLabel,
    QStyle,
    QMessageBox,
    QBoxLayout,
    QHBoxLayout,
    QVBoxLayout,
    QFrame,
    QProgressBar,
    QSizePolicy,
    QGridLayout,
    QTabWidget,
    QSpacerItem,
    QToolButton,
    QHeaderView,
    QMenu,
    QFileDialog
)

class CardListTreeWidgetItem(QTreeWidgetItem):
    def __init__(self, parent):
        super().__init__(parent)
        self.entry = None

class ProjectListWorkflowWidgetItem(QTreeWidgetItem):
    def __init__(self, parent):
        super().__init__(parent)
        self.workflow = None
        
class ProjectListBinWidgetItem(QTreeWidgetItem):
    def __init__(self, parent):
        super().__init__(parent)
        self.workflow = None
        self.bin = None

class ProjectListArchetypeWidgetItem(QTreeWidgetItem):
    def __init__(self, parent):
        super().__init__(parent)
        self.workflow = None
        self.bin = None
        self.archetype = None

class ProjectListRuleWidgetItem(QTreeWidgetItem):
    def __init__(self, parent):
        super().__init__(parent)
        self.workflow = None
        self.bin = None
        self.archetype = None
        self.rule = None

class MainWindow(QMainWindow):

    def __init__(self):
        super().__init__()

        self.settings = Settings.load()
        if (len(self.settings.workflows) == 0):
            self.settings.workflows = [ self.__build_default_workflow() ]
        self.settings.save()

        self.card_sorter = CardSorter(self.settings)
        self.card_identifier = CardIdentifier(self.settings)
        self.workflow_executor = None
        self.workflow = None

        for child in CardSource.__subclasses__():
            source = child()
            self.card_identifier.add_card_source(source.get_dataset_name(), source)

        self.was_connected = False
        self.disconnect_user_triggered = False
        self.auto_connect_initial_delay = 1
        self.auto_connect_max_delay = 30
        self.auto_connect_delay = self.auto_connect_initial_delay
        self.next_auto_connect_time = 0
        self.is_auto_connect_paused = False
        self.is_auto_connect_attempt_pending = False

        self.tool_bar = None
        self.status_bar = None
        self.status_label = None
        self.main_layout = None

        self.connect_button = None
        self.disconnect_button = None
        self.start_button = None
        self.stop_button = None
        self.pause_button = None
        self.resume_button = None
        self.settings_button = None
        
        self.machine_view_layout = None
        self.ip_line_edit = None
        self.project_tree_widget = None
        self.poll_timer = None

        self.current_preview_image = None
        self.current_full_image = None
        self.current_uncropped_preview_image = None

        self.__need_new_uncropped_image = False
        self.__need_to_apply_webcam_settings = False
        self.__is_live_preview = False
        self.__queued_device_operations = []

        self.device_properties = {
            "X":            ("0.000", [ ("-", self.__jog_neg_x_axis_clicked), ("+", self.__jog_x_axis_clicked), ("Home", self.__home_x_axis_clicked) ]),
            "Y":            ("0.000", [ ("-", self.__jog_neg_y_axis_clicked), ("+", self.__jog_y_axis_clicked), ("Home", self.__home_y_axis_clicked) ]),
            "Z":            ("0.000", [ ("-", self.__jog_neg_z_axis_clicked), ("+", self.__jog_z_axis_clicked), ("Park", self.__park_z_axis_clicked) ]),
            "Card Servo":   ("Open", [ ("Toggle", self.__toggle_servo_clicked) ]),
            "Card Light":   ("On", [ ("Toggle", self.__toggle_light_clicked) ]),
            "X Limit":      ("Triggered", []),
            "Y Limit":      ("Triggered", []),
            "Card Probe":   ("Triggered", []),
            "Status":       ("Disconnected", []),
        }
        
        self.workflow_list_dirty = True
        self.last_card_sorter_state = CardSorterState.DISCONNECTED
        
        self.device_properties_labels = {}
        
        self.property_tree_node_lookup = {}

        # Use a timer to periodically check for recieved messages/etc from the machine.
        self.poll_timer = QTimer()
        self.poll_timer.setInterval(100)
        self.poll_timer.timeout.connect(self.__poll)
        self.poll_timer.start()

        self.__setup_window()
        self.__update_state()

        self.main_layout.setFocus()

    def __build_default_workflow(self):

        # Create a dummy workflow to test out matching.
        workflow_bin_1 = WorkflowBin( "~", 300, [] )
        workflow_bin_2 = WorkflowBin( "C", 300, [
            WorkflowCardArchetype("Common cards", 0, [ 
                WorkflowCardArchetypeRule(CardFieldName.RARITY, WorkflowCardArchetypeRuleOperator.EQUAL, CardRarity.COMMON)
            ])
        ])
        workflow_bin_3 = WorkflowBin( "C", 300, [
            WorkflowCardArchetype("Common cards", 0, [ 
                WorkflowCardArchetypeRule(CardFieldName.RARITY, WorkflowCardArchetypeRuleOperator.EQUAL, CardRarity.COMMON)
            ])
        ])
        workflow_bin_4 = WorkflowBin( "U", 300, [
            WorkflowCardArchetype("Uncommon cards", 0, [ 
                WorkflowCardArchetypeRule(CardFieldName.RARITY, WorkflowCardArchetypeRuleOperator.EQUAL, CardRarity.UNCOMMON)
            ])
        ])
        workflow_bin_5 = WorkflowBin( "R", 300, [
            WorkflowCardArchetype("Rare cards", 0, [ 
                WorkflowCardArchetypeRule(CardFieldName.RARITY, WorkflowCardArchetypeRuleOperator.EQUAL, CardRarity.RARE)
            ])
        ])
        workflow_bin_6 = WorkflowBin( "M", 300, [
            WorkflowCardArchetype("Mythic cards", 0, [ 
                WorkflowCardArchetypeRule(CardFieldName.RARITY, WorkflowCardArchetypeRuleOperator.EQUAL, CardRarity.MYTHIC)
            ])
        ])
        workflow_bin_7 = WorkflowBin( "F", 300, [ 
            WorkflowCardArchetype("High price cards", 0, [ 
                WorkflowCardArchetypeRule(CardFieldName.PRICE_USD, WorkflowCardArchetypeRuleOperator.GREATER, "0.5")
            ]),
            WorkflowCardArchetype("Foil cards", 0, [ 
                WorkflowCardArchetypeRule(CardFieldName.IS_FOIL, WorkflowCardArchetypeRuleOperator.EQUAL, CardBoolean.TRUE)
            ])
        ])

        return Workflow("Default Workflow", WorkflowMatchBehaviour.RIGHT_TO_LEFT, [ 
            workflow_bin_1, 
            workflow_bin_2, 
            workflow_bin_3, 
            workflow_bin_4, 
            workflow_bin_5,
            workflow_bin_6,
            workflow_bin_7
        ])
                
    def __get_jog_distance(self):
        return int(self.feed_distance_line_edit.text())

    def __get_jog_rate(self):
        return int(self.feed_rate_line_edit.text())    
                
    def __is_workflow_active(self):
        return (self.workflow_executor != None and (self.workflow_executor.get_run_state() == WorkflowExecutorRunState.RUNNING or self.workflow_executor.get_run_state() == WorkflowExecutorRunState.PAUSED))

    def __queue_device_operation(self, operation):
        if (not self.card_sorter.is_connected() or self.__is_workflow_active()):
            return
        self.__queued_device_operations.append(operation)

    def __queue_jog(self, direction):
        distance = self.__get_jog_distance()
        rate = self.__get_jog_rate()
        distance_axis = (direction[0] * distance, direction[1] * distance, direction[2] * distance)
        self.__queue_device_operation(lambda: self.card_sorter.jog(distance_axis, rate))

    def __jog_x_axis_clicked(self):
        self.__queue_jog((1, 0, 0))
    
    def __jog_y_axis_clicked(self):
        self.__queue_jog((0, 1, 0))
    
    def __jog_z_axis_clicked(self):
        self.__queue_jog((0, 0, 1))

    def __jog_neg_x_axis_clicked(self):
        self.__queue_jog((-1, 0, 0))
    
    def __jog_neg_y_axis_clicked(self):
        self.__queue_jog((0, -1, 0))
    
    def __jog_neg_z_axis_clicked(self):
        self.__queue_jog((0, 0, -1))

    def __home_x_axis_clicked(self):
        self.__queue_device_operation(lambda: self.card_sorter.home_x())

    def __home_y_axis_clicked(self):
        self.__queue_device_operation(lambda: self.card_sorter.home_y())

    def __park_z_axis_clicked(self):
        self.__queue_device_operation(lambda: self.card_sorter.park_z())
                    
    def __deliver_to_bin_clicked(self):
        bin_index = self.sender().property("bin_index")
        self.__queue_device_operation(lambda: self.card_sorter.drop_card_in_bin(bin_index))

    def __feed_card_clicked(self):
        self.__queue_device_operation(lambda: self.card_sorter.feed_card())

    def __load_card_clicked(self):
        self.__queue_device_operation(lambda: self.card_sorter.load_card())

    def __toggle_servo_clicked(self):
        self.__queue_device_operation(lambda: self.card_sorter.toggle_servo())
    
    def __toggle_light_clicked(self):
        self.__queue_device_operation(lambda: self.card_sorter.toggle_light())

    def __setup_window(self):
        self.setWindowTitle("Libre Card Sorter")
        self.setMinimumSize(QSize(1200, 700))

        # Tool bar ----------------------------------
        self.tool_bar = QToolBar("Main Toolbar")
        self.tool_bar.setToolButtonStyle(Qt.ToolButtonStyle.ToolButtonTextBesideIcon)
        self.addToolBar(self.tool_bar)

        self.ip_line_edit = QLineEdit()
        self.ip_line_edit.setMaxLength(64);
        self.ip_line_edit.setPlaceholderText("Enter card sorter ip address")      
        self.ip_line_edit.setMaximumWidth(250);  
        self.ip_line_edit.setText(self.settings.card_sorter_ip_address)
        self.tool_bar.addWidget(self.ip_line_edit)

        self.connect_button = QAction("Connect")
        self.connect_button.setStatusTip("Connect to card sorter with IP address")
        self.connect_button.triggered.connect(self.__connect_clicked)
        self.tool_bar.addAction(self.connect_button)

        self.disconnect_button = QAction("Disconnect")
        self.disconnect_button.setStatusTip("Disconnect from card sorter")
        self.disconnect_button.triggered.connect(self.__disconnect_clicked)
        self.tool_bar.addAction(self.disconnect_button)

        self.tool_bar.addSeparator()

        self.start_button = QAction("Start")
        self.start_button.setIcon(self.style().standardIcon(QStyle.StandardPixmap.SP_MediaPlay))
        self.start_button.setStatusTip("Start running current workflow")
        self.start_button.triggered.connect(self.__start_clicked)
        self.tool_bar.addAction(self.start_button)

        self.stop_button = QAction("Stop")
        self.stop_button.setIcon(self.style().standardIcon(QStyle.StandardPixmap.SP_MediaStop))
        self.stop_button.setStatusTip("Stop running current workflow")
        self.stop_button.triggered.connect(self.__stop_clicked)
        self.tool_bar.addAction(self.stop_button)

        self.pause_button = QAction("Pause")
        self.pause_button.setIcon(self.style().standardIcon(QStyle.StandardPixmap.SP_MediaPause))
        self.pause_button.setStatusTip("Pause running workflow")
        self.pause_button.triggered.connect(self.__pause_clicked)
        self.tool_bar.addAction(self.pause_button)

        self.resume_button = QAction("Resume")
        self.resume_button.setIcon(self.style().standardIcon(QStyle.StandardPixmap.SP_MediaPlay))
        self.resume_button.setStatusTip("Resume running workflow")
        self.resume_button.triggered.connect(self.__resume_clicked)
        self.tool_bar.addAction(self.resume_button)

        tool_bar_spacer = QWidget()
        tool_bar_spacer.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Preferred)
        self.tool_bar.addWidget(tool_bar_spacer)

        self.settings_button = QAction("Settings")
        self.settings_button.setIcon(self.style().standardIcon(QStyle.StandardPixmap.SP_FileDialogListView))
        self.settings_button.setStatusTip("Change card sorter settings")
        self.settings_button.triggered.connect(self.__settings_clicked)
        self.tool_bar.addAction(self.settings_button)

        self.emergency_stop_button = QAction("Emergency Stop")
        self.emergency_stop_button.setIcon(self.style().standardIcon(QStyle.StandardPixmap.SP_BrowserStop))
        self.emergency_stop_button.setStatusTip("Stop the workflow and halt all motion immediately")
        self.emergency_stop_button.triggered.connect(self.__emergency_stop_clicked)
        self.tool_bar.addAction(self.emergency_stop_button)

        # Status bar ----------------------------------
        self.status_bar = QStatusBar()
        self.setStatusBar(self.status_bar)

        self.status_label = QLabel(self)
        self.status_label.setText("Not Connected")
        self.status_bar.addWidget(self.status_label)

        self.cards_per_minute_label = QLabel(self)
        self.status_bar.addPermanentWidget(self.cards_per_minute_label)
        self.cards_left_label = QLabel(self)
        self.status_bar.addPermanentWidget(self.cards_left_label)
        self.time_remaining_label = QLabel(self)
        self.status_bar.addPermanentWidget(self.time_remaining_label)

        # Tab Control ----------------------------------

        self.main_layout = QTabWidget()
        
        # Workflows Tab ----------------------------------

        self.workflows_tab_layout = QSplitter(self)

        self.project_tree_widget = QTreeWidget(self)
        self.project_tree_widget.setColumnCount(2)
        self.project_tree_widget.setHeaderLabels([ "Workflow", "" ])
        self.project_tree_widget.setHeaderLabels([ "Workflow", "" ])

        self.project_tree_widget.setContextMenuPolicy(QtCore.Qt.ContextMenuPolicy.CustomContextMenu)
        self.project_tree_widget.customContextMenuRequested.connect(self.__show_project_tree_context_menu)
        self.project_tree_widget.itemSelectionChanged.connect(self.__project_tree_selected_item_changed)

        self.workflows_tab_layout.addWidget(self.project_tree_widget)
        self.workflows_tab_layout.setSizes([1000, 50])

        self.project_tree_property_grid = QtPropertyGrid(self)
        self.project_tree_property_grid.on_property_changed.add(self.__project_tree_property_changed)
        self.workflows_tab_layout.addWidget(self.project_tree_property_grid)

  
        # Status Tab ----------------------------------

        self.status_tab_layout = QSplitter(self)
        
        # Card List view ----------------------------------
        self.card_list_tree_widget = QTreeWidget(self)
        self.card_list_tree_widget.setColumnCount(5)
        self.card_list_tree_widget.setHeaderLabels([ "Card", "Rarity", "Foil", "Quantity", "Price" ])
        self.card_list_tree_widget.setColumnWidth(0, 280)
        self.card_list_tree_widget.setColumnWidth(1, 85)
        self.card_list_tree_widget.setColumnWidth(2, 75)
        self.card_list_tree_widget.setColumnWidth(3, 75)
        self.card_list_tree_widget.setColumnWidth(4, 75)

        self.export_csv_button = QPushButton("Export CSV")
        self.export_csv_button.clicked.connect(self.__export_csv_clicked)

        self.total_cards_label = QLabel("Total Cards: 0")
        self.total_card_price_label = QLabel("Total Card Price: $0.00")

        card_list_footer_layout = QHBoxLayout()
        card_list_footer_layout.addWidget(self.total_cards_label)
        card_list_footer_layout.addSpacing(20)
        card_list_footer_layout.addWidget(self.total_card_price_label)
        card_list_footer_layout.addStretch()
        card_list_footer_layout.addWidget(self.export_csv_button)

        card_list_widget = QWidget(self)
        card_list_layout = QVBoxLayout(card_list_widget)
        card_list_layout.setContentsMargins(0, 0, 0, 6)
        card_list_layout.addWidget(self.card_list_tree_widget)
        card_list_layout.addLayout(card_list_footer_layout)
        self.status_tab_layout.addWidget(card_list_widget)

        # Machine status view ----------------------------------
        self.machine_view_layout = QSplitter(Qt.Orientation.Vertical, self)
        self.status_tab_layout.addWidget(self.machine_view_layout)

        # Card preview        
        self.preview_layout = QSplitter(Qt.Orientation.Horizontal, self)        
        self.machine_view_layout.addWidget( self.preview_layout )
        
        self.card_preview = QtAspectRatioLabel(self)
        self.card_preview.setAutoFillBackground(True)
        self.card_preview.setText("")
        bg_pallete = self.card_preview.palette()
        bg_pallete.setColor(self.card_preview.backgroundRole(), bg_pallete.color(self.card_preview.backgroundRole()).darker(120))            
        self.card_preview.setPalette(bg_pallete)
        self.preview_layout.addWidget( self.card_preview )

        self.card_full_image = QtAspectRatioLabel(self)
        self.card_full_image.setAutoFillBackground(True)
        self.card_full_image.setText("")
        self.card_full_image.setPalette(bg_pallete)
        self.preview_layout.addWidget( self.card_full_image )
        
        self.preview_layout.setSizes([1, 1])

        # Bin information
        self.bin_info_layout_container = QWidget()
        self.bin_info_layout = QHBoxLayout(self.bin_info_layout_container)
        self.machine_view_layout.addWidget(self.bin_info_layout_container)
                
        self.bin_progress_bars = []
        self.bin_card_count_labels = []
        self.bin_labels = []
                
        for i in range(self.settings.bin_count):           
                        
            bin_container = QFrame()
            bin_container.setFrameStyle(QFrame.Shape.StyledPanel | QFrame.Shadow.Plain)
            
            bg_pallete = bin_container.palette()
            bg_pallete.setColor(bin_container.backgroundRole(), bg_pallete.color(bin_container.backgroundRole()).darker(120))
            bin_container.setPalette(bg_pallete)
            bin_container.setAutoFillBackground(True)
                                                
            bin_layout = QVBoxLayout(bin_container)
            self.bin_info_layout.addWidget(bin_container)
             
            bin_label = QLabel(self)
            bin_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
            bin_label.setText(f"{i + 1}")
            bin_label.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)
            bin_layout.addWidget(bin_label)
            self.bin_labels.append(bin_label)    
            
            bin_progress_bar = QProgressBar(self)
            bin_progress_bar.setValue(50)
            bin_progress_bar.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Expanding)
            bin_progress_bar.setOrientation(Qt.Orientation.Vertical)
            bin_layout.addWidget(bin_progress_bar)            
            self.bin_progress_bars.append(bin_progress_bar)    

            bin_count_label = QLabel(self)
            bin_count_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
            bin_count_label.setText("150")
            bin_count_label.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)
            bin_layout.addWidget(bin_count_label)
            self.bin_card_count_labels.append(bin_count_label)    
                    
        # Device Tab ----------------------------------

        self.device_tab_layout = QSplitter(self)

        self.left_device_panel = QWidget()
        self.right_device_panel = QWidget()
        self.device_tab_layout.addWidget(self.left_device_panel)
        self.device_tab_layout.addWidget(self.right_device_panel)

        self.device_position_layout = QGridLayout(self.left_device_panel)
        
        row_index = 0
        for key, values in self.device_properties.items():
    
            text = values[0]
            actions = values[1]
    
            label = QLabel(self)
            label.setText(key)
            label.setMinimumHeight(35)
            label.setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Minimum) 
            label.setContentsMargins(5, 5, 5, 5)    
            bg_pallete = label.palette()
            bg_pallete.setColor(label.backgroundRole(), bg_pallete.color(label.backgroundRole()).darker(120))            
            label.setPalette(bg_pallete)
            label.setAutoFillBackground(True)
            label.setAlignment(Qt.AlignmentFlag.AlignCenter)        
            self.device_position_layout.addWidget(label, row_index, 0)
            
            label = QLabel(self)
            label.setText(text)
            label.setMinimumHeight(35)
            label.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)
            self.device_properties_labels[key] = label

            if (len(actions) == 0):
                self.device_position_layout.addWidget(label, row_index, 1, 1, 2)
                row_index += 1
                continue

            self.device_position_layout.addWidget(label, row_index, 1)
                        
            action_container = QFrame()              
            action_container.setMinimumHeight(35)
            action_container.setSizePolicy(QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Minimum)            
            action_layout = QHBoxLayout(action_container)
            self.device_position_layout.addWidget(action_container, row_index, 2, Qt.AlignmentFlag.AlignRight)
                        
            for action in actions:
                button = QToolButton(self)
                button.setText(action[0])
                button.setMinimumWidth(30)
                button.minimumSizeHint()
                button.setSizePolicy(QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Minimum)                
                button.clicked.connect(action[1])
                action_layout.addWidget(button)
            
            row_index += 1
    
        spacer = QSpacerItem(1, 15, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Minimum)
        self.device_position_layout.addItem(spacer, row_index, 0)
        spacer = QSpacerItem(1, 1, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)
        self.device_position_layout.addItem(spacer, row_index, 1)
        spacer = QSpacerItem(1, 1, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Minimum)
        self.device_position_layout.addItem(spacer, row_index, 2)
        row_index += 1
                                
        feed_validator = QIntValidator()
        feed_validator.setRange(0, 100000)
                
        # Feed Rate Option
        label = QLabel(self)
        label.setText("Feed Rate")
        label.setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Minimum) 
        label.setContentsMargins(5, 5, 5, 5)
        bg_pallete = label.palette()
        bg_pallete.setColor(label.backgroundRole(), bg_pallete.color(label.backgroundRole()).darker(120))        
        label.setPalette(bg_pallete)
        label.setAutoFillBackground(True)
        label.setAlignment(Qt.AlignmentFlag.AlignCenter)        
        self.device_position_layout.addWidget(label, row_index, 0)

        self.feed_rate_line_edit = QLineEdit()
        self.feed_rate_line_edit .setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Minimum) 
        self.feed_rate_line_edit.setMaxLength(8);
        self.feed_rate_line_edit.setPlaceholderText("Feed Rate")        
        self.feed_rate_line_edit.setText(str(self.settings.x_feed_rate))
        self.feed_rate_line_edit.setValidator(feed_validator)
        self.device_position_layout.addWidget(self.feed_rate_line_edit, row_index, 1)

        spacer = QSpacerItem(1, 1, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Minimum)
        self.device_position_layout.addItem(spacer, row_index, 2)
        row_index += 1
        
        # Feed Distance Option
        label = QLabel(self)
        label.setText("Feed Distance")
        label.setSizePolicy(QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Minimum) 
        label.setContentsMargins(5, 5, 5, 5)
        bg_pallete = label.palette()
        bg_pallete.setColor(label.backgroundRole(), bg_pallete.color(label.backgroundRole()).darker(120))        
        label.setPalette(bg_pallete)
        label.setAutoFillBackground(True)
        label.setAlignment(Qt.AlignmentFlag.AlignCenter)        
        self.device_position_layout.addWidget(label, row_index, 0)

        self.feed_distance_line_edit = QLineEdit()
        self.feed_distance_line_edit .setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Minimum) 
        self.feed_distance_line_edit.setMaxLength(8);
        self.feed_distance_line_edit.setPlaceholderText("Feed Rate")        
        self.feed_distance_line_edit.setText(str(10))
        self.feed_distance_line_edit.setValidator(feed_validator)
        self.device_position_layout.addWidget(self.feed_distance_line_edit, row_index, 1)

        spacer = QSpacerItem(1, 1, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Minimum)
        self.device_position_layout.addItem(spacer, row_index, 2)
        row_index += 1

        spacer = QSpacerItem(1, 15, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Minimum)
        self.device_position_layout.addItem(spacer, row_index, 0)
        spacer = QSpacerItem(1, 1, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)
        self.device_position_layout.addItem(spacer, row_index, 1)
        spacer = QSpacerItem(1, 1, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Minimum)
        self.device_position_layout.addItem(spacer, row_index, 2)
        row_index += 1

        # Deliver to Bin
        label = QLabel(self)
        label.setText("Deliver to Bin")
        label.setMinimumHeight(35)
        label.setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Minimum) 
        label.setContentsMargins(5, 5, 5, 5)
        bg_pallete = label.palette()
        bg_pallete.setColor(label.backgroundRole(), bg_pallete.color(label.backgroundRole()).darker(120))        
        label.setPalette(bg_pallete)
        label.setAutoFillBackground(True)
        label.setAlignment(Qt.AlignmentFlag.AlignCenter)        
        self.device_position_layout.addWidget(label, row_index, 0)

        bin_button_container = QFrame()
        bin_button_layout = QHBoxLayout(bin_button_container)
        bin_button_layout.setContentsMargins(0, 0, 0, 0)
        for i in range(self.settings.bin_count):
            button = QToolButton(self)
            button.setText(str(i + 1))
            button.setMinimumWidth(30)
            button.setProperty("bin_index", i)
            button.clicked.connect(self.__deliver_to_bin_clicked)
            bin_button_layout.addWidget(button)
        bin_button_layout.addStretch()
        self.device_position_layout.addWidget(bin_button_container, row_index, 1, 1, 2)
        row_index += 1

        # Motion
        label = QLabel(self)
        label.setText("Motion")
        label.setMinimumHeight(35)
        label.setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Minimum)
        label.setContentsMargins(5, 5, 5, 5)
        bg_pallete = label.palette()
        bg_pallete.setColor(label.backgroundRole(), bg_pallete.color(label.backgroundRole()).darker(120))
        label.setPalette(bg_pallete)
        label.setAutoFillBackground(True)
        label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        self.device_position_layout.addWidget(label, row_index, 0)

        motion_button_container = QFrame()
        motion_button_layout = QHBoxLayout(motion_button_container)
        motion_button_layout.setContentsMargins(0, 0, 0, 0)
        self.feed_card_button = QPushButton("Feed Card")
        self.feed_card_button.clicked.connect(self.__feed_card_clicked)
        motion_button_layout.addWidget(self.feed_card_button)
        self.load_card_button = QPushButton("Load Card")
        self.load_card_button.clicked.connect(self.__load_card_clicked)
        motion_button_layout.addWidget(self.load_card_button)
        motion_button_layout.addStretch()
        self.device_position_layout.addWidget(motion_button_container, row_index, 1, 1, 2)
        row_index += 1
        
        spacer = QSpacerItem(1, 1, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Expanding)
        self.device_position_layout.addItem(spacer, row_index, 0)
        spacer = QSpacerItem(1, 1, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Expanding)
        self.device_position_layout.addItem(spacer, row_index, 1)
        spacer = QSpacerItem(1, 1, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Expanding)
        self.device_position_layout.addItem(spacer, row_index, 2)
        row_index += 1
            
        # Preview / Crop Configuration section

        self.device_crop_layout = QVBoxLayout(self.right_device_panel)

        self.crop_preview = QtRectangleOverlayLabel(self)
        self.crop_preview.setScaledContents(True)
        self.crop_preview.set_rectangle_bounds(self.settings.webcam_crop_left, self.settings.webcam_crop_top, (self.settings.webcam_crop_right - self.settings.webcam_crop_left), (self.settings.webcam_crop_bottom - self.settings.webcam_crop_top))
        self.crop_preview.setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Expanding) 
        self.crop_preview.setAutoFillBackground(True)
        self.crop_preview.setText("")
        bg_pallete = self.crop_preview.palette()
        bg_pallete.setColor(self.crop_preview.backgroundRole(), bg_pallete.color(self.crop_preview.backgroundRole()).darker(120))            
        self.crop_preview.setPalette(bg_pallete)
        self.device_crop_layout.addWidget( self.crop_preview )

        live_preview_layout = QVBoxLayout(self.crop_preview)
        live_preview_layout.setContentsMargins(10, 10, 10, 10)
        self.live_preview_button = QToolButton(self.crop_preview)
        self.live_preview_button.setIconSize(QSize(24, 24))
        self.live_preview_button.setStatusTip("Refresh the webcam preview continually")
        self.live_preview_button.clicked.connect(self.__live_preview_clicked)
        live_preview_layout.addWidget(self.live_preview_button, 0, Qt.AlignmentFlag.AlignLeft | Qt.AlignmentFlag.AlignBottom)

        crop_settings_bar = QWidget()
        crop_settings_bar.setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Minimum) 
        crop_settings_layout = QHBoxLayout(crop_settings_bar)
        crop_settings_layout.setContentsMargins(0, 0, 0, 0)
        self.device_crop_layout.addWidget( crop_settings_bar )
        
        float_validator = QDoubleValidator()
        #floatValidator.setRange(0, 1.0)

        float255_validator = QDoubleValidator()
        float255_validator.setRange(0, 255)
                
        float10000_validator = QDoubleValidator()
        float10000_validator.setRange(0, 10000)
                
        # Crop Left 
        label = QLabel(self)
        label.setText("Left")
        crop_settings_layout.addWidget(label)        
        
        self.left_crop_line_edit = QLineEdit()
        self.left_crop_line_edit.setMaxLength(6)
        self.left_crop_line_edit.setText(str(self.settings.webcam_crop_left))
        self.left_crop_line_edit.setValidator(float_validator)
        self.left_crop_line_edit.textChanged.connect(self.__camera_crop_changed)
        crop_settings_layout.addWidget(self.left_crop_line_edit)
        
        label = QLabel(self)
        label.setText("Right")
        crop_settings_layout.addWidget(label)        
        
        self.right_crop_line_edit = QLineEdit()
        self.right_crop_line_edit.setMaxLength(6)
        self.right_crop_line_edit.setText(str(self.settings.webcam_crop_right))
        self.right_crop_line_edit.setValidator(float_validator)
        self.right_crop_line_edit.textChanged.connect(self.__camera_crop_changed)
        crop_settings_layout.addWidget(self.right_crop_line_edit)
        
        label = QLabel(self)
        label.setText("Top")
        crop_settings_layout.addWidget(label)        
        
        self.top_crop_line_edit = QLineEdit()
        self.top_crop_line_edit.setMaxLength(6)
        self.top_crop_line_edit.setText(str(self.settings.webcam_crop_top))
        self.top_crop_line_edit.setValidator(float_validator)
        self.top_crop_line_edit.textChanged.connect(self.__camera_crop_changed)
        crop_settings_layout.addWidget(self.top_crop_line_edit)

        label = QLabel(self)
        label.setText("Bottom")
        crop_settings_layout.addWidget(label)        
        
        self.bottom_crop_line_edit = QLineEdit()
        self.bottom_crop_line_edit.setMaxLength(6)
        self.bottom_crop_line_edit.setText(str(self.settings.webcam_crop_bottom))
        self.bottom_crop_line_edit.setValidator(float_validator)
        self.bottom_crop_line_edit.textChanged.connect(self.__camera_crop_changed)
        crop_settings_layout.addWidget(self.bottom_crop_line_edit)
        
        
        webcam_settings_bar = QWidget()
        webcam_settings_bar.setSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Minimum) 
        webcam_settings_layout = QHBoxLayout(webcam_settings_bar)
        webcam_settings_layout.setContentsMargins(0, 0, 0, 0)
        self.device_crop_layout.addWidget( webcam_settings_bar )
                
        label = QLabel(self)
        label.setText("Exposure")
        webcam_settings_layout.addWidget(label)        
        
        self.exposure_line_edit = QLineEdit()
        self.exposure_line_edit.setMaxLength(6)
        self.exposure_line_edit.setText(str(self.settings.webcam_exposure))
        self.exposure_line_edit.setValidator(float255_validator)
        self.exposure_line_edit.textChanged.connect(self.__camera_settings_changed)
        webcam_settings_layout.addWidget(self.exposure_line_edit)
        
        label = QLabel(self)
        label.setText("Brightness")
        webcam_settings_layout.addWidget(label)        
        
        self.brightness_line_edit = QLineEdit()
        self.brightness_line_edit.setMaxLength(6)
        self.brightness_line_edit.setText(str(self.settings.webcam_brightness))
        self.brightness_line_edit.setValidator(float255_validator)
        self.brightness_line_edit.textChanged.connect(self.__camera_settings_changed)
        webcam_settings_layout.addWidget(self.brightness_line_edit)
        
        label = QLabel(self)
        label.setText("Focus")
        webcam_settings_layout.addWidget(label)        
        
        self.focus_line_edit = QLineEdit()
        self.focus_line_edit.setMaxLength(6)
        self.focus_line_edit.setText(str(self.settings.webcam_focus))
        self.focus_line_edit.setValidator(float255_validator)
        self.focus_line_edit.textChanged.connect(self.__camera_settings_changed)
        webcam_settings_layout.addWidget(self.focus_line_edit)
        
        label = QLabel(self)
        label.setText("White Balance")
        webcam_settings_layout.addWidget(label)        
        
        self.white_balance_line_edit = QLineEdit()
        self.white_balance_line_edit.setMaxLength(6)
        self.white_balance_line_edit.setText(str(self.settings.webcam_white_balance))
        self.white_balance_line_edit.setValidator(float10000_validator)
        self.white_balance_line_edit.textChanged.connect(self.__camera_settings_changed)
        webcam_settings_layout.addWidget(self.white_balance_line_edit)
            
        # Final setup ------------------------
                
        self.machine_view_layout.setSizes([500, 1]) # Split between preview and bin info
        
        self.main_layout.addTab(self.workflows_tab_layout, "Workflows")
        self.workflows_tab_layout.setSizes([1000, 600])

        self.main_layout.addTab(self.status_tab_layout, "Status")
        self.status_tab_layout.setSizes([400, 2])        

        self.main_layout.addTab(self.device_tab_layout, "Device")
        self.device_tab_layout.setSizes([400, 1200])        
        
        self.main_layout.currentChanged.connect(self.__tab_changed)

        self.setCentralWidget(self.main_layout)
          
    def __camera_crop_changed(self, new_property_value):
        if (len(self.left_crop_line_edit.text()) > 0):
            self.settings.webcam_crop_left = float(self.left_crop_line_edit.text())
        if (len(self.right_crop_line_edit.text()) > 0):
            self.settings.webcam_crop_right = float(self.right_crop_line_edit.text())
        if (len(self.top_crop_line_edit.text()) > 0):
            self.settings.webcam_crop_top = float(self.top_crop_line_edit.text())
        if (len(self.bottom_crop_line_edit.text()) > 0):
            self.settings.webcam_crop_bottom = float(self.bottom_crop_line_edit.text())
        
        self.crop_preview.set_rectangle_bounds(self.settings.webcam_crop_left, self.settings.webcam_crop_top, (self.settings.webcam_crop_right - self.settings.webcam_crop_left), (self.settings.webcam_crop_bottom - self.settings.webcam_crop_top))
        self.settings.save()
        
        self.__need_new_uncropped_image = True

    def __camera_settings_changed(self, new_property_value):
        self.settings.webcam_exposure = int(self.exposure_line_edit.text())
        self.settings.webcam_brightness = int(self.brightness_line_edit.text())
        self.settings.webcam_focus = int(self.focus_line_edit.text())
        self.settings.webcam_white_balance = int(self.white_balance_line_edit.text())
                
        self.settings.save()
        
        self.__need_new_uncropped_image = True
        self.__need_to_apply_webcam_settings = True
        
    def __poll(self):
        # Handle any errors that occur.
        if (self.card_sorter.get_state() == CardSorterState.ERROR):
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Icon.Critical)
            msg.setText(f"Card sorter encountered an error and was disconnected:\n\n{self.card_sorter.get_error()}")
            msg.setInformativeText(f"")
            msg.setWindowTitle("Error")
            msg.exec()

            self.card_sorter.disconnect()
            self.__discard_workflow_executor()
        
        if (self.card_sorter.get_state() == CardSorterState.DISCONNECTED):
            if (self.was_connected):
                self.was_connected = False
                self.__disconnected()
                
            if (self.is_auto_connect_attempt_pending):
                self.is_auto_connect_attempt_pending = False
                self.next_auto_connect_time = time.monotonic() + self.auto_connect_delay
                self.auto_connect_delay = min(self.auto_connect_delay * 2, self.auto_connect_max_delay)
            elif (self.last_card_sorter_state == CardSorterState.CONNECTING):
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Icon.Critical)
                msg.setText("Failed to connect to card sorter. Ensure its on and connected to the network.")
                msg.setInformativeText(f"")
                msg.setWindowTitle("Error")
                msg.exec()                
                
            # Not while the address is being edited, as a half-typed one would be tried.
            if (self.__is_auto_connecting() and not self.ip_line_edit.hasFocus() and time.monotonic() >= self.next_auto_connect_time):
                if (self.settings.card_sorter_ip_address != self.ip_line_edit.text()):
                    self.settings.card_sorter_ip_address = self.ip_line_edit.text()
                    self.settings.save()
                self.card_sorter.connect(self.settings.card_sorter_ip_address)
                self.is_auto_connect_attempt_pending = True

        elif (self.card_sorter.is_connected()):
            self.was_connected = True
            self.is_auto_connect_attempt_pending = False
            self.auto_connect_delay = self.auto_connect_initial_delay

        self.last_card_sorter_state = self.card_sorter.get_state()

        if (self.card_sorter.is_connected() and self.card_sorter.get_state() == CardSorterState.IDLE and not self.__is_workflow_active()):
            try:
                if (len(self.__queued_device_operations) > 0):
                    self.__queued_device_operations[0]()
                    self.__queued_device_operations.pop(0)
                elif (self.__need_to_apply_webcam_settings):
                    self.card_sorter.apply_webcam_settings()
                    self.__need_to_apply_webcam_settings = False
                elif (self.__need_new_uncropped_image or self.__is_live_preview):
                    self.card_sorter.request_uncropped_image(keep_light_on=self.__is_live_preview)
                    self.__need_new_uncropped_image = False
            except CardSorterNotIdleException:
                pass
                
        # Show a message if the workflow executor encounters an error.
        if (self.workflow_executor != None):
            if (self.workflow_executor.get_run_state() == WorkflowExecutorRunState.BIN_FULL):
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Icon.Warning)
                msg.setText("One of the card sorter bins are full. Please empty -all- bins, then click OK to carry on.")
                msg.setInformativeText(f"")
                msg.setWindowTitle("Bin Full")
                msg.exec()

                self.workflow_executor.mark_bins_as_empty()
                self.workflow_executor.resume()

            elif (self.workflow_executor.get_run_state() == WorkflowExecutorRunState.COMPLETED):
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Icon.Information)
                msg.setText("Workflow has completed succesfully.")
                msg.setInformativeText(f"")
                msg.setWindowTitle("Workflow Completed")
                msg.exec()

                self.__discard_workflow_executor()

            elif (self.workflow_executor.get_run_state() == WorkflowExecutorRunState.ERROR):
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Icon.Critical)
                msg.setText(f"Workflow stopped after an error:\n\n{self.workflow_executor.get_error()}")
                msg.setInformativeText(f"")
                msg.setWindowTitle("Workflow Error")
                msg.exec()

                self.workflow_executor.clear_error()

        # Display the current card image.
        current_image = self.card_sorter.get_card_image()
        if (current_image != None and current_image != self.current_preview_image):
            self.current_preview_image = current_image            
            # Correct aspect ratio as the webcam images are cropped and resized.
            aspect_ratio = 1.3978 # Standard card image aspect ration.            
            resized_image = current_image.copy()
            resized_image = resized_image.resize((resized_image.width, int(resized_image.height * aspect_ratio)), Image.Resampling.LANCZOS)            
            current_image_pixmap = ImageQt.toqpixmap(resized_image)
            self.card_preview.setPixmap(current_image_pixmap)
            #self.card_preview.resize(current_image_pixmap.width(), current_image_pixmap.height())
            
        # Display the current uncropped card image.
        current_image = self.card_sorter.get_uncropped_card_image()
        if (current_image != None and current_image != self.current_uncropped_preview_image):
            self.current_uncropped_preview_image = current_image     
            current_image_pixmap = ImageQt.toqpixmap(current_image)       
            self.crop_preview.setPixmap(current_image_pixmap)
            
        # Display the identified card.
        if (self.workflow_executor == None):
            self.card_full_image.setPixmap(None)
            self.card_full_image.setText("")            
        elif (self.workflow_executor.is_identifying_card_foil()):
            self.card_full_image.setPixmap(None)
            self.card_full_image.setText("Identifying foil ...")
        elif (self.workflow_executor.is_identifying_card()):
            self.card_full_image.setPixmap(None)
            self.card_full_image.setText("Identifying card ...")
        else:
            identity = self.workflow_executor.get_last_card_identity()
            if (identity != None):
                current_image = identity.preview_image
                if (current_image != None and current_image != self.current_full_image):
                    self.current_full_image = current_image                                        
                    current_image_pixmap = ImageQt.toqpixmap(current_image)
                    self.card_full_image.setPixmap(current_image_pixmap)
                    # self.card_full_image.resize(current_image_pixmap.width(), current_image_pixmap.height())
                elif (current_image == None and self.current_full_image != None):
                    self.current_full_image = None
                    self.card_full_image.setPixmap(None)
            else:
                self.card_full_image.setPixmap(None)

        self.__update_state()

    def __update_state(self):
        is_connected = self.card_sorter.is_connected()
        is_connecting = (self.card_sorter.get_state() == CardSorterState.CONNECTING)
        self.connect_button.setVisible(not is_connected)
        self.connect_button.setText("Connecting ..." if is_connecting else "Connect")
        self.connect_button.setEnabled(not is_connecting)
        self.disconnect_button.setVisible(is_connected)

        self.live_preview_button.setEnabled(is_connected and not self.__is_workflow_active())
        self.live_preview_button.setIcon(self.style().standardIcon(QStyle.StandardPixmap.SP_MediaStop if self.__is_live_preview else QStyle.StandardPixmap.SP_MediaPlay))
        self.emergency_stop_button.setEnabled(is_connected)
        self.ip_line_edit.setReadOnly(is_connected or is_connecting)

        if (is_connected):
            workflow_state = WorkflowExecutorRunState.STOPPED if self.workflow_executor == None else self.workflow_executor.get_run_state()
            self.start_button.setVisible(workflow_state == WorkflowExecutorRunState.STOPPED or workflow_state == WorkflowExecutorRunState.COMPLETED or workflow_state == WorkflowExecutorRunState.BIN_FULL)
            self.stop_button.setVisible(workflow_state == WorkflowExecutorRunState.RUNNING)
            self.resume_button.setVisible(workflow_state == WorkflowExecutorRunState.PAUSED)
            self.pause_button.setVisible(workflow_state == WorkflowExecutorRunState.RUNNING)
        else:
            self.start_button.setVisible(False)
            self.stop_button.setVisible(False)
            self.resume_button.setVisible(False)
            self.pause_button.setVisible(False)

        if (self.card_sorter.get_state() == CardSorterState.DISCONNECTED and self.__is_auto_connecting() and self.ip_line_edit.hasFocus()):
            self.status_label.setText("Disconnected, retrying once the IP address is no longer being edited")
        elif (self.card_sorter.get_state() == CardSorterState.DISCONNECTED and self.__is_auto_connecting()):
            seconds_to_retry = max(0, int(self.next_auto_connect_time - time.monotonic() + 0.999))
            self.status_label.setText(f"Disconnected, retrying in {seconds_to_retry}s")
        elif (self.card_sorter.get_state() == CardSorterState.DISCONNECTED):
            self.status_label.setText("Disconnected")
        elif (self.card_sorter.get_state() == CardSorterState.DISCONNECTING):
            self.status_label.setText("Disconnecting")
        elif (self.card_sorter.get_state() == CardSorterState.CONNECTING):
            self.status_label.setText(f"Connecting to {self.ip_line_edit.text()}...")
        elif (self.card_sorter.get_state() == CardSorterState.STOPPING):
            self.status_label.setText("Emergency stopping")
        elif (self.card_sorter.get_state() == CardSorterState.ERROR):
            error_msg = self.card_sorter.get_error()
            self.status_label.setText(f"Error occured: {error_msg}...")
        else:
            self.status_label.setText(f"Connected to card sorter")
            
        cards_per_minute = None if self.workflow_executor == None else self.workflow_executor.get_cards_per_minute()
        cards_left = self.card_sorter.get_estimated_magazine_card_count()
        self.cards_per_minute_label.setText("Cards/Min: " + ("-" if cards_per_minute == None else f"{cards_per_minute:.1f}"))
        self.cards_left_label.setText("Cards Left: " + ("-" if cards_left == None else f"~{cards_left}"))
        if (cards_per_minute == None or cards_left == None):
            self.time_remaining_label.setText("Time Left: -")
        else:
            minutes, seconds = divmod(int(cards_left * 60 / cards_per_minute), 60)
            hours, minutes = divmod(minutes, 60)
            self.time_remaining_label.setText(f"Time Left: ~{hours}:{minutes:02}:{seconds:02}")

        # Update bin info
        # Bin widgets are only built at startup, so a changed bin count shows after a restart.
        for i in range(len(self.bin_progress_bars)):
            progress_bar = self.bin_progress_bars[i]
            count_label = self.bin_card_count_labels[i]
            bin_label = self.bin_labels[i]
            
            if (self.workflow_executor != None):                
                card_count = self.workflow_executor.get_bin_card_count(i)
                card_capacity = self.workflow_executor.get_bin_card_capacity(i)
                workflow = self.workflow_executor.get_workflow()
                
                progress_bar.setValue(int((float(card_count) / float(card_capacity)) * 100))
                count_label.setText(f"{card_count}")
                bin_label.setText(f"{workflow.bins[i].name}")
            else:
                progress_bar.setValue(0)
                count_label.setText("0")
                bin_label.setText(f"{i + 1}")
                
        # Check the currently selected workflow.
        selected_items = self.project_tree_widget.selectedItems()
        selected_workflow = None
        if (len(selected_items) > 0):
            selected_workflow = selected_items[0].workflow
        self.start_button.setText(f"Start: {selected_workflow.name}" if selected_workflow != None else "Start")
        self.start_button.setEnabled(selected_workflow != None)
                
        # Update device info.
        self.device_properties_labels["X"].setText(str(self.card_sorter.get_position()[0]))
        self.device_properties_labels["Y"].setText(str(self.card_sorter.get_position()[1]))
        self.device_properties_labels["Z"].setText(str(self.card_sorter.get_position()[2]))
        self.device_properties_labels["Card Servo"].setText("Open" if self.card_sorter.get_servo_state() else "Closed")
        self.device_properties_labels["Card Light"].setText("On" if self.card_sorter.get_light_state() else "Off")
        self.device_properties_labels["X Limit"].setText("Triggered" if self.card_sorter.get_limit_state()[0] else "Open")
        self.device_properties_labels["Y Limit"].setText("Triggered" if self.card_sorter.get_limit_state()[1] else "Open")
        self.device_properties_labels["Card Probe"].setText("Triggered" if self.card_sorter.get_limit_state()[2] else "Open")
        self.device_properties_labels["Status"].setText(self.card_sorter.get_state().name.replace("_", " ").title())

        self.__update_card_list()
        
        if (self.workflow_list_dirty):
            self.__rebuild_workflow_list()
            self.workflow_list_dirty = False

        self.card_sorter.poll()

    def __rule_to_string(self, rule, is_first):
        operator_name = ""
        if (rule.operator == WorkflowCardArchetypeRuleOperator.EQUAL):
            operator_name = "is"
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.NOT_EQUAL):
            operator_name = "is not"
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.LESS):
            operator_name = "less than"
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.GREATER):
            operator_name = "greater than"
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.LESS_EQUAL):
            operator_name = "less than or equal to"
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.GREATER_EQUAL):
            operator_name = "greater than or equal to"
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.CONTAINS):
            operator_name = "contains"
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.NOT_CONTAINS):
            operator_name = "does not contain"
        return f"{"" if is_first else "and "}if {rule.attribute_name} {operator_name} {rule.value}"
 
    def __project_tree_property_changed(self, obj, key, value):
        node = self.project_tree_property_grid.target_metadata()
        
        node.setText(0, self.__get_node_text(node))
        self.settings.save()
 
    def __project_tree_selected_item_changed(self):
        selected_items = self.project_tree_widget.selectedItems()
        if (len(selected_items) == 0):
            self.project_tree_property_grid.set_target(None, None)
        else:
            selected_item = selected_items[0]        
            if isinstance(selected_item, ProjectListWorkflowWidgetItem):                
                self.project_tree_property_grid.set_target(selected_items[0].workflow, selected_items[0])
            elif isinstance(selected_item, ProjectListBinWidgetItem):              
                self.project_tree_property_grid.set_target(selected_items[0].bin, selected_items[0])
            elif isinstance(selected_item, ProjectListArchetypeWidgetItem):              
                self.project_tree_property_grid.set_target(selected_items[0].archetype, selected_items[0])
            elif isinstance(selected_item, ProjectListRuleWidgetItem):              
                self.project_tree_property_grid.set_target(selected_items[0].rule, selected_items[0])
            else:
                self.project_tree_property_grid.set_target(None, None)
             
    def __show_project_tree_context_menu(self, point):
        self.context_menu_item = self.project_tree_widget.itemAt(point)
                
        delete_workflow_button = QAction("Delete Workflow")
        delete_workflow_button.triggered.connect(self.__delete_workflow_clicked)
        
        delete_bin_button = QAction("Delete Bin")
        delete_bin_button.triggered.connect(self.__delete_bin_clicked)
        
        delete_archetype_button = QAction("Delete Archetype")
        delete_archetype_button.triggered.connect(self.__delete_archetype_clicked)
        
        delete_rule_button = QAction("Delete Rule")
        delete_rule_button.triggered.connect(self.__delete_rule_clicked)
            
        add_workflow_button = QAction("Add Workflow")
        add_workflow_button.triggered.connect(self.__add_workflow_clicked)
        
        add_bin_button = QAction("Add Bin")
        add_bin_button.triggered.connect(self.__add_bin_clicked)

        add_archetype_button = QAction("Add Archetype")
        add_archetype_button.triggered.connect(self.__add_archetype_clicked)

        add_rule_button = QAction("Add Rule")
        add_rule_button.triggered.connect(self.__add_rule_clicked)
                
        menu = QMenu(self)
        if (self.context_menu_item == None):
            menu.addAction(add_workflow_button)
        elif isinstance(self.context_menu_item, ProjectListWorkflowWidgetItem):
            if (len(self.context_menu_item.workflow.bins) < self.settings.bin_count):
                menu.addAction(add_bin_button)
            menu.addAction(delete_workflow_button)
        elif isinstance(self.context_menu_item, ProjectListBinWidgetItem):
            menu.addAction(add_archetype_button)
            menu.addAction(delete_bin_button)
        elif isinstance(self.context_menu_item, ProjectListArchetypeWidgetItem):
            menu.addAction(add_rule_button)
            menu.addAction(delete_archetype_button)
        elif isinstance(self.context_menu_item, ProjectListRuleWidgetItem):
            menu.addAction(delete_rule_button)
        
        menu.exec(QCursor.pos())

    def __delete_workflow_clicked(self):
        self.settings.workflows.remove(self.context_menu_item.workflow)
        self.project_tree_widget.invisibleRootItem().removeChild(self.context_menu_item)
        
    def __delete_bin_clicked(self):
        self.context_menu_item.workflow.bins.remove(self.context_menu_item.bin)
        self.context_menu_item.parent().removeChild(self.context_menu_item)
    
    def __delete_archetype_clicked(self):
        self.context_menu_item.bin.archetypes.remove(self.context_menu_item.archetype)
        self.context_menu_item.parent().removeChild(self.context_menu_item)
    
    def __delete_rule_clicked(self):
        parent = self.context_menu_item.parent()
        self.context_menu_item.archetype.rules.remove(self.context_menu_item.rule)
        parent.removeChild(self.context_menu_item)
        
        # Text depends on index in rule array, so update all nodes that still exist
        for i in range(parent.childCount()):
            child = parent.child(i)
            child.setText(0, self.__get_node_text(child))
    
    def __add_workflow_clicked(self):
        workflow = Workflow("Unnamed Workflow", WorkflowMatchBehaviour.RIGHT_TO_LEFT, [])        
        self.settings.workflows.append(workflow)
        self.__create_workflow_node(workflow)       
    
    def __add_bin_clicked(self):
        bin = WorkflowBin("Unnamed Bin", 300, [])        
        self.context_menu_item.workflow.bins.append(bin)
        self.__create_bin_node(self.context_menu_item.workflow, bin, self.context_menu_item)       
        self.context_menu_item.setExpanded(True)
    
    def __add_archetype_clicked(self):
        archetype = WorkflowCardArchetype("Unnamed Archetype", 0, [])           
        self.context_menu_item.bin.archetypes.append(archetype)
        self.__create_archetype_node(self.context_menu_item.workflow, self.context_menu_item.bin, archetype, self.context_menu_item)       
        self.context_menu_item.setExpanded(True)
    
    def __add_rule_clicked(self):
        rule = WorkflowCardArchetypeRule(CardFieldName.RARITY, WorkflowCardArchetypeRuleOperator.EQUAL, CardRarity.COMMON)        
        self.context_menu_item.archetype.rules.append(rule)
        self.__create_rule_node(self.context_menu_item.workflow, self.context_menu_item.bin, self.context_menu_item.archetype, rule, self.context_menu_item)        
        self.context_menu_item.setExpanded(True)
 
    def __get_node_text(self, node):
        if (isinstance(node, ProjectListWorkflowWidgetItem)):
            return node.workflow.name
        elif (isinstance(node, ProjectListBinWidgetItem)):
            return node.bin.name
        elif (isinstance(node, ProjectListArchetypeWidgetItem)):
            return node.archetype.name
        elif (isinstance(node, ProjectListRuleWidgetItem)):
            return self.__rule_to_string(node.rule, node.archetype.rules.index(node.rule) == 0)
        else:
            return ""
         
    def __create_workflow_node(self, workflow):
        item = ProjectListWorkflowWidgetItem(self.project_tree_widget)
        item.workflow = workflow
        item.setText(0, workflow.name)
        item.setIcon(0, self.style().standardIcon(QStyle.StandardPixmap.SP_DirOpenIcon))
        return item
    
    def __create_bin_node(self, workflow, bin, parent):
        item = ProjectListBinWidgetItem(parent)
        item.workflow = workflow
        item.bin = bin
        item.setText(0, f"{bin.name}")
        item.setIcon(0, self.style().standardIcon(QStyle.StandardPixmap.SP_TrashIcon))
        return item

    def __create_archetype_node(self, workflow, bin, archetype, parent):
        item = ProjectListArchetypeWidgetItem(parent)
        item.workflow = workflow
        item.bin = bin
        item.archetype = archetype
        item.setText(0, f"{archetype.name}")
        item.setIcon(0, self.style().standardIcon(QStyle.StandardPixmap.SP_FileIcon))                    
        return item
    
    def __create_rule_node(self, workflow, bin, archetype, rule, parent):        
        item = ProjectListRuleWidgetItem(parent)
        item.workflow = workflow
        item.bin = bin
        item.archetype = archetype
        item.rule = rule
        item.setText(0, f"{self.__rule_to_string(rule, archetype.rules.index(rule) == 0)}")    
        item.setIcon(0, self.style().standardIcon(QStyle.StandardPixmap.SP_ToolBarHorizontalExtensionButton))                                                        
        return item
     
    def __rebuild_workflow_list(self):
        self.project_tree_widget.clear()
        for workflow in self.settings.workflows:                  
            workflow_item = self.__create_workflow_node(workflow)             
            for bin in workflow.bins:           
                bin_item = self.__create_bin_node(workflow, bin, workflow_item)
                for archetype in bin.archetypes:           
                    archetype_item = self.__create_archetype_node(workflow, bin, archetype, bin_item)
                    for rule in archetype.rules:           
                        rule_item = self.__create_rule_node(workflow, bin, archetype, rule, archetype_item)

        self.project_tree_widget.header().setStretchLastSection(False)
        self.project_tree_widget.header().setSectionResizeMode(0, QHeaderView.ResizeMode.Stretch)
        self.project_tree_widget.header().setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)

    def __update_card_list(self):
        if (self.workflow_executor == None):
            return

        root_widget = self.card_list_tree_widget.invisibleRootItem()

        # Update / Add existing widgets
        card_list = self.workflow_executor.get_card_list()
        total_cards = 0
        total_price = 0.0
        for entry in card_list:
            total_cards += entry.quantity
            total_price += entry.quantity * (entry.card_identity.info.attributes[CardFieldName.PRICE_USD_FOIL] if entry.card_identity.is_foil else entry.card_identity.info.attributes[CardFieldName.PRICE_USD_NONFOIL])

            exists = False
            for i in range(root_widget.childCount()):
                child = root_widget.child(i)
                child_entry = child.entry
                if (entry.card_identity.is_foil == child_entry.card_identity.is_foil and 
                    entry.card_identity.info.id == child_entry.card_identity.info.id):               
                    child.setText(3, str(entry.quantity))
                    exists = True
                    
            if (not exists):
                item = CardListTreeWidgetItem(self.card_list_tree_widget)
                item.entry = entry
                item.setText(0, entry.card_identity.info.name)
                item.setText(1, entry.card_identity.info.attributes[CardFieldName.RARITY])
                item.setText(2, "Foil" if entry.card_identity.is_foil else "Normal")
                item.setText(3, str(entry.quantity))
                item.setText(4, "$" + str(entry.card_identity.info.attributes[CardFieldName.PRICE_USD_FOIL] if entry.card_identity.is_foil else entry.card_identity.info.attributes[CardFieldName.PRICE_USD_NONFOIL]))

                image_url = QUrl.fromLocalFile(get_card_image_path(entry.card_identity.info.id)).toString()
                for column in range(self.card_list_tree_widget.columnCount()):
                    item.setToolTip(column, f'<img src="{image_url}" width="250" height="349">')

        self.total_cards_label.setText(f"Total Cards: {total_cards}")
        self.total_card_price_label.setText(f"Total Card Price: ${total_price:.2f}")

        # Remove unused cards
        i = 0
        while (i < root_widget.childCount()):
            child = root_widget.child(i)
            child_entry = child.entry
            exists = False
            for entry in card_list:
                if (entry.card_identity.is_foil == child_entry.card_identity.is_foil and 
                    entry.card_identity.info.id == child_entry.card_identity.info.id):               
                    exists = True
                    break
            if (not exists):
                root_widget.removeChild(child)
            else:
                i += 1

    def __export_csv_clicked(self, s):
        path, _ = QFileDialog.getSaveFileName(self, "Export CSV", "cards.csv", "CSV Files (*.csv)")
        if (path == ""):
            return

        header = self.card_list_tree_widget.headerItem()
        column_count = self.card_list_tree_widget.columnCount()

        with open(path, "w", newline="", encoding="utf-8") as file:
            writer = csv.writer(file)

            row = []
            for column in range(column_count):
                row.append(header.text(column))
            writer.writerow(row)

            root_widget = self.card_list_tree_widget.invisibleRootItem()
            for i in range(root_widget.childCount()):
                item = root_widget.child(i)
                row = []
                for column in range(column_count):
                    row.append(item.text(column))
                writer.writerow(row)

    def __connect_clicked(self, s):
        ip_address = self.ip_line_edit.text()
        self.disconnect_user_triggered = False
        self.settings.card_sorter_ip_address = ip_address
        self.settings.save()
        self.is_auto_connect_paused = False
        self.auto_connect_delay = self.auto_connect_initial_delay
        self.card_sorter.connect(ip_address)
        self.__update_state()

    def __disconnect_clicked(self, s):
        self.card_sorter.disconnect()
        self.disconnect_user_triggered = True
        self.is_auto_connect_paused = True

    def __is_auto_connecting(self):
        return (self.settings.auto_connect and not self.is_auto_connect_paused)

    def __set_live_preview(self, is_live_preview, turn_light_off = True):
        if (self.__is_live_preview and not is_live_preview and turn_light_off):
            self.__need_new_uncropped_image = True
        self.__is_live_preview = is_live_preview
        self.__update_state()

    def __live_preview_clicked(self):
        self.__set_live_preview(not self.__is_live_preview)

    def __tab_changed(self, index):
        if (self.main_layout.widget(index) != self.device_tab_layout):
            self.__set_live_preview(False)

    def __disconnected(self):        
        is_workflow_interrupted = self.__is_workflow_active() or (self.workflow_executor != None and self.workflow_executor.was_interrupted())
        if (not self.disconnect_user_triggered and (not self.__is_auto_connecting() or is_workflow_interrupted)):        
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Icon.Critical)
            msg.setText("Lost network connection to card sorter.")
            msg.setInformativeText(f"")
            msg.setWindowTitle("Disconnected")
            msg.exec()
        
        self.__discard_workflow_executor()
        self.__queued_device_operations = []
        self.__set_live_preview(False)
        self.main_layout.setCurrentIndex(0)
        self.disconnect_user_triggered = False

    def __start_clicked(self, s):                
        selected_items = self.project_tree_widget.selectedItems()
        selected_workflow = None
        if (len(selected_items) > 0):
            selected_workflow = selected_items[0].workflow
        
        if (selected_workflow == None):
            return

        msg = QMessageBox()
        msg.setIcon(QMessageBox.Icon.Information)
        msg.setText("Please ensure all bins are empty, then click OK to start.")
        msg.setInformativeText(f"")
        msg.setWindowTitle("Workflow Starting")
        msg.exec()
                
        self.__set_live_preview(False, turn_light_off=False)
        self.__queued_device_operations = []
        self.__discard_workflow_executor()
        self.workflow_executor = WorkflowExecutor(self.card_sorter, self.card_identifier, self.settings)
        self.workflow_executor.start(selected_workflow)
        self.__update_state()
        self.main_layout.setCurrentIndex(1)

    def __stop_clicked(self, s):
        try:
            self.workflow_executor.stop()
        except WorkflowExecutorInvalidStateException:
            pass
        self.__update_state()

    def closeEvent(self, event):
        self.poll_timer.stop()
        self.__discard_workflow_executor()
        self.card_sorter.disconnect()
        super().closeEvent(event)

    def __discard_workflow_executor(self):
        if (self.workflow_executor != None):
            self.workflow_executor.shutdown()
            self.workflow_executor = None

    def __emergency_stop_clicked(self, s):
        self.__queued_device_operations = []
        if (self.workflow_executor != None):
            self.workflow_executor.emergency_stop()
        self.card_sorter.emergency_stop()
        self.__update_state()

    def __pause_clicked(self, s):
        try:
            self.workflow_executor.pause()
        except WorkflowExecutorInvalidStateException:
            pass
        self.__update_state()

    def __settings_clicked(self, s):
        previous_settings = dict(vars(self.settings))

        SettingsWindow(self.settings, self).exec()

        self.ip_line_edit.setText(self.settings.card_sorter_ip_address)

        mirrored_line_edits = [
            (self.left_crop_line_edit, self.settings.webcam_crop_left),
            (self.right_crop_line_edit, self.settings.webcam_crop_right),
            (self.top_crop_line_edit, self.settings.webcam_crop_top),
            (self.bottom_crop_line_edit, self.settings.webcam_crop_bottom),
            (self.exposure_line_edit, self.settings.webcam_exposure),
            (self.brightness_line_edit, self.settings.webcam_brightness),
            (self.focus_line_edit, self.settings.webcam_focus),
            (self.white_balance_line_edit, self.settings.webcam_white_balance),
        ]
        for line_edit, value in mirrored_line_edits:
            line_edit.blockSignals(True)
            line_edit.setText(str(value))
            line_edit.blockSignals(False)
        self.crop_preview.set_rectangle_bounds(self.settings.webcam_crop_left, self.settings.webcam_crop_top, (self.settings.webcam_crop_right - self.settings.webcam_crop_left), (self.settings.webcam_crop_bottom - self.settings.webcam_crop_top))

        for key, value in previous_settings.items():
            if (key.startswith("webcam_") and getattr(self.settings, key) != value):
                self.__need_new_uncropped_image = True
                self.__need_to_apply_webcam_settings = True

    def __resume_clicked(self, s):
        try:
            self.workflow_executor.resume()
        except WorkflowExecutorInvalidStateException:
            pass
        self.__update_state()