//include <BOSL2/BOSL2>

// Turn off to export a part at the origin rather than in its place in the machine.
assemble = true;

// Show specific objects
show_base_plate = true;
show_externals = true;
show_camera_view = false;
show_scan_plate = true;
show_brain_plate = true;
show_brain_plate_lid = false;
show_brain_shelf = true;
show_brain_box_mount = true;
show_card_magazine_lifter = true;
show_card_magazine_lifter_top = false;
show_card_magazine_top = true;
show_card_magazine_bottom = true;
show_card_magazine_door_top = true;
show_card_magazine_door_bottom = true;
show_card_magazine_pad = true;
show_gantry = true;
show_card_bin = true;
show_card_bin_door = true;
show_card_mover_plate = false;
show_card_mover_plate_motor = false;
show_card_mover_plate_spindle = false;
show_card_mover = false;
show_card_mover_slide = false;
show_limit_switch_mount = false;
show_limit_switch_mount_small = false;
show_limit_switch_carrier = true;
show_swing_sun_gear = false;
show_swing_clutch_collar = false;
show_swing_idler_gear = false;
show_swing_roller = false;
show_swing_roller_mould_a = false;
show_swing_roller_mould_b = false;
show_swing_drive_arm = true;
show_swing_idle_arm = true;
show_camera_mount = false;
show_led_ring_spacer = false;
show_exit_insert = true;
show_exit_nip_tongue = true;
show_nip_roller = true;
show_nip_roller_mould_a = false;
show_nip_roller_mould_b = false;
show_nip_drive_gear = true;
show_nip_idler_gear = true;
show_nip_gear = true;
show_nip_pad_mould = true;
show_nip_pad_cast_lid = false;
show_nip_pad_cast_base = false;
show_nip_pad_cast_shim = false;
// Fills for recessed text, so it can be printed in a second filament.
show_text_inlays = false;

text_inlay_depth = 1;

// Just use to extend sizes to make sure boolean difference shows up without flickering in preview.
epsilon = 0.1;

// Core values
extrusion_long_width = 20.0;
extrusion_long_depth = 600.0;
extrusion_long_height = 20.0;

extrusion_short_width = 20.0;
extrusion_short_depth = 200.0;
extrusion_short_height = 20.0;

bearing_rod_radius = 8 * 0.5;
bearing_rod_hole_threshold = 0.75;
bearing_rod_linear_bearing_height = 24;
bearing_rod_bearing_bearing_to_base_offset = 11;//11;

bearing_rod_clamp_rod_to_base_offset = 20;
bearing_rod_clamp_rod_to_screw_offset = 33 * 0.5;
bearing_rod_clamp_screw_radius = 6 * 0.5;
bearing_rod_clamp_plate_width = 12;
bearing_rod_clamp_plate_depth = 42;
bearing_rod_clamp_plate_height = 20;

lead_screw_radius = 8 * 0.5;
lead_screw_height = 400;
lead_screw_hole_threshold = 0.75;
lead_screw_mounting_hole_radius = 4 * 0.5;
lead_screw_mounting_hole_offset = 8;//5.75;
lead_screw_base_hole_radius = 14;

stepping_motor_width = 42;
stepping_motor_depth = 42;
stepping_motor_height = 23;
stepping_motor_tolerance = 1.0;
stepping_motor_screw_hole_offset = 15.55;
stepping_motor_screw_hole_radius  = 3.9 * 0.5;

card_width = 88.0;
card_depth = 63.0;
card_thickness = 0.31;

card_bin_tolerance = 1;
card_bin_thickness = 8;
card_bin_count = 1;
card_bin_offset = 40 - 100;
// The bin leans back as it rises, and cards land on a floor tipped towards its front (+x) wall.
card_bin_skew_offset = 132;
// Steep enough that a card left leaning on the back wall slides its bottom edge forwards and drops flat.
card_bin_floor_angle = 28;
// Where the floor meets the inside of the front wall, in the bin's x/z; the door is shaped around this point.
// The chute runs down into the base as far as leaves 4mm of base under the recess the door's tongue hooks into.
card_bin_floor_low_point = [78.85, -8.25];
// Cards slide down the floor against the front wall, so all the slack along it becomes a gap at the back wall.
// Under card_thickness * tan(card_bin_card_wall_angle / 2) (about 0.09mm) the gap is narrower than a card, so a falling card's edge can't drop into it.
card_bin_floor_clearance = 0.05;
// Ribs down the back wall stop cards sliding down it from sticking flat against it.
card_bin_back_rib_radius = 0.8;
card_bin_back_rib_count = 5;
// The top of the bin funnels inwards, from its back (-x) and front (+x) edges, over this depth.
card_bin_flare_depth = 30;
card_bin_flare_inset = [45, 15];

// The front wall is a door that hooks in at the bottom and clicks shut at the top, so cards can be lifted out.
// It sits in rebates in the side walls so the bin gets no wider along the rail.
card_bin_door_clearance = 0.25;
card_bin_door_rebate = 3;
card_bin_door_floor_margin = 2;
card_bin_door_skin_cut = 1;
card_bin_door_tongue_length = 5;
// Room behind the tongue for it to swing as the door tilts open.
card_bin_door_tongue_swing = 3;
card_bin_door_window_radius = 10;
// Distance from each end of the door to the centre of the window's rounded end.
card_bin_door_window_margin = 25;
// A handle near the top of the card bin's and magazine's doors to pull them out by: fingers hook behind the lip on its end.
// The lip leans out from the door so the door prints lying on its inside without supports under the lip.
door_handle_width = 40;
door_handle_reach = 12;
door_handle_thickness = 4;
door_handle_lip = 6;
door_handle_lip_angle = 45;
door_handle_inset = 12;
door_handle_fillet_radius = 2;
// The window below a handle stops this far below its lip, so fingers behind the lip don't reach into the bin.
door_window_handle_margin = 5;
card_bin_door_latch_length = 25;
// The finger's stiffness and the bump's height set how hard the door is to knock out: together these hold it about three
// times as firmly as a 2mm finger with a 1mm bump, while bending the finger well short of breaking it.
card_bin_door_latch_width = 2.5;
card_bin_door_latch_gap = 1;
card_bin_door_latch_top_margin = 6;
card_bin_door_latch_bump_radius = 2;
card_bin_door_latch_bump_height = 1.3;
card_bin_door_latch_bump_length = 8;
card_bin_door_latch_groove_clearance = 0.15;

base_plate_height = 10;
base_plate_width = 160;//extrusion_short_depth + extrusion_long_width;
base_plate_depth = extrusion_short_depth;
base_plate_stepping_motor_plate_height = 5;
base_plate_bearing_plate_height = 8;//5;

card_magazine_tolerance = 0.3;
card_magazine_thickness = 14;
card_magazine_thickness_bottom = 22;
// The lifter's arms stop on the bottoms of the side cutouts, at card_magazine_thickness_bottom, so the floor under the
// stack can be thinner. Level with the door's sill, so the inside of the sill's tongue recess stays closed.
card_magazine_floor_thickness = base_plate_height;
// Stiffens the tall walls. Limited by the floor's bolt head recesses, 10mm in from the walls.
card_magazine_floor_fillet_radius = 5;
card_magazine_top_flare_width = 30;
card_magazine_top_flare_depth = 30;
card_magazine_top_flare_height = 10;
card_magazine_tab_width = 20;
card_magazine_tab_height = 30;
card_magazine_tab_depth = 6;
// The side walls splay out towards the door, so a stack pushed in off-centre is guided into the hole. Limited by the top
// half's indexing peg holes behind them.
card_magazine_loading_flare_width = 4;
card_magazine_loading_flare_angle = 30;

card_magazine_lifter_cutout_size = 18;
// Tall enough for the one linear bearing on the rod.
card_magazine_lifter_height = ((bearing_rod_linear_bearing_height * 2) + base_plate_bearing_plate_height + 5) * 0.5;
card_magazine_lifter_arm_width = 14;
card_magazine_lifter_hand_width = 35;
card_magazine_lifter_hand_depth = 38;
card_magazine_lifter_rod_plate_depth = 7;
card_magazine_lifter_rod_plate_hole_offset_height = 18 * 0.5;
card_magazine_lifter_rod_plate_hole_offset_depth = 24 * 0.5;
card_magazine_lifter_rod_plate_hole_radius = 4.4 * 0.5;
card_magazine_lifter_lead_rod_plate_offset = 5;

// Tabs standing up from the scan plate's edges against the gantry's posts, each bolted through to a T-nut in the post's slot.
scan_plate_bracket_thickness = 6;
// Tall enough that the bolt's slot stays clear of the fillet below it.
scan_plate_bracket_height = 25;
scan_plate_bracket_fillet_radius = 5;


tbolt_nut_radius = 4.5;
tbolt_nut_facets = 100;
tbolt_nut_height = 1.5;
tbolt_shank_radius = 2.75;
tbolt_shank_radius_tolerance = 0.2;
tbolt_shank_height = 45;
// Bolts into the frame's extrusions go through slots running along the extrusion's slot, so a bolt can go in with a hammer
// T-nut (10 x 6mm) already on it and the nut be passed through into the extrusion before it's turned to lock.
extrusion_bolt_slot_width = 6.5;
extrusion_bolt_slot_length = 11;

card_mover_top_bar_height = 350 - 50;
card_mover_bottom_bar_height = 290 - 50;

card_mover_bearing_rod_radius = 8 * 0.5;
card_mover_bearing_rod_height = 600;
card_mover_bar_offset = 28;
card_mover_plate_length = card_mover_bearing_rod_height;

extrusion_motor_mount_width = extrusion_short_width;// * 0.75;
extrusion_motor_mount_height = 15;
extrusion_motor_mount_depth = 95 + 20;
extrusion_motor_mount_thickness = 15;
extrusion_motor_mount_plate_depth = 50;
extrusion_motor_mount_arm_height = 50;
extrusion_motor_mount_offset = 37;
extrusion_motor_mount_spigot_radius = lead_screw_base_hole_radius + lead_screw_hole_threshold;
        
extrusion_spindle_mount_plate_depth = 30;
extrusion_spindle_mount_hole_radius = 2.7;
        
extrusion_clamp_height_padding = 10;
extrusion_clamp_width = card_mover_bar_offset - (bearing_rod_clamp_rod_to_base_offset);
extrusion_clamp_corner_radius = 4;

card_mover_back_width = 10;
card_mover_back_height = 30;
card_mover_back_depth = 100;
card_mover_back_offset = 28;
card_mover_back_height_offset = 5;

card_mover_bearing_mount_width = bearing_rod_bearing_bearing_to_base_offset;
card_mover_bearing_mount_height = 30;
card_mover_bearing_mount_depth = 35;
card_mover_bearing_mount_hole_length = card_mover_bearing_mount_width + card_mover_back_width + (epsilon * 2);

limit_switch_mount_width = 10;
limit_switch_mount_depth = extrusion_short_width * 0.75;
limit_switch_mount_height = 44;    
limit_switch_mount_arm_depth = limit_switch_mount_depth;
limit_switch_mount_arm_width = 45;
limit_switch_mount_hole_distance = 9.5;
limit_switch_mount_hole_radius = 2.47 * 0.5;
limit_switch_mount_hole_inset = 4;
limit_switch_mount_hole_vertical_inset = 0;
limit_switch_mount_hole_gap_height = 9;
limit_switch_mount_hole_length = 10;
limit_switch_mount_arm_height = limit_switch_mount_height - ((limit_switch_mount_height * 0.5) - (limit_switch_mount_hole_gap_height * 0.5));

// The top-of-magazine switch is bolted straight onto a carrier on the card-side face of a tab on the scan plate's +y wall,
// set back so the switch's face is at the hole's edge. A screw into a heat-set insert in the tab's top pulls the carrier
// down against a spring to set the switch's height, then two clamp bolts through slots in the tab lock the carrier flat
// against the tab's face.
limit_switch_tab_width = 24;
limit_switch_tab_thickness = 8;
limit_switch_tab_height = 20;
// Switch bolt height above the wall top with the screw done right down, and how far loosening it lets the spring lift them.
limit_switch_bolt_low = 2.9;
limit_switch_travel = 8;
limit_switch_carrier_thickness = 4;
// Sides that wrap round the tab's ends, so the carrier can only slide straight up and down.
limit_switch_carrier_side_thickness = 3;
limit_switch_carrier_side_clearance = 0.2;
// Height of the carrier's lower edge above the wall top, which keeps it clear of the card stop along the wall.
limit_switch_carrier_bottom = 0.5;
limit_switch_carrier_flange = 6;
limit_switch_carrier_gap = 1;
// The switch's M2 bolt heads ride in channels in the tab's face, with their nuts on the switch's card side.
limit_switch_bolt_head_radius = (3.8 + 0.6) * 0.5;
limit_switch_bolt_head_depth = 2;
// M3 clamp bolts behind the switch body, above its bolts. Their nuts are covered by the switch once it's fitted, and
// 12mm bolts end flush with the carrier's face, so they don't press on it.
limit_switch_clamp_spacing = 16;
limit_switch_clamp_low = 7.5;
limit_switch_clamp_nut_radius = (5.5 + 0.3) / sqrt(3);
limit_switch_clamp_nut_depth = 2.6;

card_mover_slide_height = 3;
card_mover_slide_depth = 90;
card_mover_slide_mid_depth = 66;              
card_mover_slide_drop = 113;              

sg90_width = 22.4;
sg90_height = 16;
sg90_depth = 12;
sg90_mounting_width = 10;
sg90_hole_distance = 27.7;
sg90_hole_radius = 1.2;
sg90_distance_to_rotor = 32 - 22.8;

component_wall_slack = 0.5;
component_wall_thickness = 2;
component_spacing = 0;

PCB_width = 57;
PCB_depth = 88;
PCB_hole_radius = 3.5 * 0.5;
PCB_hole_distance = 37 * 0.5;

PCB_width_and_slack = PCB_width + (component_wall_slack * 2);
PCB_depth_and_slack = PCB_depth + (component_wall_slack * 2);
PCB_and_wall_width = PCB_width_and_slack + (component_wall_thickness * 2); 
PCB_and_wall_depth = PCB_depth_and_slack + (component_wall_thickness * 2); 
PCB_spacing = PCB_and_wall_width + component_spacing;

UNOQ_width = 53.34;
UNOQ_depth = 68.58;
UNOQ_hole_radius = 3.5 * 0.5;

UNOQ_width_and_slack = UNOQ_width + (component_wall_slack * 2);
UNOQ_depth_and_slack = UNOQ_depth + (component_wall_slack * 2);
UNOQ_and_wall_width = UNOQ_width_and_slack + (component_wall_thickness * 2); 
UNOQ_and_wall_depth = UNOQ_depth_and_slack + (component_wall_thickness * 2); 

MCP23017_width = 23.0;
MCP23017_depth = 38.0;
MCP23017_hole_radius = 1.5;
MCP23017_hole_distance = 19.0;

MCP23017_width_and_slack = MCP23017_width + (component_wall_slack * 2);
MCP23017_depth_and_slack = MCP23017_depth + (component_wall_slack * 2);
MCP23017_and_wall_width = MCP23017_width_and_slack + (component_wall_thickness * 2); 
MCP23017_and_wall_depth = MCP23017_depth_and_slack + (component_wall_thickness * 2); 

IMX179_width = 62;
IMX179_depth = 9;
IMX179_angle = 23;
IMX179_hole_radius = 1.3;
IMX179_camera_radius = 1.5;
IMX179_standoff = 5;
// IMX179 sensor: 3280 x 2464 pixels at 1.4um, long side along x.
camera_sensor_size = [3280, 2464] * 0.0014;
// The usual "75 degree" (diagonal) lens. Wide angle (2.8mm) versions distort too much for the pinhole view below to hold.
camera_focal_length = 3.8;
camera_view_angles = [for (size = camera_sensor_size) 2 * atan(size * 0.5 / camera_focal_length)];

belt_block_depth = card_mover_back_height * 0.5;
belt_block_width = 19;
belt_block_height = 15;
belt_block_cut_depth = 11;
belt_block_offset = 5;

card_magazine_hole_scan_wall_size = 5;
card_magazine_hole_scan_wall_height_size = 5;
                
// Exit insert heights are relative to the top of the scan plate, which the top of the card stack sits just above.
// Per side, so the insert drops into its pocket and the gate's tongue between the posts without binding.
exit_insert_tolerance = 0.4;
exit_insert_pocket_depth = 4;
exit_insert_lip_height = -0.45;
exit_insert_lead_in_height = 1.5;
exit_insert_lead_in_angle = 20;
exit_insert_tip_height = 0.8;
exit_insert_post_width = 10;
exit_insert_post_height = 5;
// Keeps the posts and gate clear of the roller and its rod holder.
exit_insert_post_offset = 5.5;
// Cards push the insert forwards, so the posts bearing on this wall keep its back face flush with the magazine.
exit_insert_registration_wall = 4;
// The posts' backs stop this close to their pockets' back walls, so the insert can't slide back into the magazine.
exit_insert_post_back_clearance = 0.1;

// The nip: a second roller just past the exit wall, geared off the drive shaft to turn with the swing roller, presses the
// card onto a pad set into the lip. The roller grips a card harder than the pad does, and the pad harder than one card grips
// another, so only the top card is driven through. Reversing to park the arm turns it back, returning a second card to the stack.
// As close to the exit wall as the lead-in allows, so a second card dragged off the stack meets the pad within a few mm.
exit_nip_x = 7.5;
// Cast in polyurethane rubber (VytaFlex 60) and glued into a recess in a tongue, which flexes down as cards pass.
// It runs past both ends of the roller, so the roller only ever bears on the pad.
exit_nip_pad_length = 6;
exit_nip_pad_overhang = 1;
exit_nip_pad_thickness = 1.5;
exit_nip_pad_clearance = 0.1;
// The tongue is a leaf spring, rooted downstream, which only flexes between the pad's recess and its root, so its stiffness
// comes from this length and thickness. It's a separate part so it prints without overhangs, layers running along it.
exit_nip_tongue_flex_length = 7.5;
exit_nip_tongue_thickness = 0.7;
// The flexing section is slotted along the card's travel into ribs, as at full width it pressed the roller onto the pad hard
// enough that their rubbing, whenever no card was between them, stalled the motor. Stiffness goes with the ribs' total width;
// a card's edge always spans the slots, resting on the ribs either side.
exit_nip_tongue_rib_count = 3;
exit_nip_tongue_rib_width = 2.5;
exit_nip_tongue_wall = 1.5;
// Wide enough to stay clear of the insert wherever it sits in its pocket.
exit_nip_tongue_slot = 1;
// Room under the tongue: it swings about its root, so its tip moves about 1.6 times as far as the pad, which is pushed down by
// the preload plus up to two cards.
exit_nip_tongue_travel = 1.6;
// The floor under the tongue is an arm of its root, lying in a recess in the scan plate's pocket. It runs to the magazine's
// exit wall, so the recess leaves no opening there for a card's edge to push into.
exit_nip_floor_thickness = 1.6;
// The insert's sides are joined by a bar under the tongue's flexing section, which moves least there, as well as by the strip
// at the exit wall, so the insert stays one stiff part with a flat bottom.
exit_nip_bridge_clearance = 1;
// The insert is too shallow under the lip for nuts, so the tongue's root drops through it into the scan plate and is bolted
// up through the plate (M3x8) into nuts slid in from its sides.
exit_nip_root_floor_thickness = 3;
exit_nip_root_clearance = 0.2;
exit_nip_nut_radius = (5.5 + 0.3) / sqrt(3);
exit_nip_nut_depth = 2.6;
// Under the nut, which the bolt pulls down.
exit_nip_nut_floor_thickness = 1.6;
exit_nip_nut_wall = 0.6;
exit_nip_bolt_inset = 4;
exit_nip_bolt_overrun = 1;
// The roller presses the pad down this far at rest, so its axle always sits at the tops of its bearings and its gear meshes
// at the designed distance.
exit_nip_preload = 0.3;
// Steep enough that cards slide off even on a high-friction surface.
exit_ramp_angle = 35;
// The lip runs on past the tongue's root until the ramp leaves the scan plate's edge this thick, so it doesn't print as a
// knife edge.
exit_ramp_edge_thickness = 1.5;
// Each side of the exit channel opens out from the magazine's exit wall, so a card skewed or pushed sideways by the roller
// moves away from the walls instead of jamming against them.
exit_channel_flare_angle = 6;

// Loose, since the insert prints on its side and its vertical holes come out undersized.
exit_screw_clearance_radius = 3.8 * 0.5;
exit_threaded_insert_radius = 4.0 * 0.5;
exit_threaded_insert_depth = 5;
exit_spring_radius = 6.6 * 0.5;
exit_spring_depth = 4;

// 12 LED WS2812 ring round the camera, lighting the card. M2 bolts go through its holes, printed spacers and the camera
// mount into nuts recessed in its top; the spacers leave room for the wires soldered to the back of the ring.
led_ring_outer_radius = 50 * 0.5;
led_ring_inner_radius = 35 * 0.5;
led_ring_thickness = 1.6;
led_ring_hole_radius = 47 * 0.5;
led_ring_hole_angles = [45, 135, 225, 315];
led_ring_bolt_clearance_radius = 2.4 * 0.5;
// Across the corners of an M2 nut, plus clearance.
led_ring_nut_radius = (4 + 0.3) / sqrt(3);
led_ring_nut_depth = 2;
led_ring_spacer_radius = 6 * 0.5;
led_ring_spacer_height = 5;

// Swing arm feed: the roller hangs off an arm pivoting on the drive shaft and is driven through an idler,
// so driving forwards swings it down onto the card and reversing swings it up out of the camera's view.
// Positions are [x, z] relative to exit_position.
// Far enough from the nip roller for its gear train, and out of the light from the LED ring to the card's exit edge, so
// it doesn't shadow the card.
swing_shaft = [-1, 27];
swing_rod_radius = 8 * 0.5;
swing_rod_clearance_radius = swing_rod_radius + 0.2;
// Looser than the printed parts' bores, since these holes print sideways and their tops sag.
swing_support_clearance_radius = swing_rod_radius + 0.35;
// Far enough back that its grip stays clear of the nip roller's at the lower stop.
swing_roller_contact_x = -20;
// The grip is silicone cast onto the roller in swing_roller_mould_half(), keyed into grooves along the core so it
// can't spin, and rings around it so it can't slide.
swing_roller_radius = 8;
// The grip the arm is laid out for.
swing_roller_grip_thickness = 2;
// The grip actually cast, thicker than the layout's so it grips the card harder. The arm just rests a little higher on the stack.
swing_roller_cast_grip_thickness = 4;
swing_roller_key_count = 8;
swing_roller_key_width = 2;
swing_roller_key_depth = 1;
swing_roller_ring_count = 3;
// Well short of the magazine hole, so slop in the arms can't rest it on the walls.
swing_roller_length = 50;
swing_roller_hub_radius = 6;
// The hubs run out to the drive arm and the idle arm's clamp, so the roller can't slide far enough to unmesh its gear.
// Generous, so where the sun gear is clamped along the shaft (which sets where the clutch spring holds the drive arm)
// isn't critical enough to squeeze the roller against the idle arm.
swing_roller_end_play = 1;

// Two-part mould, split along the roller, stood upright with the gear end up for pouring.
swing_roller_mould_wall = 3;
// Under the socket for the roller's idle-end hub.
swing_roller_mould_socket_floor = 2;
// Deep enough to hold the pour funnel, stopping just short of the roller's gear.
swing_roller_mould_top = 16;
swing_roller_mould_hub_clearance = 0.15;
swing_roller_mould_bolt_inset = 8;
// Leaves a solid wall beyond the funnel's mouth.
swing_roller_mould_bolt_margin = 8;
// M3 nuts recessed into the back of half "b": across the corners plus clearance.
swing_roller_mould_nut_radius = (5.5 + 0.3) / sqrt(3);
swing_roller_mould_nut_depth = 3;
// A ridge round the cavity on half "b" seats in a groove in half "a", so silicone can't creep out along the split.
swing_roller_mould_seal_gap = 1.5;
swing_roller_mould_ridge_width = 2;
swing_roller_mould_ridge_height = 2;
// Generous, since the groove prints narrow and the ridge wide; if the ridge can't drop in it holds the halves apart.
swing_roller_mould_ridge_clearance = 0.4;
swing_roller_mould_pour_radius = [1.5, 7];
// The pour funnel and vent lean outwards so their walls stay clear of the roller's hub, which sticks out of the top.
swing_roller_mould_funnel_lean = 6;
swing_roller_mould_vent_radius = [1.5, 4];
// Room round the nip roller's clamp boss for the lip heat-setting raises round its insert, and an insert left proud.
// The boss stays a close fit for the land next to the cavity, so the resin is still sealed in.
nip_roller_mould_insert_relief = 1.5;
nip_roller_mould_seal_land = 1;
swing_axle_radius = 8 * 0.5;
swing_axle_clearance_radius = swing_axle_radius + 0.2;
// The axle doesn't turn in the drive arm, so it only needs to slide in, and a close fit keeps the roller's gear in mesh.
swing_axle_locating_radius = swing_axle_radius + 0.1;
// The axle passes through both arms, so its length isn't critical, and a grub screw in the idle arm's clamp holds it.
swing_axle_clamp_length = 6.5;
swing_axle_clamp_radius = swing_axle_radius + exit_threaded_insert_depth + 0.5;
swing_grub_screw_clearance_radius = 3.4 * 0.5;
// Clamps only reach out to their full radius on the insert's side, so the axle clamp's underside stays clear of the plate at the lower stop.
swing_clamp_boss_radius = exit_threaded_insert_radius + 2;
swing_card_top = 0.16;

swing_gear_module = 1;
swing_gear_teeth = 14;
swing_gear_pressure_angle = 20;
// Generous, since the sun gear's grub screw pushes it to one side of its bore.
swing_gear_backlash = 0.25;
swing_gear_thickness = 6;
swing_gear_inner_y = 48;
// The idler turns on the shoulder of a 4mm shoulder bolt through a boss on the drive arm's outer face. The nut tightens
// against the end of the shoulder, in a pocket whose floor is level with it, so the bolt can be done up hard without
// crushing the plastic or clamping the gear.
swing_idler_shoulder_radius = 4 * 0.5;
swing_idler_shoulder_length = 16;
swing_idler_end_play = 0.3;
// Close, since the gears' bore clearances add up to push the meshes apart under load.
swing_idler_bore_radius = swing_idler_shoulder_radius + 0.1;
swing_idler_nut_radius = (5.5 + 0.3) / sqrt(3);
// An M3 nut is 2.4mm thick; recessed a little below the boss's end.
swing_idler_nut_depth = 2.6;
swing_idler_boss_radius = swing_idler_nut_radius + 1.2;

swing_hub_radius = 7;
// Long enough to fit the insert, with solid walls either side, past the clamp's chamfer.
swing_sun_hub_length = 10;
// Close, since it's clamped rather than running and any offset in it makes the nip roller run eccentric.
swing_sun_bore_radius = swing_rod_radius + 0.1;
// The clamped gears printed too tight at the roller's bore to slide onto their rods; the grub screw still clamps them.
swing_gear_bore_radius = swing_rod_radius + 0.25;
swing_sun_clamp_radius = swing_rod_radius + exit_threaded_insert_depth + 0.5;
// The clamp reaches past the roller gear's tips as the arm swings, so it starts back from the gear face.
swing_sun_clamp_gap = 1;
swing_arm_end_radius = 7;
swing_arm_thickness = 4;
swing_idle_arm_y = 44;

swing_support_width = 16;
// Narrower than the support so its sides slope away from the path of an axle sticking out past the arms.
swing_support_base_width = 10;
swing_support_fillet_radius = 6;
swing_support_thickness = 16;
// PTFE flat washer between the idle arm and its rod support, so the support's drag doesn't fight the arm's swing.
swing_washer_outer_radius = 14 * 0.5;
swing_washer_thickness = 2;
// Slipping clutch that drags the arm round with the shaft until a stop holds it: a compression spring between a collar
// clamped to the shaft and the drive arm presses the arm against the sun gear.
swing_clutch_spring_outer_radius = 12 * 0.5;
swing_clutch_spring_inner_radius = 10 * 0.5;
// Compressed, from about 20mm free; sliding the collar sets the preload.
swing_clutch_spring_length = 10;
swing_clutch_collar_length = 8;
// Room to slide the collar out to soften the clutch.
swing_clutch_collar_play = 2;
// The drive arm bears on the sun gear only inside the gear's root circle, through a groove where the teeth sweep, so the
// clutch doesn't rub over the ends of the teeth. A groove rather than a raised ring keeps the arm's face flat for printing.
swing_clutch_ring_outer_radius = 5.5;
swing_clutch_groove_outer_radius = swing_gear_module * (swing_gear_teeth * 0.5 + 1) + 0.5;
swing_clutch_groove_depth = 0.5;
// Pads on both rod supports that the roller axle's protruding ends park and drop onto, so the arm can't twist.
swing_axle_stop_radius = 3;
// How far below the engaged position the arm is laid out for it can drop on an empty magazine. The cast grip is thicker
// than the layout's, so even at 0 the grip drops well below a card, while the gears stay clear of the plate.
swing_arm_lower_travel_angle = 0;
swing_arm_park_clearance = 2;

// The nip's gears sit outside the idle rod support, where nothing else moves: one clamped to the drive shaft, an idler on a
// 4mm shoulder bolt into a heat-set insert in the support, and one clamped to the nip roller's axle, which turns in both
// rod supports. The shoulder's end sits down a counterbore, so the idler gets the same end play as the swing idler.
nip_idler_shoulder_length = 8;
nip_idler_boss_radius = exit_threaded_insert_radius + 2.5;
nip_bearing_wall = 3;
// The roller is clamped to its axle by its hub at one end. The other end's hub runs to the idle support, so the roller holds
// the axle against its inner face while the nip gear bears on its outer face; a collar there would hit the arm's stop pin.
nip_roller_clamp_length = 7;
// The far hub's bore is close only over its end, so the roller still slides onto the rod.
nip_roller_locating_length = 5;
// The far hub necks in where it runs over the insert's posts; the posts were cut down after the built roller rubbed on them.
nip_roller_post_clearance = 1.5;
// An open tray casting several pads face down, so the face that meets the cards comes off its flat floor.
nip_pad_mould_count = 2;
nip_pad_mould_wall = 2;
nip_pad_mould_floor = 1.5;
// Casting the pad in place in the tongue: a lid clamped on the tongue's top moulds the pad's face flush with the lip, and
// a shim in the tongue's travel gap holds the stiff block up against the lid, so the seal doesn't rely on the flex.
nip_pad_cast_clearance = 0.2;
nip_pad_cast_wall = 3;
nip_pad_cast_lid_thickness = 8;
// Keeps the lid off the flex and root, so it bears only on the stiff block.
nip_pad_cast_relief = 0.5;
nip_pad_cast_floor_thickness = 2.5;
nip_pad_cast_bolt_length = 16;
// The pour and vent cones, as [radius at the lid's top, how far the top leans in from the slot].
nip_pad_cast_pour = [4, 2];
nip_pad_cast_vent = [2.5, 1];
// Short of the recess's ends in x, so the slots stay over it if the lid sits slightly off.
nip_pad_cast_slot_inset = 1;

swing_motor_mount_thickness = 6;
// The drive rod runs half way into the motor coupler.
swing_coupler_length = 25;
// The motor is fitted before the scan plate goes on the frame, so the screw heads are recessed to sit flush beside the corner post.
swing_motor_bolt_head_radius = 6.2 * 0.5;
swing_motor_bolt_head_depth = 3.2;
swing_motor_boss_radius = 23 * 0.5;
swing_wall_notch_length = 20;

// 0 is engaged on the card, swing_arm_park_rotation is parked.
swing_arm_angle = 0;

card_magazine_index_size = 7;
card_magazine_index_height = 7;
card_magazine_index_insert = 8;
card_magazine_index_tolerance = 0.3;

