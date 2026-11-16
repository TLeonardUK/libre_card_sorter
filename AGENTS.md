## Project Description
This project is designed to create a card-sorting machine.

This machine has a an X axis that moves horizontally and is used to drive an open-ended funnel that contains a card and a servo at the bottom to stop the card from dropping out. The X axis moves this funnel to different bins that a card can be dropped in.
The machine also has a Y axis that moves a stack of cards upwards within a magazine. Cards are fed off the top of the magazine stack and into the funnel so they can be moved to a bin and deposited.
The Z axis of this machine is connected to a stepper motor that is attached to a roller at the top of the card magazine to push cards off the stack and into the funnel.
Above the magazine a camera is mounted so images of the cards can be taken and used to identify them and determine which bins they should be placed in.

The X axis is powered by a NEMA 17 stepper motor and has a minimum limit switch.
The Y axis is powered by a NEMA 17 stepper motor and has a minimum limit switch.
There is also a limit switch at the top of the magazine that is used to determine when the card stack reaches the top of the magazine.

The X axis is belt driven and has two linear guide rods.
The Y axis is direct-drive with a lead screw, a platform the cards sit on in the magazine is connected to the lead screw.

The movement is controlled by a BTT Menta M4P board running Marlin.
The M4P board also has a CB1 board attached to it which is running a websocket server that accepts commands (such as capturing webcam images, sending serial to marlin, etc) and forwards any serial recieved from marlin back to the connected clients.

The majority of the printer is made of 3D printed parts, in either PLA or PTEG.

# Project Structure
The code in this respository is made up 4 main components
- The cad directory contains OpenSCAD files defining the design of the machine.
- The mpu directory contains the python websocket server run on the CB1 board.
- The mcu directory contains the marlin code run on the M4P board.

- The software/ui directory contains the end-user application used to monitor and control the sorting machine.
- The software/training directory contains the code required to download datasets and train a CLIP model to recognize card images captured by the webcam.
- The software/utils directory contains misc testing scripts.

# Code style
Code should be clean and minimal, not extraneous functionality should be added until its shown to actually be needed.

Comments should be kept to a minimum, code should be self-documenting. Any comments that must be added should be concise and describe the why not the what of the behaving code.

# Committed
No code should ever be committed by AI. If at a stage where it should be committed for backup purposes always prompt.
