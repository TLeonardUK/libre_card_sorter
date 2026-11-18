# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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

## Project Structure
The code in this respository is made up 4 main components
- The cad directory contains OpenSCAD files defining the design of the machine.
- The mpu directory contains the python websocket server run on the CB1 board.
- The mcu directory contains the marlin code run on the M4P board.

- The software/ui directory contains the end-user application used to monitor and control the sorting machine.
- The software/training directory contains the code required to download datasets and train a CLIP model to recognize card images captured by the webcam.
- The software/utils directory contains misc testing scripts.

## Code style
Code should be clean and minimal, no extraneous functionality should be added until its shown to actually be needed.

Comments should be kept to a minimum, code should be self-documenting. Any comments that must be added should be concise and describe the why not the what of the behaving code.

## Committed
No code should ever be committed by AI. If at a stage where it should be committed for backup purposes always prompt.

`mcu/AGENTS.md` is upstream Marlin's own file; it describes Marlin, not this project.

## Commands

There is no test suite, linter or build system for the Python code; scripts are run directly.

- **CAD:** use the OpenSCAD AppImage at `/var/home/admin/Desktop/OpenScad.AppImage`, not the installed flatpak (which is an older 2021.01 release): `/var/home/admin/Desktop/OpenScad.AppImage -o out.stl cad/card_sorter.scad`. Which part renders is selected by the `show_*` flags near the top of the file (override with `-D show_scan_plate=true` etc.). The user's OpenSCAD has the `lazy-union` feature enabled, so pass `--enable=lazy-union` when rendering or exporting. With it, a `for` loop's results stay separate shapes, so don't rely on them merging (e.g. as one child of `intersection()`).
- **Exporting STLs:** always export straight into `cad/` (never a subfolder), one file per `show_*` flag named after the flag without `show_`, rendered with every other flag forced off (including `show_externals`, which adds bought parts like rods and washers). For `card_sorter_swing_arm.scad` also pass `-D assemble=false` so the part comes out at its origin rather than in place in the machine. Skip `show_gantry`, `show_externals` and `show_camera_view` (a translucent visualisation of the camera's field of view, worked out from `camera_sensor_size` and `camera_focal_length`). Overwriting existing STLs is fine; they're transient and should only hold the latest exports. Parts with recessed text (currently `brain_plate` and `brain_plate_lid`) also get a `<part>.3mf` exported the same way plus `-D show_text_inlays=true`, holding the body and its text fill as separate objects so the text can be printed in a second filament.
- **Firmware:** `cd mcu && platformio run -e STM32G0B1RE_manta_btt` (the BTT Manta M4P env, set as `default_envs`). Project-specific settings live in `mcu/Marlin/Configuration.h` and `Configuration_adv.h`.
- **Server (on the CB1):** `python mpu/server.py`. Listens on port 8321.
- **UI:** `cd software/ui && python Main.py` (imports are relative to `software/ui`; has its own `.venv`).
- **Packaging the UI:** `cd software/ui && .venv/bin/python Scripts/PackageBuild.py` builds a package for the platform it runs on: `Builds/LibreCardSorter-<Settings.VERSION>-linux-x86_64.AppImage` (with appimagetool, downloaded by the script), `-windows-x86_64.zip` or `-macos-arm64.dmg`, leaving the folder it's made from in `Builds/<version>/` (the AppDir's `AppRun` can be run directly to try a Linux build). Bump `Settings.VERSION` for each release; `--force` replaces an existing build of the version. The package is a relocatable Python runtime (python-build-standalone) with only PyQt installed (pruned to the Qt modules the app imports), the app's source and runtime (precompiled, as the package is read-only), and a launcher (`AppRun`; on Windows pip's GUI `.exe` launcher pointed at `pythonw.exe`; on macOS an ad hoc signed `.app`) that starts `Launch.py`. On first run `Launch.py` runs `Bootstrap.py`, which downloads, into `<data folder>/libre-card-sorter/runtime/<version>/` (Settings' `RUNTIME_DIR`, used when `../setup/setup.json` exists beside the app, which also moves Settings' training folder there), everything the build listed in `setup/setup.json` with each file's size and SHA-256 (so it can show overall progress and check each file): the wheels pip resolves at build time for that platform from `requirements.txt`'s packages, constrained to `requirements-lock.json`'s versions (the CUDA build of torch if the NVIDIA driver and GPU support it, else the CPU build; macOS has only the standard build; never triton), pip-installed from those files; the latest card database on the GitHub remote's `main` (checked against the hash in its Git LFS pointer there); and the models' files at pinned Hugging Face revisions, saved as float16. Startup doesn't load the models, so a build that starts can still fail when the first card is identified. Run from the `.venv` (which must have the CUDA build of torch), a build first rewrites `software/ui/requirements-lock.json` from it; commit it whenever it changes, as it's what the release workflow builds from. Elsewhere the build only needs PyQt installed.
- **Releasing:** run the Release workflow (`.github/workflows/release.yml`) from the repo's Actions tab after bumping `Settings.VERSION`. It builds the UI package on Ubuntu, Windows and macOS runners, builds the firmware with PlatformIO 6.2.0, zips `mpu/server.py`, and publishes them all (`LibreCardSorter-<version>-linux-x86_64.AppImage`, `-windows-x86_64.zip`, `-macos-arm64.dmg`, `-btt-manta-m4p-firmware.bin` and `-btt-cb1-firmware.zip`) as release `v<version>`; it refuses a version that's already released.
- **Training** (run from `software/training`, the scripts use relative `./datasets/...` paths):
  - `datasets/<name>/build_dataset.py` builds a per-game `dataset.db` (e.g. from `scryfall.jsonl` for mtg).
  - `build_combined_data.py` merges the per-game datasets into `software/training/dataset.db` and computes CLIP embeddings.
  - `build_fine_tuned_model.py` fine-tunes CLIP into `models/clip-finetuned`.
  - `python test_inference.py <image> [--top N]` / `test_inference_finetuned.py` test recognition of a single image against the database.