// The door is printed in two halves, as it's taller than the printer, joined like the magazine's halves by tabs on the
// bottom half lapping over the outside of the top half, bolted through, so it comes off in one piece. Like the card bin's door, it tilts out about a tongue along its bottom, which hooks
// into a sill, and lifts off, held shut by sprung catches near the top of each half. The top half's tongue in the top of
// the bottom half keeps the halves in line. It sits between the side walls, overlapping their ends by the rebate either
// side of the loading flare, which stops it going in too far.
card_magazine_door_thickness = 7;
card_magazine_door_clearance = 0.25;
card_magazine_door_rebate = 3;
card_magazine_door_tongue_length = 5;
// From each edge of the door to the centre of a tab, between the catch and the handle.
card_magazine_door_tab_inset = 10;
card_magazine_door_tab_width = 11;
// Shallower than the magazine's, as the door is thin; the bolt head still sits below the door's inside face.
card_magazine_door_tab_bolt_recess = 0.5;
// A window up the middle of each half, the size of the card bin door's, shows how full the magazine is. It's narrower than a
// card, so the doors either side still hold the card's edge.
// Above the door, from the magazine's top flare to the top of the scan plate's walls, a sprung pad pushes the cards against
// the exit wall. It's held in the fixed parts so the door can't
// move it, and its top stands above any card, so none can come down onto it. Being sprung, it gives way rather than
// catching cards rising onto its sloped bottom.
card_magazine_pad_width = 40;
card_magazine_pad_thickness = 7;
// How far the pad stands past the magazine wall with no cards against it. Cards above the exit's lip, and on its lead-in,
// are pushed this much less the hole's tolerance towards the exit.
card_magazine_pad_reach = 1;
// The lifter pushes cards up onto the bottom slope, so it can be steep. It reaches behind the door by however far the door
// might hang open.
card_magazine_pad_bottom_angle = 45;
card_magazine_door_slack = 2;
// The pad's front hangs down into a notch in the top of the door, so cards are pushed into line before they reach the
// magazine top's wall either side of the pad.
card_magazine_pad_door_overlap_margin = 1;
card_magazine_pad_tolerance = 0.4;
card_magazine_pad_bolt_spacing = 28;
card_magazine_pad_spring_spacing = 20;
card_magazine_pad_spring_seat_depth = 2;

// The PSU lies on its back with the M4P on a shelf above it, keeping the box's footprint small. It sits centred on the
// gantry's top beam, with x running along it from the PSU's terminal end at the gantry's -y end.
brain_plate_height = base_plate_height;
brain_box_wall_thickness = 5;
// Rounds the box's and lid's vertical edges. Matching the walls keeps the inside corners square, for the lid's lip.
brain_box_corner_radius = brain_box_wall_thickness;

// The lid sits flush on the walls, held by a lip round its underside that's a push fit inside them.
brain_box_lid_lip_thickness = 3;
brain_box_lid_lip_depth = 8;
brain_box_lid_thickness = 4;
brain_box_lid_threshold = 0.2;
brain_box_lid_fillet_radius = 2;
// Tabs sticking out from the middle of the lid's ends, past the walls, to get fingers under to pull it off. As thick as
// the lid so they don't snap.
brain_box_lid_tab_width = 30;
// Short enough that the lid still fits a 256mm print bed.
brain_box_lid_tab_reach = 4;
brain_box_lid_tab_thickness = brain_box_lid_thickness;
brain_box_lid_tab_corner_radius = 2;
// A sprung finger in the lip at each end, with a bump that clicks into a groove in the wall. Thinner and longer than the
// lip so it bends rather than snaps; short enough that its groove stays clear of the wire hole.
brain_box_lid_latch_width = 12;
brain_box_lid_latch_length = 18;
brain_box_lid_latch_thickness = 2;
brain_box_lid_latch_gap = 1;
brain_box_lid_latch_fillet_radius = 3;
brain_box_lid_latch_bump_height = 0.8;
// Height of the bump's centre above the finger's tip.
brain_box_lid_latch_bump_rise = 4;

// Lying on its back: length along x, terminals at its -x end.
psu_width = 215.0;
psu_depth = 114.0;
psu_height = 50.0;
psu_terminal_clearance = 15;
// Air under the PSU's back.
psu_standoff_height = 7;
psu_standoff_radius = 5;
psu_standoff_inset = 15;
// Its fan is on top, blowing into the gap under the shelf, which the vents on all four walls let out.
psu_fan_clearance = 13;
// Threaded holes in the side it's bolted through the -y wall by: from its end away from the terminals, and up from its back.
psu_side_holes_x = [31.5, 182];
psu_side_holes_z = [11, 36];
psu_bolt_clearance_radius = 4.5 * 0.5;
// Lets the PSU be lowered in past the walls.
psu_clearance = 2;
psu_side_clearance = 3;

control_board_width = 160;
control_board_depth = 95;
control_board_height = 10;
control_board_thickness = 1.6;
// Free above the board for its wiring.
control_board_clearance = 30;
// The board sits in the corner of the box so the ports on its edges come out through the walls: from the M4P's dimension
// drawing, in board coordinates (x from the edge with the SD slots, y from the edge with the USB ports).
control_board_wall_gap = 3;
// Bigger at the edge with the ports, for the wires into its power terminals.
control_board_port_wall_gap = 6;
control_board_port_margin = 1.5;
// [from, to] along the edge, and height above the board's top.
control_board_usb_c = [[51.4, 60.1], 3.3];
control_board_usb_a = [[64.8, 78.6], 15.6];
// From BTT's STEP model.
control_board_hdmi = [[30.15, 45.15], 6.3];
control_board_ethernet = [[81.65, 97.6], 14.4];
control_board_power_terminals = [[105.3, 147.7], 15.1];
// Both microSD slots, on the underside, side by side along the edge.
control_board_sd_slots = [[40.2, 87], 2];
// Flares the outside of their opening, to get fingers to cards recessed in the wall.
control_board_sd_chamfer = 4;

ac_plug_width = 22;
ac_plug_depth = 27;
ac_plug_height = 48;
ac_plug_hole_distance = 39;
ac_plug_hole_radius = 2.0;

brain_box_standoff_height = 6;
brain_box_standoff_outer_radius = 9.5*0.5;
brain_box_standoff_inner_radius = 4.5*0.5;

brain_shelf_thickness = 4;
brain_shelf_clearance = 0.5;
// Each side, for the shelf's edge and lip against the walls and its tabs in their slots. Loose enough to slide freely, as
// the bolts are what hold it still.
brain_shelf_fit_clearance = 0.4;
// Round the shelf's edge, bearing on the walls. Stops just below the vents, the inlet and the wire hole.
brain_shelf_lip_thickness = 2;
brain_shelf_lip_height = 10;
brain_shelf_lip_fillet_radius = 2;
// Reach above the board to get a finger through.
brain_shelf_grip_width = 40;
brain_shelf_grip_thickness = 4;
brain_shelf_grip_height = 42;
brain_shelf_grip_corner_radius = 5;
brain_shelf_grip_hole_radius = 10;
brain_shelf_grip_fillet_radius = 3;
// Bolts through the long walls into inserts in the shelf's edge. The boss stays low enough to fit under the board.
// Round the mains inlet's body, so the shelf lifts out with the inlet fitted.
brain_shelf_inlet_clearance = 1;
brain_shelf_inlet_rear_clearance = 20;
// Walls and a roof over the inlet, so its mains wires can only be reached from below, with the shelf out. The inlet's
// screws go into inserts in its wall holes: a nut inside, or a screw through the wall, would stop the roof lifting past.
brain_shelf_inlet_hood_thickness = 2.5;
brain_shelf_inlet_hood_fillet_radius = 2;
brain_shelf_bolt_clearance_radius = 1.7;
brain_shelf_bolt_boss_width = 10;
brain_shelf_bolt_boss_depth = 8;
brain_shelf_bolt_boss_height = 5;
// Tabs on the shelf's long edges drop into slots open at the top of the long walls, which carry and locate it.
brain_shelf_tab_width = 20;
brain_shelf_tab_depth = 2;
brain_shelf_tab_clearance = 0.3;

brain_box_psu_position = [brain_box_wall_thickness + psu_terminal_clearance, brain_box_wall_thickness, brain_plate_height + psu_standoff_height];
brain_plate_width = brain_box_psu_position[0] + psu_width + psu_clearance + brain_box_wall_thickness;
brain_plate_depth = (brain_box_wall_thickness * 2) + psu_depth + psu_side_clearance;
brain_shelf_z = brain_box_psu_position[2] + psu_height + psu_fan_clearance;
brain_shelf_top = brain_shelf_z + brain_shelf_thickness;
brain_box_height = brain_shelf_top + brain_box_standoff_height + control_board_height + control_board_clearance;
// The board's corner at its SD slots and USB ports, in the box's +x, +y corner: turned end for end so its USB ports face out
// the same side as the mains inlet.
brain_box_board_corner = [brain_plate_width - brain_box_wall_thickness - control_board_wall_gap, brain_plate_depth - brain_box_wall_thickness - control_board_port_wall_gap, brain_shelf_top];
brain_box_board_x0 = brain_box_board_corner[0] - control_board_width;
brain_box_board_y0 = brain_box_board_corner[1] - control_board_depth;
// A mount bolted down onto the beam at two points carries the box, with cheeks down the beam's sides so it can't twist.
// A dovetail at each point slides into a groove across the floor's underside, closed at the -y side, so the box slides on
// from the +y side; a screw up through the mount at each dovetail into an insert in the floor stops it sliding back off.
brain_box_mount_x = [0.25, 0.75] * brain_plate_width;
brain_box_mount_length = 30;
brain_box_mount_bridge = 6;
// Thickness, and depth down the beam's side.
brain_box_mount_cheek = [4, 10];
// Width at the floor's face, width at its top, height.
brain_box_mount_dovetail = [16, 21, 4.5];
brain_box_mount_clearance = 0.2;
brain_box_mount_groove_y = brain_box_wall_thickness + 5;
brain_box_mount_lock_y = brain_plate_depth - 10;
brain_box_mount_fillet_radius = 3;
// Midway between the shelf's lip and the lid's, for anything through the walls above the board.
brain_box_upper_z = (brain_shelf_top + brain_shelf_lip_height + brain_box_height - brain_box_lid_lip_depth) * 0.5;
// Lower, so the hood's roof clears the lid's lip; the shelf's notch lets it past the shelf's own.
brain_box_inlet_z = (brain_shelf_top + brain_box_height - brain_box_lid_lip_depth) * 0.5;
brain_box_wire_hole_radius = 13;
// To the side of the lid latch's groove, which is level with it.
brain_box_wire_hole_y = ((brain_plate_depth - card_bin_door_latch_bump_length) * 0.5) - brain_box_wire_hole_radius - 2;
// Along both long walls: at the board's ends, clear of the mains inlet and the vents.
brain_shelf_inlet_length = ac_plug_height + (ac_plug_depth * 0.25) + (brain_shelf_inlet_clearance * 2);
brain_shelf_inlet_x0 = (brain_box_wall_thickness + brain_box_board_x0 - brain_shelf_inlet_length) * 0.5;
brain_shelf_inlet_y0 = brain_plate_depth - ac_plug_width - brain_shelf_inlet_clearance - brain_shelf_inlet_rear_clearance;
brain_shelf_inlet_roof_z = brain_box_inlet_z + (ac_plug_depth * 0.5) + brain_shelf_inlet_clearance;

// [centre of the face, rotation]. One between the board and the front wall, as far along as the end's lip allows. The board
// fills the back, so the other is between the board's end and the inlet's hood.
brain_shelf_grips = [
    [[brain_plate_width - brain_box_wall_thickness - brain_shelf_fit_clearance - brain_shelf_lip_thickness - brain_shelf_lip_fillet_radius - brain_shelf_grip_fillet_radius - (brain_shelf_grip_width * 0.5), brain_box_wall_thickness + 8], 0],
    [[brain_box_board_x0 - brain_shelf_grip_fillet_radius - brain_shelf_grip_thickness, brain_shelf_inlet_y0 - brain_shelf_inlet_hood_thickness - (brain_shelf_grip_width * 0.5)], -90]
];
// [x, wall: 0 front, 1 back]. A triangle, so the shelf can't pivot. The front's kept right of the terminal cut-out and the
// tabs, the outer one backing the grip; the back's between the shelf's notch for the inlet and the board's end.
brain_shelf_bolts = [[brain_plate_width * 0.5, 0], [204, 0], [73, 1]];
// The first's kept just past the back bolt, whose hole would otherwise break into its slot.
brain_shelf_tab_x = [brain_shelf_bolts[2][0] + (brain_shelf_tab_width * 0.5) + 3.5, brain_box_board_corner[0] - (brain_shelf_tab_width * 0.5)];

camera_mount_camera_x = 12.5;
// Twice camera_mount_camera_x so its outer edge runs straight on from the plate.
camera_mount_arm_width = camera_mount_camera_x * 2;
// The arm widens over this length into a pad carrying the camera and the LED ring's mounting holes.
camera_mount_arm_taper_length = 30;
camera_mount_pad_margin = 2;
camera_mount_corner_radius = 3;
// Keeps a flat seat round the camera's screw holes where the view cut would otherwise reach them.
camera_mount_screw_seat_radius = 3.5;

motor_full_mount_width = 49;

// Derivative values
// Where each part sits in the assembled machine. Parts are modelled with this point at their origin.
base_plate_position = [-extrusion_short_depth - base_plate_width, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width, extrusion_short_height];

card_bin_inner_width = card_width + (card_bin_tolerance * 2);
card_bin_inner_depth = card_depth + (card_bin_tolerance * 2);
card_bin_inner_height = 220;

card_bin_width = card_bin_inner_width + (card_bin_thickness * 2);
card_bin_depth = card_bin_inner_depth + (card_bin_thickness * 2);
card_bin_height = card_bin_inner_height + card_bin_thickness;
card_bin_width_skewed = card_bin_width - 25;
card_bin_lean = atan2(card_bin_skew_offset, card_bin_height);
card_bin_card_wall_angle = 90 - card_bin_lean - card_bin_floor_angle;
// Cards meet the walls at an angle, so the floor is longer than a card by its thickness's run along the walls,
// and by the room the ribs take up where they meet it.
card_bin_floor_length = card_width + (card_thickness / tan(card_bin_card_wall_angle)) + card_bin_floor_clearance + (card_bin_back_rib_radius / sin(card_bin_card_wall_angle));
// Where the floor meets the inside of the back wall, in the bin's x/z.
card_bin_floor_high_point = card_bin_floor_low_point - [card_bin_floor_length * cos(card_bin_floor_angle), -card_bin_floor_length * sin(card_bin_floor_angle)];
// Where the outside of the back wall meets the base, so the wall is card_bin_thickness thick wherever the floor sits.
card_bin_back_offset = card_bin_floor_high_point[0] + (card_bin_floor_high_point[1] * tan(card_bin_lean)) - (card_bin_thickness / cos(card_bin_lean));
// The door is modelled with x out through the front wall, y across the bin and z up along the front face from its bottom edge.
card_bin_door_origin = [card_bin_width_skewed, 0, 0];
card_bin_door_rotation = [0, -card_bin_lean, 0];
card_bin_door_thickness = ((card_bin_width_skewed - card_bin_floor_low_point[0]) * cos(card_bin_lean)) - (card_bin_floor_low_point[1] * sin(card_bin_lean));
card_bin_door_bottom = ((card_bin_width_skewed - card_bin_floor_low_point[0]) * sin(card_bin_lean)) + (card_bin_floor_low_point[1] * cos(card_bin_lean)) - card_bin_door_floor_margin;
// The door stops below the funnel at the top of the bin: its top edge is square to the leaning door, so its outer
// corner is set level with where the funnel meets the inside of the front wall.
card_bin_door_flare_start = card_bin_to_door_frame([-card_bin_skew_offset + card_bin_width_skewed - card_bin_flare_inset[1], card_bin_height - card_bin_flare_depth]);
card_bin_door_flare_end = card_bin_to_door_frame([-card_bin_skew_offset + card_bin_width_skewed, card_bin_height + 2]);
card_bin_door_flare_meet = card_bin_door_flare_start[1] + ((card_bin_door_flare_end[1] - card_bin_door_flare_start[1]) * (-card_bin_door_thickness - card_bin_door_flare_start[0]) / (card_bin_door_flare_end[0] - card_bin_door_flare_start[0]));
card_bin_door_top = card_bin_door_flare_meet - (card_bin_door_thickness * tan(card_bin_lean));
card_bin_door_y = [card_bin_thickness - card_bin_door_rebate, card_bin_depth - card_bin_thickness + card_bin_door_rebate];
card_bin_door_tongue_thickness = (card_bin_door_thickness * 0.5) - card_bin_door_clearance;
card_bin_door_latch_u = [card_bin_door_top - card_bin_door_clearance - card_bin_door_latch_top_margin - card_bin_door_latch_length, card_bin_door_top - card_bin_door_clearance - card_bin_door_latch_top_margin];

card_magazine_hole_width = card_width + (card_magazine_tolerance * 2);
card_magazine_hole_depth = card_depth + (card_magazine_tolerance * 2);

card_magazine_width = card_width + (card_magazine_tolerance * 2) + (card_magazine_thickness * 2);
card_magazine_depth = card_depth + (card_magazine_tolerance * 2) + (card_magazine_thickness * 2);
card_magazine_height = 360 + card_magazine_thickness_bottom;
card_magazine_door_top = card_magazine_height - base_plate_height - card_magazine_top_flare_height;
card_magazine_door_joint = card_magazine_height * 0.5;
// The sill below the door fills the gap down to the base plate.
card_magazine_door_bottom = base_plate_height;
card_magazine_door_y = [card_magazine_thickness - card_magazine_loading_flare_width - card_magazine_door_rebate, card_magazine_depth - card_magazine_thickness + card_magazine_loading_flare_width + card_magazine_door_rebate];
card_magazine_door_mid_x = card_magazine_thickness - (card_magazine_door_thickness * 0.5);
// The pad, at rest, in the magazine's frame.
card_magazine_pad_face_x = card_magazine_thickness + card_magazine_pad_reach;
card_magazine_pad_back_x = card_magazine_pad_face_x - card_magazine_pad_thickness;
// Flush with the top of the scan plate's walls.
card_magazine_pad_z = [card_magazine_door_top + card_magazine_pad_tolerance, card_magazine_height + card_magazine_hole_scan_wall_height_size];
// The bottom slopes back behind the door, so cards rising off it meet a slope.
card_magazine_pad_bottom_x = card_magazine_thickness - card_magazine_door_slack;
card_magazine_pad_lip_z = card_magazine_door_top - card_magazine_pad_door_overlap_margin - ((card_magazine_pad_face_x - card_magazine_pad_bottom_x) / tan(card_magazine_pad_bottom_angle));
card_magazine_pad_y = card_magazine_depth * 0.5;
// Deep enough for the pad to be pushed back level with the door.
card_magazine_pad_pocket_x = card_magazine_pad_back_x - card_magazine_pad_reach - card_magazine_pad_tolerance;
// The magazine's top flare's outer face, which the bolts go in through.
card_magazine_pad_bolt_x = card_magazine_thickness - (card_magazine_top_flare_width * 0.5);
// As high in the flare as the bolt heads' recesses allow, so the pad's inserts stay clear of its bottom slope.
card_magazine_pad_bolt_z = card_magazine_door_top + card_magazine_top_flare_height - swing_motor_bolt_head_radius - 0.4;
// Midway up the scan plate, so the springs push nearer the middle of the cards against the pad than the bolts hold it.
card_magazine_pad_spring_z = card_magazine_height - (base_plate_height * 0.5);
// Corner of the magazine relative to base_plate_position.
card_magazine_offset = [(base_plate_width * 0.5) - (card_magazine_width * 0.5), (base_plate_depth * 0.5) - (card_magazine_depth * 0.5), 0];
card_magazine_position = base_plate_position + card_magazine_offset + [0, 0, base_plate_height];
scan_plate_position = base_plate_position + [0, 0, card_magazine_height];
// The exit wall of the magazine hole, at the top of the scan plate, relative to the scan plate.
scan_plate_exit_offset = card_magazine_offset + [card_magazine_thickness + card_magazine_hole_width, card_magazine_depth * 0.5, base_plate_height];
// Exit and swing arm parts are modelled from the exit wall, with x pointing out of the magazine.
exit_position = scan_plate_position + scan_plate_exit_offset;
// Moves the limit switch, and the gap in the card stop below its lever, clear of the magazine's indexing peg hole and of
// the swing roller's hub on its way to park.
limit_switch_x_shift = -16;
limit_switch_tab_offset = [(base_plate_width * 0.55) + limit_switch_x_shift, (base_plate_depth * 0.5) + (card_magazine_hole_depth * 0.5), base_plate_height + card_magazine_hole_scan_wall_height_size];
limit_switch_carrier_position = scan_plate_position + limit_switch_tab_offset;
card_bin_position = [-card_bin_offset, 0, extrusion_long_height];
camera_mount_plate_width = base_plate_width * 0.45;
// High enough that the swing roller passes under the LED ring on its way to park.
camera_mount_position = [-extrusion_short_depth - camera_mount_plate_width - extrusion_short_width, 0, extrusion_short_height + card_magazine_height + 82];
camera_mount_camera_center = [camera_mount_camera_x, extrusion_short_width + (base_plate_depth * 0.5)];
led_ring_hole_positions = [for (angle = led_ring_hole_angles) camera_mount_camera_center + polar(led_ring_hole_radius, angle)];
led_ring_spacer_positions = [for (hole = led_ring_hole_positions) camera_mount_position + [hole[0], hole[1], -led_ring_spacer_height]];
camera_lens_position = camera_mount_position + [camera_mount_camera_center[0], camera_mount_camera_center[1], base_plate_height + IMX179_standoff];
// Down to the top of the card stack.
camera_view_depth = camera_lens_position[2] - exit_position[2];
brain_plate_position = [-extrusion_short_depth - (extrusion_short_width * 0.5) + (brain_plate_depth * 0.5), 0, extrusion_long_depth + (extrusion_long_width * 2) + brain_box_mount_bridge];
brain_plate_rotation = [0, 0, 90];
card_mover_bar_mid_height = (card_mover_top_bar_height + card_mover_bottom_bar_height) * 0.5;
card_mover_bottom_bar_offset = card_mover_bottom_bar_height - card_mover_bar_mid_height;
card_mover_top_bar_offset = card_mover_top_bar_height - card_mover_bar_mid_height;
card_mover_position = [-extrusion_short_depth + card_mover_bar_offset - (card_mover_bearing_rod_radius * 0.5), 120, card_mover_bar_mid_height];
card_mover_slide_position = [-extrusion_short_depth, 120, extrusion_short_height + card_magazine_height + base_plate_height];
card_mover_clamp_positions = [for (y = [extrusion_short_width * 0.5, -(extrusion_short_width * 0.5) + card_mover_plate_length], z = [card_mover_top_bar_height, card_mover_bottom_bar_height]) [-extrusion_short_depth + card_mover_bar_offset, y, z]];
card_mover_plate_motor_position = [-extrusion_short_depth - (extrusion_short_height * 0.5) - (extrusion_motor_mount_width * 0.5), -extrusion_motor_mount_height, card_mover_bar_mid_height - (extrusion_motor_mount_depth * 0.5)];
card_mover_plate_spindle_position = [card_mover_plate_motor_position[0], extrusion_long_depth + extrusion_motor_mount_height, card_mover_plate_motor_position[2]];

// Runs to the edge of the scan plate, where cards drop off into the funnel.
exit_insert_length = (base_plate_width * 0.5) + (card_magazine_width * 0.5) - card_magazine_thickness - card_magazine_hole_width;
exit_insert_post_end = exit_insert_length - exit_insert_registration_wall;
exit_insert_post_pocket_start = exit_insert_post_offset - (exit_insert_tolerance * 2);
exit_channel_half_width = card_magazine_hole_depth * 0.5;
// How much wider each side of the channel is at the plate edge than at the exit wall.
exit_channel_flare = exit_insert_length * tan(exit_channel_flare_angle);
// The pocket's walls (the channel plus the insert's tolerance) start tapering this far back from the exit wall, where they
// meet the magazine hole, so the hole widens straight into the V without a step.
exit_channel_lead_in_length = exit_insert_tolerance / tan(exit_channel_flare_angle);
// Between the nip roller's axle, which runs over the posts, and their ends.
exit_insert_screw_x = (exit_nip_x + swing_rod_radius + exit_insert_post_end) * 0.5;
exit_post_top = exit_insert_lip_height + exit_insert_post_height;
exit_nip_tongue_root_x = exit_nip_x + (exit_nip_pad_length * 0.5) + exit_nip_pad_clearance + exit_nip_tongue_wall + exit_nip_tongue_flex_length;
exit_lip_end = exit_insert_length - ((base_plate_height - exit_ramp_edge_thickness + exit_insert_lip_height) / tan(exit_ramp_angle));
exit_insert_lead_in_length = exit_insert_lead_in_height / tan(exit_insert_lead_in_angle);
exit_insert_tip_z = -exit_insert_pocket_depth + exit_insert_tip_height;
exit_insert_ramp_end = exit_lip_end + ((exit_insert_lip_height - exit_insert_tip_z) / tan(exit_ramp_angle));

// The insert's lead-in, lip and ramp, drawn in x/z down to bottom.
function exit_insert_profile(bottom) = [
    [0, bottom],
    [0, exit_insert_lip_height - exit_insert_lead_in_height],
    [exit_insert_lead_in_length, exit_insert_lip_height],
    [exit_lip_end, exit_insert_lip_height],
    [exit_insert_ramp_end, exit_insert_tip_z],
    [exit_insert_ramp_end, bottom]
];

function exit_channel_half_width_at(x) = exit_channel_half_width + (x * tan(exit_channel_flare_angle));
// Posts run alongside the channel at a constant width, so they stay clear of the swing arm's rod supports at the narrow end
// while their screws and springs keep the same wall thickness wherever they sit.
function exit_post_y(x) = exit_channel_half_width_at(x) + (exit_insert_post_width * 0.5);

swing_roller_center = [swing_roller_contact_x, swing_card_top + swing_roller_radius + swing_roller_grip_thickness];
// Slightly close, since load pushes the gears apart by their bore clearances; the backlash stops them binding at rest.
swing_gear_centre_distance = (swing_gear_module * swing_gear_teeth) - 0.1;
// The sun and roller hubs neck in at the gear face to stay inside the idler's tooth tips even when it slides along its
// shoulder, and flare out at 45 degrees so they still print without supports.
swing_hub_neck_radius = swing_gear_centre_distance - (swing_gear_module * ((swing_gear_teeth * 0.5) + 1)) - swing_idler_end_play - 0.2;
swing_idler_center = swing_elbow(swing_shaft, swing_roller_center, swing_gear_centre_distance, swing_gear_centre_distance);
swing_arm_length = norm(swing_roller_center - swing_shaft);
swing_arm_engaged_angle = 360 + atan2(swing_roller_center[1] - swing_shaft[1], swing_roller_center[0] - swing_shaft[0]);
// Parked clear of the light from the LED ring's nearest edge to the card's exit edge, so it neither shows in the image nor
// shadows the card.
swing_light_edge = [camera_lens_position[0] - exit_position[0] + led_ring_outer_radius, camera_mount_position[2] - led_ring_spacer_height - led_ring_thickness - exit_position[2]];
swing_light_normal = [swing_light_edge[1] - swing_card_top, -swing_light_edge[0]] / norm(swing_light_edge - [0, swing_card_top]);
swing_arm_park_rotation = swing_arm_engaged_angle - atan2(swing_light_normal[1], swing_light_normal[0])
    - acos((swing_roller_radius + swing_roller_cast_grip_thickness + swing_arm_park_clearance - (swing_light_normal * (swing_shaft - [0, swing_card_top]))) / swing_arm_length);

swing_idler_phase = swing_mesh_phase(swing_shaft, swing_idler_center, 0);
swing_roller_phase = swing_mesh_phase(swing_idler_center, swing_roller_center, swing_idler_phase);
// The arm's sides are tangent to its hub and end circles, so they lean away from its centre line by this much.

swing_gear_outer_y = swing_gear_inner_y + swing_gear_thickness;
swing_drive_arm_outer_y = swing_gear_outer_y + swing_clutch_groove_depth + swing_arm_thickness;
swing_idle_arm_outer_y = swing_idle_arm_y + swing_arm_thickness;
swing_idler_shoulder_end_y = -swing_gear_inner_y + swing_idler_end_play - swing_idler_shoulder_length;
swing_clutch_collar_y = [-swing_drive_arm_outer_y - swing_clutch_spring_length - swing_clutch_collar_length, -swing_drive_arm_outer_y - swing_clutch_spring_length];
swing_drive_support_y = [swing_clutch_collar_y[0] - swing_clutch_collar_play - swing_support_thickness, swing_clutch_collar_y[0] - swing_clutch_collar_play];
swing_idle_support_y = [swing_idle_arm_outer_y + swing_washer_thickness, swing_idle_arm_outer_y + swing_washer_thickness + swing_support_thickness];

swing_motor_face_y = -(base_plate_depth * 0.5) - extrusion_short_width - 1;

