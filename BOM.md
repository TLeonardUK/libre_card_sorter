# Bill of Materials

For nuts & bolts, I would suggest grabbing a mixed pack of M5, M4, M3, M2 of varying sizes. The mounts are connections are made to be very forgiving to different bolt lengths.

Prices are per-item and are estimates based on amazon prices, you can likely get them a lot cheaper on aliexpress or similar.

The design is also quite flexible, you can extend aluminium extrusions to fit more bins, or the rods to increase the magazine capacity. These specs are for the standard 7 bin layout.

## Frame

You can get away with less corner brackets and plates, but I would advise fixing as many as you can to keep the frame rigid.

| Qty | Part | Price | Notes | Amazon Link |
|---|---|---|---|---|
| 6 | 2020 aluminium extrusion, 600mm | - | - | - |
| 3 | 2020 aluminium extrusion, 200mm | - | - | - |
| 12 | 2020 metal corner bracket | - | You can also use printed ones for this, check printables for many options. | - |
| 9 | 2020 corner plate | - | You can also use printed ones for this, check printables for many options. | - |

## Motion

| Qty | Part | Price | Notes | Amazon Link |
|---|---|---|---|---|
| 1 | T8 lead screw, 400mm | - | - | - |
| 1 | 8mm smooth rod, 400mm | - | - | - |
| 2 | 8mm smooth rod, 600mm | - | - | - |
| 3 | NEMA 17 stepper motor, 5mm shaft | - | - | - |
| 1 | 8mm brass flange | - | - | - |
| 2 | Flexible shaft coupler, 5mm to 8mm | - | - | - |
| ~2m | GT2 belt, 6mm wide | - | - | - |
| 1 | GT2 pulley, 20 tooth, 5mm bore, 6mm belt | - | - | - |
| 1 | GT2 idler, 5mm bore, 6mm belt | - | - | - |
| 4 | SC8UU linear bearing block, 8mm | - | - | - |
| 4 | SK8 8mm rod holder | - | - | - |
| 1 | SG90 micro servo | - | - | - |
| 3 | Micro limit switch, roller lever arm | - | - | - |

## Feed rollers (swing arm and nip)

| Qty | Part | Price | Notes | Amazon Link |
|---|---|---|---|---|
| 3 | 8mm smooth rod, about 200mm | - | - | - |
| 1 | M3 x 4mm shoulder bolt, 16mm shoulder | - | - | - |
| 1 | M3 x 4mm shoulder bolt, 8mm shoulder | - | - | - |
| 1 | Compression spring, 12mm OD / 10mm ID, about 10mm long | - | - | - |
| 2+ | PTFE flat washer, 8mm ID x 14mm OD x 2mm | - | - | - |
| 1 | 8mm rod collar | - | You can use a printed one for this, but I advise metal as it will be under a lot of spring tension.  | - | - | - |
| 150ml | Polyurethane rubber, VytaFlex 30 | - | - | - |
| 150ml | Polyurethane rubber, VytaFlex 60 | - | - | - |
| | Mould release, ease release 200 | - | - | - |

For the polyurethane rubber, you can also use silicone if easier to get, you just loose about half the friction and it will wear faster.

You do need to ensure you get two different strengths of rubber, the hardest one with the least friction is for the nip-pad (to stop multiple cards feeding), the softest one with the most friction is for the rollers.

## Electronics

