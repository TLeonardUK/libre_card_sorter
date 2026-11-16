# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

import asyncio
import sys
import os
import io
import base64
import time
import math
import Utils.Timing as Timing
from PIL import Image

from threading import Thread, RLock

import websockets.exceptions
from websockets.sync.client import connect

from Utils.Events import Event
from Settings import Settings

from enum import Enum

class CardSorterNotIdleException(Exception):
    pass

# What state the card sorter is in which defines what its actively doing.
class CardSorterState(Enum):
    DISCONNECTED = 0
    DISCONNECTING = 1,
    CONNECTING = 2
    INITAL_SETUP = 3,
    IDLE = 4
    HOMING = 5
    DELIVERING_CARD = 6
    MOVING = 7
    GETTING_CARD_IMAGE = 8
    LOADING_CARD = 9
    JOGGING = 10
    POLLING_STATE = 11
    RESETTING_WEBCAM = 12
    ERROR = 13
    FEEDING_CARD = 14
    STOPPING = 15
    
# Main class for connecting to and controlling the card sorter.
class CardSorter:

    def __init__(self, settings):

        self.__connection_thread = None
        self.__connection_ip = ""
        self.__connection_uri = ""

        self.__state = CardSorterState.DISCONNECTED
        self.__last_poll_state = CardSorterState.DISCONNECTED

        self.__thread_lock = RLock()

        self.__send_message_queue = []
        
        self.__pending_accept_message_queue = []

        self.__active_command_list = []

        self.__card_image = None
        self.__uncropped_card_image = None        
        self.__next_webcam_images_is_uncropped = False

        self.__error_code = ""

        self.__x_pos = 0
        self.__y_pos = 0
        self.__z_pos = 0
        self.__x_limit_hit = False
        self.__y_limit_hit = False
        self.__z_limit_hit = False
        self.__loaded_y_pos = None
        self.__servo_state = False
        self.__light_state = False

        self.__last_position_poll = 0

        self.on_connected = Event()
        self.on_disconnected = Event()
        self.on_card_image_updated = Event()
        self.on_error = Event()
        self.on_state_changed = Event()

        self.__settings = settings

    def __connection_handler(self):
        try:
            print(f"Connecting to {self.__connection_uri}")
            with connect(self.__connection_uri, max_size=(32*1024*1024), open_timeout = 5, compression=None) as websocket:
                print("Connected to server.")

                with self.__thread_lock:
                    if (self.__state == CardSorterState.CONNECTING):   
                        self.__next_webcam_images_is_uncropped = True                 
                        self.__run_command_list(CardSorterState.INITAL_SETUP, require_idle = False, command_list = [             
                            #f"send_serial M914 X{self.__settings.x_stall_threshold} Y{self.__settings.y_stall_threshold}",  # TMC Sensorless Homing Theshold            
                            #f"send_serial M920 X{self.__settings.x_homing_current} Y{self.__settings.y_homing_current}",    # TNC Homing Current
                        
                            # Get uncropped webcam image
                            f"set_setting webcam_crop_left 0", 
                            f"set_setting webcam_crop_right 1", 
                            f"set_setting webcam_crop_top 0", 
                            f"set_setting webcam_crop_bottom 1", 
                            f"set_setting webcam_resize_width 1920",
                            f"set_setting webcam_resize_height 1080",
                            f"set_setting webcam_exposure {self.__settings.webcam_exposure}", 
                            f"set_setting webcam_focus {self.__settings.webcam_focus}", 
                            f"set_setting webcam_white_balance {self.__settings.webcam_white_balance}", 
                            f"send_serial M150 P{self.__settings.webcam_brightness} R255 U255 B255",     # Turn all LED on
                            f"send_serial M400",                                                        # Wait for commands to finish
                            "capture_webcam",            
                            f"send_serial M150 P0",                                                     # Turn all LED off
                            f"send_serial M400",                                                        # Wait for commands to finish

                            # Setup settings and home
                            f"set_setting webcam_crop_left {self.__settings.webcam_crop_left}", 
                            f"set_setting webcam_crop_right {self.__settings.webcam_crop_right}", 
                            f"set_setting webcam_crop_top {self.__settings.webcam_crop_top}", 
                            f"set_setting webcam_crop_bottom {self.__settings.webcam_crop_bottom}", 
                            f"set_setting webcam_resize_width 224",
                            f"set_setting webcam_resize_height 224",
                            f"send_serial M150 P0",                                                                     # Turn all LED off
                            f"send_serial M280 P0 S90",                                                                 # Close dispenser
                            f"send_serial M154 S1",                                                                     # Report position every second
                            f"send_serial M201 X{self.__settings.x_max_acceleration} Y{self.__settings.y_max_acceleration} Z{self.__settings.z_max_acceleration}",    # Max acceleration
                            f"send_serial M203 X{self.__settings.x_max_feed_rate} Y{self.__settings.y_max_feed_rate} Z{self.__settings.z_max_feed_rate}",       # Max feed rate
                            f"send_serial M204 P{self.__settings.acceleration} T{self.__settings.acceleration}",           # Move acceleration
                            "reset_webcam",                                                                             # Apply all webcam settings
                            "send_serial M400",                                                                         # Wait for completion
                        ])            

                while (self.__state != CardSorterState.DISCONNECTING):
                    to_send = []
                    with self.__thread_lock:
                        to_send = self.__send_message_queue
                        self.__send_message_queue = []

                    for msg in to_send:
                        websocket.send(msg)

                    try:
                        while (True):
                            msg = websocket.recv(0, decode=True)
                            self.__recv_message(msg)
                    except TimeoutError:
                        pass 

                    time.sleep(0.001)
        except ConnectionRefusedError:
            print("Could not connect to server.")
        except Exception as e:
            print(f"Connection error: {e}")
        finally:
            with self.__thread_lock:
                self.__active_command_list = []
                self.__pending_accept_message_queue = []
                self.__change_state(CardSorterState.DISCONNECTED)

    def __recv_message(self, raw):
        with self.__thread_lock:
            self.__process_message(raw)

    def __send_message(self, raw):        
        if (self.__settings.verbose):
            print(f"> {raw}")
        with self.__thread_lock:
            self.__send_message_queue.append(raw)
            self.__pending_accept_message_queue.append(raw)

    def __command_list_completed(self):
        #print("Operation completed, list finished.")
        self.__active_command_list = []

        if (self.__state == CardSorterState.LOADING_CARD):
            self.__loaded_y_pos = self.__y_pos

        self.__change_state(CardSorterState.IDLE)

    def __command_accepted(self):
        # An acknowledgement still queued when the connection dropped mustn't bring the state back from disconnected.
        if (not self.is_connected() or len(self.__pending_accept_message_queue) == 0):
            return

        last_command = self.__pending_accept_message_queue.pop(0)

        # Commands sent before the stop are still acknowledged, so it's only idle once they all have been.
        if (self.__state == CardSorterState.STOPPING):
            if (len(self.__pending_accept_message_queue) == 0):
                self.__change_state(CardSorterState.IDLE)
            return
        
        # Hackily track some state.

        # Track LED state
        if (last_command.startswith("send_serial M150")):
            if (last_command.startswith("send_serial M150 P0")):
                self.__light_state = False
            else:
                self.__light_state = True
            
        # Track servo state
        if (last_command.startswith("send_serial M280")):
            if (last_command.startswith("send_serial M280 P0 S90")):
                self.__servo_state = False
            else:
                self.__servo_state = True
                
        if (len(self.__active_command_list) <= 1):            
            self.__command_list_completed()
        else:
            self.__active_command_list = self.__active_command_list[1:]                    
            self.__send_message(self.__active_command_list[0])

    def __process_message(self, raw):          
        if (self.__settings.verbose):
            if (raw.startswith("webcam_data")):
                print(f"< webcam_data")
            else:
                print(f"< {raw}")

        if (raw.startswith("webcam_data")):
            jpeg_base64 = raw[12:]
            jpeg_bytes = base64.b64decode(jpeg_base64)

            stream = io.BytesIO(jpeg_bytes)

            loaded_image = Image.open(stream)
            loaded_image.load()

            if (self.__next_webcam_images_is_uncropped):
                self.__uncropped_card_image = loaded_image
            else:
                self.__card_image = loaded_image
            stream.close()

            self.on_card_image_updated.invoke()
            
            self.__next_webcam_images_is_uncropped = False
            #self.__command_accepted() # Send as seperate OK
            #self.__change_state(CardSorterState.IDLE)
        # Confirmation from relay server
        elif (raw.startswith("ok")):  
            self.__command_accepted()      
        # Diagnostic messages from relay server
        elif (raw.startswith("echo")):  
            pass
        elif (raw.startswith("recv_serial")):
            raw = raw[12:].strip()                  
            # Action complete, queue next action or return to idle.
            if (raw == "ok"):
                self.__command_accepted()
            # Error
            elif (raw.startswith("Error:")):        
                self.__error_code = f"marlin error {raw[6:]}"
                self.__active_command_list = []
                self.__change_state(CardSorterState.ERROR)
            # Position update
            elif (raw.startswith("X:")):
                sections = raw.split(" ")       
                for section in sections:
                    key_values = section.split(":")
                    if (len(key_values) == 2):
                        key = key_values[0]
                        values = key_values[1].split(",")
                        if (key == 'X'):
                            self.__x_pos = float(values[0])
                        elif (key == 'Y'):
                            self.__y_pos = float(values[0])
                        elif (key == 'Z'):
                            self.__z_pos = float(values[0])
                    else:
                        break
            # Limit switch update
            elif (raw.startswith("x_min:")):
                value = raw[7:].strip()
                self.__x_limit_hit = (value != "open")
            elif (raw.startswith("y_min:")):
                value = raw[7:].strip()
                self.__y_limit_hit = (value != "open")
            elif (raw.startswith("z_min:")):
                value = raw[7:].strip()
                self.__z_limit_hit = (value != "open")
            # Status messages
            elif (raw.startswith("echo") or raw.startswith("busy") or raw.startswith("buzy") or raw.startswith("Reporting endstop status")):   
                pass # Starts updates, we don't care
            else:
                pass
                #self.__error_code = f"unknown serial response: {raw}"
                #self.__change_state(CardSorterState.ERROR)
        else:
            self.__error_code = "unknown message"
            self.__change_state(CardSorterState.ERROR)

    def __change_state(self, new_state):
        if (new_state == self.__state):
            return
        if (self.__settings.verbose):
            print(f"Changed state to {new_state}")
        if (new_state == CardSorterState.ERROR):
            self.__active_command_list = []
            print(f"Error occured: {self.__error_code}")
            self.on_error.invoke()
        self.__state = new_state
        self.on_state_changed.invoke()

    def __run_command_list(self, new_state, command_list, require_idle = True):
        with self.__thread_lock:
            if (require_idle and self.__state != CardSorterState.IDLE):
                raise CardSorterNotIdleException()
            self.__change_state(new_state)
            self.__active_command_list = command_list
            self.__send_message(command_list[0])

    #def __ShouldPollState(self):
    #    return (self.__state != CardSorterState.ERROR and self.__state != CardSorterState.LoadingMagazine and self.__state != CardSorterState.LoadingMagazineBackoff and self.__state != CardSorterState.LoadingMagazineFine)
    
    def connect(self, ip):
        if (self.__connection_thread != None):
            self.disconnect()

        with self.__thread_lock:
            self.__send_message_queue = []
            self.__pending_accept_message_queue = []
            self.__active_command_list = []
            self.__last_poll_state = CardSorterState.CONNECTING
            self.__change_state(CardSorterState.CONNECTING)
        self.__connection_ip = ip
        self.__connection_uri = f"ws://{self.__connection_ip}:{self.__settings.connection_port}"
        self.__connection_thread = Thread(target = self.__connection_handler)        
        self.__connection_thread.start()

    def disconnect(self):
        if (self.__connection_thread == None):
            return

        with self.__thread_lock:
            self.__change_state(CardSorterState.DISCONNECTING)
        self.__connection_thread.join()
        self.__connection_thread = None
        with self.__thread_lock:
            self.__change_state(CardSorterState.DISCONNECTED)

    def poll(self):
        # Fire events
        if (self.__state != self.__last_poll_state):
            if (self.is_connected()):
                self.on_connected.invoke()
            elif (self.__state == CardSorterState.DISCONNECTED):
                self.on_disconnected.invoke()
            self.__last_poll_state = self.__state

        with self.__thread_lock:
            # Periodically just ask for the current position/limit states so we can update UI/etc
            elapsed_ms = Timing.get_milliseconds() - self.__last_position_poll
            if (self.is_connected() and elapsed_ms > 1000 and self.__state == CardSorterState.IDLE):
                # Position is automatically reported via M154            
                self.__run_command_list(CardSorterState.POLLING_STATE, [                                            
                    "send_serial M119" # Get limit switch state
                ])    
                self.__last_position_poll = Timing.get_milliseconds()
        
    def get_position(self):        
        return (self.__x_pos, self.__y_pos, self.__z_pos)
    
    def get_limit_state(self):        
        return (self.__x_limit_hit, self.__y_limit_hit, self.__z_limit_hit)

    def get_servo_state(self):
        return self.__servo_state
    
    def get_light_state(self):
        return self.__light_state
    
    def toggle_servo(self):
        with self.__thread_lock:
            self.__toggle_servo()

    def __toggle_servo(self):
        if (self.__servo_state):
            self.__run_command_list(CardSorterState.JOGGING, [                                            
                f"send_serial M280 P0 S90"
            ])                   
        else:        
            self.__run_command_list(CardSorterState.JOGGING, [                                            
                f"send_serial M280 P0 S180"
            ])           

    def toggle_light(self):
        with self.__thread_lock:
            self.__toggle_light()

    def __toggle_light(self):
        if (self.__light_state):
            self.__run_command_list(CardSorterState.JOGGING, [                                            
                f"send_serial M150 P0"
            ])       
        else:             
            self.__run_command_list(CardSorterState.JOGGING, [                                            
                f"send_serial M150 P{self.__settings.webcam_brightness} R255 U255 B255"
            ])

    def emergency_stop(self):
        with self.__thread_lock:
            if (not self.is_connected()):
                return
            self.__active_command_list = []
            self.__change_state(CardSorterState.STOPPING)
            self.__send_message("send_serial M410")                                             # Halt

    def jog(self, distance_axis, feed_rate):        
        self.__run_command_list(CardSorterState.JOGGING, [                                            
            f"send_serial G91",                                                                 # Use relative positioning
            f"send_serial G0 X{distance_axis[0]} Y{distance_axis[1]} Z{distance_axis[2]} F{feed_rate}",    
            f"send_serial G90",                                                                 # Use absolute positioning
        ])

    def is_connected(self):
        return (self.__state != CardSorterState.DISCONNECTED and self.__state != CardSorterState.CONNECTING and self.__state != CardSorterState.DISCONNECTING)

    def get_error(self):
        return self.__error_code

    def get_state(self):
        return self.__state

    def get_card_image(self):
        return self.__card_image

    def get_uncropped_card_image(self):
        return self.__uncropped_card_image

    # Requsts a webcam image but gets it uncropped. The LED can be left on for a stream of captures, rather than flashing.
    def request_uncropped_image(self, keep_light_on = False):
        
        commands = [
            f"set_setting webcam_crop_left 0", 
            f"set_setting webcam_crop_right 1", 
            f"set_setting webcam_crop_top 0", 
            f"set_setting webcam_crop_bottom 1", 
            f"set_setting webcam_resize_width 1920",
            f"set_setting webcam_resize_height 1080",

            f"send_serial M150 P{self.__settings.webcam_brightness} R255 U255 B255",     # Turn all LED on
            "capture_webcam",            
        ]
        if (not keep_light_on):
            commands.append(f"send_serial M150 P0")                                     # Turn all LED off
        with self.__thread_lock:
            self.__run_command_list(CardSorterState.GETTING_CARD_IMAGE, commands)
            self.__next_webcam_images_is_uncropped = True
        
    def apply_webcam_settings(self):        
        self.__run_command_list(CardSorterState.RESETTING_WEBCAM, [
            f"set_setting webcam_exposure {self.__settings.webcam_exposure}", 
            f"set_setting webcam_focus {self.__settings.webcam_focus}", 
            f"set_setting webcam_white_balance {self.__settings.webcam_white_balance}", 
        ])

    def request_new_card_image(self):
        self.__run_command_list(CardSorterState.GETTING_CARD_IMAGE, [                                      
            f"set_setting webcam_crop_left {self.__settings.webcam_crop_left}", 
            f"set_setting webcam_crop_right {self.__settings.webcam_crop_right}", 
            f"set_setting webcam_crop_top {self.__settings.webcam_crop_top}", 
            f"set_setting webcam_crop_bottom {self.__settings.webcam_crop_bottom}", 
            f"set_setting webcam_resize_width 224",
            f"set_setting webcam_resize_height 224",
                                                                
            f"send_serial M150 P{self.__settings.webcam_brightness} R255 U255 B255",     # Turn all LED on
            "capture_webcam",            
            f"send_serial M150 P0",                                                     # Turn all LED off
        ])

    def request_new_card_image_led_controlled(self, led_index):
        self.__run_command_list(CardSorterState.GETTING_CARD_IMAGE, [                                            
            f"send_serial M150 I{led_index} P{self.__settings.webcam_brightness} R255 U255 B255",    # Turn one LED on
            "capture_webcam",            
            f"send_serial M150 P0",                                                                 # Turn all LED off
        ])

    def is_magazine_empty(self):
        return self.__y_pos > self.__settings.y_axis_range

    def get_estimated_magazine_card_count(self):
        if (self.__loaded_y_pos == None):
            return None
        return max(0, int((self.__settings.y_axis_range - self.__loaded_y_pos) / self.__settings.card_thickness))

    def load_card(self):

        self.__run_command_list(CardSorterState.LOADING_CARD, [
            f"send_serial G38.3 Y1000 F{self.__settings.y_feed_rate}",                                        # Move towards top of Y until probe is hit
            "send_serial M400",                                                                             # Wait for completion
            "send_serial M114",                                                                             # Get position
            "send_serial M400",                                                                             # Wait for completion
        ]);
        
    # How far another axis can move alongside an X move without making the move take any longer, as Marlin runs
    # every axis in a move together at the pace of the slowest.
    def __distance_alongside_x_move(self, x_distance, feed_rate, max_feed_rate, max_acceleration):
        x_speed = min(self.__settings.x_feed_rate / 60, self.__settings.x_max_feed_rate)
        x_acceleration = min(self.__settings.x_max_acceleration, self.__settings.acceleration)
        speed = min(feed_rate / 60, max_feed_rate)
        acceleration = min(max_acceleration, self.__settings.acceleration)
        return abs(x_distance) * min(speed / x_speed, acceleration / x_acceleration)

    def __x_move_command(self, x_distance, y_distance):
        # The feed rate applies along the whole move, so it's raised by Y's share to keep X at full speed.
        x_speed = min(self.__settings.x_feed_rate / 60, self.__settings.x_max_feed_rate)
        length = math.sqrt(x_distance * x_distance + y_distance * y_distance)
        feed_rate = x_speed * 60
        if (x_distance != 0):
            feed_rate *= length / abs(x_distance)
        return f"send_serial G0 X{x_distance:.3f} Y{y_distance:.3f} F{feed_rate:.0f}"

    # Pushes the card on top of the stack out towards the funnel, leaving the roller parked.
    def __dispense_card_commands(self):
        return [
            f"send_serial G91",                                                                             # Use relative positioning
            f"send_serial G0 Z{self.__settings.z_dispense_grip_card_distance} F{self.__settings.z_feed_rate}",    # Move Z forward to push card out (part way to grip it)
            f"send_serial G0 Y{self.__settings.y_dispense_card_backoff_distance} F{self.__settings.y_feed_rate}", # Backoff Y a bit so we don't load two cards
            f"send_serial G0 Z{self.__settings.z_dispense_feed_card_distance} F{self.__settings.z_feed_rate}",    # Move Z forward to push card out (rest of the way)
            f"send_serial G4 S0.15",                                                                        # Wait for card to fall
            f"send_serial G0 Z-{self.__settings.z_park_distance} F{self.__settings.z_feed_rate}",               # Park the roller (the card drops into the funnel as it lifts, so X must wait for it)
        ]

    # Loads the next card and pushes it out without delivering it to a bin or moving the funnel.
    def feed_card(self):

        commands = [
            f"send_serial G90",                                                                             # Use absolute positioning
            f"send_serial G38.3 Y1000 F{self.__settings.y_feed_rate}",                                        # Move towards top of Y until probe is hit
        ]
        commands.extend(self.__dispense_card_commands())
        commands.append(f"send_serial G90")                                                                 # Use absolute positioning
        commands.append(f"send_serial M400")                                                                # Wait for completion
        self.__run_command_list(CardSorterState.FEEDING_CARD, commands)

    # Drops the card already in the funnel into a bin, then returns to the load position.
    def drop_card_in_bin(self, bin_index):

        bin_position = self.__settings.x_bin_offset + (self.__settings.x_bin_stride * bin_index)

        self.__run_command_list(CardSorterState.DELIVERING_CARD, [
            f"send_serial G90",                                                                             # Use absolute positioning
            f"send_serial G0 X{bin_position} F{self.__settings.x_feed_rate}",                                  # Move to card bin position
            f"send_serial M400",                                                                            # Wait for completion
            f"send_serial M280 P0 S180",                                                                    # Open dispenser
            f"send_serial G4 P300",                                                                         # Wait for dispenser to open and card to fall
            f"send_serial M280 P0 S90",                                                                     # Close dispenser (finishes while moving back)
            f"send_serial G0 X{self.__settings.x_load_position} F{self.__settings.x_feed_rate}",                # Move back to card load position
            f"send_serial M400",                                                                            # Wait for completion
        ])

    def deliver_card_to_bin(self, bin_index):        
        
        x_distance = self.__settings.x_bin_offset + (self.__settings.x_bin_stride * bin_index) - self.__settings.x_load_position

        # The stack is raised back up during the X moves to and from the bin, as far as it can be without slowing them.
        # load_card's probe raises it the rest of the way.
        raise_distance = max(0, -self.__settings.y_dispense_card_backoff_distance - self.__settings.y_load_approach_distance)
        y_alongside = self.__distance_alongside_x_move(x_distance, self.__settings.y_feed_rate, self.__settings.y_max_feed_rate, self.__settings.y_max_acceleration)
        y_out = min(y_alongside, raise_distance)
        y_back = min(y_alongside, raise_distance - y_out)
        
        commands = [
            f"send_serial G90",                                                                             # Use absolute positioning
            f"send_serial G0 X{self.__settings.x_load_position} F{self.__settings.x_feed_rate}",                # Move to card load position
        ]
        commands.extend(self.__dispense_card_commands())
        commands.extend([
            self.__x_move_command(x_distance, y_out),                                                       # Move to bin, raising stack
            f"send_serial M400",                                                                            # Wait for completion
            f"send_serial M280 P0 S180",                                                                    # Open dispenser
            f"send_serial G4 P300",                                                                         # Wait for dispenser to open and card to fall
            f"send_serial M280 P0 S90",                                                                     # Close dispenser (finishes while moving back)
            self.__x_move_command(-x_distance, y_back),                                                     # Move back to load position, raising stack
            f"send_serial G90",                                                                             # Use absolute positioning
        ])
        self.__run_command_list(CardSorterState.DELIVERING_CARD, commands)

    def move_to_bin(self, bin_index):

        bin_position = self.__settings.x_bin_offset + (self.__settings.x_bin_stride * bin_index)
        
        self.__run_command_list(CardSorterState.MOVING, [ 
            "send_serial G90",                                                           # Use absolute positioning
            f"send_serial G0 X{bin_position} F{self.__settings.x_feed_rate}",               # Move to card bin position
            "send_serial M400",                                                          # Wait for completion
        ])

    def home(self):
        
        self.__run_command_list(CardSorterState.HOMING, [ 
            "send_serial G90",                                                                          # Use absolute positioning
            "send_serial G28 X",                                                                        # Home X
            f"send_serial G0 X{self.__settings.x_load_position} F{self.__settings.x_feed_rate}",            # Move to card load position
            "send_serial G28 Y",                                                                        # Home Y
            f"send_serial G91",                                                                         # Use relative positioning
            f"send_serial G0 Z-{self.__settings.z_park_distance} F{self.__settings.z_feed_rate}",           # Move Z forward to park the roller
            "send_serial M400",                                                                         # Wait for completion
        ])
        
    def home_x(self):
        
        self.__run_command_list(CardSorterState.HOMING, [ 
            "send_serial G90",                                                                          # Use absolute positioning
            "send_serial G28 X",                                                                        # Home X
            "send_serial M400",                                                                         # Wait for completion
        ])
        
    def home_y(self):
        
        self.__run_command_list(CardSorterState.HOMING, [ 
            "send_serial G90",                                                                          # Use absolute positioning
            "send_serial G28 Y",                                                                        # Home Y
            "send_serial M400",                                                                         # Wait for completion
        ])
        
    def park_z(self):
        
        self.__run_command_list(CardSorterState.HOMING, [ 
            f"send_serial G91",                                                                         # Use relative positioning
            f"send_serial G0 Z-{self.__settings.z_park_distance} F{self.__settings.z_feed_rate}",           # Move Z forward to park the roller
            "send_serial G90",                                                                          # Use absolute positioning
            "send_serial M400",                                                                         # Wait for completion
        ])