exit_nip_pad_size = [exit_nip_pad_length, swing_roller_length + (exit_nip_pad_overhang * 2), exit_nip_pad_thickness];
exit_nip_tongue_half_width = (exit_nip_pad_size[1] * 0.5) + exit_nip_pad_clearance + exit_nip_tongue_wall;
exit_nip_cut_half_width = exit_nip_tongue_half_width + exit_nip_tongue_slot;
exit_nip_tongue_bottom = exit_insert_lip_height - exit_nip_pad_size[2] - exit_nip_tongue_thickness;
exit_nip_floor_top = exit_nip_tongue_bottom - exit_nip_tongue_travel;
exit_nip_floor_bottom = exit_nip_floor_top - exit_nip_floor_thickness;
exit_nip_bridge_x = [exit_nip_x + (exit_nip_pad_length * 0.5) + exit_nip_pad_clearance + exit_nip_tongue_wall + exit_nip_tongue_slot, exit_nip_tongue_root_x - exit_nip_tongue_slot];
exit_nip_bridge_top = exit_insert_lip_height - exit_nip_tongue_thickness - exit_nip_bridge_clearance;
exit_nip_root_bottom = -base_plate_height + exit_nip_root_floor_thickness;
exit_nip_nut_bottom = exit_nip_root_bottom + exit_nip_nut_floor_thickness;
exit_nip_bolt_x = exit_nip_tongue_root_x + exit_nip_nut_wall + (exit_nip_nut_radius * cos(30));
exit_nip_bolt_y = exit_nip_tongue_half_width - exit_nip_bolt_inset;
// The nip roller's grip is cast this much smaller than the swing roller's, since the built nip pressed the pad in far harder
// than the preload; its axle stays where a full-size grip would give the preload.
nip_roller_grip_reduction = 1;
nip_roller_radius = swing_roller_radius + swing_roller_cast_grip_thickness - nip_roller_grip_reduction;
// Geared up so the nip roller's surface outruns the swing roller's (measured at 22 and 23.5mm across) whatever the casting
// variation, as one holding the card back stalled the motor; outrunning it only slides the card under the swing roller. Both
// gears are profile shifted to mesh at the idler's existing spacing, the nip gear's tips raised to keep the contact ratio.
nip_drive_gear_teeth = 15;
nip_drive_gear_profile_shift = -0.5;
nip_drive_gear_addendum = 0.5;
nip_gear_teeth = 13;
nip_gear_profile_shift = 0.5;
nip_gear_addendum = 1.2;
nip_center = [exit_nip_x, exit_insert_lip_height + nip_roller_radius + nip_roller_grip_reduction - exit_nip_preload];
// The pad pushes the axle up against the tops of its bearings.
nip_bearing_center = nip_center - [0, swing_support_clearance_radius - swing_rod_radius];
nip_bearing_boss_radius = swing_support_clearance_radius + nip_bearing_wall;
nip_idler_center = swing_elbow(nip_center, swing_shaft, swing_gear_centre_distance, swing_gear_centre_distance);
nip_idler_counterbore_depth = nip_idler_shoulder_length - swing_gear_thickness - (swing_idler_end_play * 2);
nip_gear_y = [swing_idle_support_y[1] + swing_idler_end_play, swing_idle_support_y[1] + swing_idler_end_play + swing_gear_thickness];
nip_hub_end_y = nip_gear_y[1] + swing_sun_hub_length;
nip_clamp_start_y = nip_gear_y[1] + swing_sun_clamp_gap;
// The drive gear's clamp sits beyond the nip gear's hub, as the two turn at different speeds and their clamps would meet.
nip_drive_clamp_start_y = nip_hub_end_y + swing_sun_clamp_gap;
nip_drive_hub_end_y = nip_drive_clamp_start_y + nip_hub_end_y - nip_clamp_start_y;
nip_idler_phase = swing_mesh_phase(swing_shaft, nip_idler_center, 0, nip_drive_gear_teeth);
nip_gear_phase = swing_mesh_phase(nip_idler_center, nip_center, nip_idler_phase, swing_gear_teeth, nip_gear_teeth);
nip_pad_cast_tip_x = exit_nip_tongue_wall + exit_nip_tongue_slot;
nip_pad_cast_recess_x = [exit_nip_x - (exit_nip_pad_size[0] * 0.5) - exit_nip_pad_clearance, exit_nip_x + (exit_nip_pad_size[0] * 0.5) + exit_nip_pad_clearance];
nip_pad_cast_recess_half_width = (exit_nip_pad_size[1] * 0.5) + exit_nip_pad_clearance;
nip_pad_cast_stiff_end_x = nip_pad_cast_recess_x[1] + exit_nip_tongue_wall;
nip_pad_cast_inner_half_width = exit_nip_tongue_half_width + nip_pad_cast_clearance;
nip_pad_cast_bolt_x = (nip_pad_cast_tip_x + nip_pad_cast_stiff_end_x) * 0.5;
nip_pad_cast_bolt_y = nip_pad_cast_inner_half_width + exit_screw_clearance_radius + (nip_pad_cast_wall * 0.5);
nip_pad_cast_half_width = nip_pad_cast_bolt_y + swing_roller_mould_nut_radius + (nip_pad_cast_wall * 0.5);
nip_pad_cast_x0 = nip_pad_cast_tip_x - nip_pad_cast_clearance - nip_pad_cast_wall;
nip_pad_cast_lid_top = exit_insert_lip_height + nip_pad_cast_lid_thickness;
nip_pad_cast_floor_bottom = exit_nip_root_bottom - nip_pad_cast_floor_thickness;
// Deep enough that the bolt's end passes right through the nut without reaching the bench.
nip_pad_cast_nut_top = nip_pad_cast_lid_top - nip_pad_cast_bolt_length + swing_roller_mould_nut_depth;
nip_pad_cast_wall_top = exit_nip_tongue_bottom - nip_pad_cast_relief;
nip_roller_hub_end_y = swing_idle_support_y[0] - swing_idler_end_play;
nip_roller_neck_radius = nip_center[1] - exit_post_top - nip_roller_post_clearance;
nip_roller_neck_end_y = exit_channel_half_width_at(nip_center[0] + swing_roller_hub_radius) + exit_insert_post_width + nip_roller_post_clearance;
swing_roller_idle_hub_end_y = swing_idle_arm_y - swing_axle_clamp_length - swing_roller_end_play;

function radiansToDegrees(x) = x * (180.0 / PI);
function easeOutQuad(alpha) = 1 - (1 - alpha) * (1 - alpha);
function easeInSine(alpha) = 1.0 - cos(radiansToDegrees((alpha * PI) / 2.0));
function clamp(a, lower, upper) = (a < lower ? lower : (a > upper ? upper : a));
function lerp(start, end, alpha) = start + ((end - start) * alpha);

module rounded_top_cube(width, depth, height)
{
    rounded_radius = 5;
    hull()
    {
        cube([rounded_radius, depth, rounded_radius]);
        translate([width - rounded_radius, 0, 0]) cube([rounded_radius, depth, rounded_radius]);
        translate([rounded_radius, 0, height - rounded_radius]) rotate([-90, 0, 0]) cylinder(r=rounded_radius, h=depth, $fn=100);
        translate([width - rounded_radius, 0, height - rounded_radius]) rotate([-90, 0, 0]) cylinder(r=rounded_radius, h=depth, $fn=100);
    }
}

// Long piece of extrusion.
module long_extrusion()
{
    color("gray") 
    {
        cube([extrusion_long_width, extrusion_long_depth, extrusion_long_height]);
    }
}

// Short piece of extrusion.
module short_extrusion()
{
    color("gray") 
    {
        cube([extrusion_short_width, extrusion_short_depth, extrusion_short_height]);
    }
}

// Like cylinder(h=height), but a slot for a bolt into an extrusion, elongated along the given axis.
module extrusion_bolt_slot(height, along)
{
    hull() for (side = [-1, 1])
    {
        translate(along * side * (extrusion_bolt_slot_length - extrusion_bolt_slot_width) * 0.5) cylinder(r=extrusion_bolt_slot_width * 0.5, h=height, $fn=100);
    }
}

// Hole for fitting a recessed tbolt. With slot_along, the shank's hole is a slot into an extrusion, along that axis.
module recessed_bolt_hole(recess_amount = 3, slot_along = undef)
{
    translate([0, 0, -tbolt_nut_height - recess_amount + epsilon])
    {
        cylinder(h=tbolt_nut_height + recess_amount, r=tbolt_nut_radius, $fn=tbolt_nut_facets);
        translate([0, 0, -tbolt_shank_height - epsilon])
        {
            if (is_undef(slot_along)) cylinder(h=tbolt_shank_height + (epsilon*2), r=tbolt_shank_radius, $fn=100);
            else extrusion_bolt_slot(tbolt_shank_height + (epsilon * 2), slot_along);
        }
    }
}

// Hole for fitting a tbolt. With slot_along, it's a slot into an extrusion, along that axis.
module bolt_hole(radius, height, slot_along = undef)
{
    translate([0, 0, -height - epsilon])
    {
        if (is_undef(slot_along)) cylinder(h=height + (epsilon * 2), r=radius + tbolt_shank_radius_tolerance, $fn=100);
        else extrusion_bolt_slot(height + (epsilon * 2), slot_along);
    }
}

// Bin that cards are deposited in
module card_bin()
{
    difference()
    {
        // Add a small skew to keep cards flat.
        union()
        {
            union()
            {                
                difference()
                {
                    union()
                    {
                        hull()
                        {
                            // Runs down to the bottom of the base, so the front wall and door continue down beside the chute.
                            translate([card_bin_back_offset + (extrusion_long_height * tan(card_bin_lean)), 0, -extrusion_long_height])
                            {
                                cube([card_bin_width_skewed - card_bin_back_offset, card_bin_depth, 0.001]);
                            }
                            translate([card_bin_back_offset - card_bin_skew_offset, 0, card_bin_height])
                            {
                                cube([card_bin_width_skewed - card_bin_back_offset, card_bin_depth, 0.001]);
                            }
                        }
                        // Base, cut by the chute where it runs down into it.
                        translate([card_bin_offset, 0, 0])
                        {
                            cube([card_bin_back_offset - card_bin_offset, card_bin_depth, 12]);
                        }
                        translate([card_bin_offset + extrusion_long_width, 0, -extrusion_long_height])
                        {
                            cube([-card_bin_offset + card_bin_width - extrusion_long_width - 25, card_bin_depth, 20]);
                        }
                    }
                    union()
                    {
                        // Cut out center, with walls following the bin's lean up from the floor to above its top.
                        hull()
                        {
                            rise = card_bin_height + card_bin_flare_depth - card_bin_floor_low_point[1];
                            translate([0, card_bin_thickness, 0])
                            {
                                for (z = [0, rise])
                                {
                                    translate([card_bin_floor_high_point[0] - (z * tan(card_bin_lean)), 0, card_bin_floor_high_point[1] + z])
                                    {
                                        rotate([0, card_bin_floor_angle, 0]) cube([card_bin_floor_length, card_bin_inner_depth, 0.001]);
                                    }
                                }
                            }
                        }
                        card_bin_flare_cut();
                    }
                }
        
            }

            card_bin_back_ribs();

        }
        union()
        {
            card_bin_door_frame() card_bin_door_pocket();

            // Cut out tbolt holes in the bottom to connect to extrusion
            translate([card_bin_offset + (extrusion_long_width * 0.5), card_bin_depth*0.25, extrusion_long_height])
            {
                recessed_bolt_hole(slot_along=[0, 1, 0]);
            }
            translate([card_bin_offset + (extrusion_long_width * 0.5), card_bin_depth*0.75, extrusion_long_height])
            {
                recessed_bolt_hole(slot_along=[0, 1, 0]);
            }
        }
    }

}

// Flares the top of the bin a bit.
module card_bin_flare_cut()
{
    hull()
    {
        translate([-card_bin_skew_offset, 0, card_bin_height + 2])
        {
            cube([card_bin_width_skewed, card_bin_depth, 0.001]);
        }
        flare_depth = card_bin_depth - 60;
        translate([-card_bin_skew_offset + card_bin_flare_inset[0], (card_bin_depth * 0.5) - (flare_depth * 0.5), card_bin_height - card_bin_flare_depth])
        {
            cube([card_bin_width_skewed - card_bin_flare_inset[0] - card_bin_flare_inset[1], flare_depth, 0.001]);
        }
    }
}

// Rounded ribs running down the back wall, from the floor to where the flare cuts the wall away.
module card_bin_back_ribs()
{
    length = (card_bin_height - card_bin_floor_high_point[1]) / cos(card_bin_lean);
    difference()
    {
        union()
        {
            for (i = [0:card_bin_back_rib_count - 1])
            {
                y = card_bin_thickness + (card_bin_inner_depth * (i + 0.5) / card_bin_back_rib_count);
                translate([card_bin_floor_high_point[0], y, card_bin_floor_high_point[1]]) rotate([0, -card_bin_lean, 0]) cylinder(r=card_bin_back_rib_radius, h=length, $fn=100);
            }
        }
        card_bin_flare_cut();
    }
}

// Tab to connect the magazine halfs together.
function card_bin_to_door_frame(p) = [((p[0] - card_bin_door_origin[0]) * cos(card_bin_lean)) + (p[1] * sin(card_bin_lean)), ((card_bin_door_origin[0] - p[0]) * sin(card_bin_lean)) + (p[1] * cos(card_bin_lean))];

module card_bin_door_frame()
{
    translate(card_bin_door_origin) rotate(card_bin_door_rotation) children();
}

// Repeats a feature modelled at the door's low-y edge onto its high-y edge.
module card_bin_door_both_sides()
{
    for (side = [0, 1])
    {
        translate([0, card_bin_depth * side, 0]) mirror([0, side, 0]) children();
    }
}

// A catch bump on the outer face of the door's low-y edge. Bump and groove share a centre, so the door has play up and down.
module card_bin_door_latch_bump(radius, length)
{
    translate([-card_bin_door_thickness * 0.5, card_bin_door_y[0] + card_bin_door_clearance + card_bin_door_latch_bump_radius - card_bin_door_latch_bump_height, card_bin_door_latch_u[1] - 3 - ((card_bin_door_latch_bump_length + length) * 0.5)])
    {
        cylinder(r=radius, h=length, $fn=100);
    }
}

// Cut from the bin, in the door's frame: the opening, the recess its bottom tongue hooks into, and the grooves its catches click into.
module card_bin_door_pocket()
{
    translate([-card_bin_door_thickness, card_bin_door_y[0], card_bin_door_bottom])
    {
        cube([card_bin_door_thickness + epsilon, card_bin_door_y[1] - card_bin_door_y[0], card_bin_door_top - card_bin_door_bottom]);
    }
    translate([-card_bin_door_thickness - card_bin_door_tongue_swing, card_bin_door_y[0], card_bin_door_bottom - card_bin_door_tongue_length - card_bin_door_clearance])
    {
        cube([card_bin_door_tongue_swing + (card_bin_door_thickness * 0.5), card_bin_door_y[1] - card_bin_door_y[0], card_bin_door_tongue_length + card_bin_door_clearance + epsilon]);
    }
    // The tongue's inner face swings in as the door tilts, so the recess runs up behind the door to just under the card floor.
    translate([-card_bin_door_thickness - card_bin_door_tongue_swing, card_bin_door_y[0], card_bin_door_bottom - epsilon])
    {
        cube([card_bin_door_tongue_swing + epsilon, card_bin_door_y[1] - card_bin_door_y[0], card_bin_door_floor_margin - 0.5]);
    }
    card_bin_door_both_sides() card_bin_door_latch_bump(card_bin_door_latch_bump_radius + card_bin_door_latch_groove_clearance, card_bin_door_latch_bump_length + 2);
    // The inside of the front wall isn't quite parallel to the outside, so clear what's left behind the door across
    // the card space, starting above the floor. The side rebates keep their backs to stop the door.
    translate([-card_bin_door_thickness - card_bin_door_skin_cut, card_bin_thickness, card_bin_door_bottom + card_bin_door_floor_margin + 2])
    {
        cube([card_bin_door_skin_cut + epsilon, card_bin_inner_depth, card_bin_door_top - card_bin_door_bottom - card_bin_door_floor_margin - 2]);
    }
}

// Tilts out about the tongue at its bottom and lifts off. Each catch is a sprung finger with a bump on it, freed by slots cut through the door.
module card_bin_door()
{
    width = card_bin_door_y[1] - card_bin_door_y[0] - (card_bin_door_clearance * 2);
    y0 = card_bin_door_y[0] + card_bin_door_clearance;
    handle_z = card_bin_door_top - card_bin_door_clearance - door_handle_inset;

    difference()
    {
        union()
        {
            translate([-card_bin_door_thickness, y0, card_bin_door_bottom])
            {
                cube([card_bin_door_thickness, width, card_bin_door_top - card_bin_door_bottom - card_bin_door_clearance]);
            }
            translate([-card_bin_door_thickness, y0, card_bin_door_bottom - card_bin_door_tongue_length])
            {
                cube([card_bin_door_tongue_thickness, width, card_bin_door_tongue_length + epsilon]);
            }
        }
        hull()
        {
            for (u = [card_bin_door_bottom + card_bin_door_window_margin, door_window_top(handle_z)])
            {
                translate([epsilon, card_bin_depth * 0.5, u]) rotate([0, -90, 0]) cylinder(r=card_bin_door_window_radius, h=card_bin_door_thickness + (epsilon * 2), $fn=100);
            }
        }
        card_bin_door_both_sides()
        {
            // Slot along the inside of the finger, and across its free end.
            translate([-card_bin_door_thickness - epsilon, y0 + card_bin_door_latch_width, card_bin_door_latch_u[0]])
            {
                cube([card_bin_door_thickness + (epsilon * 2), card_bin_door_latch_gap, card_bin_door_latch_length + card_bin_door_latch_gap]);
            }
            translate([-card_bin_door_thickness - epsilon, y0 - epsilon, card_bin_door_latch_u[1]])
            {
                cube([card_bin_door_thickness + (epsilon * 2), card_bin_door_latch_width + card_bin_door_latch_gap + epsilon, card_bin_door_latch_gap]);
            }
        }
    }
    translate([0, (card_bin_door_y[0] + card_bin_door_y[1]) * 0.5, 0]) mirror([1, 0, 0]) door_handle(handle_z);
    card_bin_door_both_sides()
    {
        intersection()
        {
            card_bin_door_latch_bump(card_bin_door_latch_bump_radius, card_bin_door_latch_bump_length);
            // Only the bump's outside and the finger it sits on, so it doesn't bridge the slot behind the finger.
            translate([-card_bin_door_thickness, y0 - card_bin_door_latch_bump_height, card_bin_door_latch_u[0]]) cube([card_bin_door_thickness, card_bin_door_latch_bump_height + card_bin_door_latch_width, card_bin_door_latch_length]);
        }
    }
}

module card_magazine_tab(width = card_magazine_tab_width)
{
    cube([width, card_magazine_tab_depth, card_magazine_tab_height]);
    hull()
    {
        translate([0, card_magazine_tab_depth*0.5, 0])
        {
            rotate([0, 90, 0]) cylinder(r=card_magazine_tab_depth*0.5, h=width, $fn=100);
        }                    
        translate([0, card_magazine_tab_depth * 1.5, -20])
        {
            rotate([0, 90, 0]) cylinder(r=card_magazine_tab_depth*0.5, h=width, $fn=100);
        }  
    }    
}

// Holes to connect the magazine tabs.
module card_magazine_tab_hole()
{
    translate([card_magazine_tab_width * 0.5, card_magazine_tab_depth + card_magazine_thickness, card_magazine_tab_height - 5]) 
    {
        rotate([-90, 0, 0])
        {
            recessed_bolt_hole();
        }
    }
}

// Pegs used for indexing the top and bottom of the card magazine.
module card_magazine_indexing_pegs(size, height)
{        
    translate([card_magazine_index_insert, (card_magazine_thickness * 0.5), (card_magazine_height * 0.5) + (size * 0.5)])
    {
        cube([size, size, height], center=true);
    }                    
    translate([card_magazine_index_insert, card_magazine_depth - (card_magazine_thickness * 0.5), (card_magazine_height * 0.5) + (size * 0.5)])
    {
        cube([size, size, height], center=true);
    }
    translate([card_magazine_width * 0.53, (card_magazine_thickness * 0.5), (card_magazine_height * 0.5) + (size * 0.5)])
    {
        cube([size, size, height], center=true);
    }
    translate([card_magazine_width * 0.53, card_magazine_depth -(card_magazine_thickness * 0.5), (card_magazine_height * 0.5) + (size * 0.5)])
    {
        cube([size, size, height], center=true);
    }        
    translate([card_magazine_width - card_magazine_thickness - card_magazine_index_insert + 1, (card_magazine_thickness * 0.5), (card_magazine_height * 0.5) + (size * 0.5)])
    {
        cube([size, size, height], center=true);
    }
    translate([card_magazine_width - card_magazine_thickness - card_magazine_index_insert + 1, card_magazine_depth - (card_magazine_thickness * 0.5), (card_magazine_height * 0.5) + (size * 0.5)])
    {
        cube([size, size, height], center=true);
    }
}
// Pegs used for indexing the top of the magazine with the scan plate
module card_magazine_indexing_top_pegs(size, height)
{        
    translate([card_magazine_index_insert, (card_magazine_thickness * 0.5), (card_magazine_height * 0.5) + (size * 0.5)])
    {
        cube([size, size, height], center=true);
    }                    
    translate([card_magazine_index_insert, card_magazine_depth - (card_magazine_thickness * 0.5), (card_magazine_height * 0.5) + (size * 0.5)])
    {
        cube([size, size, height], center=true);
    }
    translate([card_magazine_width * 0.566, (card_magazine_thickness * 0.5), (card_magazine_height * 0.5) + (size * 0.5)])
    {
        cube([size, size, height], center=true);
    }
    translate([card_magazine_width * 0.566, card_magazine_depth -(card_magazine_thickness * 0.5), (card_magazine_height * 0.5) + (size * 0.5)])
    {
        cube([size, size, height], center=true);
    }   
}
// Pegs used for indexing the bottom of the magazine with the bottom plate
module card_magazine_indexing_bottom_pegs(size, height)
{        
    translate([card_magazine_index_insert, (card_magazine_thickness * 0.5), -height*0.5])
    {
        cube([size, size, height], center=true);
    }                    
    translate([card_magazine_index_insert, card_magazine_depth - (card_magazine_thickness * 0.5), -height*0.5])
    {
        cube([size, size, height], center=true);
    }
    translate([card_magazine_width * 0.82, (card_magazine_thickness * 0.5), -height*0.5])
    {
        cube([size, size, height], center=true);
    }
    translate([card_magazine_width * 0.82, card_magazine_depth -(card_magazine_thickness * 0.5), -height*0.5])
    {
        cube([size, size, height], center=true);
    }   
}

// Magazine that cards start in
module card_magazine(top, bottom)
{
    // The main body of the bin
    difference()
    {
        union()
        {
            card_magazine_door_frame(top, bottom);
            translate([card_magazine_thickness + epsilon, 0, 0])
            {    
                if (bottom)
                {        
                    union() cube([card_magazine_width - card_magazine_thickness + (epsilon * 2), card_magazine_depth, card_magazine_height * 0.5]);
                }
                if (top)
                {        
                    translate([0, 0, card_magazine_height * 0.5])
                    {
                        union() cube([card_magazine_width - card_magazine_thickness + (epsilon * 2), card_magazine_depth, (card_magazine_height * 0.5) - base_plate_height - epsilon]);
                    }
                }
            
                if (top)
                {
                    translate([-card_magazine_top_flare_width*0.5, -card_magazine_top_flare_depth*0.5, card_magazine_height - base_plate_height - card_magazine_top_flare_height])
                    {
                        union() cube([card_magazine_width - card_magazine_thickness + (epsilon * 2) + card_magazine_top_flare_width, card_magazine_depth + card_magazine_top_flare_depth, card_magazine_top_flare_height]);
                    }
                }
            
                // Tabs on the side we use to screw the two halfs together.
                if (bottom)
                {    
                    union() difference()
                    {
                        union()
                        {
                            translate([card_magazine_width * 0.1, -card_magazine_tab_depth, (card_magazine_height * 0.5) - (card_magazine_tab_height * 0.5)])
                            {
                                card_magazine_tab();
                            }
                            translate([card_magazine_width * 0.6, -card_magazine_tab_depth, (card_magazine_height * 0.5) - (card_magazine_tab_height * 0.5)])
                            {
                                card_magazine_tab();
                            }
                            translate([(card_magazine_width * 0.1) + card_magazine_tab_width, card_magazine_depth + card_magazine_tab_depth, (card_magazine_height * 0.5) - (card_magazine_tab_height * 0.5)])
                            {
                                rotate([0, 0, 180]) card_magazine_tab();
                            }
                            translate([(card_magazine_width * 0.6) + card_magazine_tab_width, card_magazine_depth + card_magazine_tab_depth, (card_magazine_height * 0.5) - (card_magazine_tab_height * 0.5)])
                            {
                                rotate([0, 0, 180]) card_magazine_tab();
                            }
                        }
                        union()
                        {                        
                            translate([0, 0, card_magazine_height * 0.5])
                            {
                                union() cube([card_magazine_width - card_magazine_thickness + (epsilon * 2), card_magazine_depth, card_magazine_height * 0.5]);
                            }
                        }
                    }
                
                    // Add indexing pegs.
                    card_magazine_indexing_pegs(card_magazine_index_size, card_magazine_index_height);
                }
            
                // Indexing pegs for the scan board            
                if (top)
                {    
                    translate([0, 0, (card_magazine_height * 0.5) - base_plate_height])
                    {
                        union() card_magazine_indexing_top_pegs(card_magazine_index_size, card_magazine_index_height + 5);
                    }
                }
            
                // Indexing pegs for the base board            
                if (bottom)
                {    
                    union() card_magazine_indexing_bottom_pegs(card_magazine_index_size, card_magazine_index_height);
                }
            }
        }
        union()
        {
            card_magazine_width_plus_thresholds = card_width + (card_magazine_tolerance * 2);
            card_magazine_depth_plus_thresholds = card_depth + (card_magazine_tolerance * 2);

            card_magazine_door_tongue_recess(card_magazine_door_bottom);
            card_magazine_door_both_sides()
            {
                card_magazine_door_latch_bump(card_magazine_door_joint, card_bin_door_latch_bump_radius + card_bin_door_latch_groove_clearance, card_bin_door_latch_bump_length + 2);
                card_magazine_door_latch_bump(card_magazine_door_top - card_magazine_door_clearance, card_bin_door_latch_bump_radius + card_bin_door_latch_groove_clearance, card_bin_door_latch_bump_length + 2);
            }
                        
            // Cut out peg holes
            if (top)
            {
                translate([card_magazine_thickness + epsilon, 0, -epsilon])
                {    
                    card_magazine_indexing_pegs(card_magazine_index_size + card_magazine_index_tolerance, card_magazine_index_height + card_magazine_index_tolerance);
                }
            }
                        
            // Cut holes out for connecting the magazine.
            translate([card_magazine_thickness + epsilon, 0, 0])
            {    
                translate([card_magazine_width * 0.1, -card_magazine_tab_depth, (card_magazine_height * 0.5) - (card_magazine_tab_height * 0.5)])
                {
                    card_magazine_tab_hole();
                }
                translate([card_magazine_width * 0.6, -card_magazine_tab_depth, (card_magazine_height * 0.5) - (card_magazine_tab_height * 0.5)])
                {
                    card_magazine_tab_hole();
                }
                translate([(card_magazine_width * 0.1) + card_magazine_tab_width, card_magazine_depth + card_magazine_tab_depth, (card_magazine_height * 0.5) - (card_magazine_tab_height * 0.5)])
                {
                    rotate([0, 0, 180]) card_magazine_tab_hole();
                }
                translate([(card_magazine_width * 0.6) + card_magazine_tab_width, card_magazine_depth + card_magazine_tab_depth, (card_magazine_height * 0.5) - (card_magazine_tab_height * 0.5)])
                {
                    rotate([0, 0, 180]) card_magazine_tab_hole();
                }
            }
            
            // Cut screw holes out of the top.   
            translate([card_magazine_thickness + epsilon, 0, 0])
            {         
                translate([-card_magazine_top_flare_width*0.5, -card_magazine_top_flare_depth*0.5, card_magazine_height - base_plate_height - card_magazine_top_flare_height])
                {
                    translate([card_magazine_top_flare_width*0.25, card_magazine_top_flare_depth*0.25, base_plate_height + card_magazine_top_flare_height])
                    {
                        bolt_hole(tbolt_shank_radius, 30);
                    }
                    translate([card_magazine_width + (card_magazine_top_flare_width*0.25), card_magazine_top_flare_depth*0.25, base_plate_height + card_magazine_top_flare_height])
                    {
                        bolt_hole(tbolt_shank_radius, 30);
                    }
                    translate([card_magazine_top_flare_width*0.25, card_magazine_depth + (card_magazine_top_flare_depth*0.75), base_plate_height + card_magazine_top_flare_height])
                    {
                        bolt_hole(tbolt_shank_radius, 30);
                    }
                    translate([card_magazine_width + (card_magazine_top_flare_width*0.25), card_magazine_depth + (card_magazine_top_flare_depth*0.75), base_plate_height + card_magazine_top_flare_height])
                    {
                        bolt_hole(tbolt_shank_radius, 30);
                    }
                }
            }
            
            if (top)
            {
                card_magazine_pad_pocket();
            }

            // Cut the middle out
            difference()
            {
                translate([card_magazine_thickness, card_magazine_thickness, card_magazine_floor_thickness])
                {
                    cube([card_width + (card_magazine_tolerance * 2), card_depth + (card_magazine_tolerance * 2), card_magazine_height + card_magazine_tolerance - card_magazine_floor_thickness]);
                }
                card_magazine_floor_fillet();
            }
                        
            card_magazine_loading_flare();
            card_magazine_window();

            // Cut the sides out.
            translate([(card_magazine_width_plus_thresholds * 0.5) - (card_magazine_lifter_cutout_size * 0.5) + card_magazine_thickness, -epsilon, card_magazine_thickness_bottom])
            {
                cube([card_magazine_lifter_cutout_size, card_depth + (epsilon*2) + (card_magazine_tolerance * 2) + (card_magazine_thickness * 2), card_magazine_height - card_magazine_thickness_bottom - card_magazine_thickness_bottom]);
            }
        }
    }
}

// The side walls' ends either side of the door, and the sill below it.
module card_magazine_door_frame(top, bottom)
{
    x0 = card_magazine_thickness - card_magazine_door_thickness;
    width = card_magazine_door_thickness + (epsilon * 2);
    if (bottom)
    {
        translate([x0, 0, 0])
        {
            union() cube([width, card_magazine_depth, card_magazine_door_bottom]);
        }
        union() card_magazine_door_both_sides() translate([x0, 0, 0]) cube([width, card_magazine_door_y[0], card_magazine_door_joint]);
    }
    if (top)
    {
        union() card_magazine_door_both_sides()
        {
            translate([x0, 0, card_magazine_door_joint]) cube([width, card_magazine_door_y[0], card_magazine_door_joint - base_plate_height - epsilon]);
        }
    }
}

// Repeats a feature modelled at the door's low-y edge onto its high-y edge.
module card_magazine_door_both_sides()
{
    for (side = [0, 1])
    {
        translate([0, card_magazine_depth * side, 0]) mirror([0, side, 0]) children();
    }
}

// The finger that catches a door half shut runs down from latch_top. The same bump, grown, is the groove it catches in.
function card_magazine_door_latch_top(half_top) = half_top - card_bin_door_latch_top_margin;

// A catch bump on the low-y edge of the door half whose top is at half_top. Bump and groove share a centre, so the door
// has play up and down.
module card_magazine_door_latch_bump(half_top, radius, length)
{
    translate([card_magazine_door_mid_x, card_magazine_door_y[0] + card_magazine_door_clearance + card_bin_door_latch_bump_radius - card_bin_door_latch_bump_height, card_magazine_door_latch_top(half_top) - 3 - ((card_bin_door_latch_bump_length + length) * 0.5)])
    {
        cylinder(r=radius, h=length, $fn=100);
    }
}

// Where a door half's tongue hooks in, below z, with room behind it to swing in as the half tilts out.
module card_magazine_door_tongue_recess(z)
{
    translate([card_magazine_door_mid_x, card_magazine_thickness, z - card_magazine_door_tongue_length - card_magazine_door_clearance])
    {
        cube([(card_magazine_door_thickness * 0.5) + card_bin_door_tongue_swing, card_magazine_hole_depth, card_magazine_door_tongue_length + card_magazine_door_clearance + epsilon]);
    }
}

card_magazine_door_tab_y = card_magazine_door_y[0] + card_magazine_door_clearance + card_magazine_door_tab_inset;
card_magazine_door_tab_bolt_z = card_magazine_door_joint + (card_magazine_tab_height * 0.5) - 5;

// The tab on the door's low-y edge, on the bottom half and lapping over the top half's outer face.
module card_magazine_door_tab()
{
    translate([card_magazine_thickness - card_magazine_door_thickness - card_magazine_tab_depth, card_magazine_door_tab_y - (card_magazine_door_tab_width * 0.5), card_magazine_door_joint - (card_magazine_tab_height * 0.5)])
    {
        rotate([0, 0, 90]) mirror([0, 1, 0]) card_magazine_tab(card_magazine_door_tab_width);
    }
}

// Centre of the rounded top of the window below a handle whose top is at z.
function door_window_top(handle_z) = handle_z - door_handle_thickness - door_handle_lip - door_window_handle_margin - card_bin_door_window_radius;

// On a door's outer face at x = 0, reaching out along -x, centred on y = 0 with its top at z.
module door_handle(z)
{
    reach = door_handle_reach;
    thickness = door_handle_thickness;
    lip = door_handle_lip;
    lean = tan(door_handle_lip_angle);
    y0 = -door_handle_width * 0.5;
    // Where the lip's inside meets the ledge, so the lip is as thick as the ledge.
    inner_x = -reach + (thickness * (1 - sin(door_handle_lip_angle)) / cos(door_handle_lip_angle));

    xz_extrude(y0, y0 + door_handle_width)
    {
        polygon([
            [epsilon, z],
            [-reach, z],
            [-reach - ((thickness + lip) * lean), z - thickness - lip],
            [inner_x - (lip * lean), z - thickness - lip],
            [inner_x, z - thickness],
            [epsilon, z - thickness]
        ]);
    }
    // Fillet where the handle joins the door. base_fillet() rises along z, so turn that to point out of the door.
    rotate([0, -90, 0])
    {
        base_fillet(door_handle_fillet_radius) translate([z - thickness, y0]) square([thickness, door_handle_width]);
    }
}