- **Manual server testing:** `software/utils/websocket_client.py` connects to the server and lets you send raw commands.

## Architecture

Control flows UI → websocket → CB1 server → USB serial → Marlin:

- `mpu/server.py` is a thin relay. Commands: `send_serial <gcode>` (forwarded to Marlin), `capture_webcam` (replies `webcam_data <base64 jpeg>`, cropped by `set_webcam_crop left right top bottom`, fractions of the frame). Every serial line from Marlin is broadcast to all clients as `recv_serial <line>`.
- `software/ui/Sorting/CardSorting.py` drives the machine. Each operation (`home`, `load_card`, `deliver_card_to_bin`, ...) is a list of commands sent one at a time; the next is sent when Marlin replies `ok`. State is tracked in `CardSorterState`, and `poll()` must be called regularly to process received messages and fire events. Machine constants (feed rates, bin offset/stride, load position, Z dispense distance) live in `Settings.py`.
- Axis mapping in Marlin: X moves the funnel between bins, Y lifts the card stack, Z drives the feed roller (no extruders; servo 0 opens the funnel via `M280 P0`). Cards are loaded by probing Y upwards with `G38.3` until the top-of-magazine switch triggers.
- `software/ui/Main.py` opens the PyQt `MainWindow` (`Windows/MainWindow.py`), which polls the sorter on a `QTimer` and has three tabs: Workflows (user-built rules sorting cards into bins, run by `Workflow/WorkflowExecution.py`), Status and Device (jogging, homing, servo, light and webcam settings).
- Card recognition matches a webcam image's CLIP embedding against the per-card embeddings stored in `dataset.db` (`cards` table plus a `metadata` table recording the embedding model).

## CAD conventions