| Qty | Part | Price | Notes | Amazon Link |
|---|---|---|---|---|
| 1 | BTT Manta M4P | £59.99 | - | https://www.amazon.co.uk/BIGTREETECH-M4P-Manta-V2-1/dp/B0B81RB4FQ |
| 1 | BTT CB1 | £36.99 | - | https://www.amazon.co.uk/BIGTREETECH-M4P-Manta-V2-1/dp/B0BL9V1ZTQ |
| 3 | TMC2209 motor driver | £11 | Make sure you you get ones that have the UART headers soldered on. | https://www.amazon.co.uk/KINGPRINT-TMC2209-Stepper-Driver-Printer/dp/B07WC71M4R |
| 2 | microSD card | £5.66 | One for CB1 firmware, one for flashing M4P firmware. M4P requires an adapter for standard SD card size. | https://www.amazon.co.uk/KEXIN-MicroSDHS-External-Smartphone-Security/dp/B07XJTK459 |
| 1 | Enclosed 24V PSU, 215 x 114 x 50mm | £30 | - | https://www.amazon.co.uk/MUYIRTED-Universal-Regulated-Switching-Transformer/dp/B09YHC5XZL |
| 1 | IEC C14 fused panel inlet | £2 | - | https://www.amazon.co.uk/HAAMNING7-Module-Rocker-Switch-Socket/dp/B0G5XZ2CDX |
| 1 | IMX179 USB camera module (8MP, 3.8mm lens) | £38 | - | https://www.amazon.co.uk/Arducam-Autofocus-Microphone-Industrial-Compatible/dp/B09PRGT7JT |
| 1 | WS2812 RGB LED ring, 12 LEDs, 50mm OD / 35mm ID  | £1.68 | - | https://www.amazon.co.uk/Lord-Tools-Advertising-Decorations-Microcontroller/dp/B0CMW5LWM2 |
| ~10m | Cables | £2 / m | I use 20 AWG solid core cable, but similar should be fine, nothing is high voltage. | https://www.amazon.co.uk/TUOFENG-Colors-26-3ft-Tinned-Copper/dp/B0CM5VY69G |
| ~ | Cable Connectors | - | An assortment of dupont and crimp connectors are advised to wire things up if you don't want to solder everything. | - |

## Fasteners

| Qty | Part | Price | Notes | Amazon Link |
|---|---|---|---|---|
| ~45 | M5 Bolt / Nut | - | - | - |
| ~30 | M4 Bolt / Nut | - | - | - |
| ~30 | M3 Bolt / Nut | - | - | - |
| ~30 | 2020 T-Nuts | - | - | - |
| 21 | M3 heat-set insert | - | - | - |
| 6 | M3 grub screw | - | - | - |
| 3 | Compression spring small, < 6.6mm OD | - | - | - |
| ~10 | Zip ties | - | 2 for fixing the belt to the X-axis mover, the rest for just cable-managing. | - |

## Printed parts

Printed in PLA (PETG also works, and is in theory better for some of the heat-exposed parts). 

Exported to `cad/` as STLs. Optional 3MF files are also provided for a couple of parts with optional multi-color text.

Printing everything requires about 5 kg of filament.

| Qty | Part | Notes |
|---|---|---|
| 7 | `card_bin` | - |
| 7 | `card_bin_door` | - |
| 4 | `card_mover_plate` | - |
| 4 | `led_ring_spacer` | - |
| 1 | `base_plate`, `scan_plate`, `exit_insert`, `exit_nip_tongue`, `card_magazine_bottom`, `card_magazine_top`, `card_magazine_door_bottom`, `card_magazine_door_top`, `card_magazine_pad`, `card_magazine_lifter`, `card_magazine_lifter_top`, `card_mover`, `card_mover_slide`, `card_mover_plate_motor`, `card_mover_plate_spindle`, `limit_switch_mount`, `limit_switch_mount_small`, `limit_switch_carrier`, `camera_mount`, `swing_sun_gear`, `swing_clutch_collar`, `swing_idler_gear`, `swing_drive_arm`, `swing_idle_arm`, `swing_roller`, `nip_roller`, `nip_drive_gear`, `nip_idler_gear`, `nip_gear`, `brain_plate`, `brain_plate_lid`, `brain_shelf`, `brain_box_mount` | - |
| 1 | `swing_roller_mould_a`, `swing_roller_mould_b`, `nip_roller_mould_a`, `nip_roller_mould_b` | Used for moulding, not part of final design. |