// One half of the door, between z0 and z1, with its tongue below z0 and its catches near z1. Each catch is a sprung finger
// with a bump on it, freed by slots cut through the door.
module card_magazine_door_half(z0, z1)
{
    x0 = card_magazine_thickness - card_magazine_door_thickness;
    y0 = card_magazine_door_y[0] + card_magazine_door_clearance;
    latch_top = card_magazine_door_latch_top(z1);
    latch_bottom = latch_top - card_bin_door_latch_length;

    difference()
    {
        union()
        {
            translate([x0, y0, z0])
            {
                cube([card_magazine_door_thickness, card_magazine_door_y[1] - card_magazine_door_y[0] - (card_magazine_door_clearance * 2), z1 - z0]);
            }
            translate([card_magazine_door_mid_x + card_magazine_door_clearance, card_magazine_thickness + card_magazine_door_clearance, z0 - card_magazine_door_tongue_length])
            {
                cube([(card_magazine_door_thickness * 0.5) - card_magazine_door_clearance, card_magazine_hole_depth - (card_magazine_door_clearance * 2), card_magazine_door_tongue_length + epsilon]);
            }
        }
        hull()
        {
            for (z = [z0 + card_bin_door_window_margin, door_window_top(z1 - door_handle_inset)])
            {
                translate([x0 - epsilon, card_magazine_depth * 0.5, z]) rotate([0, 90, 0]) cylinder(r=card_bin_door_window_radius, h=card_magazine_door_thickness + (epsilon * 2), $fn=100);
            }
        }
        card_magazine_door_both_sides()
        {
            // Slot along the inside of the finger, and across its free end.
            translate([x0 - epsilon, y0 + card_bin_door_latch_width, latch_bottom])
            {
                cube([card_magazine_door_thickness + (epsilon * 2), card_bin_door_latch_gap, card_bin_door_latch_length + card_bin_door_latch_gap]);
            }
            translate([x0 - epsilon, y0 - epsilon, latch_top])
            {
                cube([card_magazine_door_thickness + (epsilon * 2), card_bin_door_latch_width + card_bin_door_latch_gap + epsilon, card_bin_door_latch_gap]);
            }
        }
    }
    card_magazine_door_both_sides()
    {
        intersection()
        {
            card_magazine_door_latch_bump(z1, card_bin_door_latch_bump_radius, card_bin_door_latch_bump_length);
            // Only the bump's outside and the finger it sits on, so it doesn't bridge the slot behind the finger.
            translate([x0, y0 - card_bin_door_latch_bump_height, latch_bottom]) cube([card_magazine_door_thickness, card_bin_door_latch_bump_height + card_bin_door_latch_width, card_bin_door_latch_length]);
        }
    }
}

// Fillet where the side and back walls meet the floor; the door side is open. Profiled like base_fillet(). It stops short of
// the door, so the door's tongue can swing in as it's lifted out.
module card_magazine_floor_fillet()
{
    steps = 16;
    slice = 0.01;
    radius = card_magazine_floor_fillet_radius;
    function flare(i) = radius * (1 - sin(90 * i / steps));
    function height(i) = radius * (1 - cos(90 * i / steps));

    translate([card_magazine_thickness, card_magazine_thickness, card_magazine_floor_thickness])
    {
        difference()
        {
            translate([card_bin_door_tongue_swing, 0, 0]) cube([card_magazine_hole_width - card_bin_door_tongue_swing, card_magazine_hole_depth, radius]);
            for (i = [0:steps - 1])
            {
                hull()
                {
                    for (j = [i, i + 1])
                    {
                        translate([-epsilon, flare(j), height(j) - (j == 0 ? epsilon : 0)])
                        {
                            cube([card_magazine_hole_width + epsilon - flare(j), card_magazine_hole_depth - (flare(j) * 2), slice + (j == 0 ? epsilon : 0)]);
                        }
                    }
                }
            }
        }
    }
}

// Up the back wall, to see how full the magazine is. It stops short of the top, where the pad presses the cards against
// the wall.
module card_magazine_window()
{
    hull()
    {
        for (z = [card_magazine_floor_thickness + card_bin_door_window_margin, card_magazine_door_top - card_bin_door_window_margin])
        {
            translate([card_magazine_thickness + card_magazine_hole_width - epsilon, card_magazine_depth * 0.5, z])
            {
                rotate([0, 90, 0]) cylinder(r=card_bin_door_window_radius, h=card_magazine_thickness + (epsilon * 5), $fn=100);
            }
        }
    }
}

module card_magazine_loading_flare()
{
    length = card_magazine_loading_flare_width / tan(card_magazine_loading_flare_angle);
    for (side = [0, 1])
    {
        translate([0, card_magazine_depth * side, card_magazine_thickness_bottom])
        {
            mirror([0, side, 0])
            {
                linear_extrude(card_magazine_height)
                {
                    polygon([
                        [card_magazine_thickness - epsilon, card_magazine_thickness + epsilon],
                        [card_magazine_thickness - epsilon, card_magazine_thickness - card_magazine_loading_flare_width],
                        [card_magazine_thickness + length, card_magazine_thickness + epsilon]
                    ]);
                }
            }
        }
    }
}

// Door for card magazine.
module card_magazine_door(top, bottom)
{    
    difference()
    {
        union()
        {
            if (bottom)
            {
                card_magazine_door_half(card_magazine_door_bottom, card_magazine_door_joint);
                union() card_magazine_door_both_sides() card_magazine_door_tab();
            }
            if (top)
            {
                card_magazine_door_half(card_magazine_door_joint, card_magazine_door_top - card_magazine_door_clearance);
                translate([card_magazine_thickness - card_magazine_door_thickness, (card_magazine_door_y[0] + card_magazine_door_y[1]) * 0.5, 0]) door_handle(card_magazine_door_top - card_magazine_door_clearance - door_handle_inset);
            }
        }
        card_magazine_door_both_sides()
        {
            translate([card_magazine_thickness, card_magazine_door_tab_y, card_magazine_door_tab_bolt_z])
            {
                rotate([0, 90, 0]) recessed_bolt_hole(card_magazine_door_tab_bolt_recess);
            }
        }
        if (bottom)
        {
            card_magazine_door_tongue_recess(card_magazine_door_joint);
        }
        if (top)
        {
            notch_x = card_magazine_pad_bottom_x - card_magazine_pad_reach - card_magazine_pad_tolerance;
            notch_half_width = (card_magazine_pad_width * 0.5) + card_magazine_pad_tolerance;
            notch_bottom = card_magazine_pad_lip_z - card_magazine_pad_tolerance;
            translate([notch_x, card_magazine_pad_y - notch_half_width, notch_bottom])
            {
                cube([card_magazine_thickness + epsilon - notch_x, notch_half_width * 2, card_magazine_door_top + epsilon - notch_bottom]);
            }
        }
    }
}

// Springs in the scan plate push it against the cards; bolts in through the magazine's top flare into its inserts set how
// far it reaches when there are none. Modelled at rest, in the magazine's frame.
module card_magazine_pad()
{
    z0 = card_magazine_pad_z[0];
    z1 = card_magazine_pad_z[1];

    union() difference()
    {
        xz_extrude(card_magazine_pad_y - (card_magazine_pad_width * 0.5), card_magazine_pad_y + (card_magazine_pad_width * 0.5))
        {
            polygon([
                [card_magazine_pad_back_x, z0],
                [card_magazine_pad_bottom_x, z0],
                [card_magazine_pad_bottom_x, card_magazine_pad_lip_z],
                [card_magazine_pad_face_x, card_magazine_pad_lip_z + ((card_magazine_pad_face_x - card_magazine_pad_bottom_x) / tan(card_magazine_pad_bottom_angle))],
                [card_magazine_pad_face_x, z1],
                [card_magazine_pad_back_x, z1]
            ]);
        }
        for (side = [-1, 1])
        {
            translate([card_magazine_pad_back_x - epsilon, card_magazine_pad_y + (side * card_magazine_pad_bolt_spacing * 0.5), card_magazine_pad_bolt_z])
            {
                rotate([0, 90, 0]) cylinder(r=exit_threaded_insert_radius, h=exit_threaded_insert_depth + epsilon, $fn=100);
            }
            translate([card_magazine_pad_back_x - epsilon, card_magazine_pad_y + (side * card_magazine_pad_spring_spacing * 0.5), card_magazine_pad_spring_z])
            {
                rotate([0, 90, 0]) cylinder(r=exit_spring_radius, h=card_magazine_pad_spring_seat_depth + epsilon, $fn=100);
            }
        }
    }
}

// Cut from the magazine's top and the scan plate, in the magazine's frame: the pad's pocket, open below to the door and
// above, and its bolt and spring holes.
module card_magazine_pad_pocket()
{
    half_width = (card_magazine_pad_width * 0.5) + card_magazine_pad_tolerance;
    translate([card_magazine_pad_pocket_x, card_magazine_pad_y - half_width, card_magazine_door_top - epsilon])
    {
        cube([card_magazine_thickness + epsilon - card_magazine_pad_pocket_x, half_width * 2, card_magazine_pad_z[1] - card_magazine_door_top + (epsilon * 2)]);
    }
    // Above the plate, the card stop along the wall overhangs the hole where the pad now stands.
    translate([card_magazine_pad_pocket_x, card_magazine_pad_y - half_width, card_magazine_height - epsilon])
    {
        cube([card_magazine_thickness + card_magazine_hole_scan_wall_size - card_magazine_pad_pocket_x, half_width * 2, card_magazine_hole_scan_wall_height_size + (epsilon * 2)]);
    }
    for (side = [-1, 1])
    {
        translate([card_magazine_pad_bolt_x - epsilon, card_magazine_pad_y + (side * card_magazine_pad_bolt_spacing * 0.5), card_magazine_pad_bolt_z])
        {
            rotate([0, 90, 0])
            {
                cylinder(r=exit_screw_clearance_radius, h=card_magazine_pad_pocket_x - card_magazine_pad_bolt_x + (epsilon * 2), $fn=100);
                cylinder(r=swing_motor_bolt_head_radius, h=swing_motor_bolt_head_depth + epsilon, $fn=100);
            }
        }
        translate([card_magazine_pad_pocket_x - exit_spring_depth, card_magazine_pad_y + (side * card_magazine_pad_spring_spacing * 0.5), card_magazine_pad_spring_z])
        {
            rotate([0, 90, 0]) cylinder(r=exit_spring_radius, h=exit_spring_depth + epsilon, $fn=100);
        }
    }
}

// Lifter that attachs to the lead screw to lift cards up.
module card_lifter(lifter, top)
{
    lifter_depth = base_plate_depth;

    translate([card_magazine_thickness + card_magazine_tolerance, card_magazine_thickness + card_magazine_tolerance, card_magazine_thickness_bottom])
    {
        difference()
        {
            union()
            {
                // Main card plate - base_plate_height added so the top rises above the scan plate.
                translate([0, 0, card_magazine_lifter_height - (base_plate_height * 0.5)])
                {
                    if (lifter)
                    {
                        union() cube([card_width, card_depth, base_plate_height * 0.5]);
                    }
                }
                translate([0, 0, card_magazine_lifter_height])
                {
                    if (top)
                    {
                        union() cube([card_width, card_depth, card_magazine_thickness_bottom]);                
                    }
                }                
                
                if (lifter)
                {
                    // Arms
                    translate([(card_width*0.5) - (card_magazine_lifter_arm_width * 0.5), (card_depth*0.5) - (lifter_depth*0.5), 0])
                    {
                        arm_depth = lifter_depth - (card_magazine_lifter_hand_depth * 2) + 10;
                        
                        translate([0, 3 + card_magazine_lifter_hand_depth - card_magazine_lifter_rod_plate_depth + bearing_rod_bearing_bearing_to_base_offset - 10, 0])
                        {
                            union() cube([card_magazine_lifter_arm_width, arm_depth - 3, card_magazine_lifter_height]);
                        }
                        
                        // Lead screw plate            
                        translate([(card_magazine_lifter_arm_width*0.5) - (card_magazine_lifter_hand_width*0.5), card_magazine_lifter_lead_rod_plate_offset, 0])
                        {
                            translate([card_magazine_lifter_hand_width*0.5, card_magazine_lifter_hand_width*0.5 - 1.5, 0])
                            {
                                difference()
                                {
                                    union() cylinder(r=card_magazine_lifter_hand_width*0.5, h=card_magazine_lifter_height);     
                                    translate([0, 0, -epsilon])                               
                                    {
                                        union() cylinder(r=card_magazine_lifter_hand_width*0.4, h=card_magazine_lifter_height * 0.5);
                                    }
                                }
                            }
                        }           
                    }
                }
            }
            union()
            {
                // Bolt holes
                translate([0, 0, card_magazine_lifter_height + card_magazine_thickness_bottom])
                {
                    translate([card_width - 10, card_depth - 10, 0])
                    {
                        recessed_bolt_hole();
                    }         
                    translate([10, card_depth - 10, 0])
                    {
                        recessed_bolt_hole();
                    }   
                    translate([card_width - 10, 10, 0])
                    {
                        recessed_bolt_hole();
                    }         
                    translate([10, 10, 0])
                    {
                        recessed_bolt_hole();
                    }         
                }       
            }
        }
    }   
    
    // Rod plate            
    union() translate(-card_magazine_offset) // Cancel out magazine lifters offset to get into base plate space
    {
        translate([(base_plate_width / 2) - (stepping_motor_width/2), base_plate_depth - stepping_motor_depth, 0])
        {
            translate([stepping_motor_width/2, stepping_motor_depth/2, 0])
            {
                translate([0, 0, card_magazine_thickness_bottom])
                {
                    if (lifter)
                    {
                        bearing_mount();
                    }
                }
            }
        }
    }           
}

// Holes required for the lead screen and rod to pass through everything
module rod_holes(large_lead_screw_radius)
{
    translate([0, 0, base_plate_height])
    {
        motor_width_plus_threshold = stepping_motor_width + (stepping_motor_tolerance * 2);
        motor_depth_plus_threshold = stepping_motor_depth + (stepping_motor_tolerance * 2);
        
        // Stepping motor and lead screw
        translate([(base_plate_width / 2) - (motor_width_plus_threshold / 2), -stepping_motor_tolerance, -stepping_motor_height - base_plate_stepping_motor_plate_height])
        {
            cube([motor_width_plus_threshold, motor_depth_plus_threshold, stepping_motor_height]);
            translate([motor_width_plus_threshold/2, motor_depth_plus_threshold/2, stepping_motor_height])
            {
                // Main motor shaft hole.
                translate([0, 0, -epsilon])
                {
                    if (large_lead_screw_radius)
                    {
                        cylinder(r=lead_screw_base_hole_radius + lead_screw_hole_threshold, h=card_magazine_lifter_height + (epsilon * 4) - 10, $fn=100);
                    }
                    cylinder(r=lead_screw_radius + lead_screw_hole_threshold, h=lead_screw_height, $fn=100);
                    
                    translate([0, 0, base_plate_stepping_motor_plate_height + card_magazine_thickness - epsilon])
                    {
                        translate([0, lead_screw_mounting_hole_offset, 0])
                        {
                            cylinder(r=lead_screw_mounting_hole_radius, h=card_magazine_lifter_height * 2 + (epsilon * 4), $fn=100);                    
                        }
                        translate([0, -lead_screw_mounting_hole_offset, 0])
                        {
                            cylinder(r=lead_screw_mounting_hole_radius, h=card_magazine_lifter_height * 2 + (epsilon * 4), $fn=100);                    
                        }
                        translate([lead_screw_mounting_hole_offset, 0, 0])
                        {
                            cylinder(r=lead_screw_mounting_hole_radius, h=card_magazine_lifter_height * 2 + (epsilon * 4), $fn=100);                    
                        }
                        translate([-lead_screw_mounting_hole_offset, 0, 0])
                        {
                            cylinder(r=lead_screw_mounting_hole_radius, h=card_magazine_lifter_height * 2 + (epsilon * 4), $fn=100);                    
                        }
                    }
                }
            }
        }  
                            
        // Bearing rod
        translate([(base_plate_width / 2) - (stepping_motor_width/2), base_plate_depth - stepping_motor_depth, -stepping_motor_height - base_plate_stepping_motor_plate_height])
        {
            translate([stepping_motor_width/2, stepping_motor_depth/2, 0])
            {
                cylinder(r=bearing_rod_radius + bearing_rod_hole_threshold, h=lead_screw_height + base_plate_height + epsilon, $fn=100);               
            
            }
        }
    }     
}

// Line of bins and the extrusion below it.
// Gantry is all the extrusion. 
module gantry()
{
    // Bin line
    long_extrusion();
    
    // U shape connecting to the bin line.
    rotate([0, 0, 90])
    {
        short_extrusion();
    }
    translate([0, extrusion_long_depth - extrusion_long_width, 0])
    {
        rotate([0, 0, 90])
        {
            short_extrusion();
        }
    }
    translate([-(extrusion_short_depth + extrusion_short_width), 0, 0])
    {
        long_extrusion();
    }
     
    // Short extrusion for base plate.    
    translate([-extrusion_short_depth - extrusion_long_width, (extrusion_short_depth/2) - (extrusion_short_width/2) + extrusion_short_width, 0])
    {
        rotate([0, 0, 90])
        {
            short_extrusion();
        }
    }
    
    // Main beams going up.
    translate([-extrusion_short_depth - extrusion_short_width, 0, 0])
    {
        rotate([90, 0, 0])
        {
            translate([0, extrusion_short_width, -extrusion_short_width])
            {
                long_extrusion();
            }
            translate([0, extrusion_short_width, -extrusion_short_depth - (extrusion_long_width * 2)])
            {
                long_extrusion();
            }
            translate([0, extrusion_short_width, -extrusion_long_depth])
            {
                long_extrusion();
            }           
        }
    }
    
    // Beam at top of gantry
    translate([-(extrusion_short_depth + extrusion_short_width), 0, extrusion_long_depth + extrusion_short_width])
    {
        long_extrusion();
    }
}

// Mount to connect a linear bearing to the lead screw.
// Origin is expected to be the center of the rod.
module bearing_mount()
{    
    translate([-(card_magazine_lifter_hand_width * 0.5), -bearing_rod_bearing_bearing_to_base_offset - bearing_rod_clamp_plate_width, 0])
    {
        difference()
        {
            cube([card_magazine_lifter_hand_width, bearing_rod_clamp_plate_width, card_magazine_lifter_height]);
        
            // Bearing bolt holes
            translate([(card_magazine_lifter_hand_width * 0.5), epsilon+5, card_magazine_lifter_height * 0.5])
            {
                for (x = [-1, 1])
                {
                    for (z = [-1, 1])
                    {
                        translate([card_magazine_lifter_rod_plate_hole_offset_depth * x, (bearing_rod_clamp_plate_width * 0.5) + 1, card_magazine_lifter_rod_plate_hole_offset_height * z])
                        {
                            rotate([90, 0, 0]) cylinder(h=bearing_rod_clamp_plate_width + 1, r=card_magazine_lifter_rod_plate_hole_radius, $fn=100);
                            translate([0, -bearing_rod_clamp_plate_width + 4 - epsilon, 0])
                            {
                                rotate([90, 0, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2.2, $fn=100);
                            }
                        }
                    }
                }
            }
        }
    }
}

// Mount for the clamp that holds onto the bearing rod.
module rod_mount()
{        
    translate([0, 0, base_plate_height])
    {
        translate([(base_plate_width / 2) - (stepping_motor_width/2), base_plate_depth - stepping_motor_depth, -stepping_motor_height])
        {
            translate([stepping_motor_width/2, stepping_motor_depth/2, stepping_motor_height])
            {
                translate([bearing_rod_clamp_rod_to_base_offset, -bearing_rod_clamp_plate_depth*0.5, 0])
                {
                    difference()
                    {
                        cube([bearing_rod_clamp_plate_width, bearing_rod_clamp_plate_depth, bearing_rod_clamp_plate_height]);
                        union()
                        {
                            translate([-epsilon, (bearing_rod_clamp_plate_depth * 0.5) - bearing_rod_clamp_rod_to_screw_offset, bearing_rod_clamp_plate_height * 0.5])
                            {
                                rotate([0, 90, 0]) cylinder(h=bearing_rod_clamp_plate_width + (epsilon * 2), r=bearing_rod_clamp_screw_radius, $fn=100);
                            }
                            translate([-epsilon, (bearing_rod_clamp_plate_depth * 0.5) + bearing_rod_clamp_rod_to_screw_offset, bearing_rod_clamp_plate_height * 0.5])
                            {
                                rotate([0, 90, 0]) cylinder(h=bearing_rod_clamp_plate_width + (epsilon * 2), r=bearing_rod_clamp_screw_radius, $fn=100);
                            }
                        }
                    }
                }
        
            }
        }
    }
}

// Plate at the bottom of the gantry that the magazine sits on.
module base_plate()
{
    difference()
    {
        difference()
        {
            union() hull()
            {
                translate([base_plate_width - 10, base_plate_depth*0.2, 0])
                {
                    cube([10, base_plate_depth * 0.6, base_plate_height]);       
                }
                translate([base_plate_width * 0.3, 0, 0])
                {
                    cube([base_plate_width * 0.4, base_plate_depth, base_plate_height]);       
                }
                translate([15, base_plate_depth*0.2, 0])
                {
                    cube([10, base_plate_depth * 0.6, base_plate_height]);       
                }
            }
            union()
            {                 
                // Indexing pegs for the base board                       
                translate([0, 0, base_plate_height + epsilon])
                {
                    translate(card_magazine_offset)
                    {    
                        translate([card_magazine_thickness + epsilon, 0, 0])
                        {    
                            union() card_magazine_indexing_bottom_pegs(card_magazine_index_size + card_magazine_index_tolerance, base_plate_height + (epsilon*2));
                        }
                    }
                }
             
            }
        }

        base_plate_cuts();
    }
    union() rod_mount();
}

// Also cut from the magazine parts, which sit on the base plate.
module base_plate_cuts()
{

    translate([0, 0, base_plate_height])
    {
        card_magazine_width_plus_thresholds = card_width + (card_magazine_tolerance * 2);
        card_magazine_depth_plus_thresholds = card_depth + (card_magazine_tolerance * 2);
              
        // Magazine connector holes
        translate(card_magazine_offset)
        {
            translate([card_magazine_thickness, card_magazine_thickness, card_magazine_floor_thickness])
            {
                translate([10, 10, 0])
                {
                    recessed_bolt_hole();
                }
                translate([card_magazine_width_plus_thresholds - 10, 10, 0])
                {
                    recessed_bolt_hole();
                }
                translate([10, card_magazine_depth_plus_thresholds - 10, 0])
                {
                    recessed_bolt_hole();
                }
                translate([card_magazine_width_plus_thresholds - 10, card_magazine_depth_plus_thresholds - 10, 0])
                {
                    recessed_bolt_hole();
                }
            }
        }
    }

    // Cut corners out of base plate, we use this for connector fixings.
    translate([base_plate_width - extrusion_short_width - 2, 0, -epsilon])
    {
        cube([extrusion_short_width + 2, 40, base_plate_height + (epsilon * 2)]);
    }
    translate([base_plate_width - extrusion_short_width - 2, base_plate_depth - 40, -epsilon])
    {
        cube([extrusion_short_width + 2, 40, base_plate_height + (epsilon * 2)]);
    }

    // Holes for the main rods.
    rod_holes(true);

    // TBolt connections
    translate([0, 0, base_plate_height])
    {
        translate([base_plate_width - (extrusion_short_width / 2), base_plate_depth * 0.3, 0])
        {
            bolt_hole(tbolt_shank_radius, 30, [0, 1, 0]);
        }
        translate([base_plate_width - (extrusion_short_width / 2), base_plate_depth * 0.7, 0])
        {
            bolt_hole(tbolt_shank_radius, 30, [0, 1, 0]);
        }   
        translate([25, base_plate_depth * 0.5, 0])
        {
            bolt_hole(tbolt_shank_radius, 30, [1, 0, 0]);
        }   
    }    

    translate([0, 0, base_plate_height])
    {
        motor_width_plus_threshold = stepping_motor_width + (stepping_motor_tolerance * 2);
        motor_depth_plus_threshold = stepping_motor_depth + (stepping_motor_tolerance * 2);
    
        // Stepping motor and lead screw
        translate([(base_plate_width / 2) - (motor_width_plus_threshold / 2), -stepping_motor_tolerance, -stepping_motor_height - base_plate_stepping_motor_plate_height])
        {
            cube([motor_width_plus_threshold, motor_depth_plus_threshold, stepping_motor_height]);
            translate([motor_width_plus_threshold/2, motor_depth_plus_threshold/2, stepping_motor_height])
            {
                // Mounting screw holes.
                translate([stepping_motor_screw_hole_offset, stepping_motor_screw_hole_offset, -epsilon])
                {
                    cylinder(r=stepping_motor_screw_hole_radius, h=base_plate_height, $fn=100);                            
                }
                translate([-stepping_motor_screw_hole_offset, stepping_motor_screw_hole_offset, -epsilon])
                {
                    cylinder(r=stepping_motor_screw_hole_radius, h=base_plate_height, $fn=100);                            
                }
                translate([stepping_motor_screw_hole_offset, -stepping_motor_screw_hole_offset, -epsilon])
                {
                    cylinder(r=stepping_motor_screw_hole_radius, h=base_plate_height, $fn=100);                            
                }
                translate([-stepping_motor_screw_hole_offset, -stepping_motor_screw_hole_offset, -epsilon])
                {
                    cylinder(r=stepping_motor_screw_hole_radius, h=base_plate_height, $fn=100);                            
                }
            }
        }  
    }      

}

module base_plate_externals()
{
    translate([0, 0, base_plate_height])
    {
        // Stepping motor and lead screw
        translate([(base_plate_width / 2) - (stepping_motor_width/2), 0, -stepping_motor_height - base_plate_stepping_motor_plate_height])
        {
            color("blue") cube([stepping_motor_width, stepping_motor_depth, stepping_motor_height]);
            translate([stepping_motor_width/2, stepping_motor_depth/2, stepping_motor_height])
            {
                color("blue") cylinder(r=lead_screw_radius, h=lead_screw_height, $fn=100);
            }
        }
    
        // Bearing rod
        translate([(base_plate_width / 2) - (stepping_motor_width/2), base_plate_depth - stepping_motor_depth, -stepping_motor_height - base_plate_stepping_motor_plate_height])
        {
            translate([stepping_motor_width/2, stepping_motor_depth/2, stepping_motor_height])
            {
                color("blue") cylinder(r=bearing_rod_radius, h=lead_screw_height, $fn=100);
            }
        }
    }

}

// Cuts a magazine part, modelled from the magazine's corner, with the base plate's cuts.
module cut_by_base_plate()
{
    difference()
    {
        children();
        translate(base_plate_position - card_magazine_position) base_plate_cuts();
    }
}

// Removes the magazine's top flare below the card channel's exit, so exit and chute changes never need it reprinting.
module card_magazine_exit_flare_cut()
{
    channel_width = card_magazine_hole_depth + ((exit_channel_flare + exit_insert_tolerance) * 2);
    // The body's front face, which card_magazine() offsets by its epsilons.
    front_x = card_magazine_width + (epsilon * 3);
    translate([front_x, (card_magazine_depth - channel_width) * 0.5, card_magazine_height - base_plate_height - card_magazine_top_flare_height - epsilon])
    {
        cube([(card_magazine_top_flare_width * 0.5) + epsilon, channel_width, card_magazine_top_flare_height + (epsilon * 2)]);
    }
}

// Scan plate at the top of the magazine where the fun goes down.
module scan_plate()
{
    difference()
    {
        union()
        {
            difference()
            {    
                union()
                {
                    hull()
                    {
                        translate([base_plate_width - 10, 0, 0])
                        {
                            cube([10, base_plate_depth, base_plate_height]);       
                        }
                        translate([base_plate_width * 0.3, 0, 0])
                        {
                            cube([base_plate_width * 0.4, base_plate_depth, base_plate_height]);       
                        }
                        translate([15, base_plate_depth*0.2, 0])
                        {
                            cube([10, base_plate_depth * 0.6, base_plate_height]);       
                        }                    
                    }
            
                    // Walls around hole.
                    translate([base_plate_width * 0.5, base_plate_depth * 0.5, base_plate_height])
                    {
                        translate([-(card_magazine_hole_width * 0.5) - card_magazine_hole_scan_wall_size, -(card_magazine_hole_depth * 0.5) - card_magazine_hole_scan_wall_size])
                        {
                            full_width = card_magazine_hole_width + card_magazine_hole_scan_wall_size + ((base_plate_width - card_magazine_hole_width) * 0.5);
                            full_depth = card_magazine_hole_depth + (card_magazine_hole_scan_wall_size * 2);
                            full_height = card_magazine_hole_scan_wall_height_size;
                        
                            hole_width = card_magazine_hole_width + ((base_plate_width - card_magazine_hole_width) * 0.5);
                            hole_depth = card_magazine_hole_depth;
                            hole_height = card_magazine_hole_scan_wall_height_size;
                    
                            difference()
                            {
                                cube([full_width, full_depth, full_height]);
                                translate([card_magazine_hole_scan_wall_size, card_magazine_hole_scan_wall_size, 0])
                                {
                                    cube([hole_width, hole_depth, hole_height]);
                                }
                            }
                        }
                    }
                
                    translate(limit_switch_tab_offset) limit_switch_tab();
                
                }
                
                union()
                {            
                    translate([0, 0, -card_magazine_height])
                    {
                
                        rod_holes(false);
                    
                    }
                              
                    translate([0, 0, -card_magazine_height])
                    {
                        translate([0, 0, base_plate_height])
                        {             
                            // Card hole   
                            translate(card_magazine_offset)
                            {       
                                // Cut our holes for indexing pegs
                                translate([card_magazine_thickness + epsilon, 0, 0])
                                {        
                                    translate([0, 0, (card_magazine_height * 0.5) - base_plate_height])
                                    {
                                        union() card_magazine_indexing_top_pegs(card_magazine_index_size + card_magazine_index_tolerance, card_magazine_index_height + card_magazine_index_tolerance + 100);
                                    }
                                }
                        
                                translate([card_magazine_thickness, card_magazine_thickness, card_magazine_thickness])
                                {
                                    cube([card_width + (card_magazine_tolerance * 2), card_depth + (card_magazine_tolerance * 2), card_magazine_height + card_magazine_tolerance]);
                                }
                                       
                            }
                        
                            // Magazine  
                            translate(card_magazine_offset)
                            {
                                // Cut screw holes out of the top.   
                                translate([card_magazine_thickness + epsilon, 0, 0])
                                {         
                                    translate([-card_magazine_top_flare_width*0.5, -card_magazine_top_flare_depth*0.5, card_magazine_height - base_plate_height - card_magazine_top_flare_height])
                                    {
                                        translate([card_magazine_top_flare_width*0.25, card_magazine_top_flare_depth*0.25, base_plate_height + card_magazine_top_flare_height])
                                        {
                                            bolt_hole(tbolt_shank_radius, 30);
                                        }
                                        translate([card_magazine_width + (card_magazine_top_flare_width*0.25), card_magazine_top_flare_depth*0.25, base_plate_height + card_magazine_top_flare_height])
                                        {
                                            bolt_hole(tbolt_shank_radius, 30);
                                        }
                                        translate([card_magazine_top_flare_width*0.25, card_magazine_depth + (card_magazine_top_flare_depth*0.75), base_plate_height + card_magazine_top_flare_height])
                                        {
                                            bolt_hole(tbolt_shank_radius, 30);
                                        }
                                        translate([card_magazine_width + (card_magazine_top_flare_width*0.25), card_magazine_depth + (card_magazine_top_flare_depth*0.75), base_plate_height + card_magazine_top_flare_height])
                                        {
                                            bolt_hole(tbolt_shank_radius, 30);
                                        }
                                    }
                                }
                    
                            }
                        }
                    }
                }
            }    
        
            union()
            {        
                // Walls around hole.
                translate([base_plate_width * 0.5, base_plate_depth * 0.5, base_plate_height])
                {
                    translate([-(card_magazine_hole_width * 0.5) - card_magazine_hole_scan_wall_size, -(card_magazine_hole_depth * 0.5) - card_magazine_hole_scan_wall_size])
                    {
                        full_width = card_magazine_hole_width + card_magazine_hole_scan_wall_size + ((base_plate_width - card_magazine_hole_width) * 0.5);
                        full_depth = card_magazine_hole_depth + (card_magazine_hole_scan_wall_size * 2);
                        full_height = card_magazine_hole_scan_wall_height_size;
                    
                        hole_width = card_magazine_hole_width + ((base_plate_width - card_magazine_hole_width) * 0.5);
                        hole_depth = card_magazine_hole_depth;
                        hole_height = card_magazine_hole_scan_wall_height_size;
                
                        card_stop_size = 4.922;
                        card_top_spacing = 0.16;
                        // Ends where the walls are notched for the roller hub, rather than overhanging the notch.
                        card_stop_length = card_magazine_hole_width + swing_roller_contact_x - (swing_wall_notch_length * 0.5);

                        // Add a card stop around the edges.
                        translate([card_magazine_hole_scan_wall_size, card_magazine_hole_scan_wall_size, card_top_spacing])
                        {
                            translate([0, 0, card_stop_size*0.5])
                            {
                                rotate([-90, -30, 0])
                                {
                                    cylinder(r=card_stop_size*0.5, h=hole_depth, $fn=100);
                                }
                            }
                        }
                    
                        translate([card_magazine_hole_scan_wall_size, card_magazine_hole_scan_wall_size, card_top_spacing])
                        {
                            translate([0, 0, card_stop_size*0.5])
                            {
                                rotate([0, 90, 0])
                                {
                                    cylinder(r=card_stop_size*0.5, h=card_stop_length, $fn=100);
                                }
                            }
                        }
                    
                        // Short runs between the notches and the exit, so the front of the stack is held down too.
                        front_stop_start = card_magazine_hole_width + swing_roller_contact_x + (swing_wall_notch_length * 0.5);
                        front_stop_end = card_magazine_hole_width - exit_channel_lead_in_length;
                        for (y = [card_magazine_hole_scan_wall_size, hole_depth + card_magazine_hole_scan_wall_size])
                        {
                            translate([card_magazine_hole_scan_wall_size + front_stop_start, y, card_top_spacing + (card_stop_size * 0.5)])
                            {
                                rotate([0, 90, 0]) cylinder(r=card_stop_size * 0.5, h=front_stop_end - front_stop_start, $fn=100);
                            }
                        }

                        translate([card_magazine_hole_scan_wall_size, hole_depth + card_magazine_hole_scan_wall_size - card_stop_size, card_top_spacing])
                        {
                            difference()
                            {
                                translate([0, card_stop_size, card_stop_size*0.5])
                                {
                                    rotate([0, 90, 0])
                                    {
                                        cylinder(r=card_stop_size*0.5, h=card_stop_length, $fn=100);
                                    }
                                }
                                translate([(hole_width * 0.25) + limit_switch_x_shift, 0, 0])
                                {
                                    cube([hole_width*0.25, card_stop_size, card_stop_size]);
                                }
                            }
                        }
                    }
                }
            }
        }
        union()
        {
            translate(scan_plate_exit_offset)
            {
                exit_insert_pocket();
                swing_wall_notches();
            }
            translate(limit_switch_tab_offset) limit_switch_screw_cut();
            translate(card_magazine_position - scan_plate_position) card_magazine_pad_pocket();
        }            
    }