- `cad/card_sorter.scad` describes the whole machine in assembled world coordinates; parts are exported from their assembled position.
- `cad/card_sorter_swing_arm.scad` models each part at its own origin, in its machine orientation. The build section at the end places each one with `place(<part>_position)` (positions are defined together after `base_plate_position`), and `assemble = false` turns placement off for exporting. Keep `show_*` checks in the build section, not inside part modules. Cuts shared between parts are their own modules, e.g. `base_plate_cuts()` is applied to the magazine parts with `cut_by_base_plate()`.
- Don't bake print orientation into the OpenSCAD files; it depends on the printer and material, so it's decided in the slicer.
- `epsilon` exists so boolean cuts extend past coplanar faces (avoids preview flicker). Extend cuts by it; don't use it to shift functional geometry.
- The card exit is a separate `exit_insert()`, positioned at `exit_position` (`scan_plate_exit_offset` within the scan plate), with its origin at the magazine's exit wall, at the scan-plate top surface, x pointing out of the magazine). Heights are adjusted with springs and screws into heat-set inserts. The insert is held flush with the magazine wall by its posts bearing on a wall at the front of their pockets, because cards push it forwards; the posts' backs stop within `exit_insert_post_back_clearance` of their pockets' back walls, so it can't slide back into the magazine well, where rising cards would catch on it. The exit channel is V-shaped (`exit_channel()`, flaring by `exit_channel_flare_angle` each side) so a skewed card moves away from the walls rather than jamming on them. Its walls start tapering `exit_channel_lead_in_length` back inside the magazine hole so the hole runs straight into the V with no step, and below the pocket `exit_channel_lead_in_slope()` eases them back to the hole by the bottom of the plate.
- In `card_sorter_swing_arm.scad`, cards are separated by a nip (`exit_nip_*`, `nip_*`) instead of a gate gap: a second roller (`nip_roller()`, the swing roller's core and grip on a clamped axle turning in both rod supports) presses the card onto a VytaFlex 60 pad glued into a tongue (`exit_nip_tongue()`), a separate leaf spring that flexes down under it. The tongue is the nip's spring: a pad mounted rigidly would only give through the rubber, pressing tens of newtons harder and climbing steeply with each card, so its softness keeps the nip force at a few newtons whatever the card count or setup. Its flexing section is slotted along the card's travel into ribs (`exit_nip_tongue_rib_*`), as at full width the roller rubbing on the pad with no card between them stalled the motor; a card's edge spans the slots. It's printed in PETG, which is softer and creeps less than PLA; in PLA even the slotted tongue still stalled the motor once the nip was geared up. The nip roller is geared off the drive shaft outside the +Y rod support (`nip_drive_gear()`, `nip_idler_gear()`, `nip_gear()`), so it turns with the swing roller (geared 15:13, profile shifted to mesh at the idler's spacing, so it always outruns the swing roller whatever the casting variation; a slower nip held the card back and stalled the motor), and parking turns it back, returning a dragged second card to the stack. The roller is clamped to its axle, and its far hub runs to the +Y support's inner face, so with the nip gear on the outer face it holds the axle endwise; a collar there would hit the arm's stop pin. It relies on grip, roller > pad > card on card, not on card thickness. The nip sits as close to the exit wall as the lead-in allows, so a dragged second card meets the pad within a few mm rather than sliding out along the lip. The tongue is rooted downstream and its top carries on the insert's lip and ramp, so its tip, just past the wall, flexes down and a card only ever steps down onto it; the insert keeps a strip standing at the exit wall, and the floor under the tongue is an arm of its root lying in a recess in the scan plate's pocket and running to the wall, so the magazine wall has no opening for a card's edge to push into. The tongue swings about its root, so its tip travels about 1.6 times as far as the pad (`exit_nip_tongue_travel`). Besides the strip, the insert's sides are joined by a bar under the tongue's flexing section, where it moves least (`exit_nip_bridge_*`), so the insert is one stiff part with a flat bottom that prints without supports. The insert is too shallow for nuts, so the root drops through it into a pocket in the scan plate and is bolted up through the plate (M3x8) into nuts slid in from the tongue's sides. Being fixed to the plate, the tongue doesn't follow the insert's height adjustment; its softness makes that unnecessary. Its xz profile is the same across its width, so it prints on its side with layers running along it and nothing overhanging. The pad can be cast in place rather than glued (`nip_pad_cast_lid()`, `_base()`, `_shim()`): the lid clamps onto the tongue's top, located by skirts along its sides and tip, so its flat face moulds the pad flush with the lip, and a shim in the tongue's travel gap holds the stiff block up against it so the seal doesn't depend on the flex. It's poured and vented through slots into the recess's ends, beyond the roller, so the sprue stubs never meet a card.
- The magazine door is printed as two halves (`card_magazine_door_half()`), joined like the magazine's halves by tabs on the bottom half that lap over the top half and bolt through (`card_magazine_door_tab()`), so it lifts out in one piece and snaps shut like the card bin's door: it tilts out about a tongue along its bottom into a sill, and the top half's tongue into the bottom half keeps the halves in line. Its edges bear on the ends of the side walls, which holds its inside flush with the hole. Above the door, a sprung pad (`card_magazine_pad()`, in `card_magazine_pad_pocket()` cut from the magazine top and scan plate) pushes the cards against the exit wall. Its top is flush with the top of the scan plate's walls, above any card, so none can come down onto it. The stack moves both up and down, so avoid fixed lead-in chamfers or steps around the hole; they leave ledges for cards to land on going the other way.
- Never self-tap screws (including grub screws) into plastic, so parts can be taken apart. Prefer bolts through to a nut (recessed in a `$fn=6` pocket where it would otherwise stick out); use a heat-set insert only where a nut would make assembly much harder (e.g. grub screws, blind holes). Insert sizes are the `exit_threaded_insert_*` parameters (M3, 4.0mm hole, 5mm deep). No press fits anywhere: holes for rods get running clearance (e.g. `swing_axle_clearance_radius`), rods are clamped with a grub screw in an insert (`swing_clamp_2d()`/`swing_clamp_cut()`), and through holes let rods stick out since exact rod lengths aren't practical.
- Holes for bolts into the frame's 2020 extrusions are slots running along the extrusion's slot (`extrusion_bolt_slot()`, or `slot_along` on `bolt_hole()`/`recessed_bolt_hole()`), so a bolt can go in with a hammer T-nut already on it and the nut be passed through before it's turned to lock. Not where the bolt also passes through a bought part with round holes (e.g. the rod clamps on `extrusion_clamp_mount()`).
- The roller's axle and the swing drive shaft are both 8mm rods (8mm ID PTFE washers).
- Colours distinguish printed parts: each printed part gets one colour, different from every other part and never blue, applied once where it's placed in the build section. Don't use `color()` inside printed part modules (use `union()` to group). Bought parts shown by `show_externals` (rods, washers, motors, boards, LED ring, etc.) are `color("blue")`.
- Use `$fn=100` on cylinders, circles and rounded offsets so curves print smoothly. Exceptions: `$fn=6` for hex nut recesses, and the gear root circle (`teeth * 4`), which is hidden under the teeth.
- The brain box (`brain_plate()`, its lid and the M4P's `brain_shelf()`) holds a heavy PSU and mains AC wiring: don't thin its floor (it must not sag under the PSU), walls, lid or shelf (4mm each for the lid and shelf) any further, or add openings, to save material. Slicing showed thinning the 10mm floor to 6mm saved under a minute and 12g. It should stay robust to knocks.
- Fillet the bases of thin upright features that join a plate (see `base_fillet()`), since printed hard edges snap.

### Design variants

- `cad/card_sorter.scad` uses a fixed roller on the scan plate.
- `cad/card_sorter_swing_arm.scad` is a copy where the roller hangs on a swing arm (`swing_*` parameters and modules): sun gear on an 8mm drive shaft, idler, and roller gear, so driving forwards swings the roller down onto the card and reversing parks it out of the camera's view. The arm only swings because a slipping clutch (a spring between `swing_clutch_collar()` and the drive arm, pressing the arm against the sun gear) drags it round with the shaft until a stop holds it. It parks clear of the light from the LED ring's nearest edge to the card's exit edge (`swing_light_edge`), since the foil check lights the card one LED at a time and a shadow would read as sheen; the shaft is kept out of that light too, and the camera mount is high enough for the roller to pass under the ring. The roller axle's protruding ends stop on pads on both rod supports, when parked and at the lower stop (posts rising from the plate, `swing_arm_lower_travel_angle`), so the arms can't twist against each other: the clutch drags the drive arm, and a stop on one side only lets the other side's gears drop onto the plate on an empty magazine. Work is done in `card_sorter_swing_arm.scad`: don't change `card_sorter.scad` unless asked, even for parts the two share.

### Machine geometry worth knowing

These constrain anything added around the scan plate (local coordinates are relative to `exit_position`):

- The top of the card stack sits 0.16mm above the scan plate top (`card_top_spacing`), held by the card-stop insets around the hole.
- Frame corner posts stand at world x -220..-200, y 0..20 and y 220..240 and rise above the scan plate; the card mover starts at world x -196 and the camera mount at world z 484 in the swing-arm design (472 in the fixed-roller one).
- The scan plate's +X edge is `exit_insert_length` (35.7mm) beyond the exit wall. In the fixed-roller design the roller must touch the card within about 7mm of the exit wall, or the card's centre of mass won't pass the plate edge before the roller loses it; in the swing-arm design the nip carries the card on until it's past.
- The motor (and its recessed screws) is fitted to the scan plate before the plate goes on the frame, so parts beside the corner post only need clearance once assembled.

### Verifying CAD changes

- Collision check: render `intersection()` of the changed part with everything else (call the modules directly with the relevant `show_*` flags on) and measure the resulting STL's volume. Zero volume means only touching faces. For moving parts, repeat at several positions (e.g. `swing_arm_angle` from the lower stop to park) and just past each stop to confirm stops engage.
- Count separate bodies in an exported STL to catch floating geometry.
- Cross-sections via `projection(cut=true)` to SVG give exact coordinates; `--render --camera=... -o view.png` close-ups are useful for checking surfaces such as fillets.
