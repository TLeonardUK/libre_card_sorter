# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

# Works as a fairly simple websocket command relay.
#
# The messages currently recieved are:
#
#    send_serial        [args]                 Sends a gcode command to grbl.
#    capture_webcam                            Captures a webcam image.
#    set_webcam_crop    left right top bottom
#
# The messages sent are:
#    
#    unknown_command                           Sent if the last command was unknown.
#    unknown_command_format                    Sent if the last command has incorrect argument format
#    recv_serial                               Contains serial data recieves from grbl.
#    webcam_data       [data]                  Contains a serialized jpeg of the camera.
#

# todo
# Figure out best properties of v4l2-ctl -d /dev/video0 --all

import asyncio
import cv2
from websockets.sync.server import serve
from PIL import Image
import threading
import time
import io
import pybase64
import serial

serial_id = "/dev/serial/by-id/usb-STMicroelectronics_MARLIN_STM32G0B1RE_CDC_in_FS_Mode_204D366C594D-if00"
serial_baud_rate = 250000

serial_instance = None
serial_send_queue = []
serial_send_mutex = threading.Lock()

server_thread = None
server_instance = None
client_connections = []
client_connections_lock = threading.Lock()

class Settings:
    webcam_crop_left = 0.2925
    webcam_crop_right = 0.8
    webcam_crop_top = 0.043
    webcam_crop_bottom = 0.992
    webcam_resize_width = 224
    webcam_resize_height = 224
    webcam_frame_width = 1280
    webcam_frame_height = 960
    webcam_fps = 30
    webcam_exposure = 160
    webcam_focus = 64
    webcam_white_balance = 4200

settings = Settings()
camera = None
video_capture = None

class VideoCapture:
    def __init__(self, cam):
        self.cap = cam
        self.lock = threading.Lock()
        self.grabbed = threading.Condition(self.lock)
        self.grab_count = 0
        self.stopped = False
        self.t = threading.Thread(target=self._reader)
        self.t.daemon = True
        self.t.start()

    def _reader(self):
        while not self.stopped:
            with self.lock:
                ret = self.cap.grab()
                self.grab_count += 1
                self.grabbed.notify_all()
            if not ret:
                print("Camera grab failed, no further frames will be captured")
                break

    def read(self):
        with self.lock:
            # Ensure we capture a later frame after RGB lights/etc are turned on.
            target = self.grab_count + 2
            self.grabbed.wait_for(lambda: self.grab_count >= target, timeout=10)
            ret, frame = self.cap.retrieve()
        return frame if ret else None

    def release(self):
        self.stopped = True
        self.t.join()
        self.cap.release()

def broadcast(msg):
    global server_instance
    global client_connections
    global client_connections_lock

    with client_connections_lock:
        for websocket in client_connections:
            websocket.send(msg)

def open_camera():
    global camera
    global video_capture
    global settings

    # We re-open the camera each time to ensure any
    # adjustments (brightness/focus/etc) take effect.

    index = 0
    while (True):
        camera_name = f"/dev/video{index % 4}"
        print(f"Setting up camera {camera_name} ...")
        camera = cv2.VideoCapture(camera_name, cv2.CAP_V4L2)
        camera.set(cv2.CAP_PROP_FOURCC, cv2.VideoWriter_fourcc(*"MJPG"))
        camera.set(cv2.CAP_PROP_FRAME_WIDTH, settings.webcam_frame_width)
        camera.set(cv2.CAP_PROP_FRAME_HEIGHT, settings.webcam_frame_height)
        camera.set(cv2.CAP_PROP_FPS, settings.webcam_fps)
        camera.set(cv2.CAP_PROP_AUTO_EXPOSURE, 1)
        camera.set(cv2.CAP_PROP_EXPOSURE, settings.webcam_exposure)
        camera.set(cv2.CAP_PROP_AUTOFOCUS, 0)
        camera.set(cv2.CAP_PROP_FOCUS, settings.webcam_focus)
        camera.set(cv2.CAP_PROP_AUTO_WB, 0)
        camera.set(cv2.CAP_PROP_WB_TEMPERATURE, settings.webcam_white_balance)

        index += 1
        if not camera.isOpened():
            print("- Failed to open camera, retrying in 5 seconds ...")
            time.sleep(5)
        else:
            break

    video_capture = VideoCapture(camera)

def close_camera():
    global camera
    global video_capture

    print("Closing camera")
    video_capture.release()
    video_capture = None
    camera = None

def send_image(websocket, image):
    print("Saving as jpeg ...")
    buffer = io.BytesIO()
    image.save(buffer, format="JPEG", quality=90)

    print("Base64 Encoding ...")
    jpeg_bytes = buffer.getvalue()
    jpeg_base64 = pybase64.b64encode(jpeg_bytes).decode("ascii")

    print(f"Image is {len(jpeg_base64)} bytes, sending...")
    websocket.send(f"webcam_data {jpeg_base64}")
    websocket.send(f"ok")
    print(f"Finished send.")