    translate(scan_plate_exit_offset)
    {
        swing_motor_mount();
        swing_rod_supports();
    }
    scan_plate_gantry_brackets();

}

// The exit channel's V-shaped outline, from where it meets the magazine hole to the plate edge, grown by grow on each side.
module exit_channel(grow, bottom, height)
{
    start_x = -exit_channel_lead_in_length - epsilon;
    start_half_width = exit_channel_half_width_at(start_x) + grow;
    end_x = exit_insert_length + epsilon;
    end_half_width = exit_channel_half_width_at(end_x) + grow;
    translate([0, 0, bottom])
    {
        linear_extrude(height)
        {
            polygon([
                [start_x, -start_half_width],
                [end_x, -end_half_width],
                [end_x, end_half_width],
                [start_x, start_half_width]
            ]);
        }
    }
}

// Continues the insert's ramp down through the scan plate.
module exit_ramp_cut()
{
    ramp_end_x = exit_insert_length + epsilon;
    ramp_bottom = exit_insert_lip_height - ((ramp_end_x - exit_lip_end) * tan(exit_ramp_angle));
    half_width = exit_channel_half_width + exit_channel_flare + exit_insert_tolerance + epsilon;
    intersection()
    {
        xz_extrude(-half_width, half_width)
        {
            polygon([
                [exit_lip_end, exit_insert_lip_height],
                [ramp_end_x, ramp_bottom],
                [ramp_end_x, exit_insert_lip_height]
            ]);
        }
        exit_channel(exit_insert_tolerance, ramp_bottom - epsilon, exit_insert_lip_height - ramp_bottom + (epsilon * 2));
    }
}

// Below the pocket, slopes the lead-in's walls back to the magazine hole by the bottom of the plate, so cards moving down the
// magazine have no ledge to catch on.
module exit_channel_lead_in_slope()
{
    hole_half_width = card_magazine_hole_depth * 0.5;
    top = -exit_insert_pocket_depth + epsilon;
    hull()
    {
        polyhedron(
            points=[
                [-exit_channel_lead_in_length, -hole_half_width, top],
                [-exit_channel_lead_in_length, hole_half_width, top],
                [0, -hole_half_width - exit_insert_tolerance, top],
                [0, hole_half_width + exit_insert_tolerance, top],
                [0, -hole_half_width, -base_plate_height],
                [0, hole_half_width, -base_plate_height]
            ],
            faces=[[0, 1, 3, 2], [2, 3, 5, 4], [0, 4, 5, 1], [0, 2, 4], [1, 5, 3]]
        );
    }
}

// One post's outline, alongside the +Y side of the channel from start_x to the end of the posts.
module exit_post_outline(start_x, width)
{
    polygon([
        [start_x, exit_channel_half_width_at(start_x)],
        [exit_insert_post_end, exit_channel_half_width_at(exit_insert_post_end)],
        [exit_insert_post_end, exit_channel_half_width_at(exit_insert_post_end) + width],
        [start_x, exit_channel_half_width_at(start_x) + width]
    ]);
}

module exit_insert_pocket()
{
    height = exit_insert_pocket_depth + card_magazine_hole_scan_wall_height_size + epsilon;

    exit_channel(exit_insert_tolerance, -exit_insert_pocket_depth, height);
    exit_channel_lead_in_slope();
    // Past the posts the scan walls would only be slivers beside the channel; the posts still bear on the pocket below.
    wall_half_width = (card_magazine_hole_depth * 0.5) + card_magazine_hole_scan_wall_size + epsilon;
    translate([exit_insert_post_end, -wall_half_width, 0])
    {
        cube([exit_insert_length - exit_insert_post_end + epsilon, wall_half_width * 2, card_magazine_hole_scan_wall_height_size + epsilon]);
    }
    for (side = [0, 1])
    {
        mirror([0, side, 0])
        {
            translate([0, 0, -exit_insert_pocket_depth])
            {
                linear_extrude(height)
                {
                    exit_post_outline(exit_insert_post_pocket_start, exit_insert_post_width + exit_insert_tolerance);
                }
            }
        }
    }
    exit_ramp_cut();
    // Takes the floor under the nip's tongue.
    recess_half_width = exit_nip_cut_half_width + exit_insert_tolerance;
    translate([-epsilon, -recess_half_width, exit_nip_floor_bottom]) cube([exit_nip_tongue_root_x - exit_nip_root_clearance + (epsilon * 2), recess_half_width * 2, -exit_insert_pocket_depth - exit_nip_floor_bottom + epsilon]);
    root_half_width = exit_nip_tongue_half_width + exit_nip_root_clearance;
    translate([exit_nip_tongue_root_x - exit_nip_root_clearance, -root_half_width, exit_nip_root_bottom]) cube([exit_insert_ramp_end - exit_nip_tongue_root_x + (exit_nip_root_clearance * 2), root_half_width * 2, -exit_insert_pocket_depth - exit_nip_root_bottom + epsilon]);
    for (side = [-1, 1])
    {
        translate([exit_nip_bolt_x, side * exit_nip_bolt_y, exit_nip_root_bottom + epsilon]) bolt_hole(exit_screw_clearance_radius - tbolt_shank_radius_tolerance, exit_nip_root_floor_thickness);
    }
    for (side = [-1, 1])
    {
        translate([exit_insert_screw_x, side * exit_post_y(exit_insert_screw_x), -exit_insert_pocket_depth - exit_threaded_insert_depth])
        {
            cylinder(r=exit_threaded_insert_radius, h=exit_threaded_insert_depth + epsilon, $fn=100);
        }
    }
}

// Separate part so its height can be set, and so it prints without supports.
// Springs under the posts let the screws set the lip height.
module exit_insert()
{
    half_width = exit_channel_half_width + exit_channel_flare + exit_insert_tolerance + epsilon;
    bottom = -exit_insert_pocket_depth - epsilon;
    top = exit_post_top + epsilon;

    module ramp()
    {
        xz_extrude(-half_width, half_width) polygon(exit_insert_profile(bottom));
    }

    union() difference()
    {
        union()
        {
            intersection()
            {
                ramp();
                exit_channel(0, -exit_insert_pocket_depth, exit_insert_pocket_depth + exit_insert_lip_height + epsilon);
            }
            // The posts run along the V-shaped channel walls, which then guide the card above the ramp. Above the ramp their
            // faces line up with the scan plate's walls either side (cut back by the pocket's tolerance), so a card sliding
            // along the wall has no ledge to catch on; below it they stay joined to the ramp.
            difference()
            {
                union() for (side = [0, 1])
                {
                    mirror([0, side, 0])
                    {
                        translate([0, 0, -exit_insert_pocket_depth])
                        {
                            linear_extrude(exit_insert_pocket_depth + exit_post_top)
                            {
                                exit_post_outline(exit_insert_post_pocket_start + exit_insert_post_back_clearance, exit_insert_post_width);
                            }
                        }
                    }
                }
                difference()
                {
                    exit_channel(exit_insert_tolerance, -exit_insert_pocket_depth - epsilon, exit_insert_pocket_depth + exit_post_top + (epsilon * 2));
                    ramp();
                }
            }
        }
        for (side = [-1, 1])
        {
            translate([exit_insert_screw_x, side * exit_post_y(exit_insert_screw_x), -exit_insert_pocket_depth - epsilon])
            {
                cylinder(r=exit_screw_clearance_radius, h=exit_insert_pocket_depth + exit_post_top + (epsilon * 2), $fn=100);
                cylinder(r=exit_spring_radius, h=exit_spring_depth + epsilon, $fn=100);
            }
        }
        // Room for the nip's tongue, leaving a strip standing at the exit wall.
        difference()
        {
            translate([exit_nip_tongue_wall, -exit_nip_cut_half_width, bottom - epsilon]) cube([exit_insert_ramp_end - exit_nip_tongue_wall + epsilon, exit_nip_cut_half_width * 2, top - bottom + (epsilon * 2)]);
            translate([exit_nip_bridge_x[0], -exit_nip_cut_half_width - epsilon, bottom - (epsilon * 2)]) cube([exit_nip_bridge_x[1] - exit_nip_bridge_x[0], (exit_nip_cut_half_width + epsilon) * 2, exit_nip_bridge_top - bottom + (epsilon * 2)]);
        }
    }
}

// Leaf spring carrying the nip's pad, rooted downstream so its tip, just past the exit wall, flexes down under the roller and
// the card only ever steps down onto it. Its top carries on the insert's lip and ramp.
module exit_nip_tongue()
{
    half_width = exit_nip_tongue_half_width;
    pad_half_width = (exit_nip_pad_size[1] * 0.5) + exit_nip_pad_clearance;
    pad_x = exit_nip_x - (exit_nip_pad_size[0] * 0.5) - exit_nip_pad_clearance;
    pad_length = exit_nip_pad_size[0] + (exit_nip_pad_clearance * 2);
    tip_x = exit_nip_tongue_wall + exit_nip_tongue_slot;
    stiff_end_x = pad_x + pad_length + exit_nip_tongue_wall;
    flex_bottom = exit_insert_lip_height - exit_nip_tongue_thickness;
    top = exit_insert_lip_height + epsilon;

    difference()
    {
        intersection()
        {
            xz_extrude(-half_width, half_width) polygon(exit_insert_profile(exit_nip_root_bottom));
            union()
            {
                translate([tip_x, -half_width - epsilon, exit_nip_tongue_bottom]) cube([stiff_end_x - tip_x, (half_width + epsilon) * 2, top - exit_nip_tongue_bottom]);
                translate([stiff_end_x - epsilon, -half_width - epsilon, flex_bottom]) cube([exit_nip_tongue_root_x - stiff_end_x + (epsilon * 2), (half_width + epsilon) * 2, top - flex_bottom]);
                translate([exit_nip_tongue_root_x, -half_width - epsilon, exit_nip_root_bottom - epsilon]) cube([exit_insert_ramp_end - exit_nip_tongue_root_x + epsilon, (half_width + epsilon) * 2, top - exit_nip_root_bottom + epsilon]);
                // Short of the exit wall by the root's clearance, so wherever the tongue sits it never sticks into the magazine.
                translate([exit_nip_root_clearance, -half_width - epsilon, exit_nip_floor_bottom]) cube([exit_nip_tongue_root_x - exit_nip_root_clearance + epsilon, (half_width + epsilon) * 2, exit_nip_floor_thickness]);
            }
        }
        translate([pad_x, -pad_half_width, exit_insert_lip_height - exit_nip_pad_size[2]]) cube([pad_length, pad_half_width * 2, exit_nip_pad_size[2] + epsilon]);
        rib_pitch = ((half_width * 2) - exit_nip_tongue_rib_width) / (exit_nip_tongue_rib_count - 1);
        for (i = [0:exit_nip_tongue_rib_count - 2])
        {
            translate([stiff_end_x, -half_width + exit_nip_tongue_rib_width + (i * rib_pitch), flex_bottom - epsilon]) cube([exit_nip_tongue_root_x - stiff_end_x, rib_pitch - exit_nip_tongue_rib_width, top - flex_bottom + (epsilon * 2)]);
        }
        for (side = [0, 1])
        {
            mirror([0, side, 0])
            {
                translate([exit_nip_bolt_x, -exit_nip_bolt_y, exit_nip_root_bottom - epsilon])
                {
                    cylinder(r=exit_screw_clearance_radius, h=exit_nip_nut_floor_thickness + exit_nip_nut_depth + exit_nip_bolt_overrun + epsilon, $fn=100);
                }
                hull()
                {
                    for (y = [-exit_nip_bolt_y, -half_width - epsilon])
                    {
                        translate([exit_nip_bolt_x, y, exit_nip_nut_bottom]) rotate([0, 0, 30]) cylinder(r=exit_nip_nut_radius, h=exit_nip_nut_depth, $fn=6);
                    }
                }
            }
        }
    }
}

// Extrudes a 2D profile drawn in x/z along y, between y0 and y1.
module xz_extrude(y0, y1)
{
    translate([0, y1, 0])
    {
        rotate([90, 0, 0])
        {
            linear_extrude(y1 - y0)
            {
                children();
            }
        }
    }
}

// A cylinder along y between y0 and y1, centred on an [x, z] point.
module y_cylinder(center, radius, y0, y1)
{
    xz_extrude(y0, y1) translate(center) circle(r=radius);
}

// A hole along y that overshoots both faces between y0 and y1.
module y_bore(center, radius, y0, y1)
{
    y_cylinder(center, radius, y0 - epsilon, y1 + epsilon);
}

// Two circles hulled into a rounded link, in x/z.
module swing_link(a, radius_a, b, radius_b)
{
    hull()
    {
        translate(a) circle(r=radius_a, $fn=100);
        translate(b) circle(r=radius_b, $fn=100);
    }
}

function involute_angle(pressure_angle) = (tan(pressure_angle) - (pressure_angle * PI / 180)) * 180 / PI;
function polar(radius, angle) = [radius * cos(angle), radius * sin(angle)];

module spur_gear_2d(teeth, profile_shift = 0, addendum = swing_gear_module)
{
    pitch_radius = swing_gear_module * teeth * 0.5;
    base_radius = pitch_radius * cos(swing_gear_pressure_angle);
    tip_radius = pitch_radius + addendum;
    root_radius = pitch_radius - (swing_gear_module * (1.25 - profile_shift));
    max_roll = sqrt(pow(tip_radius / base_radius, 2) - 1);
    half_angle = (90 / teeth) + involute_angle(swing_gear_pressure_angle) + ((((profile_shift * swing_gear_module * tan(swing_gear_pressure_angle)) - (swing_gear_backlash * 0.5)) / pitch_radius) * 180 / PI);
    steps = 8;
    flank = [for (i = [0:steps]) let (t = max_roll * i / steps) polar(base_radius * sqrt(1 + (t * t)), half_angle - ((t * 180 / PI) - atan(t)))];
    mirrored = [for (i = [steps:-1:0]) [flank[i][0], -flank[i][1]]];

    circle(r=root_radius + epsilon, $fn=teeth * 4);
    for (i = [0:teeth - 1])
    {
        rotate(i * 360 / teeth)
        {
            polygon(concat([polar(root_radius, half_angle)], flank, mirrored, [polar(root_radius, -half_angle)]));
        }
    }
}

// Where two links of the given lengths from a and b meet, taking the upper of the two solutions.
function swing_elbow(a, b, length_a, length_b) =
    let (d = norm(b - a), along = ((d * d) + (length_a * length_a) - (length_b * length_b)) / (2 * d), u = (b - a) / d)
        a + (u * along) + ([u[1], -u[0]] * sqrt((length_a * length_a) - (along * along)));

// Rotation of a gear meshing with one at the given rotation, along the line between their centres.
function swing_mesh_phase(from, to, from_phase, from_teeth = swing_gear_teeth, to_teeth = swing_gear_teeth) =
    let (pitch = 360 / from_teeth, centre_angle = atan2(to[1] - from[1], to[0] - from[0]), offset = centre_angle - from_phase - (pitch * round((centre_angle - from_phase) / pitch)))
        centre_angle + 180 + (180 / to_teeth) + (offset * from_teeth / to_teeth);

// All three gears sit in the same plane between the drive arm and the roller.
module swing_gear(center, phase)
{
    xz_extrude(-swing_gear_outer_y, -swing_gear_inner_y) translate(center) rotate(phase) spur_gear_2d(swing_gear_teeth);
}

// Rotates the arm about the drive shaft, positive angles lift the roller.
module swing_pose(angle)
{
    translate([swing_shaft[0], 0, swing_shaft[1]])
    {
        rotate([0, angle, 0])
        {
            translate([-swing_shaft[0], 0, -swing_shaft[1]])
            {
                children();
            }
        }
    }
}

// A rod clamp: a grub screw in a heat-set insert, on the +z side where it can be reached from above.
module swing_clamp_2d(center, radius, reach)
{
    hull()
    {
        translate(center) circle(r=radius, $fn=100);
        translate(center + [0, reach - swing_clamp_boss_radius]) circle(r=swing_clamp_boss_radius, $fn=100);
    }
}

module swing_clamp_cut(center, y, reach)
{
    translate([center[0], y, center[1]])
    {
        cylinder(r=swing_grub_screw_clearance_radius, h=reach + epsilon, $fn=100);
        translate([0, 0, reach - exit_threaded_insert_depth]) cylinder(r=exit_threaded_insert_radius, h=exit_threaded_insert_depth + epsilon, $fn=100);
    }
}

module swing_sun_gear()
{
    hub_end_y = -swing_gear_inner_y + swing_sun_hub_length;
    clamp_start_y = -swing_gear_inner_y + swing_sun_clamp_gap;
    // The clamp's underside is chamfered at 45 degrees so it prints without sagging onto the teeth.
    chamfer = swing_sun_clamp_radius - swing_hub_radius;

    union() difference()
    {
        union()
        {
            swing_gear(swing_shaft, 0);
            hull()
            {
                y_cylinder(swing_shaft, swing_hub_neck_radius, -swing_gear_inner_y - epsilon, -swing_gear_inner_y, $fn=100);
                y_cylinder(swing_shaft, swing_hub_radius, -swing_gear_inner_y + (swing_hub_radius - swing_hub_neck_radius), hub_end_y, $fn=100);
            }
            hull()
            {
                xz_extrude(clamp_start_y, clamp_start_y + epsilon) offset(r=-chamfer, $fn=100) swing_clamp_2d(swing_shaft, swing_hub_radius, swing_sun_clamp_radius);
                xz_extrude(clamp_start_y + chamfer, hub_end_y) swing_clamp_2d(swing_shaft, swing_hub_radius, swing_sun_clamp_radius);
            }
        }
        y_bore(swing_shaft, swing_gear_bore_radius, -swing_gear_outer_y, hub_end_y, $fn=100);
        swing_clamp_cut(swing_shaft, (clamp_start_y + chamfer + hub_end_y) * 0.5, swing_sun_clamp_radius);
    }
}

module swing_clutch_collar()
{
    y = swing_clutch_collar_y;

    union() difference()
    {
        xz_extrude(y[0], y[1]) swing_clamp_2d(swing_shaft, swing_hub_radius, swing_sun_clamp_radius);
        y_bore(swing_shaft, swing_rod_clearance_radius, y[0], y[1], $fn=100);
        swing_clamp_cut(swing_shaft, (y[0] + y[1]) * 0.5, swing_sun_clamp_radius);
    }
}

module swing_idler_gear()
{
    union() difference()
    {
        swing_gear(swing_idler_center, swing_idler_phase);
        y_bore(swing_idler_center, swing_idler_bore_radius, -swing_gear_outer_y, -swing_gear_inner_y, $fn=100);
    }
}

// Turns on a fixed axle held by both arms, with its gear printed onto the end.
// The core profile, with grooves along it for the cast silicone grip to key into.
module swing_roller_core_2d()
{
    difference()
    {
        circle(r=swing_roller_radius, $fn=100);
        for (i = [0:swing_roller_key_count - 1])
        {
            rotate(i * 360 / swing_roller_key_count) translate([swing_roller_radius - swing_roller_key_depth, -swing_roller_key_width * 0.5]) square([swing_roller_key_depth + epsilon, swing_roller_key_width]);
        }
    }
}

// The core the grip is cast onto, shared by the swing and nip rollers so both use the same grip and cast alike.
module swing_roller_core(center)
{
    half_length = swing_roller_length * 0.5;
    taper = swing_roller_radius - swing_roller_hub_radius;

    difference()
    {
        // The ends taper down to the hubs at 45 degrees so the core prints without supports.
        intersection()
        {
            xz_extrude(-half_length, half_length) translate(center) swing_roller_core_2d();
            hull()
            {
                y_cylinder(center, swing_roller_hub_radius, -half_length, half_length, $fn=100);
                y_cylinder(center, swing_roller_radius + epsilon, -half_length + taper, half_length - taper, $fn=100);
            }
        }
        for (i = [1:swing_roller_ring_count])
        {
            y = -half_length + (swing_roller_length * i / (swing_roller_ring_count + 1));
            difference()
            {
                y_cylinder(center, swing_roller_radius + epsilon, y - (swing_roller_key_width * 0.5), y + (swing_roller_key_width * 0.5), $fn=100);
                y_bore(center, swing_roller_radius - swing_roller_key_depth, y - (swing_roller_key_width * 0.5), y + (swing_roller_key_width * 0.5), $fn=100);
            }
        }
    }
}

module swing_roller()
{
    idle_hub_end_y = swing_roller_idle_hub_end_y;
    half_length = swing_roller_length * 0.5;

    union() difference()
    {
        union()
        {
            swing_gear(swing_roller_center, swing_roller_phase);
            hull()
            {
                y_cylinder(swing_roller_center, swing_hub_neck_radius, -swing_gear_inner_y - epsilon, -swing_gear_inner_y, $fn=100);
                y_cylinder(swing_roller_center, swing_roller_hub_radius, -swing_gear_inner_y + (swing_roller_hub_radius - swing_hub_neck_radius), -half_length + epsilon, $fn=100);
            }
            swing_roller_core(swing_roller_center);
            y_cylinder(swing_roller_center, swing_roller_hub_radius, half_length - epsilon, idle_hub_end_y, $fn=100);
        }
        y_bore(swing_roller_center, swing_axle_clearance_radius, -swing_gear_outer_y, idle_hub_end_y, $fn=100);
    }
}

// Clamped to its axle by its -y hub, inside the exit channel; its +y hub only locates it in the mould.
module nip_roller()
{
    half_length = swing_roller_length * 0.5;
    clamp_end_y = -half_length - nip_roller_clamp_length;

    union() difference()
    {
        union()
        {
            swing_roller_core(nip_center);
            xz_extrude(clamp_end_y, -half_length + epsilon) swing_clamp_2d(nip_center, swing_roller_hub_radius, swing_sun_clamp_radius);
            y_cylinder(nip_center, nip_roller_neck_radius, half_length - epsilon, nip_roller_neck_end_y, $fn=100);
            // Flares out at 45 degrees so it prints without supports.
            hull()
            {
                y_cylinder(nip_center, nip_roller_neck_radius, nip_roller_neck_end_y - epsilon, nip_roller_neck_end_y, $fn=100);
                y_cylinder(nip_center, swing_roller_hub_radius, nip_roller_neck_end_y + swing_roller_hub_radius - nip_roller_neck_radius, nip_roller_hub_end_y, $fn=100);
            }
        }
        // Close only in the clamp and the far hub's end, so it slides onto the rod along its length but still runs true.
        y_bore(nip_center, swing_sun_bore_radius, clamp_end_y, nip_roller_hub_end_y, $fn=100);
        y_bore(nip_center, swing_rod_clearance_radius, -half_length, nip_roller_hub_end_y - nip_roller_locating_length, $fn=100);
        swing_clamp_cut(nip_center, (clamp_end_y - half_length) * 0.5, swing_sun_clamp_radius);
    }
}

// A gear in the nip's plane, clamped to its rod by a hub on its outer side like the sun gear's.
module nip_clamped_gear(center, phase, teeth, profile_shift, addendum, clamp_start_y, hub_end_y)
{
    chamfer = swing_sun_clamp_radius - swing_hub_radius;

    union() difference()
    {
        union()
        {
            xz_extrude(nip_gear_y[0], nip_gear_y[1]) translate(center) rotate(phase) spur_gear_2d(teeth, profile_shift, addendum);
            hull()
            {
                y_cylinder(center, swing_hub_neck_radius, nip_gear_y[1], nip_gear_y[1] + epsilon, $fn=100);
                y_cylinder(center, swing_hub_radius, nip_gear_y[1] + (swing_hub_radius - swing_hub_neck_radius), hub_end_y, $fn=100);
            }
            hull()
            {
                xz_extrude(clamp_start_y - epsilon, clamp_start_y) offset(r=-chamfer, $fn=100) swing_clamp_2d(center, swing_hub_radius, swing_sun_clamp_radius);
                xz_extrude(clamp_start_y + chamfer, hub_end_y) swing_clamp_2d(center, swing_hub_radius, swing_sun_clamp_radius);
            }
        }
        y_bore(center, swing_gear_bore_radius, nip_gear_y[0], hub_end_y, $fn=100);
        swing_clamp_cut(center, (clamp_start_y + chamfer + hub_end_y) * 0.5, swing_sun_clamp_radius);
    }
}

module nip_drive_gear()
{
    nip_clamped_gear(swing_shaft, 0, nip_drive_gear_teeth, nip_drive_gear_profile_shift, nip_drive_gear_addendum, nip_drive_clamp_start_y, nip_drive_hub_end_y);
}

module nip_gear()
{
    nip_clamped_gear(nip_center, nip_gear_phase, nip_gear_teeth, nip_gear_profile_shift, nip_gear_addendum, nip_clamp_start_y, nip_hub_end_y);
}

module nip_idler_gear()
{
    union() difference()
    {
        xz_extrude(nip_gear_y[0], nip_gear_y[1]) translate(nip_idler_center) rotate(nip_idler_phase) spur_gear_2d(swing_gear_teeth);
        y_bore(nip_idler_center, swing_idler_bore_radius, nip_gear_y[0], nip_gear_y[1], $fn=100);
    }
}

// Pads are cast face down and scraped flush with the top, so the face that meets the cards is the floor's.
module nip_pad_mould()
{
    pitch = exit_nip_pad_size[1] + nip_pad_mould_wall;
    size = [exit_nip_pad_size[0] + (nip_pad_mould_wall * 2), (pitch * nip_pad_mould_count) + nip_pad_mould_wall, nip_pad_mould_floor + exit_nip_pad_size[2]];

    union() difference()
    {
        cube(size);
        union() for (i = [0:nip_pad_mould_count - 1])
        {
            translate([nip_pad_mould_wall, nip_pad_mould_wall + (i * pitch), nip_pad_mould_floor]) cube([exit_nip_pad_size[0], exit_nip_pad_size[1], exit_nip_pad_size[2] + epsilon]);
        }
    }
}

module nip_pad_cast_bolt_holes()
{
    for (side = [-1, 1])
    {
        translate([nip_pad_cast_bolt_x, side * nip_pad_cast_bolt_y, nip_pad_cast_floor_bottom - epsilon])
        {
            cylinder(r=exit_screw_clearance_radius, h=nip_pad_cast_lid_top - nip_pad_cast_floor_bottom + (epsilon * 2), $fn=100);
        }
    }
}

// Located on the tongue by skirts along its sides and across its tip. The pour and vent slots enter the recess's ends,
// beyond the roller, so the stubs they leave never meet a card.
module nip_pad_cast_lid()
{
    profile = exit_insert_profile(exit_nip_tongue_bottom - 1);
    slot_y = [swing_roller_length * 0.5, nip_pad_cast_recess_half_width];
    slot_x = [nip_pad_cast_recess_x[0] + nip_pad_cast_slot_inset, nip_pad_cast_recess_x[1] - nip_pad_cast_slot_inset];
    length = exit_insert_ramp_end - nip_pad_cast_x0;

    union() difference()
    {
        translate([nip_pad_cast_x0, -nip_pad_cast_half_width, exit_nip_tongue_bottom]) cube([length, nip_pad_cast_half_width * 2, nip_pad_cast_lid_top - exit_nip_tongue_bottom]);
        intersection()
        {
            xz_extrude(-nip_pad_cast_inner_half_width, nip_pad_cast_inner_half_width) polygon(profile);
            translate([nip_pad_cast_tip_x - nip_pad_cast_clearance, -nip_pad_cast_half_width, exit_nip_tongue_bottom - 1]) cube([length, nip_pad_cast_half_width * 2, nip_pad_cast_lid_top]);
        }
        intersection()
        {
            xz_extrude(-nip_pad_cast_inner_half_width, nip_pad_cast_inner_half_width) offset(delta=nip_pad_cast_relief) polygon(profile);
            translate([nip_pad_cast_stiff_end_x, -nip_pad_cast_half_width, exit_nip_tongue_bottom - 1]) cube([length, nip_pad_cast_half_width * 2, nip_pad_cast_lid_top]);
        }
        for (cone = [[-1, nip_pad_cast_pour], [1, nip_pad_cast_vent]])
        {
            hull()
            {
                translate([slot_x[0], cone[0] > 0 ? slot_y[0] : -slot_y[1], exit_insert_lip_height - epsilon]) cube([slot_x[1] - slot_x[0], slot_y[1] - slot_y[0], epsilon]);
                translate([(slot_x[0] + slot_x[1]) * 0.5, cone[0] * (((slot_y[0] + slot_y[1]) * 0.5) - cone[1][1]), nip_pad_cast_lid_top]) cylinder(r=cone[1][0], h=epsilon, $fn=100);
            }
        }
        nip_pad_cast_bolt_holes();
    }
}

// The tongue sits in it on its floor arm and root, between walls that stop short of the lid so the clamping goes through
// the stiff block.
module nip_pad_cast_base()
{
    length = exit_insert_ramp_end - nip_pad_cast_x0;

