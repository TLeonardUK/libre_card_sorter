import asyncio
import websockets
import subprocess
import sys
import os
import io
import time
import base64
import urllib

uri = "ws://10.69.40.10:8321"

async def run():
    while (True):
        try:
            print(f"Connecting to {uri}")
            async with websockets.connect(uri, max_size=(32*1024*1024)) as websocket:
                print("Connected to server.")

                async def receive():
                    try:
                        async for message in websocket:
                            if (message.startswith("webcam_data")):
                                jpeg_base64 = message[12:]
                                jpeg_bytes = base64.b64decode(jpeg_base64)
                                with open("webcam.png", "wb") as binary_file:
                                    binary_file.write(jpeg_bytes)                            
                                print(f"    Recieved {len(jpeg_bytes)} of webcam data, written to webcam.png.")
                                subprocess.call(['xdg-open', os.getcwd() + "/webcam.png"])
                            else:
                                print(f"    {message}")                            
                            print("> ", end="", flush=True)
                    except websockets.exceptions.ConnectionClosed:
                        print("Connection to server closed")
                        os._exit(1)
                    except Exception as e:
                        print(f"Error receiving message: {e}")
                        os._exit(1)

                async def send():
                    try:
                        while True:
                            msg = await asyncio.to_thread(input, "> ")
                            if msg.lower() == "exit":
                                print("Exiting...")
                                os._exit(1)
                            await websocket.send(msg)
                    except websockets.exceptions.ConnectionClosed:
                        print("Connection to server closed")
                        os._exit(1)
                    except Exception as e:
                        print(f"Error sending message: {e}")
                        os._exit(1)

                await asyncio.gather(receive(), send())
        except ConnectionRefusedError:
            print("Could not connect to server")
        except Exception as e:
            print(f"Connection error: {e}")

        print("Retrying connection in 5 seconds.")
        time.sleep(5.0)

if __name__ == "__main__":
    try:
        asyncio.run(run())
    except KeyboardInterrupt:
        print("\nExiting...")
        os._exit(1)