def parse_message(websocket, cmd, cmd_args):
    global video_capture
    global settings

    if (cmd == "send_serial"):
        serial_send(' '.join(cmd_args))
    elif (cmd == "capture_webcam"):
        print("Capturing webcam image ...")

        frame = video_capture.read() if video_capture else None
        if frame is None:
            print("Failed to read webcam frame")
            websocket.send("webcam_capture_failed")
            return

        print("Converting to RGB ...")
        frame = frame[:, :, ::-1] # BGR -> RGB
        image = Image.fromarray(frame)
        print("Cropping ...")
        image = image.crop(( image.width * settings.webcam_crop_left, image.height * settings.webcam_crop_top, image.width * settings.webcam_crop_right, image.height * settings.webcam_crop_bottom ))

        if (settings.webcam_resize_width > 0 and settings.webcam_resize_height > 0):
            image = image.resize((settings.webcam_resize_width, settings.webcam_resize_height), Image.Resampling.LANCZOS)
            print("Resizing ...")

        send_image(websocket, image)
    elif (cmd == "set_setting"):
        if (len(cmd_args) == 2):
            name = cmd_args[0]
            value = cmd_args[1]
            existing_value = getattr(settings, name, None)
            if (existing_value == None):
                websocket.send("unknown_setting")
            else:
                valid_setting = True

                if (isinstance(existing_value, int)):
                    setattr(settings, name, int(value))
                elif (isinstance(existing_value, float)):
                    setattr(settings, name, float(value))
                elif (isinstance(existing_value, str)):
                    setattr(settings, name, value)
                else:        
                    websocket.send("unsupported_setting")
                    valid_setting = False

                # If we changed a webcam setting then close/reopen to reapply settings.
                if (valid_setting):
                    websocket.send(f"echo {name}: {value}")
                    websocket.send(f"ok")
        else:
            websocket.send("unknown_message_format")
    elif (cmd == "reset_webcam"):
        websocket.send("echo resetting camera")
        close_camera()
        open_camera()
        websocket.send(f"ok")
    elif (cmd == "get_setting"):
        if (len(cmd_args) == 1):
            name = cmd_args[0]
            value = str(getattr(settings, name))
            websocket.send(f"{name}: {value}")
            websocket.send(f"ok")
        else:
            websocket.send("unknown_message_format")
    else:
        websocket.send("unknown_message")

def client_loop(websocket):
    global client_connections
    global client_connections_lock

    print(f"Client connected: {websocket.remote_address[0]}:{websocket.remote_address[1]}")
    with client_connections_lock:
        client_connections.append(websocket)

    try:
        for message in websocket:
            cmd_split = message.split(" ")
            if (len(cmd_split) > 0):
                cmd = cmd_split[0]
                parse_message(websocket, cmd, cmd_split[1:])
    finally:
        with client_connections_lock:
            client_connections.remove(websocket)
        print(f"Client disconnected: {websocket.remote_address[0]}:{websocket.remote_address[1]}")

def serial_send(line):
    global serial_send_mutex
    global serial_send_queue
    print(f"> {line}")
    with serial_send_mutex:
        serial_send_queue.append(line)

def serial_recv(line):
    print(f"< {line}")
    broadcast(f"recv_serial {line}")

def serve_main():
    global server_instance
    ip = "0.0.0.0"
    port = 8321
    server_instance = serve(client_loop, ip, port, max_size=(32*1024*1024))
    print(f"Now serving on ws://{ip}:{port}")
    server_instance.serve_forever()

if __name__ == "__main__":
    print("==================================================================================")
    print(" Card Sorter - Websocket Server")
    print("==================================================================================")

    # Setup serial
    print("Setting up serial ...")
    serial_instance = serial.Serial(serial_id, serial_baud_rate, timeout=0)

    # Run the websocket server
    print("Setting up server ...")
    server_thread = threading.Thread(target=serve_main)
    server_thread.start()

    # Setup camera connection
    open_camera()

    # Just chug away reading serial input
    print("Running")
    line_read_buffer = ""
    while (True):

        while (True):
            read_bytes = serial_instance.read()
            if (len(read_bytes) == 0):
                break
            char = chr(read_bytes[0])
            if (char == '\n'):
                serial_recv(line_read_buffer)
                line_read_buffer = ""
            else:
                line_read_buffer += char

        with serial_send_mutex:
            for line in serial_send_queue:
                print(f"Sending serial: {line}")
                serial_instance.write((line + "\n").encode("ascii"))
            serial_send_queue = []

        time.sleep(0.01)