    union() difference()
    {
        union()
        {
            translate([nip_pad_cast_x0, -nip_pad_cast_half_width, nip_pad_cast_floor_bottom]) cube([length, nip_pad_cast_half_width * 2, exit_nip_root_bottom - nip_pad_cast_floor_bottom]);
            translate([nip_pad_cast_x0, -nip_pad_cast_half_width, nip_pad_cast_floor_bottom]) cube([exit_nip_tongue_root_x - nip_pad_cast_clearance - nip_pad_cast_x0, nip_pad_cast_half_width * 2, exit_nip_floor_bottom - nip_pad_cast_floor_bottom]);
            for (side = [0, 1])
            {
                mirror([0, side, 0]) translate([nip_pad_cast_x0, nip_pad_cast_inner_half_width, nip_pad_cast_floor_bottom]) cube([length, nip_pad_cast_half_width - nip_pad_cast_inner_half_width, nip_pad_cast_wall_top - nip_pad_cast_floor_bottom]);
            }
        }
        nip_pad_cast_bolt_holes();
        for (side = [-1, 1])
        {
            translate([nip_pad_cast_bolt_x, side * nip_pad_cast_bolt_y, nip_pad_cast_floor_bottom - epsilon])
            {
                rotate([0, 0, 30]) cylinder(r=swing_roller_mould_nut_radius, h=nip_pad_cast_nut_top - nip_pad_cast_floor_bottom + epsilon, $fn=6);
            }
        }
    }
}

// Fills the tongue's travel gap under the stiff block, sticking out past its tip to pull it out by.
module nip_pad_cast_shim()
{
    x0 = nip_pad_cast_x0 - nip_pad_cast_wall;
    top = exit_nip_tongue_bottom - nip_pad_cast_clearance;

    union() translate([x0, -exit_nip_tongue_half_width, exit_nip_floor_top]) cube([nip_pad_cast_stiff_end_x - nip_pad_cast_clearance - x0, exit_nip_tongue_half_width * 2, top - exit_nip_floor_top]);
}

// Half of the mould for casting a roller's grip, modelled upright with the roller's -y end up: z is along the roller
// (z = -y on the roller) and the halves split on y = 0. Half "a" takes the bolts' heads and has the groove;
// half "b" has the nuts and ridge. The roller's hubs locate it, one in a socket in the base and one
// through the top, so the grip is cast evenly all round. For the nip roller the top hole takes its clamp too, which
// points along +y (up, as the roller sits in the machine).
module swing_roller_mould_half(half, nip = false)
{
    block_radius = swing_roller_radius + swing_roller_cast_grip_thickness;
    cavity_radius = nip ? nip_roller_radius : block_radius;
    half_length = swing_roller_length * 0.5;
    depth = block_radius + swing_roller_mould_wall;
    bolt_x = block_radius + swing_roller_mould_wall + swing_roller_mould_bolt_inset;
    width = (bolt_x + swing_roller_mould_bolt_margin) * 2;
    top = half_length + swing_roller_mould_top;
    bolt_z = half_length - swing_roller_mould_bolt_margin;
    side = (half == "a") ? 1 : -1;
    hub_hole_radius = swing_roller_hub_radius + swing_roller_mould_hub_clearance;
    socket_bottom = -(nip ? nip_roller_hub_end_y : swing_roller_idle_hub_end_y) - 0.5;
    bottom = socket_bottom - swing_roller_mould_socket_floor;
    sprue_x = (swing_roller_radius + cavity_radius) * 0.5;
    sprues = [[1, swing_roller_mould_pour_radius], [-1, swing_roller_mould_vent_radius]];

    // Everything cut into the split face, in x/z.
    module outline_2d()
    {
        translate([-cavity_radius, -half_length]) square([cavity_radius * 2, swing_roller_length]);
        translate([-hub_hole_radius, socket_bottom]) square([hub_hole_radius * 2, top - socket_bottom]);
        for (sprue = sprues)
        {
            polygon([for (p = [[sprue_x - sprue[1][0], half_length], [sprue_x + sprue[1][0], half_length], [sprue_x + swing_roller_mould_funnel_lean + sprue[1][1], top], [sprue_x + swing_roller_mould_funnel_lean - sprue[1][1], top]]) [sprue[0] * p[0], p[1]]]);
        }
    }

    module seal_2d(grow)
    {
        intersection()
        {
            difference()
            {
                offset(r=swing_roller_mould_seal_gap + swing_roller_mould_ridge_width + grow, $fn=100) outline_2d();
                offset(r=swing_roller_mould_seal_gap - grow, $fn=100) outline_2d();
            }
            translate([-width * 0.5, bottom]) square([width, top - bottom]);
        }
    }

    union() difference()
    {
        union()
        {
            translate([-width * 0.5, (side > 0) ? 0 : -depth, bottom]) cube([width, depth, top - bottom]);
            if (half == "b")
            {
                xz_extrude(-epsilon, swing_roller_mould_ridge_height) seal_2d(0);
            }
        }
        translate([0, 0, -half_length]) cylinder(r=cavity_radius, h=swing_roller_length, $fn=100);
        // Sockets for the roller's hubs: blind in the base for the idle end, through the top for the gear end.
        translate([0, 0, socket_bottom]) cylinder(r=hub_hole_radius, h=-half_length - socket_bottom + epsilon, $fn=100);
        translate([0, 0, half_length - epsilon])
        {
            linear_extrude(swing_roller_mould_top + (epsilon * 2))
            {
                offset(r=swing_roller_mould_hub_clearance, $fn=100)
                {
                    if (nip)
                    {
                        swing_clamp_2d([0, 0], swing_roller_hub_radius, swing_sun_clamp_radius);
                    }
                    else
                    {
                        circle(r=swing_roller_hub_radius, $fn=100);
                    }
                }
            }
        }
        if (nip)
        {
            translate([0, 0, half_length + nip_roller_mould_seal_land])
            {
                linear_extrude(swing_roller_mould_top - nip_roller_mould_seal_land + epsilon)
                {
                    intersection()
                    {
                        offset(r=swing_roller_mould_hub_clearance + nip_roller_mould_insert_relief, $fn=100) swing_clamp_2d([0, 0], swing_roller_hub_radius, swing_sun_clamp_radius);
                        translate([-cavity_radius, swing_roller_hub_radius]) square([cavity_radius * 2, cavity_radius]);
                    }
                }
            }
        }
        // Pour funnel and vent into the gap around the roller, on the split line so the sprues come away with the halves.
        for (sprue = sprues)
        {
            hull()
            {
                translate([sprue[0] * sprue_x, 0, half_length - epsilon]) cylinder(r=sprue[1][0], h=epsilon, $fn=100);
                translate([sprue[0] * (sprue_x + swing_roller_mould_funnel_lean), 0, top]) cylinder(r=sprue[1][1], h=epsilon, $fn=100);
            }
        }
        for (x = [-bolt_x, bolt_x], z = [-bolt_z, bolt_z])
        {
            translate([x, -depth - epsilon, z]) rotate([-90, 0, 0])
            {
                cylinder(r=exit_screw_clearance_radius, h=(depth + epsilon) * 2, $fn=100);
                if (half == "b")
                {
                    cylinder(r=swing_roller_mould_nut_radius, h=swing_roller_mould_nut_depth + epsilon, $fn=6);
                }
            }
        }
        if (half == "a")
        {
            xz_extrude(-epsilon, swing_roller_mould_ridge_height + swing_roller_mould_ridge_clearance) seal_2d(swing_roller_mould_ridge_clearance);
        }
    }
}

module swing_drive_arm()
{
    boss_y = swing_idler_shoulder_end_y - swing_idler_nut_depth;

    union() difference()
    {
        union()
        {
            xz_extrude(-swing_drive_arm_outer_y, -swing_gear_outer_y)
            {
                swing_link(swing_shaft, swing_hub_radius, swing_idler_center, swing_arm_end_radius);
                swing_link(swing_idler_center, swing_arm_end_radius, swing_roller_center, swing_arm_end_radius);
            }
            y_cylinder(swing_idler_center, swing_idler_boss_radius, boss_y, -swing_drive_arm_outer_y + epsilon, $fn=100);
        }
        y_bore(swing_shaft, swing_rod_clearance_radius, -swing_drive_arm_outer_y, -swing_gear_outer_y, $fn=100);
        difference()
        {
            y_cylinder(swing_shaft, swing_clutch_groove_outer_radius, -swing_gear_outer_y - swing_clutch_groove_depth, -swing_gear_outer_y + epsilon, $fn=100);
            y_bore(swing_shaft, swing_clutch_ring_outer_radius, -swing_gear_outer_y - swing_clutch_groove_depth, -swing_gear_outer_y, $fn=100);
        }
        y_bore(swing_roller_center, swing_axle_locating_radius, -swing_drive_arm_outer_y, -swing_gear_outer_y, $fn=100);
        y_bore(swing_idler_center, swing_idler_bore_radius, swing_idler_shoulder_end_y, -swing_gear_outer_y, $fn=100);
        y_bore(swing_idler_center, swing_idler_nut_radius, boss_y, swing_idler_shoulder_end_y, $fn=6);
    }
}

// The axle clamp faces up when engaged so its grub screw can be reached from above.
module swing_idle_arm()
{
    clamp_y = swing_idle_arm_y - swing_axle_clamp_length;
    clamp_middle_y = swing_idle_arm_y - (swing_axle_clamp_length * 0.5);

    union() difference()
    {
        union()
        {
            xz_extrude(swing_idle_arm_y, swing_idle_arm_outer_y) swing_link(swing_shaft, swing_hub_radius, swing_roller_center, swing_arm_end_radius);
            xz_extrude(clamp_y, swing_idle_arm_y + epsilon) swing_clamp_2d(swing_roller_center, swing_arm_end_radius, swing_axle_clamp_radius);
        }
        y_bore(swing_shaft, swing_rod_clearance_radius, swing_idle_arm_y, swing_idle_arm_outer_y, $fn=100);
        y_bore(swing_roller_center, swing_axle_clearance_radius, clamp_y, swing_idle_arm_outer_y, $fn=100);
        swing_clamp_cut(swing_roller_center, clamp_middle_y, swing_axle_clamp_radius);
    }
}

// Concave fillet rising from the plate around a 2D footprint. Layers are spaced evenly around the arc so every facet
// turns by the same amount, and joined through very thin slices so the joins don't leave ledges.
module base_fillet(radius, steps = 16)
{
    slice = 0.01;
    function flare(i) = radius * (1 - sin(90 * i / steps));
    function height(i) = radius * (1 - cos(90 * i / steps));

    for (i = [0:steps - 1])
    {
        hull()
        {
            for (j = [i, i + 1])
            {
                translate([0, 0, height(j) - (j == 0 ? epsilon : 0)])
                {
                    linear_extrude(slice + (j == 0 ? epsilon : 0))
                    {
                        offset(r=flare(j), $fn=100) children();
                    }
                }
            }
        }
    }
}

// Part of the scan plate. Both supports stop the roller axle's ends, when parked and at the lower stop below the card.
module swing_rod_supports()
{
    park_axle_angle = swing_arm_engaged_angle - swing_arm_park_rotation;
    stop_chord_angle = 2 * asin((swing_axle_radius + swing_axle_stop_radius) / (2 * swing_arm_length));
    axle_stop = swing_shaft + polar(swing_arm_length, park_axle_angle - stop_chord_angle);
    lower_axle_stop = swing_shaft + polar(swing_arm_length, swing_arm_engaged_angle + swing_arm_lower_travel_angle + stop_chord_angle);

    for (y = [swing_drive_support_y, swing_idle_support_y])
    {
        idle = (y == swing_idle_support_y);
        difference()
        {
            xz_extrude(y[0], y[1])
            {
                // Bearing for the nip roller's axle, standing straight up from the base; the idle support also carries
                // the nip idler's bolt.
                hull()
                {
                    translate(nip_bearing_center) circle(r=nip_bearing_boss_radius, $fn=100);
                    if (idle)
                    {
                        translate(nip_idler_center) circle(r=nip_idler_boss_radius, $fn=100);
                    }
                    translate([nip_bearing_center[0] - nip_bearing_boss_radius, -epsilon]) square([nip_bearing_boss_radius * 2, epsilon]);
                }
                hull()
                {
                    translate(swing_shaft) circle(r=swing_support_width * 0.5, $fn=100);
                    translate([swing_shaft[0] - (swing_support_base_width * 0.5), -epsilon]) square([swing_support_base_width, epsilon]);
                }
                // Webbed straight down to the base, which keeps it out of the axle's path and prints without overhangs.
                hull()
                {
                    translate(axle_stop) circle(r=swing_axle_stop_radius, $fn=100);
                    translate([swing_shaft[0] - (swing_support_base_width * 0.5), -epsilon]) square([swing_support_base_width, epsilon]);
                }
                hull()
                {
                    translate(lower_axle_stop) circle(r=swing_axle_stop_radius, $fn=100);
                    translate([lower_axle_stop[0] - swing_axle_stop_radius, -epsilon]) square([swing_axle_stop_radius * 2, epsilon]);
                }
            }
            y_bore(swing_shaft, swing_support_clearance_radius, y[0], y[1], $fn=100);
            y_bore(nip_bearing_center, swing_support_clearance_radius, y[0], y[1], $fn=100);
            if (idle)
            {
                translate([nip_idler_center[0], y[1] + epsilon, nip_idler_center[1]]) rotate([90, 0, 0])
                {
                    cylinder(r=swing_idler_shoulder_radius + 0.1, h=nip_idler_counterbore_depth + epsilon, $fn=100);
                    cylinder(r=exit_threaded_insert_radius, h=nip_idler_counterbore_depth + exit_threaded_insert_depth + epsilon, $fn=100);
                }
            }
        }
        base_fillet(swing_support_fillet_radius)
        {
            translate([swing_shaft[0] - (swing_support_base_width * 0.5), y[0]]) square([swing_support_base_width, y[1] - y[0]]);
        }
        base_fillet(swing_axle_stop_radius)
        {
            translate([lower_axle_stop[0] - swing_axle_stop_radius, y[0]]) square([swing_axle_stop_radius * 2, y[1] - y[0]]);
        }
    }
}

// Part of the scan plate. Sits beyond the frame's corner post and joins the plate inboard of it.
module swing_motor_mount()
{
    face_y = swing_motor_face_y;
    back_y = face_y - swing_motor_mount_thickness;
    left_x = swing_shaft[0] - (motor_full_mount_width * 0.5);
    // Outside the face plate so it is as far from the screw holes as the opposite edge.
    gusset_x = left_x - swing_motor_mount_thickness;
    post_x = exit_insert_length - extrusion_short_width;
    plate_y = -(base_plate_depth * 0.5) + 10;
    // Where the plate's edge starts to taper inwards, matching the hull in scan_plate().
    plate_edge_start_x = exit_insert_length - (base_plate_width * 0.7);
    height = base_plate_height + swing_shaft[1] + (motor_full_mount_width * 0.5);
    screws = [for (dx = [-1, 1], dz = [-1, 1]) swing_shaft + ([dx, dz] * stepping_motor_screw_hole_offset)];

    difference()
    {
        union()
        {
            translate([left_x, back_y, -base_plate_height])
            {
                cube([motor_full_mount_width, swing_motor_mount_thickness, height]);
            }
            // Filled out to the end of the plate's edge to stiffen the joint, on the side away from the corner post.
            hull()
            {
                translate([gusset_x, back_y, -base_plate_height]) cube([post_x - 1.5 - gusset_x, plate_y - back_y, base_plate_height]);
                translate([plate_edge_start_x, -(base_plate_depth * 0.5), -base_plate_height]) cube([gusset_x - plate_edge_start_x, 1, base_plate_height]);
            }
            hull()
            {
                translate([gusset_x, back_y, -base_plate_height]) cube([swing_motor_mount_thickness + epsilon, swing_motor_mount_thickness, height]);
                translate([gusset_x, plate_y - epsilon, -base_plate_height]) cube([swing_motor_mount_thickness, epsilon, base_plate_height]);
            }
        }
        y_bore(swing_shaft, swing_motor_boss_radius, back_y, face_y, $fn=100);
        for (screw = screws)
        {
            y_bore(screw, stepping_motor_screw_hole_radius, back_y, face_y, $fn=100);
            y_cylinder(screw, swing_motor_bolt_head_radius, face_y - swing_motor_bolt_head_depth, face_y + epsilon, $fn=100);
        }
    }
}

module swing_externals()
{
    color("blue")
    {
        y_cylinder(swing_shaft, swing_rod_radius, swing_motor_face_y + (swing_coupler_length * 0.5), nip_drive_hub_end_y, $fn=100);
        y_cylinder(nip_center, swing_rod_radius, swing_drive_support_y[0], nip_hub_end_y, $fn=100);
        // Long enough to reach half way through both supports' axle stops.
        swing_pose(swing_arm_angle) y_cylinder(swing_roller_center, swing_axle_radius, (swing_drive_support_y[0] + swing_drive_support_y[1]) * 0.5, (swing_idle_support_y[0] + swing_idle_support_y[1]) * 0.5, $fn=100);
    }
    color("blue")
    {
        difference()
        {
            y_cylinder(swing_shaft, swing_washer_outer_radius, swing_idle_arm_outer_y, swing_idle_support_y[0], $fn=100);
            y_bore(swing_shaft, swing_rod_radius, swing_idle_arm_outer_y, swing_idle_support_y[0], $fn=100);
        }
        difference()
        {
            y_cylinder(swing_shaft, swing_clutch_spring_outer_radius, swing_clutch_collar_y[1], -swing_drive_arm_outer_y, $fn=100);
            y_bore(swing_shaft, swing_clutch_spring_inner_radius, swing_clutch_collar_y[1], -swing_drive_arm_outer_y, $fn=100);
        }
    }
}

// Lets the roller hub and axle drop past the walls when the arm swings down onto its stop.
module swing_wall_notches()
{
    for (side = [0, 1])
    {
        mirror([0, side, 0])
        {
            translate([swing_roller_contact_x - (swing_wall_notch_length * 0.5), (card_magazine_hole_depth * 0.5) - epsilon, 0])
            {
                cube([swing_wall_notch_length, card_magazine_hole_scan_wall_size + (epsilon * 2), card_magazine_hole_scan_wall_height_size]);
            }
        }
    }
}

// Part of the scan plate, in its frame. One against each gantry post's inner face, filleted along its base and clipped to
// the plate, so the plate still drops in between the posts.
module scan_plate_gantry_brackets()
{
    x = base_plate_width - extrusion_short_width;
    bolt_z = base_plate_height + (scan_plate_bracket_height * 0.5);

    for (side = [0, 1])
    {
        translate([0, side * base_plate_depth, 0]) mirror([0, side, 0]) difference()
        {
            union()
            {
                translate([x, 0, base_plate_height]) cube([extrusion_short_width, scan_plate_bracket_thickness, scan_plate_bracket_height]);
                intersection()
                {
                    translate([0, 0, base_plate_height]) base_fillet(scan_plate_bracket_fillet_radius)
                    {
                        translate([x, 0]) square([extrusion_short_width, scan_plate_bracket_thickness]);
                    }
                    translate([x - scan_plate_bracket_fillet_radius - epsilon, 0, base_plate_height - epsilon]) cube([extrusion_short_width + scan_plate_bracket_fillet_radius + epsilon, scan_plate_bracket_thickness + scan_plate_bracket_fillet_radius + epsilon, scan_plate_bracket_fillet_radius + epsilon]);
                }
            }
            translate([x + (extrusion_short_width * 0.5), -epsilon, bolt_z]) rotate([-90, 0, 0]) extrusion_bolt_slot(scan_plate_bracket_thickness + (epsilon * 2), [0, 1, 0]);
        }
    }
}

// Mount for installing camera.
module camera_mount()
{
    camera_mount_depth = extrusion_short_width;
    camera_mount_gantry_mount_width = 8;
    camera_mount_gantry_mount_height = base_plate_height * 2.5;
    camera_center = camera_mount_camera_center;
    camera_holes = [camera_center + [0, 29], camera_center + [-4, -21.5]];
    pad_radius = led_ring_spacer_radius + camera_mount_pad_margin;
    pad_points = concat(camera_holes, led_ring_hole_positions);
    taper_start_y = min([for (p = pad_points) p[1]]) - pad_radius - camera_mount_arm_taper_length;

    union() difference()
    {
        union()
        {
            linear_extrude(base_plate_height)
            {
                offset(r=camera_mount_corner_radius, $fn=100) offset(r=-camera_mount_corner_radius * 2, $fn=100) offset(r=camera_mount_corner_radius, $fn=100)
                {
                    square([camera_mount_plate_width, camera_mount_depth]);
                    translate([camera_mount_camera_x - (camera_mount_arm_width * 0.5), 0]) square([camera_mount_arm_width, taper_start_y]);
                    hull()
                    {
                        translate([camera_mount_camera_x - (camera_mount_arm_width * 0.5), taper_start_y - epsilon]) square([camera_mount_arm_width, epsilon]);
                        for (p = pad_points)
                        {
                            translate(p) circle(r=pad_radius, $fn=100);
                        }
                    }
                }
            }
            translate([camera_mount_plate_width - camera_mount_gantry_mount_width, 0, 0])
            {
                difference()
                {
                    cube([camera_mount_gantry_mount_width, camera_mount_depth, camera_mount_gantry_mount_height]);
                    translate([-epsilon, camera_mount_depth * 0.5, (base_plate_height + camera_mount_gantry_mount_height) * 0.5])
                    {
                        rotate([0, 90, 0]) extrusion_bolt_slot(20, [1, 0, 0]);
                    }
                }
            }
            for (hole = camera_holes)
            {
                translate([hole[0], hole[1], 7.2]) cylinder(r=IMX179_hole_radius * 1.5, h=6, $fn=100);
            }
        }
        difference()
        {
            translate([camera_center[0], camera_center[1], -4.8])
            {
                hull()
                {
                    translate([0, -7, 0]) cylinder(h=15, r1=18, r2=9, $fn=100);
                    translate([0, 7, 0]) cylinder(h=15, r1=18, r2=9, $fn=100);
                }
            }
            for (hole = camera_holes)
            {
                translate([hole[0], hole[1], -4.8 - epsilon]) cylinder(r=camera_mount_screw_seat_radius, h=15 + (epsilon * 2), $fn=100);
            }
        }
        for (hole = camera_holes)
        {
            translate([hole[0], hole[1], -4.8]) cylinder(r=IMX179_hole_radius, h=20, $fn=100);
        }
        for (hole = led_ring_hole_positions)
        {
            translate([hole[0], hole[1], -epsilon]) cylinder(r=led_ring_bolt_clearance_radius, h=base_plate_height + (epsilon * 2), $fn=100);
            translate([hole[0], hole[1], base_plate_height - led_ring_nut_depth]) cylinder(r=led_ring_nut_radius, h=led_ring_nut_depth + epsilon, $fn=6);
        }
    }
}

// What the camera sees, from the lens down to the top of the card stack.
module camera_view()
{
    half = [for (angle = camera_view_angles) camera_view_depth * tan(angle * 0.5)];

    polyhedron(
        [[0, 0, 0], [-half[0], -half[1], -camera_view_depth], [half[0], -half[1], -camera_view_depth], [half[0], half[1], -camera_view_depth], [-half[0], half[1], -camera_view_depth]],
        [[0, 2, 1], [0, 3, 2], [0, 4, 3], [0, 1, 4], [1, 2, 3, 4]]);
}

// Keeps the LED ring clear of the wires soldered to its back.
module led_ring_spacer()
{
    union() difference()
    {
        cylinder(r=led_ring_spacer_radius, h=led_ring_spacer_height, $fn=100);
        translate([0, 0, -epsilon]) cylinder(r=led_ring_bolt_clearance_radius, h=led_ring_spacer_height + (epsilon * 2), $fn=100);
    }
}

// Clamp between extrusion and bearing rod.
// Origin should be center of rod.
module extrusion_clamp_mount()
{
    translate([-extrusion_clamp_width - bearing_rod_clamp_rod_to_base_offset, -bearing_rod_clamp_plate_height * 0.5, -(bearing_rod_clamp_plate_depth * 0.5)])
    {
        difference()
        {
            translate([0, 0, -extrusion_clamp_height_padding * 0.5])
            {
                hull()
                {
                    translate([0, extrusion_clamp_corner_radius, extrusion_clamp_corner_radius])                                                                                              rotate([0, 90, 0]) cylinder(r=extrusion_clamp_corner_radius, h=extrusion_clamp_width, $fn=100);
                    translate([0, bearing_rod_clamp_plate_height - extrusion_clamp_corner_radius, extrusion_clamp_corner_radius])                                                                     rotate([0, 90, 0]) cylinder(r=extrusion_clamp_corner_radius, h=extrusion_clamp_width, $fn=100);
                    translate([0, extrusion_clamp_corner_radius, bearing_rod_clamp_plate_depth + extrusion_clamp_height_padding - extrusion_clamp_corner_radius])                             rotate([0, 90, 0]) cylinder(r=extrusion_clamp_corner_radius, h=extrusion_clamp_width, $fn=100);
                    translate([0, bearing_rod_clamp_plate_height - extrusion_clamp_corner_radius, bearing_rod_clamp_plate_depth + extrusion_clamp_height_padding - extrusion_clamp_corner_radius])  rotate([0, 90, 0]) cylinder(r=extrusion_clamp_corner_radius, h=extrusion_clamp_width, $fn=100);
                }
                
            }
            union()
            {
                // Clamp connectors
                translate([-epsilon, bearing_rod_clamp_plate_height * 0.5, (bearing_rod_clamp_plate_depth * 0.5) - bearing_rod_clamp_rod_to_screw_offset])
                {
                    rotate([0, 90, 0]) cylinder(h=extrusion_clamp_width + (epsilon * 2), r=bearing_rod_clamp_screw_radius, $fn=100);
                }
                translate([-epsilon, bearing_rod_clamp_plate_height * 0.5, (bearing_rod_clamp_plate_depth * 0.5) + bearing_rod_clamp_rod_to_screw_offset])
                {
                    rotate([0, 90, 0]) cylinder(h=extrusion_clamp_width + (epsilon * 2), r=bearing_rod_clamp_screw_radius, $fn=100);
                }                
            }
        }
    }
}

// Part of the scan plate, origin at the wall top at the hole's edge.
module limit_switch_tab()
{
    width = limit_switch_tab_width;
    thickness = limit_switch_tab_thickness;
    height = limit_switch_tab_height;

    translate([0, limit_switch_carrier_thickness, 0]) difference()
    {
        translate([-width * 0.5, 0, -card_magazine_hole_scan_wall_height_size]) cube([width, thickness, height + card_magazine_hole_scan_wall_height_size]);
        for (side = [-1, 1])
        {
            hull()
            {
                for (z = [limit_switch_clamp_low, limit_switch_clamp_low + limit_switch_travel])
                {
                    translate([side * limit_switch_clamp_spacing * 0.5, -epsilon, z]) rotate([-90, 0, 0]) cylinder(r=exit_screw_clearance_radius, h=thickness + (epsilon * 2), $fn=100);
                }
            }
            hull()
            {
                for (z = [limit_switch_bolt_low, limit_switch_bolt_low + limit_switch_travel])
                {
                    translate([side * limit_switch_mount_hole_distance * 0.5, -epsilon, z]) rotate([-90, 0, 0]) cylinder(r=limit_switch_bolt_head_radius, h=limit_switch_bolt_head_depth + epsilon, $fn=100);
                }
            }
        }
        translate([0, thickness * 0.5, height - exit_threaded_insert_depth]) cylinder(r=exit_threaded_insert_radius, h=exit_threaded_insert_depth + epsilon, $fn=100);
    }
}

// Runs down through the tab, wall and scan plate below the insert, so the adjustment screw can be any length.
module limit_switch_screw_cut()
{
    bottom = -card_magazine_hole_scan_wall_height_size - base_plate_height - epsilon;
    translate([0, limit_switch_carrier_thickness + (limit_switch_tab_thickness * 0.5), bottom]) cylinder(r=exit_screw_clearance_radius, h=limit_switch_tab_height - bottom, $fn=100);
}

// Shown with the screw done right down; the spring sits in a pocket under the flange.
module limit_switch_carrier()
{
    tab = limit_switch_tab_thickness;
    thickness = limit_switch_carrier_thickness;
    flange_z = limit_switch_tab_height + limit_switch_carrier_gap;
    top = flange_z + limit_switch_carrier_flange;
    bottom = limit_switch_carrier_bottom;
    side_x = (limit_switch_tab_width * 0.5) + limit_switch_carrier_side_clearance;
    width = (side_x + limit_switch_carrier_side_thickness) * 2;

    translate([0, thickness, 0]) union() difference()
    {
        union()
        {
            translate([-width * 0.5, -thickness, bottom]) cube([width, thickness, top - bottom]);
            translate([-width * 0.5, -thickness, flange_z]) cube([width, thickness + tab, limit_switch_carrier_flange]);
            for (side = [-1, 1])
            {
                translate([side < 0 ? -width * 0.5 : side_x, -epsilon, bottom]) cube([limit_switch_carrier_side_thickness, tab + epsilon, top - bottom]);
            }
        }
        for (side = [-1, 1])
        {
            translate([side * limit_switch_mount_hole_distance * 0.5, epsilon, limit_switch_bolt_low]) rotate([90, 0, 0]) cylinder(r=limit_switch_mount_hole_radius, h=thickness + (epsilon * 2), $fn=100);
            translate([side * limit_switch_clamp_spacing * 0.5, epsilon, limit_switch_clamp_low])
            {
                rotate([90, 0, 0])
                {
                    cylinder(r=exit_screw_clearance_radius, h=thickness + (epsilon * 2), $fn=100);
                    translate([0, 0, thickness - limit_switch_clamp_nut_depth + epsilon]) cylinder(r=limit_switch_clamp_nut_radius, h=limit_switch_clamp_nut_depth + epsilon, $fn=6);
                }
            }
        }
        translate([0, tab * 0.5, flange_z - epsilon])
        {
            cylinder(r=exit_screw_clearance_radius, h=limit_switch_carrier_flange + (epsilon * 2), $fn=100);
            cylinder(r=exit_spring_radius, h=exit_spring_depth + epsilon, $fn=100);
        }
    }
}

// Attachment for limit switch to extrusion
module extrusion_limit_switch_mount(arm_length_offset, arm_depth_offset)
{
    depth = limit_switch_mount_depth + arm_depth_offset;
    arm_depth = limit_switch_mount_arm_depth + arm_depth_offset;

