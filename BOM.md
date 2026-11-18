# Bill of Materials

For nuts & bolts, I would suggest grabbing a mixed pack of M5, M4, M3, M2 of varying sizes. The connections are made to be very forgiving to different bolt lengths.

Prices are per-item and are estimates based on amazon prices, you can likely get them a lot cheaper on aliexpress or similar.

The design is also quite flexible, you can extend aluminium extrusions to fit more bins, or the lead screw / rods to increase the magazine capacity. These specs are for the standard 7 bin layout.

Rows with a ^ mean that the item is included in the amazon link as a bundle. You'll find a lot of these parts tend to be bundled together on online marketplaces.

## Frame

You can get away with less corner brackets and plates, but I would advise fixing as many as you can to keep the frame rigid.

| Qty | Part | Price | Notes | Amazon Link |
|---|---|---|---|---|
| 6 | 2020 aluminium extrusion, 600mm | £3.20 | - | https://www.amazon.co.uk/dp/B0F13B9NZN |
| 3 | 2020 aluminium extrusion, 200mm | £5.99 | - | https://www.amazon.co.uk/dp/B0F13CFWML |
| 12 | 2020 metal corner bracket | - | You can also use printed ones for this, check printables for many options. | ^|
| 6 | 2020 corner plate | - | You can also use printed ones for this, check printables for many options. | ^ |

## Motion

| Qty | Part | Price | Notes | Amazon Link |
|---|---|---|---|---|
| 1 | T8 lead screw, 400mm | £7 | - | https://www.amazon.co.uk/dp/B0C5M77PCN |
| 1 | 8mm smooth rod, 400mm | £10 | - | https://www.amazon.co.uk/dp/B0DH2681X5 |
| 2 | 8mm smooth rod, 600mm | £16 | - | https://www.amazon.co.uk/dp/B0DKJXFHLM |
| 4 | SC8UU linear bearing block, 8mm | ^ | - | ^ |
| 4 | SK8 8mm rod holder | ^ | - | ^ |
| 3 | NEMA 17 stepper motor, 5mm shaft, 42-23 | £7 | - | https://www.amazon.co.uk/dp/B0C36GNQ15 |
| 1 | 8mm brass flange | £2 | - | https://www.amazon.co.uk/dp/B0DPC43S72 |
| 2 | Flexible shaft coupler, 5mm to 8mm | £0.90 | - | https://www.amazon.co.uk/YIXISI-Flexible-Couplings-Aluminum-Connector/dp/B08JV9ZX2X |
| ~2m | GT2 belt, 6mm wide | £20 | - | https://www.amazon.co.uk/Timing-Pulley-Tensioner-Torsion-Printer/dp/B0C54ZXM88 |
| 1 | GT2 pulley, 20 tooth, 5mm bore, 6mm belt | ^ | - | ^ |
| 1 | GT2 idler, 5mm bore, 6mm belt | ^ | - | ^ |
| 1 | SG90 micro servo | £1.20 | - | https://www.amazon.co.uk/dp/B0H8SDQPG5 |
| 3 | Micro limit switch, roller lever arm | £0.50 | - | https://www.amazon.co.uk/dp/B07SPW6M61 |

## Feed rollers