    translate([-limit_switch_mount_width, 0, 0])
    {
        difference()
        {
            union()
            {
                cube([limit_switch_mount_width, depth, limit_switch_mount_height]);
                translate([-limit_switch_mount_arm_width - arm_length_offset, 0, (limit_switch_mount_height * 0.5) - (limit_switch_mount_hole_gap_height * 0.5)])
                {
                    cube([limit_switch_mount_arm_width + arm_length_offset, arm_depth, limit_switch_mount_arm_height]);
                }
            }
            union()
            {                
                // Cut part out behind the limit switch so we can bolt it.abs
                translate([-limit_switch_mount_arm_width - arm_length_offset + limit_switch_mount_hole_length, -epsilon, (limit_switch_mount_height * 0.5) - (limit_switch_mount_hole_gap_height * 0.5)])
                {
                    translate([0, 0, limit_switch_mount_hole_gap_height])
                    {
                        cube([limit_switch_mount_arm_width + arm_length_offset - limit_switch_mount_hole_length, depth + (epsilon * 2), limit_switch_mount_arm_height]);
                    }
                }
                
                // Clamp connectors, inset so their slots keep solid ends.
                translate([-epsilon, depth * 0.5, 8])
                {
                    rotate([0, 90, 0]) extrusion_bolt_slot(limit_switch_mount_width + (epsilon * 2), [1, 0, 0]);
                }
                translate([-epsilon, depth * 0.5, limit_switch_mount_height - 8])
                {
                    rotate([0, 90, 0]) extrusion_bolt_slot(limit_switch_mount_width + (epsilon * 2), [1, 0, 0]);
                } 
                
                // Limit switch holes.
                translate([-limit_switch_mount_arm_width, 0, limit_switch_mount_arm_height - limit_switch_mount_hole_vertical_inset])
                {
                    translate([-epsilon - arm_length_offset, arm_depth - limit_switch_mount_hole_inset, (limit_switch_mount_arm_height * 0.5)])
                    {
                        hull()
                        {
                            rotate([0, 90, 0]) cylinder(h=limit_switch_mount_hole_length + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=100);
                            translate([0, -(arm_depth - (limit_switch_mount_hole_inset * 2)), 0])
                            {
                                rotate([0, 90, 0]) cylinder(h=limit_switch_mount_hole_length + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=100);
                            }
                        }
                    }
                    translate([-epsilon - arm_length_offset, arm_depth - limit_switch_mount_hole_inset, (limit_switch_mount_arm_height * 0.5) - limit_switch_mount_hole_distance])
                    {
                        hull()
                        {
                            rotate([0, 90, 0]) cylinder(h=limit_switch_mount_hole_length + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=100);
                            translate([0, -(arm_depth - (limit_switch_mount_hole_inset * 2)), 0])
                            {
                                rotate([0, 90, 0]) cylinder(h=limit_switch_mount_hole_length + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=100);
                            }
                        }
                    }
                }
            }
        }
    }
}

// The plate that the card mover runs across.
module card_mover_plate_motor()
{
    difference()
    {
        difference()
        {
            union()
            {
                cube([extrusion_motor_mount_width, extrusion_motor_mount_height, extrusion_motor_mount_depth]);                            
                translate([extrusion_motor_mount_width, 0, 0])
                {
                    cube([extrusion_clamp_width, extrusion_motor_mount_height + extrusion_short_height, extrusion_motor_mount_depth]);
                }
        
                translate([0, -extrusion_motor_mount_thickness + extrusion_motor_mount_height, (extrusion_motor_mount_depth - extrusion_motor_mount_arm_height) * 0.5])
                {
                    cube([extrusion_motor_mount_offset, extrusion_motor_mount_thickness, extrusion_motor_mount_arm_height]);
                    translate([extrusion_motor_mount_offset - extrusion_motor_mount_thickness, -extrusion_motor_mount_plate_depth, 0])
                    {
                        cube([extrusion_motor_mount_thickness, extrusion_motor_mount_plate_depth, extrusion_motor_mount_arm_height]);
                    }
            
                    // Bottom brace                                
                    hull()
                    {
                        translate([0, 0, -7])
                        {
                            cube([extrusion_motor_mount_offset, extrusion_motor_mount_thickness, 7]);
                            translate([extrusion_motor_mount_offset - extrusion_motor_mount_thickness, -extrusion_motor_mount_plate_depth, 0])
                            {
                                cube([extrusion_motor_mount_thickness, extrusion_motor_mount_plate_depth, 7]);
                            }
                        }
                    }
                    // Top brace
                    hull()
                    {
                        translate([0, 0, extrusion_motor_mount_arm_height])
                        {
                            cube([extrusion_motor_mount_offset, extrusion_motor_mount_thickness, 7]);
                            translate([extrusion_motor_mount_offset - extrusion_motor_mount_thickness, -extrusion_motor_mount_plate_depth, 0])
                            {
                                cube([extrusion_motor_mount_thickness, extrusion_motor_mount_plate_depth, 7]);
                            }
                        }
                    }
                }
            }
            union()
            {
                // Holes to connect to gantry
                translate([0, extrusion_motor_mount_height - 10, 0])
                {
                    translate([extrusion_motor_mount_width * 0.5, 15, extrusion_motor_mount_depth * 0.10]) rotate([90, 0, 0]) extrusion_bolt_slot(extrusion_motor_mount_height + 10 + epsilon, [0, 1, 0]);
                    translate([extrusion_motor_mount_width * 0.5, 15, extrusion_motor_mount_depth * 0.50]) rotate([90, 0, 0]) extrusion_bolt_slot(40, [0, 1, 0]);
                    translate([extrusion_motor_mount_width * 0.5, 0, extrusion_motor_mount_depth * 0.50]) rotate([90, 0, 0]) cylinder(h=40, r=card_magazine_lifter_rod_plate_hole_radius + 3, $fn=100);
                    translate([extrusion_motor_mount_width * 0.5, 15, extrusion_motor_mount_depth * 0.90]) rotate([90, 0, 0]) extrusion_bolt_slot(extrusion_motor_mount_height + 10 + epsilon, [0, 1, 0]);
                }
        
                // Holes to connect rod clamps                            
                translate([extrusion_motor_mount_width, extrusion_motor_mount_height + (extrusion_short_height * 0.5), (extrusion_motor_mount_depth*0.5) + card_mover_bottom_bar_offset])
                {                            
                    // Clamp connectors
                    translate([-epsilon, 0, -bearing_rod_clamp_rod_to_screw_offset])
                    {
                        rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=100);
                    }
                    translate([-epsilon, 0, +bearing_rod_clamp_rod_to_screw_offset])
                    {
                        rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=100);
                    }
                }                        
                translate([extrusion_motor_mount_width, extrusion_motor_mount_height + (extrusion_short_height * 0.5), (extrusion_motor_mount_depth*0.5) + card_mover_top_bar_offset])
                {                            
                    // Clamp connectors
                    translate([-epsilon, 0, -bearing_rod_clamp_rod_to_screw_offset])
                    {
                        rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=100);
                    }
                    translate([-epsilon, 0, +bearing_rod_clamp_rod_to_screw_offset])
                    {
                        rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=100);
                    }
                }   
            }
        }                    
        translate([0, -extrusion_motor_mount_thickness, (extrusion_motor_mount_depth - extrusion_motor_mount_arm_height) * 0.5])
        {
            translate([extrusion_motor_mount_offset - extrusion_motor_mount_thickness, -extrusion_motor_mount_plate_depth + extrusion_motor_mount_height, 0])
            {
                translate([extrusion_motor_mount_thickness + epsilon, extrusion_motor_mount_plate_depth * 0.5, extrusion_motor_mount_arm_height * 0.5])
                {
                    // Big hole for spigot.                                
                    rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=extrusion_motor_mount_spigot_radius, $fn=100);
        
                    // Holes to mount motor.
                    translate([0, stepping_motor_screw_hole_offset, stepping_motor_screw_hole_offset]) rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=stepping_motor_screw_hole_radius, $fn=100);
                    translate([0, -stepping_motor_screw_hole_offset, stepping_motor_screw_hole_offset]) rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=stepping_motor_screw_hole_radius, $fn=100);
                    translate([0, stepping_motor_screw_hole_offset, -stepping_motor_screw_hole_offset]) rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=stepping_motor_screw_hole_radius, $fn=100);
                    translate([0, -stepping_motor_screw_hole_offset, -stepping_motor_screw_hole_offset]) rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=stepping_motor_screw_hole_radius, $fn=100);
                }
            }
        }
    }
}

module card_mover_plate_spindle()
{
    difference()
    {
        difference()
        {
            union()
            {
                translate([0, -extrusion_motor_mount_height, 0])
                {
                    cube([extrusion_motor_mount_width, extrusion_motor_mount_height, extrusion_motor_mount_depth]);                            
                }
                translate([extrusion_motor_mount_width, -extrusion_motor_mount_height - extrusion_short_height, 0])
                {
                    cube([extrusion_clamp_width, extrusion_motor_mount_height + extrusion_short_height, extrusion_motor_mount_depth]);
                }
        
                translate([0, -extrusion_motor_mount_height, (extrusion_motor_mount_depth - extrusion_motor_mount_arm_height) * 0.5])
                {
                    cube([extrusion_motor_mount_offset, extrusion_motor_mount_thickness, extrusion_motor_mount_arm_height]);
                    translate([extrusion_motor_mount_offset - extrusion_motor_mount_thickness, extrusion_motor_mount_thickness, 0])
                    {
                        cube([extrusion_motor_mount_thickness, extrusion_spindle_mount_plate_depth, extrusion_motor_mount_arm_height]);
                    }
        
                    // Bottom brace                                
                    hull()
                    {
                        translate([0, 0, -5])
                        {
                            cube([extrusion_motor_mount_offset, extrusion_motor_mount_thickness, 7]);
                            translate([extrusion_motor_mount_offset - extrusion_motor_mount_thickness, extrusion_motor_mount_thickness, 0])
                            {
                                cube([extrusion_motor_mount_thickness, extrusion_spindle_mount_plate_depth, 7]);
                            }
                        }
                    }
                    // Top brace
                    hull()
                    {
                        translate([0, 0, extrusion_motor_mount_arm_height])
                        {
                            cube([extrusion_motor_mount_offset, extrusion_motor_mount_thickness, 7]);
                            translate([extrusion_motor_mount_offset - extrusion_motor_mount_thickness, extrusion_motor_mount_thickness, 0])
                            {
                                cube([extrusion_motor_mount_thickness, extrusion_spindle_mount_plate_depth, 7]);
                            }
                        }
                    }
                }
            }
            union()
            {
                // Holes to connect to gantry
                translate([0, epsilon + 10, 0])
                {
                    translate([extrusion_motor_mount_width * 0.5, 0, extrusion_motor_mount_depth * 0.10]) rotate([90, 0, 0]) extrusion_bolt_slot(extrusion_motor_mount_height + epsilon + 10, [0, 1, 0]);
                    translate([extrusion_motor_mount_width * 0.5, 0, extrusion_motor_mount_depth * 0.50]) rotate([90, 0, 0]) extrusion_bolt_slot(extrusion_motor_mount_height + epsilon + 10, [0, 1, 0]);
                    translate([extrusion_motor_mount_width * 0.5, 10, extrusion_motor_mount_depth * 0.50]) rotate([90, 0, 0]) cylinder(h=extrusion_motor_mount_height + epsilon + 10, r=card_magazine_lifter_rod_plate_hole_radius + 3, $fn=100);
                    translate([extrusion_motor_mount_width * 0.5, 0, extrusion_motor_mount_depth * 0.90]) rotate([90, 0, 0]) extrusion_bolt_slot(extrusion_motor_mount_height + epsilon + 10, [0, 1, 0]);
                }
        
                // Holes to connect rod clamps
                translate([extrusion_motor_mount_width, -extrusion_motor_mount_height - (extrusion_short_height * 0.5), (extrusion_motor_mount_depth*0.5) + card_mover_bottom_bar_offset])
                {                     
                    // Clamp connectors
                    translate([-epsilon, 0, -bearing_rod_clamp_rod_to_screw_offset])
                    {
                        rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=100);
                    }
                    translate([-epsilon, 0, +bearing_rod_clamp_rod_to_screw_offset])
                    {
                        rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=100);
                    }
                }                        
                translate([extrusion_motor_mount_width, -extrusion_motor_mount_height - (extrusion_short_height * 0.5), (extrusion_motor_mount_depth*0.5) + card_mover_top_bar_offset])
                {                            
                    // Clamp connectors
                    translate([-epsilon, 0, -bearing_rod_clamp_rod_to_screw_offset])
                    {
                        rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=100);
                    }
                    translate([-epsilon, 0, +bearing_rod_clamp_rod_to_screw_offset])
                    {
                        rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=100);
                    }
                } 
            }
        }                    

        translate([0, -extrusion_motor_mount_height, (extrusion_motor_mount_depth - extrusion_motor_mount_arm_height) * 0.5])
        { 
            translate([extrusion_motor_mount_offset - extrusion_motor_mount_thickness, extrusion_motor_mount_thickness, 0])
            {
                translate([extrusion_motor_mount_thickness + epsilon, extrusion_spindle_mount_plate_depth * 0.5, extrusion_motor_mount_arm_height * 0.5])
                {                      
                    rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=extrusion_spindle_mount_hole_radius, $fn=100);
                    translate([-extrusion_motor_mount_thickness + 3 - epsilon * 2, 0, 0]) rotate([0, -90, 0]) cylinder(h=3, r=9 * 0.5, $fn=6);
                }
            }
        }
    }
}

module camera_mount_externals()
{
    color("blue")
    {
        translate([camera_mount_camera_x, extrusion_short_width + (base_plate_depth * 0.5), -led_ring_spacer_height - led_ring_thickness])
        {
            difference()
            {
                cylinder(r=led_ring_outer_radius, h=led_ring_thickness, $fn=100);
                translate([0, 0, -epsilon]) cylinder(r=led_ring_inner_radius, h=led_ring_thickness + (epsilon * 2), $fn=100);
                for (angle = led_ring_hole_angles)
                {
                    rotate(angle) translate([led_ring_hole_radius, 0, -epsilon]) cylinder(r=1, h=led_ring_thickness + (epsilon * 2), $fn=100);
                }
            }
        }
    }
}

module card_mover_plate_externals()
{
    translate([-(extrusion_short_depth) + card_mover_bar_offset, 0, card_mover_top_bar_height])
    {
        rotate([-90, 0, 0])
        {
            color("blue") cylinder(r=card_mover_bearing_rod_radius, h=card_mover_bearing_rod_height, $fn=100);
        }   
    }
    translate([-(extrusion_short_depth) + card_mover_bar_offset, 0, card_mover_bottom_bar_height])
    {
        rotate([-90, 0, 0])
        {
            color("blue") cylinder(r=card_mover_bearing_rod_radius, h=card_mover_bearing_rod_height, $fn=100);
        }   
    }

}

module belt_terminator_outer()
{         
    translate([0, 0, -0.3])
    {
        hull()
        {
            translate([-epsilon, 7, belt_block_height * 0.5])
            {
                rotate([0, 90, 0]) cylinder(h=belt_block_cut_depth, r=5.5, $fn=100);
            }
            translate([-epsilon, 0, (belt_block_height * 0.5)+3.8])
            {
                rotate([0, 90, 0]) cylinder(h=belt_block_cut_depth, r=1.5, $fn=100);
            }
        }
    }
}

module belt_terminator_inner()
{     
    translate([0, 0, -0.3])                     
    {
        hull()
        {
            translate([-epsilon, 7, belt_block_height * 0.5])
            {
                rotate([0, 90, 0]) cylinder(h=belt_block_cut_depth, r=6.5 * 0.5, $fn=100);
            }
            translate([-epsilon, 2, (belt_block_height * 0.5) + 3])
            {
                rotate([0, 90, 0]) cylinder(h=belt_block_cut_depth, r=2.5 * 0.5, $fn=100);
            }
        }
    }
}        

// The module that moves across the plate to deliver a card to a specific bin.
module card_mover()
{
    difference()
    {
        union()
        {
            // Back plate
            translate([-(card_mover_back_width * 0.5) + card_mover_back_offset, -(card_mover_back_height * 0.5), -(card_mover_back_depth * 0.5)])
            {
                translate([0, 0, card_mover_back_height_offset - 20])
                {
                    cube([card_mover_back_width, card_mover_back_height , card_mover_back_depth + 20]);
                }
            
                // Add block that the belt will be put into.       
                translate([0, 0, belt_block_offset])
                {
                    translate([-card_mover_back_width + -belt_block_width, 0, (card_mover_back_depth * 0.5) - (belt_block_height * 0.5)])
                    {
                        difference()
                        {
                            cube([belt_block_width, belt_block_depth, belt_block_height]); 
                            belt_terminator_outer();
                        }
                        belt_terminator_inner();
                    }
                    translate([-card_mover_back_width + -belt_block_width, belt_block_depth, (card_mover_back_depth * 0.5) - (belt_block_height * 0.5)])
                    {
                        difference()
                        {
                            cube([belt_block_width, belt_block_depth, belt_block_height]); 
                            translate([0, belt_block_depth, 0]) mirror([0, 1, 0]) belt_terminator_outer();
                        }
                        translate([0, belt_block_depth, 0]) mirror([0, 1, 0]) belt_terminator_inner();
                    }
                }
            
                // Little triangle to fill the back space up.
                // Super jank, should be improved to be parametric and not just magic numbers.
               hull()
               { 
                    hull()             
                    {
                        translate([-card_mover_back_width, - 15, card_mover_back_depth + 5 + 38])
                        {
                            cube([1, card_mover_back_height + 30, 1]);
                        }                  
                        translate([-card_mover_back_width, 0, card_mover_back_depth + 5])
                        {
                            cube([1, card_mover_back_height, 1]);
                        }
                    }
                    hull()
                    {
                        translate([card_mover_back_width - 1, 0, card_mover_back_depth + 5])
                        {
                            cube([1, card_mover_back_height, 1]);
                        }
                        translate([card_mover_back_width - 1, 0, card_mover_back_depth + 5 + 20])
                        {
                            cube([1, card_mover_back_height, 1]);
                        }
                    }
                    translate([card_mover_back_width + 17, 0, card_mover_back_depth + 5])
                    {
                        cube([1, card_mover_back_height, 1]);
                    }
                }
            
            }            
            // Rod bearing
            translate([(card_mover_bearing_rod_radius * 0.5) + bearing_rod_bearing_bearing_to_base_offset, -(card_mover_bearing_mount_height * 0.5), -(card_mover_back_depth * 0.5) + card_mover_back_height_offset - 20])
            {
                cube([card_mover_bearing_mount_width, card_mover_bearing_mount_height, card_mover_back_depth + 20]);
            }
        }
        union()
        {
            // Top bolt holes
            translate([(card_mover_bearing_rod_radius * 0.5) + bearing_rod_bearing_bearing_to_base_offset, -(card_mover_bearing_mount_height * 0.5), card_mover_top_bar_offset - (card_mover_bearing_mount_depth * 0.5)])
            {
                translate([card_mover_bearing_mount_hole_length - epsilon, card_mover_bearing_mount_height * 0.5, card_mover_bearing_mount_depth * 0.5])
                {
                    translate([0, card_magazine_lifter_rod_plate_hole_offset_height, card_magazine_lifter_rod_plate_hole_offset_depth])
                    {
                        rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=100);
                    }
                    translate([0, card_magazine_lifter_rod_plate_hole_offset_height, -card_magazine_lifter_rod_plate_hole_offset_depth])
                    {
                        rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=100);
                    }
                    translate([0, -card_magazine_lifter_rod_plate_hole_offset_height, card_magazine_lifter_rod_plate_hole_offset_depth])
                    {
                        rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=100);
                    }
                    translate([0, -card_magazine_lifter_rod_plate_hole_offset_height, -card_magazine_lifter_rod_plate_hole_offset_depth])
                    {
                        rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=100);
                    }
                }
            }
        
            // Bottom bolt holes
            translate([(card_mover_bearing_rod_radius * 0.5) + bearing_rod_bearing_bearing_to_base_offset, -(card_mover_bearing_mount_height * 0.5), card_mover_bottom_bar_offset - (card_mover_bearing_mount_depth * 0.5)])
            {
                translate([card_mover_bearing_mount_hole_length - epsilon, card_mover_bearing_mount_height * 0.5, card_mover_bearing_mount_depth * 0.5])
                {
                    translate([0, card_magazine_lifter_rod_plate_hole_offset_height, card_magazine_lifter_rod_plate_hole_offset_depth])
                    {
                        rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=100);
                    }
                    translate([0, card_magazine_lifter_rod_plate_hole_offset_height, -card_magazine_lifter_rod_plate_hole_offset_depth])
                    {
                        rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=100);
                    }
                    translate([0, -card_magazine_lifter_rod_plate_hole_offset_height, card_magazine_lifter_rod_plate_hole_offset_depth])
                    {
                        rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=100);
                    }
                    translate([0, -card_magazine_lifter_rod_plate_hole_offset_height, -card_magazine_lifter_rod_plate_hole_offset_depth])
                    {
                        rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=100);
                    }
                }
            }
        }
    }            
}

module card_mover_slide()
{
    difference()
    {
        union()
        {
            forward_offset = 80.0;
            total_steps = 200.0;
            total_height = 60;
            bottom_offset = total_height - 12;
    
            card_mover_slide_profile(0, 0, false, 0, 0);
        
            for (i = [0 : total_steps])
            {
                step_offset = lerp(0, total_height, i / total_steps);
                translate([0, 0, step_offset])
                {
                    top_forward_offset_a = lerp(0, forward_offset, easeInSine((1.0 / total_steps) * i));
                    bottom_height_offset = lerp(0, bottom_offset, (1.0 / total_steps) * i);
                
                    card_mover_slide_profile(1, 1, true, bottom_height_offset, top_forward_offset_a);
                    card_mover_slide_profile(1, 1, false, bottom_height_offset, top_forward_offset_a);
                }
            }
            
            final_step_offset = total_height;
            translate([0, 0, final_step_offset])
            {
                bottom_height_offset = lerp(0, bottom_offset, 1.0);
                card_mover_slide_profile(30, 30, true, bottom_height_offset, forward_offset);
                card_mover_slide_profile(30, 30, false, bottom_height_offset, forward_offset);
            }
        }
        union()
        {

            // Cut out hole for server rotator. 
            translate([card_mover_slide_drop * 0.8 - 10, 0, -card_mover_slide_drop * 0.8 - 20])
            {
                rotate([0, 45, 0])
                {
                    translate([-sg90_mounting_width + 10, -3, 12])
                    {
                        cube([(sg90_mounting_width * 2) + sg90_width - 15, 6, 10]);
                    }
                }
            }
        }
    }

    // Add mount for stopping servo            
    translate([card_mover_slide_drop * 0.8 - 10, -5.5, -card_mover_slide_drop * 0.8 - 20])
    {
        rotate([90, 45, 0])
        {
            translate([0, 2, sg90_distance_to_rotor])
            {
                sg90_mount(1.0);
            }
        }
    }
}

module sg90_mount(extra_depth)
{
    difference()
    {
        union()
        {
            if (show_externals)
            {
                color("blue") cube([sg90_width, sg90_depth, sg90_height]);
            }
            translate([-sg90_mounting_width, 0, 0])
            {
                cube([sg90_mounting_width, sg90_depth + extra_depth, sg90_height * 0.6]);
            }
            translate([sg90_width, 0, 0])
            {
                cube([sg90_mounting_width, sg90_depth + extra_depth, sg90_height * 0.6]);
            }
        }
        union()
        {
            translate([(sg90_width * 0.5) - (sg90_hole_distance * 0.5), sg90_depth * 0.5, -epsilon])
            {
                cylinder(h=sg90_height + (epsilon * 2), r=sg90_hole_radius, $fn=100);
            }
            translate([(sg90_width * 0.5) + (sg90_hole_distance * 0.5), sg90_depth * 0.5, -epsilon])
            {
                cylinder(h=sg90_height + (epsilon * 2), r=sg90_hole_radius, $fn=100);
            }
        }
    }
}

module card_mover_slide_profile(override_depth, override_mid_depth, left_side, bottom_height_offset, top_forward_offset)
{
    card_mover_slide_drop_height = 0;
    card_mover_slide_drop_height_end = -card_mover_slide_drop - bottom_height_offset;           
    card_mover_slide_drop_width = 0;
    card_mover_slide_drop_width_end = card_mover_slide_drop;              
    card_mover_slide_depth_delta = card_mover_slide_depth - card_mover_slide_mid_depth;
    
    card_mover_slide_actual_depth = (override_depth > 0) ? override_depth : card_mover_slide_depth;
    card_mover_slide_actual_mid_depth = (override_mid_depth > 0) ? override_mid_depth : card_mover_slide_mid_depth;
        
    card_mover_x_offset = (override_depth > 0 && left_side) ?  card_mover_slide_depth - override_depth : 0;
    card_mover_mid_x_offset = (override_mid_depth > 0 && left_side) ?  card_mover_slide_mid_depth - override_mid_depth : 0;
    
    translate([7, 0, -(base_plate_height * 0.5) - 7])
    {
        steps = 30;    
        for (i = [ 1 : steps ])
        {
            step_depth = lerp(card_mover_slide_depth, card_mover_slide_mid_depth, easeOutQuad((1.0 / steps) * i));     
            step_actual_depth = lerp(card_mover_slide_actual_depth, card_mover_slide_actual_mid_depth, easeOutQuad((1.0 / steps) * i));            
            step_height = lerp(card_mover_slide_drop_height, card_mover_slide_drop_height_end, (1.0 / steps) * i);       
            step_width = lerp(card_mover_slide_drop_width, card_mover_slide_drop_width_end, (1.0 / steps) * i);            
            step_x_offset = (override_mid_depth > 0) ? (left_side ? (step_depth * 0.5) - (override_mid_depth * 0.5) : -(step_depth * 0.5) + (override_mid_depth * 0.5)) : 0;
            
            last_step_depth = lerp(card_mover_slide_depth, card_mover_slide_mid_depth, easeOutQuad((1.0 / steps) * (i - 1)));     
            last_step_actual_depth = lerp(card_mover_slide_actual_depth, card_mover_slide_actual_mid_depth, easeOutQuad((1.0 / steps) * (i - 1)));            
            last_step_height = lerp(card_mover_slide_drop_height, card_mover_slide_drop_height_end, (1.0 / steps) * (i - 1));       
            last_step_width = lerp(card_mover_slide_drop_width, card_mover_slide_drop_width_end, (1.0 / steps) * (i - 1));            
            last_step_x_offset = (override_mid_depth > 0) ? (left_side ? (last_step_depth * 0.5) - (override_mid_depth * 0.5) : -(last_step_depth * 0.5) + (override_mid_depth * 0.5)) : 0;
            
            last_alpha = (1.0 / steps) * (i - 1);
            alpha = (1.0 / steps) * i;
            
            last_forward_offset = lerp(top_forward_offset, 0, clamp(last_alpha * 1.2, 0.0, 1.0));
            forward_offset = lerp(top_forward_offset, 0, clamp(alpha * 1.2, 0.0, 1.0));
            
            hull()
            {
                translate([last_step_width + last_forward_offset, -last_step_x_offset, last_step_height])
                {
                    rotate([90, 0, 0]) cylinder(r=card_mover_slide_height, h=last_step_actual_depth, $fn=100, center=true);
                }            
                translate([step_width + forward_offset, -step_x_offset, step_height])
                {
                    rotate([90, 0, 0]) cylinder(r=card_mover_slide_height, h=step_actual_depth, $fn=100, center=true);
                }
            }            
        }
    }
}

module brain_box_psu_bolt_holes()
{
    for (x = psu_side_holes_x)
    {
        for (z = psu_side_holes_z)
        {
            translate([brain_box_psu_position[0] + psu_width - x, -epsilon, brain_box_psu_position[2] + z])
            {
                rotate([-90, 0, 0]) cylinder(r=psu_bolt_clearance_radius, h=brain_box_wall_thickness + (epsilon * 2), $fn=100);
            }
        }
    }
}

// A tab on the shelf's edge against the -y wall, grown by grow for the slot it drops into.
module brain_shelf_tab(x, grow, height)
{
    translate([x - (brain_shelf_tab_width * 0.5) - grow, brain_box_wall_thickness - brain_shelf_tab_depth - grow, brain_shelf_z])
    {
        cube([brain_shelf_tab_width + (grow * 2), brain_shelf_tab_depth + grow + brain_shelf_clearance + epsilon, height]);
    }
}

// The dovetail along the top of a mount at x = 0, from y0 to y1, grown by grow for the groove it slides in.
module brain_box_mount_dovetail(grow, y0, y1)
{
    xz_extrude(y0, y1)
    {
        polygon([
            [-(brain_box_mount_dovetail[0] * 0.5) - grow, -epsilon],
            [(brain_box_mount_dovetail[0] * 0.5) + grow, -epsilon],
            [(brain_box_mount_dovetail[1] * 0.5) + grow, brain_box_mount_dovetail[2] + grow],
            [-(brain_box_mount_dovetail[1] * 0.5) - grow, brain_box_mount_dovetail[2] + grow]
        ]);
    }
}

// Under the box, astride the beam, which runs along x under the box's centre. One part, so the dovetails can't be fitted
// at the wrong spacing; the channel between them keeps them parallel.
module brain_box_mount()
{
    length = brain_box_mount_length;
    bridge = brain_box_mount_bridge;
    fillet = brain_box_mount_fillet_radius;
    x0 = brain_box_mount_x[0] - (length * 0.5);
    span = brain_box_mount_x[1] + (length * 0.5) - x0;
    cheek_inside = (extrusion_short_width * 0.5) + brain_box_mount_clearance;
    cheek_outside = cheek_inside + brain_box_mount_cheek[0];

    difference()
    {
        union()
        {
            for (x = brain_box_mount_x)
            {
                translate([x, 0, 0])
                {
                    translate([-length * 0.5, brain_box_mount_groove_y, -bridge]) cube([length, brain_plate_depth - brain_box_mount_groove_y, bridge]);
                    brain_box_mount_dovetail(0, brain_box_mount_groove_y, brain_plate_depth);
                }
            }
            // Wide enough to carry the cheeks' fillets.
            translate([x0, (brain_plate_depth * 0.5) - cheek_outside - fillet, -bridge]) cube([span, (cheek_outside + fillet) * 2, bridge]);
            for (side = [-1, 1])
            {
                translate([x0, (brain_plate_depth * 0.5) + (side > 0 ? cheek_inside : -cheek_outside), -bridge - brain_box_mount_cheek[1]])
                {
                    cube([span, brain_box_mount_cheek[0], brain_box_mount_cheek[1] + epsilon]);
                }
                // Fillet on the outside of the cheek, where it meets the bridge. base_fillet() rises along z, so turn it to hang down.
                intersection()
                {
                    translate([0, 0, -bridge]) mirror([0, 0, 1]) base_fillet(fillet)
                    {
                        translate([x0, (brain_plate_depth * 0.5) + (side > 0 ? cheek_inside : -cheek_outside)]) square([span, brain_box_mount_cheek[0]]);
                    }
                    translate([x0, (brain_plate_depth * 0.5) + (side > 0 ? cheek_outside : -cheek_outside - fillet), -bridge - fillet])
                    {
                        cube([span, fillet, fillet + epsilon]);
                    }
                }
            }
        }
        for (x = brain_box_mount_x)
        {
            translate([x, 0, 0])
            {
                // Bolt down into the beam's slot, its head sunk into the dovetail under the floor.
                translate([0, brain_plate_depth * 0.5, brain_box_mount_dovetail[2]])
                {
                    bolt_hole(tbolt_shank_radius, brain_box_mount_dovetail[2] + bridge, [1, 0, 0]);
                    translate([0, 0, -3.5]) cylinder(r=tbolt_nut_radius + 0.5, h=3.5 + epsilon, $fn=100);
                }
                translate([0, brain_box_mount_lock_y, -bridge - epsilon])
                {
                    cylinder(r=exit_screw_clearance_radius, h=bridge + brain_box_mount_dovetail[2] + (epsilon * 2), $fn=100);
                }
            }
        }
    }
}

// Repeats a feature at the -y wall onto the +y wall.
module brain_box_both_long_walls()
{
    for (side = [0, 1])
    {
        translate([0, brain_plate_depth * side, 0]) mirror([0, side, 0]) children();
    }
}

module brain_box_both_ends()
{
    for (side = [0, 1])
    {
        translate([brain_plate_width * side, 0, 0]) mirror([side, 0, 0]) children();
    }
}