| Qty | Part | Price | Notes | Amazon Link |
|---|---|---|---|---|
| 3 | 8mm smooth rod, about 200mm | £1.50 | - | https://www.amazon.co.uk/METERXITY-5-Pack-Aluminum-Industrial-Construction/dp/B0FFSVJSQR |
| 1 | M3 x 4mm shoulder bolt, 16mm shoulder | £0.32 | - | https://www.amazon.co.uk/dp/B0FDQB24SP |
| 1 | M3 x 4mm shoulder bolt, 8mm shoulder | £0.29 | - | https://www.amazon.co.uk/dp/B0FDQ4R3YC |
| 1 | Compression spring, 12mm OD / 10mm ID, about 10mm long | £0.60 | I just got these and cut them down to a good size. These are used by the slip joint on the main roller, and the force is adjustable by the collar, so the machine is quite flexible on which springs you use. | https://www.amazon.co.uk/TA-VIGOR-Compressed-Construction-Mechanical-Compression/dp/B0FCMLKN5T |
| 2+ | PTFE flat washer, 8mm ID x 14mm OD x 2mm | £0.14 | - | https://www.amazon.co.uk/TA-VIGOR-Washers-Sealing-Gaskets-Flange/dp/B0FF94Q74J |
| 1 | 8mm rod collar | £0.73 | You can use a printed one for this, but I advise metal as it will be under a lot of spring tension.  | https://www.amazon.co.uk/sourcing-map-Collars-Landing-Stopper/dp/B0CQXQJXKD |
| 30ml | Polyurethane rubber, VytaFlex 30 | £25 / pint | Unfortunately this only come in "pint" quantities at the smallest which is far more than you actually need for this. | https://www.benam.co.uk/vytaflex-30 |
| 5ml | Polyurethane rubber, VytaFlex 60 | £27 / pint | Unfortunately this only come in "pint" quantities at the smallest which is far more than you actually need for this. | https://www.benam.co.uk/vytaflex-60 |
| 10g | Mould release, ease release 200 | £18 / 340g | - | https://www.benam.co.uk/ease-release-200 |

For the polyurethane rubber, you can also use silicone if easier to get, you just loose about half the friction and it will wear faster.

You do need to ensure you get two different strengths of rubber, the hardest one with the least friction is for the nip-pad (to stop multiple cards feeding), the softest one with the most friction is for the rollers.

## Electronics

| Qty | Part | Price | Notes | Amazon Link |
|---|---|---|---|---|
| 1 | BTT Manta M4P | £59.99 | The marlin configuration is setup for a manta m4p, but if you want to do some configuration youself, you can probably use similar boards as long as they have the needed inputs. | https://www.amazon.co.uk/BIGTREETECH-M4P-Manta-V2-1/dp/B0B81RB4FQ |
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
| ~45 | M5 Bolt / Nut | £0.02 | - | https://www.amazon.co.uk/Stainless-Machine-Assorted-Washers-Assortment/dp/B0DPWZQ541 |
| ~30 | M4 Bolt / Nut | £0.02 | - | https://www.amazon.co.uk/Stainless-Machine-Assorted-Washers-Assortment/dp/B0DPX16KJ9 |
| ~30 | M3 Bolt / Nut | £0.02 | - | https://www.amazon.co.uk/Stainless-Machine-Assorted-Washers-Assortment/dp/B0DPWZ6KL6 |
| ~30 | 2020 T-Nuts | £0.09 | - | https://www.amazon.co.uk/Lyeteung-Hammer-Aluminum-Extrusion-Profile/dp/B0DGST24BC |
| 21 | M3 heat-set insert | £0.04 | - | https://www.amazon.co.uk/HOLMOL-360PCS-Brass-Metric-Knurled/dp/B0DR26QK5T |
| 6 | M3 grub screw | £0.02 | - | https://www.amazon.co.uk/dp/B0CJ6RL4GF |
| 3 | Compression spring small, < 6.6mm OD | £0.02 | - | https://www.amazon.co.uk/Compression-Assortment-Stainless-Different-Projects/dp/B0FLDKRZN4 |
| ~10 | Zip ties | £0.01 | 2 for fixing the belt to the X-axis mover, the rest for just cable-managing. | https://www.amazon.co.uk/XINGO-Assorted-Self-Locking-Resistant-Workshop/dp/B0C8HNX4FY |

## Printed parts

Printed in PLA (PETG also works, and is in theory better for some of the heat-exposed parts), except the exit nip tongue, which must be PETG: it's a leaf spring, and in PLA it's stiff enough that the nip roller's drag on its pad stalls the motor.

Exported to `cad/` as STLs. Optional 3MF files are also provided for a couple of parts with optional multi-color text.

Total filament needed is about 5kg.

Printed with a 0.4mm nozzle, with a 0.28mm layer height, with a standing orientation (non-optimal for most parts), this takes about 117 hours. If you adjust settings and orientate parts correctly, this time will come down substantially, this is just to give a very quick calculcated estimate.

| Qty | Part | Material | Filament (g) | Print time | Notes |
|---|---|---|---|---|---|
| 7 | `card_bin` | PLA | 290 | 5h 25m | - |
| 7 | `card_bin_door` | PLA | 100 | 4h 05m | - |
| 4 | `card_mover_plate` | PLA | 10 | 10m | - |
| 4 | `led_ring_spacer` | PLA | 10 | 5m | - |
| 1 | `base_plate` | PLA | 110 | 2h 00m | - |
| 1 | `scan_plate` | PLA | 130 | 2h 55m | - |
| 1 | `exit_insert` | PLA | 10 | 10m | - |
| 1 | `exit_nip_tongue` | PETG | 10 | 45m | - |
| 1 | `card_magazine_bottom` | PLA | 310 | 6h 35m | - |
| 1 | `card_magazine_top` | PLA | 310 | 6h 40m | - |
| 1 | `card_magazine_door_bottom` | PLA | 50 | 1h 00m | - |
| 1 | `card_magazine_door_top` | PLA | 50 | 55m | - |
| 1 | `card_magazine_pad` | PLA | 10 | 10m | - |
| 1 | `card_magazine_lifter` | PLA | 50 | 1h 05m | - |
| 1 | `card_magazine_lifter_top` | PLA | 40 | 45m | - |
| 1 | `card_mover` | PLA | 50 | 1h 10m | - |
| 1 | `card_mover_slide` | PLA | 110 | 2h 35m | - |
| 1 | `card_mover_plate_motor` | PLA | 60 | 1h 35m | - |
| 1 | `card_mover_plate_spindle` | PLA | 50 | 1h 25m | - |
| 1 | `limit_switch_mount` | PLA | 10 | 15m | - |
| 1 | `limit_switch_mount_small` | PLA | 20 | 25m | - |
| 1 | `limit_switch_carrier` | PLA | 10 | 10m | - |
| 1 | `camera_mount` | PLA | 30 | 35m | - |
| 1 | `swing_sun_gear` | PLA | 10 | 10m | - |
| 1 | `swing_clutch_collar` | PLA | 10 | 5m | - |
| 1 | `swing_idler_gear` | PLA | 10 | 5m | - |
| 1 | `swing_drive_arm` | PLA | 10 | 10m | - |
| 1 | `swing_idle_arm` | PLA | 10 | 10m | - |
| 1 | `swing_roller` | PLA | 10 | 30m | - |
| 1 | `nip_roller` | PLA | 10 | 30m | - |
| 1 | `nip_drive_gear` | PLA | 10 | 10m | - |
| 1 | `nip_idler_gear` | PLA | 10 | 5m | - |
| 1 | `nip_gear` | PLA | 10 | 10m | - |
| 1 | `brain_plate` | PLA | 390 | 9h 45m | - |
| 1 | `brain_plate_lid` | PLA | 100 | 2h 10m | - |
| 1 | `brain_shelf` | PLA | 110 | 2h 30m | - |
| 1 | `brain_box_mount` | PLA | 60 | 1h 45m | - |
| 1 | `swing_roller_mould_a` | PLA | 30 | 35m | Used for moulding, not part of final design. |
| 1 | `swing_roller_mould_b` | PLA | 30 | 40m | Used for moulding, not part of final design. |
| 1 | `nip_roller_mould_a` | PLA | 40 | 40m | Used for casting rubber, not part of final design. |
| 1 | `nip_roller_mould_b` | PLA | 40 | 45m | Used for casting rubber, not part of final design. |

## Overall cost

If all parts are purchased through the links (which are no where the near the cheapest you can get).

The total cost breakdown comes to roughly:

| Section | Subtotal |
|---|---|
| Electronics | £232.98 |
| Motion | £96.50 |
| Filament | £50.00 (based on ~£10/kg) |
| Frame | £37.17 |
| Feed rollers | £8.23 |
| Fasteners | £5.92 |
| **Total** | **£430.80** |