// Bump and groove share a centre, so the lid can sit anywhere in its play.
module brain_box_lid_latch_bump(radius, length)
{
    translate([brain_box_wall_thickness + brain_box_lid_threshold + card_bin_door_latch_bump_radius - brain_box_lid_latch_bump_height, brain_plate_depth * 0.5, brain_box_height - brain_box_lid_latch_length + brain_box_lid_latch_bump_rise])
    {
        rotate([90, 0, 0]) cylinder(r=radius, h=length, center=true, $fn=100);
    }
}

// Standoffs, or the holes through them and the shelf for bolts up into nuts on the board.
module brain_box_control_board(holes)
{
    radius = holes ? brain_box_standoff_inner_radius : brain_box_standoff_outer_radius;
    height_offset = holes ? -brain_shelf_thickness - epsilon : 0;
    height = holes ? brain_box_standoff_height + brain_shelf_thickness + (epsilon * 2) : brain_box_standoff_height;

    for (hole = [[155, 90], [150, 5.8], [4, 5.8], [58, 90]])
    {
        translate([hole[0], hole[1], height_offset]) cylinder(h=height, r=radius, $fn=100);
    }
}

// The mains inlet, on its side so it fits between the shelf and the lid. x points into the box.
// Into board coordinates, with z = 0 on the shelf.
module brain_box_board_frame()
{
    translate(brain_box_board_corner) rotate([0, 0, 180]) children();
}

// Through the wall in front of a port on the board's edge, in the wall's plane (along the edge, z), extruded from y0 to y1.
module brain_box_port_cut(span, z0, z1, y0, y1, grow = 0)
{
    xz_extrude(y0, y1)
    {
        offset(r=control_board_port_margin + grow, $fn=100) translate([span[0], z0]) square([span[1] - span[0], z1 - z0]);
    }
}

module brain_box_ac_plug_cut()
{
    rotate([90, 0, 0]) translate([0, -ac_plug_depth * 0.5, -ac_plug_height * 0.5])
    {
        cube([ac_plug_width, ac_plug_depth, ac_plug_height]);
        for (z = [0, ac_plug_height])
        {
            translate([0, ac_plug_depth * 0.5, z]) scale([1, 1, 0.25]) rotate([0, 90, 0]) cylinder(h=ac_plug_width, r=ac_plug_depth * 0.5, $fn=100);
        }
        for (y = [-1, 1])
        {
            translate([0, (ac_plug_depth * 0.5) + (ac_plug_hole_distance * 0.5 * y), ac_plug_height * 0.5])
            {
                rotate([0, 90, 0]) cylinder(h=brain_box_wall_thickness + (epsilon * 2), r=ac_plug_hole_radius, $fn=100);
            }
        }
    }
}

module brain_board_vent(air_vent_spacing, air_vent_count, height)
{
    translate([-((air_vent_spacing * air_vent_count) * 0.5), 0, 0])
    {
        for ( i = [ 0 : air_vent_count ])
        {
            translate([i * air_vent_spacing, 0, 0])
            {
                rotate([0, 35, 0]) cube([3, brain_box_wall_thickness + (epsilon * 4), height], center = true);
            }
        }
    }
}

module brain_box_footprint()
{
    offset(r=brain_box_corner_radius, $fn=100) offset(delta=-brain_box_corner_radius) square([brain_plate_width, brain_plate_depth]);
}

// Recessed text, sunk text_inlay_depth into the face; deeper is cut through the face.
module brain_plate_lid_warning(depth)
{
    // Reads from the side with the mains inlet.
    translate([brain_plate_width * 0.5, brain_plate_depth * 0.5, brain_box_height + brain_box_lid_thickness - text_inlay_depth])
    {
        rotate([0, 0, 180])
        {
            translate([0, 16, 0]) linear_extrude(depth) text("DANGER OF DEATH", 14, font="Droid Sans:Bold", halign="center", valign="center");
            translate([0, -2, 0]) linear_extrude(depth) text("Exposed mains power inside", 8, font="Droid Sans:Bold", halign="center", valign="center");
            translate([0, -16, 0]) linear_extrude(depth) text("Remove power before opening", 8, font="Droid Sans:Bold", halign="center", valign="center");
        }
    }
}

// On the front, in the top corner beside the vents.
module brain_plate_name(depth)
{
    for (line = [["Libre", 1], ["Card Sorter", -1]])
    {
        translate([brain_box_wall_thickness + 18, text_inlay_depth, brain_box_upper_z + line[1] * 6])
        {
            rotate([90, 0, 0]) linear_extrude(depth) text(line[0], 8, font="Droid Sans:Bold", halign="left", valign="center");
        }
    }
}

module brain_plate_lid()
{
    lip_outer = [brain_plate_width, brain_plate_depth] - ([1, 1] * (brain_box_wall_thickness + brain_box_lid_threshold) * 2);
    lip_inner = lip_outer - ([1, 1] * brain_box_lid_lip_thickness * 2);
    inset = brain_box_wall_thickness + brain_box_lid_threshold + brain_box_lid_lip_thickness;
    steps = 16;
    slice = 0.01;
    radius = brain_box_lid_fillet_radius;
    function flare(i) = radius * (1 - sin(90 * i / steps));
    function height(i) = radius * (1 - cos(90 * i / steps));

    difference()
    {
        union()
        {
            translate([0, 0, brain_box_height]) linear_extrude(brain_box_lid_thickness) brain_box_footprint();
            for (side = [0, 1])
            {
                translate([brain_plate_width * side, brain_plate_depth * 0.5, brain_box_height + brain_box_lid_thickness - brain_box_lid_tab_thickness])
                {
                    rotate([0, 0, 180 * (1 - side)]) hull()
                    {
                        translate([-epsilon, -brain_box_lid_tab_width * 0.5, 0]) cube([epsilon, brain_box_lid_tab_width, brain_box_lid_tab_thickness]);
                        for (y = [-1, 1])
                        {
                            translate([brain_box_lid_tab_reach - brain_box_lid_tab_corner_radius, y * ((brain_box_lid_tab_width * 0.5) - brain_box_lid_tab_corner_radius), 0])
                            {
                                cylinder(r=brain_box_lid_tab_corner_radius, h=brain_box_lid_tab_thickness, $fn=100);
                            }
                        }
                    }
                }
            }
            translate([brain_box_wall_thickness + brain_box_lid_threshold, brain_box_wall_thickness + brain_box_lid_threshold, brain_box_height - brain_box_lid_lip_depth])
            {
                difference()
                {
                    cube([lip_outer[0], lip_outer[1], brain_box_lid_lip_depth + epsilon]);
                    translate([brain_box_lid_lip_thickness, brain_box_lid_lip_thickness, -epsilon]) cube([lip_inner[0], lip_inner[1], brain_box_lid_lip_depth + (epsilon * 3)]);
                }
            }
            brain_box_both_ends()
            {
                latch_y = (brain_plate_depth - brain_box_lid_latch_width) * 0.5;
                translate([brain_box_wall_thickness + brain_box_lid_threshold, latch_y, brain_box_height - brain_box_lid_latch_length])
                {
                    cube([brain_box_lid_latch_thickness, brain_box_lid_latch_width, brain_box_lid_latch_length + epsilon]);
                }
                intersection()
                {
                    brain_box_lid_latch_bump(card_bin_door_latch_bump_radius, card_bin_door_latch_bump_length);
                    translate([brain_box_wall_thickness + brain_box_lid_threshold - brain_box_lid_latch_bump_height, latch_y, brain_box_height - brain_box_lid_latch_length])
                    {
                        cube([brain_box_lid_latch_bump_height + brain_box_lid_latch_thickness, brain_box_lid_latch_width, brain_box_lid_latch_length]);
                    }
                }
            }
            // Fillet inside the lip where it meets the lid, profiled like base_fillet() but hanging down.
            translate([inset, inset, brain_box_height]) mirror([0, 0, 1])
            {
                difference()
                {
                    translate([0, 0, -epsilon]) cube([lip_inner[0], lip_inner[1], radius + epsilon]);
                    for (i = [0:steps - 1])
                    {
                        hull()
                        {
                            for (j = [i, i + 1])
                            {
                                translate([flare(j), flare(j), height(j)]) cube([lip_inner[0] - (flare(j) * 2), lip_inner[1] - (flare(j) * 2), slice + (j == steps ? epsilon : 0)]);
                            }
                        }
                    }
                }
            }
        }
        union()
        {
            // Free the finger from the lip, and the lip's inner fillet, either side of it.
            brain_box_both_ends()
            {
                for (side = [-1, 1])
                {
                    translate([brain_box_wall_thickness + brain_box_lid_threshold - epsilon, (brain_plate_depth + (side * (brain_box_lid_latch_width + brain_box_lid_latch_gap)) - brain_box_lid_latch_gap) * 0.5, brain_box_height - brain_box_lid_lip_depth - epsilon])
                    {
                        cube([brain_box_lid_lip_thickness + brain_box_lid_fillet_radius + (epsilon * 2), brain_box_lid_latch_gap, brain_box_lid_lip_depth + epsilon]);
                    }
                }
                // Thinned to the finger all the way up, so it bends along its length.
                translate([brain_box_wall_thickness + brain_box_lid_threshold + brain_box_lid_latch_thickness, (brain_plate_depth - brain_box_lid_latch_width) * 0.5 - epsilon, brain_box_height - brain_box_lid_lip_depth - epsilon])
                {
                    cube([brain_box_lid_lip_thickness - brain_box_lid_latch_thickness + brain_box_lid_fillet_radius + epsilon, brain_box_lid_latch_width + (epsilon * 2), brain_box_lid_lip_depth + epsilon]);
                }
            }

            brain_plate_lid_warning(text_inlay_depth + epsilon);
        }
    }
    // Fillet on the inside of the finger's root, added after the cuts that thin it.
    brain_box_both_ends()
    {
        x0 = brain_box_wall_thickness + brain_box_lid_threshold + brain_box_lid_latch_thickness;
        y0 = (brain_plate_depth - brain_box_lid_latch_width) * 0.5;
        intersection()
        {
            translate([0, 0, brain_box_height]) mirror([0, 0, 1]) base_fillet(brain_box_lid_latch_fillet_radius)
            {
                translate([x0 - brain_box_lid_latch_thickness, y0]) square([brain_box_lid_latch_thickness, brain_box_lid_latch_width]);
            }
            translate([x0 - epsilon, y0, brain_box_height - brain_box_lid_latch_fillet_radius]) cube([brain_box_lid_latch_fillet_radius + epsilon, brain_box_lid_latch_width, brain_box_lid_latch_fillet_radius + epsilon]);
        }
    }
}

module brain_plate()
{
    psu_top = brain_box_psu_position[2] + psu_height;

    difference()
    {
        union()
        {
            difference()
            {
                linear_extrude(brain_box_height) brain_box_footprint();
                translate([brain_box_wall_thickness, brain_box_wall_thickness, brain_plate_height])
                {
                    cube([brain_plate_width - (brain_box_wall_thickness * 2), brain_plate_depth - (brain_box_wall_thickness * 2), brain_box_height]);
                }
            }

            for (x = [psu_standoff_inset, psu_width - psu_standoff_inset])
            {
                for (y = [psu_standoff_inset, psu_depth - psu_standoff_inset])
                {
                    translate([brain_box_psu_position[0] + x, brain_box_psu_position[1] + y, brain_plate_height - epsilon])
                    {
                        cylinder(r=psu_standoff_radius, h=psu_standoff_height + epsilon, $fn=100);
                    }
                }
            }

            if (show_externals)
            {
                translate(brain_box_psu_position) color("blue") cube([psu_width, psu_depth, psu_height]);
            }
        }
        union()
        {
            for (x = brain_box_mount_x)
            {
                translate([x, 0, 0])
                {
                    brain_box_mount_dovetail(brain_box_mount_clearance, brain_box_mount_groove_y - brain_box_mount_clearance, brain_plate_depth + epsilon);
                    translate([0, brain_box_mount_lock_y, brain_box_mount_dovetail[2]])
                    {
                        cylinder(r=exit_threaded_insert_radius, h=exit_threaded_insert_depth + brain_box_mount_clearance, $fn=100);
                    }
                }
            }

            brain_box_both_ends() brain_box_lid_latch_bump(card_bin_door_latch_bump_radius + card_bin_door_latch_groove_clearance, card_bin_door_latch_bump_length + 2);

            brain_plate_name(text_inlay_depth + epsilon);

            // The board's ports.
            brain_box_board_frame()
            {
                board_top = brain_box_standoff_height + control_board_thickness;
                // The USB-A and Ethernet ports share an opening, as there's no room for a strip of wall between them.
                for (port = [control_board_hdmi, control_board_usb_c, [[control_board_usb_a[0][0], control_board_ethernet[0][1]], control_board_usb_a[1]]])
                {
                    brain_box_port_cut(port[0], board_top, board_top + port[1], -brain_box_wall_thickness - control_board_port_wall_gap - epsilon, 0);
                }
                // Room for the wires, above where the shelf's lip bears on the wall.
                brain_box_port_cut(control_board_power_terminals[0], brain_shelf_lip_height + control_board_port_margin, board_top + control_board_power_terminals[1], -control_board_port_wall_gap - (brain_box_wall_thickness * 0.5), -control_board_port_wall_gap + epsilon);
                rotate([0, 0, 90])
                {
                    brain_box_port_cut(control_board_sd_slots[0], brain_box_standoff_height - control_board_sd_slots[1], brain_box_standoff_height, 0, brain_box_wall_thickness + control_board_wall_gap + epsilon);
                    outside = brain_box_wall_thickness + control_board_wall_gap;
                    hull()
                    {
                        brain_box_port_cut(control_board_sd_slots[0], brain_box_standoff_height - control_board_sd_slots[1], brain_box_standoff_height, outside - control_board_sd_chamfer, outside - control_board_sd_chamfer + epsilon);
                        brain_box_port_cut(control_board_sd_slots[0], brain_box_standoff_height - control_board_sd_slots[1], brain_box_standoff_height, outside, outside + epsilon, control_board_sd_chamfer);
                    }
                }
            }

            brain_box_psu_bolt_holes();

            brain_shelf_at_bolts() brain_shelf_bolt_hole(brain_shelf_bolt_clearance_radius, -epsilon, brain_box_wall_thickness + epsilon);

            brain_box_both_long_walls()
            {
                for (x = brain_shelf_tab_x)
                {
                    brain_shelf_tab(x, brain_shelf_tab_clearance, brain_box_height - brain_shelf_z + epsilon);
                }
            }

            // Air out of the gap above the PSU's fan, and past the board.
            for (y = [brain_box_wall_thickness * 0.5, brain_plate_depth - (brain_box_wall_thickness * 0.5)])
            {
                translate([brain_box_psu_position[0] + (psu_width * 0.5), y, psu_top + (psu_fan_clearance * 0.5)])
                {
                    brain_board_vent(9, 20, psu_fan_clearance - 3);
                }
            }
            for (x = [brain_box_wall_thickness * 0.5, brain_plate_width - (brain_box_wall_thickness * 0.5)])
            {
                translate([x, brain_plate_depth * 0.5, psu_top + (psu_fan_clearance * 0.5)])
                {
                    rotate([0, 0, 90]) brain_board_vent(9, 10, psu_fan_clearance - 3);
                }
            }
            translate([brain_box_board_x0 + (control_board_width * 0.5), brain_box_wall_thickness * 0.5, brain_box_upper_z])
            {
                brain_board_vent(9, 10, 30);
            }
            // Air in under the PSU, at its standoffs.
            for (y = [brain_box_wall_thickness * 0.5, brain_plate_depth - (brain_box_wall_thickness * 0.5)])
            {
                translate([brain_box_psu_position[0] + (psu_width * 0.5), y, brain_plate_height + (psu_standoff_height * 0.5)])
                {
                    brain_board_vent(9, 20, psu_standoff_height - 2);
                }
            }
            for (x = [brain_box_wall_thickness * 0.5, brain_plate_width - (brain_box_wall_thickness * 0.5)])
            {
                translate([x, brain_plate_depth * 0.5, brain_plate_height + (psu_standoff_height * 0.5)])
                {
                    rotate([0, 0, 90]) brain_board_vent(9, 10, psu_standoff_height - 2);
                }
            }

            // Beyond the board's end, clear of its connectors.
            translate([(brain_box_wall_thickness + brain_box_board_x0) * 0.5, brain_plate_depth + epsilon, brain_box_inlet_z])
            {
                rotate([0, 0, -90]) brain_box_ac_plug_cut();
            }

            // Hole for the wires out to the machine, in the end beyond the board.
            translate([-epsilon, brain_box_wire_hole_y, brain_box_upper_z])
            {
                rotate([0, 90, 0]) cylinder(h=brain_box_wall_thickness + (epsilon * 2), r=brain_box_wire_hole_radius, $fn=100);
            }
        }
    }
}

// Carries the M4P above the PSU, with a gap over the PSU's terminals for wires. Lifts out of the slots its tabs sit in.
// Children at x = 0 on each bolt, with y running in from the outside of its wall.
module brain_shelf_at_bolts()
{
    for (bolt = brain_shelf_bolts)
    {
        translate([bolt[0], brain_plate_depth * bolt[1], 0]) mirror([0, bolt[1], 0]) children();
    }
}

module brain_shelf_bolt_hole(radius, y0, y1)
{
    translate([0, y0, brain_shelf_top]) rotate([-90, 0, 0]) cylinder(r=radius, h=y1 - y0, $fn=100);
}

module brain_shelf_lip_side(size)
{
    inset = brain_box_wall_thickness + brain_shelf_fit_clearance;
    translate([0, 0, brain_shelf_top])
    {
        linear_extrude(brain_shelf_lip_height) translate([inset, inset]) square(size);
        base_fillet(brain_shelf_lip_fillet_radius) translate([inset, inset]) square(size);
    }
}

module brain_shelf_lip()
{
    inset = brain_box_wall_thickness + brain_shelf_fit_clearance;
    intersection()
    {
        translate([inset, inset, brain_shelf_top - epsilon])
        {
            cube([brain_plate_width - (inset * 2), brain_plate_depth - (inset * 2), brain_shelf_lip_height + epsilon]);
        }
        union()
        {
            brain_box_both_long_walls() brain_shelf_lip_side([brain_plate_width - (inset * 2), brain_shelf_lip_thickness]);
            brain_box_both_ends() brain_shelf_lip_side([brain_shelf_lip_thickness, brain_plate_depth - (inset * 2)]);
        }
    }
}

module brain_shelf_inlet_hood()
{
    wall = brain_shelf_inlet_hood_thickness;
    x0 = brain_shelf_inlet_x0 - wall;
    y0 = brain_shelf_inlet_y0 - wall;
    y1 = brain_plate_depth - brain_box_wall_thickness - brain_shelf_fit_clearance;
    length = brain_shelf_inlet_length + (wall * 2);
    top = brain_shelf_inlet_roof_z + wall;

    difference()
    {
        translate([x0, y0, brain_shelf_top - epsilon]) cube([length, y1 - y0, top - brain_shelf_top + epsilon]);
        translate([brain_shelf_inlet_x0, brain_shelf_inlet_y0, brain_shelf_top - (epsilon * 2)])
        {
            cube([brain_shelf_inlet_length, y1 - brain_shelf_inlet_y0 + epsilon, brain_shelf_inlet_roof_z - brain_shelf_top + (epsilon * 2)]);
        }
    }
    intersection()
    {
        translate([x0 - brain_shelf_inlet_hood_fillet_radius, y0 - brain_shelf_inlet_hood_fillet_radius, brain_shelf_top - epsilon])
        {
            cube([length + (brain_shelf_inlet_hood_fillet_radius * 2), y1 - y0 + brain_shelf_inlet_hood_fillet_radius, brain_shelf_inlet_hood_fillet_radius + epsilon]);
        }
        translate([0, 0, brain_shelf_top]) union()
        {
            base_fillet(brain_shelf_inlet_hood_fillet_radius) translate([x0, y0]) square([length, wall]);
            for (x = [x0, x0 + length - wall])
            {
                base_fillet(brain_shelf_inlet_hood_fillet_radius) translate([x, y0]) square([wall, y1 - y0]);
            }
        }
    }
}

module brain_shelf_grip()
{
    x0 = -brain_shelf_grip_width * 0.5;
    translate([0, 0, brain_shelf_top])
    {
        xz_extrude(0, brain_shelf_grip_thickness)
        {
            difference()
            {
                hull()
                {
                    translate([x0, -epsilon]) square([brain_shelf_grip_width, epsilon]);
                    for (x = [x0 + brain_shelf_grip_corner_radius, x0 + brain_shelf_grip_width - brain_shelf_grip_corner_radius])
                    {
                        translate([x, brain_shelf_grip_height - brain_shelf_grip_corner_radius]) circle(r=brain_shelf_grip_corner_radius, $fn=100);
                    }
                }
                translate([0, brain_shelf_grip_height - brain_shelf_grip_corner_radius - brain_shelf_grip_hole_radius - 1]) circle(r=brain_shelf_grip_hole_radius, $fn=100);
            }
        }
        base_fillet(brain_shelf_grip_fillet_radius) translate([x0, 0]) square([brain_shelf_grip_width, brain_shelf_grip_thickness]);
    }
}

module brain_shelf()
{
    difference()
    {
        union()
        {
            translate([brain_box_wall_thickness + brain_shelf_fit_clearance, brain_box_wall_thickness + brain_shelf_fit_clearance, brain_shelf_z])
            {
                cube([brain_plate_width - ((brain_box_wall_thickness + brain_shelf_fit_clearance) * 2), brain_plate_depth - ((brain_box_wall_thickness + brain_shelf_fit_clearance) * 2), brain_shelf_thickness]);
            }
            brain_box_both_long_walls()
            {
                for (x = brain_shelf_tab_x)
                {
                    brain_shelf_tab(x, brain_shelf_tab_clearance - brain_shelf_fit_clearance, brain_shelf_thickness + brain_shelf_lip_height);
                }
            }
            brain_shelf_lip();
            brain_shelf_inlet_hood();
            brain_shelf_at_bolts()
            {
                translate([-brain_shelf_bolt_boss_width * 0.5, brain_box_wall_thickness + brain_shelf_fit_clearance, brain_shelf_top - epsilon])
                {
                    cube([brain_shelf_bolt_boss_width, brain_shelf_bolt_boss_depth, brain_shelf_bolt_boss_height + epsilon]);
                }
            }
            for (grip = brain_shelf_grips)
            {
                translate(grip[0]) rotate([0, 0, grip[1]]) brain_shelf_grip();
            }
            brain_box_board_frame()
            {
                brain_box_control_board(false);
                if (show_externals)
                {
                    translate([0, 0, brain_box_standoff_height]) color("blue") cube([control_board_width, control_board_depth, control_board_height]);
                }
            }
        }
        translate([brain_shelf_inlet_x0, brain_shelf_inlet_y0, brain_shelf_z - epsilon])
        {
            cube([brain_shelf_inlet_length, brain_plate_depth - brain_shelf_inlet_y0, brain_shelf_thickness + brain_shelf_lip_height + (epsilon * 2)]);
        }
        brain_shelf_at_bolts() brain_shelf_bolt_hole(exit_threaded_insert_radius, brain_box_wall_thickness, brain_box_wall_thickness + brain_shelf_fit_clearance + exit_threaded_insert_depth + 1);
        brain_box_board_frame()
        {
            brain_box_control_board(true);
            // One opening across all the ports, and the SD slot's clear to the top of the lip, so neither leaves a flimsy
            // strip of lip behind.
            brain_box_port_cut([control_board_hdmi[0][0], control_board_ethernet[0][1]], brain_box_standoff_height + control_board_thickness, brain_shelf_lip_height, -brain_box_wall_thickness - control_board_port_wall_gap - epsilon, 0);
            rotate([0, 0, 90])
            {
                brain_box_port_cut(control_board_sd_slots[0], control_board_port_margin, brain_shelf_lip_height, 0, brain_box_wall_thickness + control_board_wall_gap + epsilon);
            }
        }
        // Over the PSU's terminals, beside the board, for its wires and the mains.
        translate([brain_box_wall_thickness, brain_box_wall_thickness, brain_shelf_z - epsilon])
        {
            cube([brain_shelf_tab_x[0] - (brain_shelf_tab_width * 0.5) - 5 - brain_box_wall_thickness, 18, brain_shelf_thickness + brain_shelf_lip_height + (epsilon * 2)]);
        }
    }
}

// Build the model!
module place(position, rotation = [0, 0, 0])
{
    if (assemble)
    {
        translate(position) rotate(rotation) children();
    }
    else
    {
        children();
    }
}

if (show_card_bin)
{
    for (i = [0:card_bin_count - 1])
    {
        place(card_bin_position + [0, i * card_bin_depth, 0]) color("wheat") card_bin();
    }
}
if (show_card_bin_door)
{
    for (i = [0:card_bin_count - 1])
    {
        place(card_bin_position + [0, i * card_bin_depth, 0] + card_bin_door_origin, card_bin_door_rotation) color("goldenrod") card_bin_door();
    }
}
if (show_gantry)
{
    gantry();
}
if (show_base_plate)
{
    place(base_plate_position) color("darkolivegreen") base_plate();
}
if (show_card_magazine_bottom)
{
    place(card_magazine_position) color("sienna") cut_by_base_plate() card_magazine(top=false, bottom=true);
}
if (show_card_magazine_top)
{
    place(card_magazine_position) color("peru") difference()
    {
        cut_by_base_plate() card_magazine(top=true, bottom=false);
        card_magazine_exit_flare_cut();
    }
}
if (show_card_magazine_door_bottom)
{
    place(card_magazine_position) color("orange") cut_by_base_plate() card_magazine_door(top=false, bottom=true);
}
if (show_card_magazine_door_top)
{
    place(card_magazine_position) color("khaki") cut_by_base_plate() card_magazine_door(top=true, bottom=false);
}
if (show_card_magazine_pad)
{
    place(card_magazine_position) color("burlywood") card_magazine_pad();
}
if (show_card_magazine_lifter)
{
    place(card_magazine_position) color("purple") cut_by_base_plate() card_lifter(lifter=true, top=false);
}
if (show_card_magazine_lifter_top)
{
    place(card_magazine_position) color("plum") cut_by_base_plate() card_lifter(lifter=false, top=true);
}
if (show_scan_plate)
{
    place(scan_plate_position) color("pink") scan_plate();
}
if (show_exit_insert)
{
    place(exit_position) color("coral") exit_insert();
}
if (show_exit_nip_tongue)
{
    place(exit_position) color("tomato") exit_nip_tongue();
}
if (show_brain_plate)
{
    place(brain_plate_position, brain_plate_rotation) color("olive") brain_plate();
}
if (show_brain_plate && show_text_inlays)
{
    place(brain_plate_position, brain_plate_rotation) color("white") brain_plate_name(text_inlay_depth);
}
if (show_brain_plate_lid)
{
    place(brain_plate_position, brain_plate_rotation) color("yellowgreen") brain_plate_lid();
}
if (show_brain_plate_lid && show_text_inlays)
{
    place(brain_plate_position, brain_plate_rotation) color("ivory") brain_plate_lid_warning(text_inlay_depth);
}
if (show_brain_shelf)
{
    place(brain_plate_position, brain_plate_rotation) color("darkkhaki") brain_shelf();
}
if (show_brain_box_mount)
{
    place(brain_plate_position, brain_plate_rotation) color("darkseagreen") brain_box_mount();
}
if (show_camera_mount)
{
    place(camera_mount_position) color("hotpink") camera_mount();
}
if (show_led_ring_spacer)
{
    // Merged so that exporting at the origin gives a single spacer rather than four overlapping copies.
    union()
    {
        for (position = led_ring_spacer_positions)
        {
            place(position) color("gold") led_ring_spacer();
        }
    }
}
if (show_card_mover_plate)
{
    // Merged so that exporting at the origin gives a single clamp rather than four overlapping copies.
    union()
    {
        for (position = card_mover_clamp_positions)
        {
            place(position) color("maroon") extrusion_clamp_mount();
        }
    }
}
if (show_card_mover_plate_motor)
{
    place(card_mover_plate_motor_position) color("chocolate") card_mover_plate_motor();
}
if (show_card_mover_plate_spindle)
{
    place(card_mover_plate_spindle_position) color("rosybrown") card_mover_plate_spindle();
}
if (show_card_mover)
{
    place(card_mover_position) color("crimson") card_mover();
}
if (show_card_mover_slide)
{
    place(card_mover_slide_position) color("salmon") card_mover_slide();
}
if (show_limit_switch_mount)
{
    place([-extrusion_short_depth - extrusion_short_width, 0, extrusion_short_height]) color("lime") extrusion_limit_switch_mount(0, 0);
}
if (show_limit_switch_carrier)
{
    place(limit_switch_carrier_position) color("orchid") limit_switch_carrier();
}
if (show_limit_switch_mount_small)
{
    place([-extrusion_short_depth, extrusion_short_width - 3, extrusion_short_height + 140], [0, 0, 180]) color("seagreen") extrusion_limit_switch_mount(-6, 10.0);
}
if (show_swing_sun_gear)
{
    place(exit_position) color("magenta") swing_sun_gear();
}
if (show_swing_clutch_collar)
{
    place(exit_position) color("tan") swing_clutch_collar();
}
if (show_swing_idler_gear)
{
    place(exit_position) swing_pose(swing_arm_angle) color("violet") swing_idler_gear();
}
if (show_swing_roller)
{
    place(exit_position) swing_pose(swing_arm_angle) color("black") swing_roller();
}
// Shown around the roller in its engaged position.
if (show_swing_roller_mould_a)
{
    place(exit_position + [swing_roller_center[0], 0, swing_roller_center[1]], [90, 0, 0]) color("mediumseagreen") swing_roller_mould_half("a");
}
if (show_swing_roller_mould_b)
{
    place(exit_position + [swing_roller_center[0], 0, swing_roller_center[1]], [90, 0, 0]) color("lightgreen") swing_roller_mould_half("b");
}
if (show_nip_roller)
{
    place(exit_position) color("darkorange") nip_roller();
}
if (show_nip_roller_mould_a)
{
    place(exit_position + [nip_center[0], 0, nip_center[1]], [90, 0, 0]) color("palegreen") swing_roller_mould_half("a", nip=true);
}
if (show_nip_roller_mould_b)
{
    place(exit_position + [nip_center[0], 0, nip_center[1]], [90, 0, 0]) color("springgreen") swing_roller_mould_half("b", nip=true);
}
if (show_nip_drive_gear)
{
    place(exit_position) color("mediumorchid") nip_drive_gear();
}
if (show_nip_idler_gear)
{
    place(exit_position) color("thistle") nip_idler_gear();
}
if (show_nip_gear)
{
    place(exit_position) color("indianred") nip_gear();
}
if (show_nip_pad_mould)
{
    place(exit_position + [exit_insert_length + 10, -exit_nip_pad_size[1], -exit_insert_pocket_depth]) color("lightsalmon") nip_pad_mould();
}
// Shown around the tongue in place.
if (show_nip_pad_cast_lid)
{
    place(exit_position) color("firebrick") nip_pad_cast_lid();
}
if (show_nip_pad_cast_base)
{
    place(exit_position) color("moccasin") nip_pad_cast_base();
}
if (show_nip_pad_cast_shim)
{
    place(exit_position) color("lawngreen") nip_pad_cast_shim();
}
if (show_swing_drive_arm)
{
    place(exit_position) swing_pose(swing_arm_angle) color("red") swing_drive_arm();
}
if (show_swing_idle_arm)
{
    place(exit_position) swing_pose(swing_arm_angle) color("orangered") swing_idle_arm();
}
if (show_camera_view)
{
    place(camera_lens_position) color("yellow", 0.3) camera_view();
}
if (show_externals)
{
    place(base_plate_position) base_plate_externals();
    card_mover_plate_externals();
    place(exit_position) swing_externals();
    place(camera_mount_position) camera_mount_externals();
}
