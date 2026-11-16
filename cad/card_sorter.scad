//include <BOSL2/BOSL2>

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
bearing_rod_height = 400;
bearing_rod_hole_threshold = 0.75;
bearing_rod_linear_bearing_radius = 15.0 * 0.5;
bearing_rod_linear_bearing_height = 24;
bearing_rod_bearing_bearing_to_base_offset = 11;//11;
bearing_rod_bearing_rod_to_screw_offset = 21 - 5;
bearing_rod_bearing_height = 14;
bearing_rod_bearing_screw_radius = 5.5 * 0.5;

bearing_rod_clamp_rod_to_base_offset = 20;
bearing_rod_clamp_height = 13;
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
card_height = 0.3;

card_bin_tolerance = 1;
card_bin_thickness = 8;
card_bin_door_viewport_height_threshold = 10;
card_bin_door_viewport_depth = 20;
card_bin_spacing = 3;
card_bin_count = 1;
card_bin_offset = 40 - 100;
card_bin_skew = -0.58;

base_plate_height = 10;
base_plate_width = 160;//extrusion_short_depth + extrusion_long_width;
base_plate_depth = extrusion_short_depth;
base_plate_stepping_motor_plate_height = 5;
base_plate_bearing_plate_height = 8;//5;

card_magazine_tolerance = 0.3;
card_magazine_thickness = 14;
card_magazine_thickness_bottom = 22;
card_magazine_door_viewport_height_threshold = 10;
card_magazine_door_viewport_depth = 10;
card_magazine_depth_offset = 5;
card_magazine_top_flare_width = 30;
card_magazine_top_flare_depth = 30;
card_magazine_top_flare_height = 10;
card_magazine_tab_width = 20;
card_magazine_tab_height = 30;
card_magazine_tab_depth = 6;

card_magazine_lifter_cutout_size = 18;
card_magazine_lifter_height = (bearing_rod_linear_bearing_height * 2) + base_plate_bearing_plate_height + 5;
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
tbolt_nut_facets = 30;
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

card_mover_lead_screw_radius = 8 * 0.5;
card_mover_lead_screw_height = 650;
card_mover_bearing_rod_radius = 8 * 0.5;
card_mover_bearing_rod_height = 600;
card_mover_bar_offset = 28;
card_mover_plate_length = card_mover_bearing_rod_height;

extrusion_motor_mount_width = extrusion_short_width;// * 0.75;
extrusion_motor_mount_height = 15;
extrusion_motor_mount_depth = 95 + 20;
extrusion_motor_mount_corner_radius = 4;
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

extrusion_bearing_height_padding = 25;
extrusion_bearing_width = card_mover_bar_offset - (bearing_rod_bearing_bearing_to_base_offset);
extrusion_bearing_height = (bearing_rod_clamp_plate_height * 2) - 9;
extrusion_bearing_corner_radius = 4;

card_mover_back_width = 10;
card_mover_back_height = 30;
card_mover_back_depth = 100;
card_mover_back_offset = 28;
card_mover_back_height_offset = 5;

card_mover_lead_screw_mount_radius = 15;
card_mover_lead_screw_mount_height = 30;

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
component_wall_height = 10;
component_wall_large_height = 10;
component_spacing = 0;
component_standoff_height = 8;
component_standoff_radius_add = 0.7;

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

buck_converter_width = 38.0;
buck_converter_depth = 62.0;
buck_converter_hole_radius = 1.5;
buck_converter_hole_distance = 4.0;

buck_converter_width_and_slack = buck_converter_width + (component_wall_slack * 2);
buck_converter_depth_and_slack = buck_converter_depth + (component_wall_slack * 2);
buck_converter_and_wall_width = buck_converter_width_and_slack + (component_wall_thickness * 2); 
buck_converter_and_wall_depth = buck_converter_depth_and_slack + (component_wall_thickness * 2); 

IMX179_width = 62;
IMX179_depth = 9;
IMX179_angle = 23;
IMX179_hole_radius = 1.3;
IMX179_camera_radius = 1.5;
IMX179_standoff = 5;

power_distributor_hole_distance = 22;
power_distributor_hole_radius = 3.5 * 0.5;

usb_c_wall_slack = 0.1;
usb_c_power_depth = 28;
usb_c_power_width = 11;
usb_c_power_wall_height = 16;
usb_c_power_wall_height_back = 4;
usb_c_power_wall_wire_port_height = 4;
usb_c_power_wall_wire_port_offset = 4;
usb_c_power_band_depth = 18;
usb_c_power_band_height = 15.0;
usb_c_power_width_and_slack = usb_c_power_width + (usb_c_wall_slack * 2);
usb_c_power_depth_and_slack = usb_c_power_depth + (usb_c_wall_slack * 2);
usb_c_power_and_wall_width = usb_c_power_width_and_slack + (component_wall_thickness * 2); 
usb_c_power_and_wall_depth = usb_c_power_depth_and_slack + (component_wall_thickness); 

belt_width = 10;
belt_block_depth = card_mover_back_height * 0.5;
belt_block_width = 19;
belt_block_height = 15;
belt_block_cut_depth = 11;
belt_block_offset = 5;

card_magazine_hole_scan_wall_size = 5;
card_magazine_hole_scan_wall_height_size = 5;
                
scan_plate_motor_mount_width_offset = 42;
scan_plate_motor_mount_height_offset = 1.5;

scan_plate_motor_width = 30;
scan_plate_motor_height = 30;
scan_plate_motor_depth = card_magazine_hole_scan_wall_size * 2.5;

scan_plate_wire_hole_depth = 5;
scan_plate_motor_mount_thickness = 2.5;
scan_plate_rod_length = 150;
scan_plate_rod_radius = 8 * 0.5;
scan_plate_motor_mount_width = scan_plate_motor_width + (scan_plate_motor_mount_thickness * 2) + 7;
scan_plate_motor_mount_height = (scan_plate_motor_height + (scan_plate_motor_mount_thickness * 2)) + scan_plate_motor_mount_height_offset;
scan_plate_motor_mount_depth = scan_plate_motor_depth + (scan_plate_motor_mount_thickness * 2);
scan_plate_motor_mount_rod_depth = 15;
scan_plate_motor_tube_length = 8;
scan_plate_motor_tube_screw_hole_radius = (4 * 0.5) + 0.2;
scan_plate_motor_tube_screw_distance = 24;
scan_plate_motor_mount_spindle_depth = 6;
scan_plate_motor_mount_spindle_radius = 12 * 0.5;

scan_plate_motor_height_offset = -10.15;
scan_plate_motor_center_hole_radius = 24 * 0.5;
scan_plate_motor_screw_hole_radius = 3.5 * 0.5;
scan_plate_motor_screw_hole_distance = 23 * 0.5;

// Exit insert heights are relative to the top of the scan plate, which the top of the card stack sits just above.
exit_insert_tolerance = 0.2;
exit_insert_pocket_depth = 4;
exit_insert_lip_height = -0.45;
exit_insert_lead_in_height = 1.5;
exit_insert_lead_in_angle = 20;
exit_insert_tip_height = 0.8;
exit_insert_post_width = 10;
exit_insert_post_height = 6;
// Keeps the posts and gate clear of the roller and its rod holder.
exit_insert_post_offset = 5.5;
// Cards push the insert forwards, so the posts bearing on this wall keep its back face flush with the magazine.
exit_insert_registration_wall = 4;

exit_gate_length = 8;
exit_gate_thickness = 4;

exit_screw_clearance_radius = 3.4 * 0.5;
exit_threaded_insert_radius = 4.0 * 0.5;
exit_threaded_insert_depth = 5;
exit_spring_radius = 6.2 * 0.5;
exit_spring_depth = 4;

card_magazine_index_size = 7;
card_magazine_index_height = 7;
card_magazine_index_insert = 8;
card_magazine_index_tolerance = 0.3;

card_magazine_hinge_hole_radius = 4 * 0.5;
card_magazine_hinge_hole_distance = 14;
card_magazine_hinge_hole_inset = 5;

card_magazine_door_thickness = 7;
card_magazine_door_index_thickness = 3;
card_magazine_door_index_height = 5;
card_magazine_door_index_tolerance = 0.3;
card_magazine_door_hinge_hole_to_edge = 13;
card_magazine_door_hinge_height = 30;
card_magazine_door_hinge_edge_space = 9;
card_magazine_door_hinge_inset = 14;
pillow_mount_hole_distance = 36;
pillow_mount_hole_radius = 6 * 0.5;

brain_plate_width = 256 - 10;
brain_plate_depth = extrusion_short_depth + (extrusion_short_width);
brain_plate_height = base_plate_height;

brain_box_height = 135;
brain_box_wall_thickness = 5;
brain_box_wall_threshold = 3;

brain_box_lid_wall_thickness = 3;
brain_box_lid_threshold = 0.2;

brain_box_inner_width = brain_plate_width - (brain_box_wall_thickness + brain_box_wall_threshold) * 2;
brain_box_inner_depth = brain_plate_depth - (brain_box_wall_thickness + brain_box_wall_threshold) * 2;
brain_box_inner_height = brain_plate_height - brain_box_height;

psu_width = 215.0;
psu_depth = 50;
psu_height = 115.0;

control_board_width = 160;
control_board_depth = 95;
control_board_height = 10;

ac_plug_width = 22;
ac_plug_depth = 27;
ac_plug_height = 48;
ac_plug_hole_distance = 39;
ac_plug_hole_radius = 2.0;

brain_box_standoff_height = 6;
brain_box_standoff_outer_radius = 9.5*0.5;
brain_box_standoff_inner_radius = 4.5*0.5;

brain_box_lid_height = 8;
brain_box_lid_slack = 0.1;

camera_mount_depth = 70;
camera_mount_width = 8;
camera_mount_height = 30;

motor_full_mount_width = 49;
motor_full_mount_height = 29 + base_plate_height;
motor_full_mount_depth = scan_plate_motor_mount_rod_depth;
motor_full_depth_offset = 16;
motor_coupling_trench_width = 32;
motor_coupling_trench_depth = 50;

scan_plate_motor_tube_sheath_radius = 6.9;
scan_plate_motor_tube_sheath_length = 130;
scan_plate_motor_tube_radius = 32 * 0.5;

// Derivative values
card_bin_inner_width = card_width + (card_bin_tolerance * 2);
card_bin_inner_depth = card_depth + (card_bin_tolerance * 2);
card_bin_inner_height = 220;

card_bin_width = card_bin_inner_width + (card_bin_thickness * 2);
card_bin_depth = card_bin_inner_depth + (card_bin_thickness * 2);
card_bin_height = card_bin_inner_height + card_bin_thickness;

card_magazine_hole_width = card_width + (card_magazine_tolerance * 2);
card_magazine_hole_depth = card_depth + (card_magazine_tolerance * 2);
card_magazine_hole_height = 360 + card_magazine_thickness_bottom;

card_magazine_width = card_width + (card_magazine_tolerance * 2) + (card_magazine_thickness * 2);
card_magazine_depth = card_depth + (card_magazine_tolerance * 2) + (card_magazine_thickness * 2);
card_magazine_height = 360 + card_magazine_thickness_bottom;

// Show specific objects
show_base_plate = false;
show_externals = false;
show_scan_plate = true;
show_brain_plate = false;
show_brain_plate_lid = false;
show_card_magazine_lifter = false;
show_card_magazine_lifter_top = false;
show_card_magazine_top = false;
show_card_magazine_bottom = false;
show_card_magazine_door_top = false;
show_card_magazine_door_bottom = false;
show_gantry = false;
show_card_bin = false;
show_card_mover_plate = false;
show_card_mover_plate_motor = false;
show_card_mover_plate_spindle = false;
show_card_mover = false;
show_card_mover_slide = false;
show_limit_switch_mount = false;
show_limit_switch_mount_small = false;
show_scan_plate_motor_mount_tube = false;
show_scan_plate_motor_mount = false;
show_camera_mount = false;
show_exit_insert = false;
show_exit_gate = false;

function radiansToDegrees(x) = x * (180.0 / PI);
function easeOutQuad(alpha) = 1 - (1 - alpha) * (1 - alpha);
function easeInQuart(alpha) = alpha * alpha * alpha * alpha;
function easeInSine(alpha) = 1.0 - cos(radiansToDegrees((alpha * PI) / 2.0));
function easeInCubic(x) = x * x * x;
function easeInOutQuad(x) = x < 0.5 ? 2 * x * x : 1 - pow(-2 * x + 2, 2) / 2;
function easeInOutCubic(x) = x < 0.5 ? x : 1 - pow(-2 * x + 2, 2) / 2;
function easeOutCubic(x) = 1 - pow(1 - x, 3);
function easeOutCirc(x) = sqrt(1 - pow(x - 1, 2));
function easeOutExpo(x) = (x == 1 ? 1 : 1 - pow(2, -10 * x));
function easeOutSineBullshit(x) = lerp(x, sin(radiansToDegrees((x * PI) / 3)), easeOutQuad(1 - x));
function clamp(a, lower, upper) = (a < lower ? lower : (a > upper ? upper : a));
function smoothstep(from, to, x) = 
        let (alpha = x * x * (3.0 - 2.0 * x))
            from + ((to - from) * alpha);
function lerp(start, end, alpha) = start + ((end - start) * alpha);

module rounded_cube(width, depth, height)
{
    rounded_radius = 5;
    hull()
    {
        translate([rounded_radius, 0, rounded_radius]) rotate([-90, 0, 0]) #cylinder(r=rounded_radius, h=scan_plate_motor_mount_depth, $fn=60);
        translate([width - rounded_radius, 0, rounded_radius]) rotate([-90, 0, 0]) #cylinder(r=rounded_radius, h=scan_plate_motor_mount_depth, $fn=60);
        translate([rounded_radius, 0, height - rounded_radius]) rotate([-90, 0, 0]) #cylinder(r=rounded_radius, h=scan_plate_motor_mount_depth, $fn=60);
        translate([width - rounded_radius, 0, height - rounded_radius]) rotate([-90, 0, 0]) #cylinder(r=rounded_radius, h=scan_plate_motor_mount_depth, $fn=60);
    }
}

module rounded_top_cube(width, depth, height)
{
    rounded_radius = 5;
    hull()
    {
        cube([rounded_radius, depth, rounded_radius]);
        translate([width - rounded_radius, 0, 0]) cube([rounded_radius, depth, rounded_radius]);
        translate([rounded_radius, 0, height - rounded_radius]) rotate([-90, 0, 0]) cylinder(r=rounded_radius, h=depth, $fn=60);
        translate([width - rounded_radius, 0, height - rounded_radius]) rotate([-90, 0, 0]) cylinder(r=rounded_radius, h=depth, $fn=60);
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

// Hole for fitting a recessed tbolt.
// With slot_along, the shank's hole is a slot into an extrusion, along that axis.
module recessed_bolt_hole(recess_amount = 3, slot_along = undef)
{
    translate([0, 0, -tbolt_nut_height - recess_amount + epsilon])
    {
        cylinder(h=tbolt_nut_height + recess_amount, r=tbolt_nut_radius, $fn=tbolt_nut_facets);
        translate([0, 0, -tbolt_shank_height - epsilon])
        {
            if (is_undef(slot_along)) cylinder(h=tbolt_shank_height + (epsilon*2), r=tbolt_shank_radius, $fn=30);
            else extrusion_bolt_slot(tbolt_shank_height + (epsilon * 2), slot_along);
        }
    }
}

// Hole for fitting a tbolt. With slot_along, it's a slot into an extrusion, along that axis.
module bolt_hole(radius, height, slot_along = undef)
{
    translate([0, 0, -height - epsilon])
    {
        if (is_undef(slot_along)) cylinder(h=height + (epsilon * 2), r=radius + tbolt_shank_radius_tolerance, $fn=30);
        else extrusion_bolt_slot(height + (epsilon * 2), slot_along);
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

// Bin that cards are deposited in
module card_bin()
{
    card_bin_skew_offset = 132;
    card_bin_width_skewed = card_bin_width - 25;

    translate([-card_bin_offset, 0, 0])
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
                                cube([card_bin_width_skewed, card_bin_depth, 0.001]);                                
                                translate([-card_bin_skew_offset, 0, card_bin_height])
                                {
                                    cube([card_bin_width_skewed, card_bin_depth, 0.001]);
                                }                                
                            }
                        }
                        union()
                        {
                            // Cut out center                            
                            hull()
                            {
                                translate([card_bin_thickness, card_bin_thickness, 0])
                                {
                                    translate([-25, 0, 42])
                                    {
                                        rotate([0, 20, 0]) cube([card_bin_inner_width, card_bin_inner_depth, 0.001]);                                
                                    }
                                    translate([-card_bin_skew_offset - 20, 0, card_bin_height + 32])
                                    {
                                        rotate([0, 20, 0]) cube([card_bin_inner_width, card_bin_inner_depth, 0.001 + epsilon]);
                                    }
                                }                                
                            }
                            // Flare the top a bit.
                            hull()
                            {                      
                                translate([-card_bin_skew_offset, 0, card_bin_height + 2])
                                {
                                    cube([card_bin_width_skewed, card_bin_depth, 0.001]);
                                }               
                                flare_depth = card_bin_depth - 60;
                                translate([-card_bin_skew_offset + 45, (card_bin_depth * 0.5) - (flare_depth * 0.5), card_bin_height - 30])
                                {
                                    cube([card_bin_width_skewed - 60, flare_depth, 0.001]);
                                } 
                            }
                            
                            // Cut viewing window out.
                            card_bin_window_radius = 10;       
                            card_bin_window_offset = 10;
                            
                            hull()
                            {
                                translate([card_bin_inner_width - (card_bin_thickness * 4) - 55, (card_bin_depth * 0.5), 12])
                                {
                                    #rotate([0, 90, 0]) cylinder(r=card_bin_window_radius, h=card_bin_thickness * 5 + (epsilon * 2) + 40);
                                }
                                translate([card_bin_inner_width - card_bin_skew_offset - (card_bin_thickness * 4), (card_bin_depth * 0.5), card_bin_inner_height + 15])
                                {
                                    rotate([0, 90, 0]) cylinder(r=card_bin_window_radius, h=card_bin_thickness * 5 + (epsilon * 2));
                                }
                            }
                        }
                    }
                
                    /*
                    multmatrix([
                        [1, 0, card_bin_skew, 0],
                        [0, 1, 0, 0],
                        [0, 0, 1, 0],
                        [0, 0, 0, 1]
                    ])
                    difference()
                    {
                        cube([card_bin_width, card_bin_depth, card_bin_height]);
                        union()
                        { 
                            translate([card_bin_thickness, card_bin_thickness, card_bin_thickness])
                            {
                                // Cut center out
                                translate([0, 0, card_bin_thickness * 2 + 20])
                                {
                                    hull()
                                    {
                                        rotate([0, 20, 0]) cube([card_bin_inner_width, card_bin_inner_depth, 1]);    
                                        translate([0, 0, card_bin_inner_height + epsilon]) rotate([0,20, 0]) cube([card_bin_inner_width, card_bin_inner_depth, 1]);    
                                    }
                                }                                
                                
                                
                                // Chamfer top edges
                                hull()
                                {
                                    translate([0, 0, card_bin_inner_height - 10])
                                    {
                                       rotate([0, 20, 0]) cube([card_bin_inner_width, card_bin_inner_depth, 0.01]);    
                                    }
                                    thickness = card_bin_thickness * 2.0;
                                    translate([-thickness * 0.5, -thickness * 0.5, card_bin_inner_height + 7 + 30])
                                    {
                                        rotate([0, 0, 0]) cube([card_bin_inner_width + (thickness * 1), card_bin_inner_depth + (thickness * 1), 0.01]);    
                                    }
                                }
                                
                                // Cut viewing window out.
                                card_bin_window_radius = 10;       
                                card_bin_window_offset = 10;
                                
                                hull()
                                {
                                    translate([card_bin_inner_width - (card_bin_thickness * 2), (card_bin_inner_depth * 0.5), 2])
                                    {
                                        rotate([0, 90, 0]) cylinder(r=card_bin_window_radius, h=card_bin_thickness * 3 + (epsilon * 2));
                                    }
                                    translate([card_bin_inner_width - (card_bin_thickness * 2), (card_bin_inner_depth * 0.5), card_bin_inner_height])
                                    {
                                        rotate([0, 90, 0]) cylinder(r=card_bin_window_radius, h=card_bin_thickness * 3 + (epsilon * 2));
                                    }
                                }
                            }                
                        }
                    }
                    */
                }
                
                translate([card_bin_offset, 0, 0])
                {
                    cube([-card_bin_offset, card_bin_depth, 12]);
                }
                translate([card_bin_offset + extrusion_long_width, 0, -extrusion_long_height])
                {
                    cube([-card_bin_offset + card_bin_width - extrusion_long_width - 25, card_bin_depth, 20]);
                }
            }
            union()
            {                                    
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
}

// Tab to connect the magazine halfs together.
module card_magazine_tab()
{
    cube([card_magazine_tab_width, card_magazine_tab_depth, card_magazine_tab_height]);
    hull()
    {
        translate([0, card_magazine_tab_depth*0.5, 0])
        {
            rotate([0, 90, 0]) cylinder(r=card_magazine_tab_depth*0.5, h=card_magazine_tab_width, $fn=60);
        }                    
        translate([0, card_magazine_tab_depth * 1.5, -20])
        {
            rotate([0, 90, 0]) cylinder(r=card_magazine_tab_depth*0.5, h=card_magazine_tab_width, $fn=60);
        }  
    }    
    /*hull()
    {
        translate([0, card_magazine_tab_depth*0.5, card_magazine_tab_height])
        {
            rotate([0, 90, 0]) cylinder(r=card_magazine_tab_depth*0.5, h=card_magazine_tab_width, $fn=60);
        }                
        translate([0, card_magazine_tab_depth * 1.5, card_magazine_tab_height + 20])
        {
            rotate([0, 90, 0]) cylinder(r=card_magazine_tab_depth*0.5, h=card_magazine_tab_width, $fn=60);
        }
    }*/
}

// Holes to connect the magazine tabs.
module card_magazine_tab_hole()
{
    translate([card_magazine_tab_width * 0.5, card_magazine_tab_depth + card_magazine_thickness, 5]) 
    {
        rotate([-90, 0, 0])
        {
        //    recessed_bolt_hole();
        }
    }    
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
    translate([card_magazine_width - card_magazine_thickness - card_magazine_index_insert + 1, (card_magazine_depth * 0.5), (card_magazine_height * 0.5) + (size * 0.5)])
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
module card_magazine()
{
    // The main body of the bin
    difference()
    {
        translate([card_magazine_thickness + epsilon, 0, 0])
        {    
            if (show_card_magazine_bottom)
            {        
                color("cyan") cube([card_magazine_width - card_magazine_thickness + (epsilon * 2), card_magazine_depth, card_magazine_height * 0.5]);
            }
            if (show_card_magazine_top)
            {        
                translate([0, 0, card_magazine_height * 0.5])
                {
                    color("brown") cube([card_magazine_width - card_magazine_thickness + (epsilon * 2), card_magazine_depth, (card_magazine_height * 0.5) - base_plate_height - epsilon]);
                }
            }
            
            if (show_card_magazine_top)
            {
                translate([-card_magazine_top_flare_width*0.5, -card_magazine_top_flare_depth*0.5, card_magazine_height - base_plate_height - card_magazine_top_flare_height])
                {
                    color("brown") cube([card_magazine_width - card_magazine_thickness + (epsilon * 2) + card_magazine_top_flare_width, card_magazine_depth + card_magazine_top_flare_depth, card_magazine_top_flare_height]);
                }
            }
            
            // Tabs on the side we use to screw the two halfs together.
            if (show_card_magazine_bottom)
            {    
                color("cyan") difference()
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
                            color("brown") cube([card_magazine_width - card_magazine_thickness + (epsilon * 2), card_magazine_depth, card_magazine_height * 0.5]);
                        }
                    }
                }
                
                // Add indexing pegs.
                card_magazine_indexing_pegs(card_magazine_index_size, card_magazine_index_height);
            }
            
            // Indexing pegs for the scan board            
            if (show_card_magazine_top)
            {    
                translate([0, 0, (card_magazine_height * 0.5) - base_plate_height])
                {
                    color("brown") card_magazine_indexing_top_pegs(card_magazine_index_size, card_magazine_index_height + 5);
                }
            }
            
            // Indexing pegs for the base board            
            if (show_card_magazine_bottom)
            {    
                translate([0, 0, 0])
                {
                    color("brown") card_magazine_indexing_bottom_pegs(card_magazine_index_size, card_magazine_index_height);
                }
            }
        }
        union()
        {
            card_magazine_width_plus_thresholds = card_width + (card_magazine_tolerance * 2);
            card_magazine_depth_plus_thresholds = card_depth + (card_magazine_tolerance * 2);
                        
            // Cut out holes for mounting hinge
            translate([card_magazine_thickness + card_magazine_hinge_hole_inset, -epsilon, card_magazine_height * 0.25])
            {                
                translate([0, 0, -card_magazine_hinge_hole_distance * 0.5]) rotate([-90, 0, 0]) cylinder(r=card_magazine_hinge_hole_radius, h=card_magazine_thickness + (epsilon * 2), $fn=60);
                translate([0, 0, card_magazine_hinge_hole_distance * 0.5]) rotate([-90, 0, 0]) cylinder(r=card_magazine_hinge_hole_radius, h=card_magazine_thickness + (epsilon * 2), $fn=60);                
                translate([0, card_magazine_thickness * 0.5 + epsilon * 2, -card_magazine_hinge_hole_distance * 0.5]) rotate([-90, 0, 0]) cylinder(r=card_magazine_hinge_hole_radius * 1.7, h=card_magazine_thickness * 0.5, $fn=60);
                translate([0, card_magazine_thickness * 0.5 + epsilon * 2, card_magazine_hinge_hole_distance * 0.5]) rotate([-90, 0, 0]) cylinder(r=card_magazine_hinge_hole_radius * 1.7, h=card_magazine_thickness * 0.5, $fn=60);
            }        
            translate([card_magazine_thickness + card_magazine_hinge_hole_inset, -epsilon, card_magazine_height * 0.75])
            {                
                translate([0, 0, -card_magazine_hinge_hole_distance * 0.5]) rotate([-90, 0, 0]) cylinder(r=card_magazine_hinge_hole_radius, h=card_magazine_thickness + (epsilon * 2), $fn=60);
                translate([0, 0, card_magazine_hinge_hole_distance * 0.5]) rotate([-90, 0, 0]) cylinder(r=card_magazine_hinge_hole_radius, h=card_magazine_thickness + (epsilon * 2), $fn=60);                
                translate([0, card_magazine_thickness * 0.5 + epsilon * 2, -card_magazine_hinge_hole_distance * 0.5]) rotate([-90, 0, 0]) cylinder(r=card_magazine_hinge_hole_radius * 1.7, h=card_magazine_thickness * 0.5, $fn=60);
                translate([0, card_magazine_thickness * 0.5 + epsilon * 2, card_magazine_hinge_hole_distance * 0.5]) rotate([-90, 0, 0]) cylinder(r=card_magazine_hinge_hole_radius * 1.7, h=card_magazine_thickness * 0.5, $fn=60);
            }                    
                        
            // Cut out peg holes
            if (show_card_magazine_top)
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
            
            // Cut the middle out
            translate([card_magazine_thickness, card_magazine_thickness, card_magazine_thickness_bottom])
            {
                cube([card_width + (card_magazine_tolerance * 2), card_depth + (card_magazine_tolerance * 2), card_magazine_height + card_magazine_tolerance - card_magazine_thickness_bottom]);
            }
                        
            // Cut the sides out.
            translate([(card_magazine_width_plus_thresholds * 0.5) - (card_magazine_lifter_cutout_size * 0.5) + card_magazine_thickness, -epsilon, card_magazine_thickness_bottom])
            {
                cube([card_magazine_lifter_cutout_size, card_depth + (epsilon*2) + (card_magazine_tolerance * 2) + (card_magazine_thickness * 2), card_magazine_height - card_magazine_thickness_bottom - card_magazine_thickness_bottom]);
            }
        }
    }
    
    // The door.
    /*
    translate([-card_magazine_thickness, 0, 0])
    {
        difference()
        {
            cube([card_magazine_thickness, card_magazine_depth, card_magazine_height]);            
            translate([-epsilon, (card_magazine_depth / 2) - (card_magazine_door_viewport_depth / 2), card_magazine_door_viewport_height_threshold])
            {
                cube([card_magazine_thickness + (epsilon * 2), card_magazine_door_viewport_depth, card_magazine_height - (card_magazine_door_viewport_height_threshold * 2)]);
            }
        }
    } 
    */   
    
    // TODO: Need a spring hinge
}

// Door for card magazine.
module card_magazine_door()
{    
    difference()
    {
        translate([card_magazine_thickness + epsilon - card_magazine_door_thickness, 0, 0])
        {    
            if (show_card_magazine_door_bottom)
            {        
                translate([0, 0, base_plate_height])
                {
                    height = (card_magazine_height * 0.5) - base_plate_height;
                    //color("orange") cube([card_magazine_door_thickness, card_magazine_depth, height]);                    
                    color("orange") hull()
                    {
                        translate([card_magazine_door_thickness*0.5, card_magazine_door_thickness*0.5, 0])
                        {
                            cylinder(r=card_magazine_door_thickness*0.5, height, $fn=100);
                        }               
                        translate([card_magazine_door_thickness*0.5, card_magazine_depth - (card_magazine_door_thickness*0.5), 0])
                        {
                            cylinder(r=card_magazine_door_thickness*0.5, height, $fn=100);
                        }
                    }
                    
                    translate([(card_magazine_door_thickness * 0.5) - (card_magazine_door_index_thickness * 0.5), card_magazine_depth*0.1*0.5, height])
                    {
                        color("orange") cube([card_magazine_door_index_thickness, card_magazine_depth * 0.9, card_magazine_door_index_height]);
                    }
                }
            }
            if (show_card_magazine_door_top)
            {        
                difference()
                {
                    translate([0, 0, card_magazine_height * 0.5])
                    {
                        //color("gray") cube([card_magazine_door_thickness, card_magazine_depth, (card_magazine_height * 0.5) - base_plate_height - card_magazine_top_flare_height - epsilon]);                                    
                        height = (card_magazine_height * 0.5) - base_plate_height - card_magazine_top_flare_height - epsilon;
                        color("gray") hull()
                        {
                            translate([card_magazine_door_thickness*0.5, card_magazine_door_thickness*0.5, 0])
                            {
                                cylinder(r=card_magazine_door_thickness*0.5, height, $fn=100);
                            }               
                            translate([card_magazine_door_thickness*0.5, card_magazine_depth - (card_magazine_door_thickness*0.5), 0])
                            {
                                cylinder(r=card_magazine_door_thickness*0.5, height, $fn=100);
                            }
                        }
                    }                        
                    translate([0, -epsilon, base_plate_height])
                    {
                        height = (card_magazine_height * 0.5) - base_plate_height;
                        translate([(card_magazine_door_thickness * 0.5) - ((card_magazine_door_index_thickness + card_magazine_door_index_tolerance) * 0.5), card_magazine_depth*0.1*0.5, height])
                        {
                            color("gray") cube([card_magazine_door_index_thickness + card_magazine_door_index_tolerance, card_magazine_depth * 0.9, card_magazine_door_index_height + card_magazine_door_index_tolerance]);
                        }
                    }
                }
            }  
        }
        union()
        {        
            // Cut out viewing slot in center
            /*
            hull()
            {
                translate([card_magazine_door_thickness, card_magazine_depth*0.5, base_plate_height + 40])
                {
                    rotate([0, 90, 0]) cylinder(h=card_magazine_door_thickness + (epsilon * 2), r=6, $fn=100);
                }
                translate([card_magazine_door_thickness, card_magazine_depth*0.5, base_plate_height])
                {
                    translate([0, 0, card_magazine_height*0.5])
                    {
                        height = (card_magazine_height * 0.5) - base_plate_height - card_magazine_top_flare_height - epsilon;
                        translate([0, 0, height - 50])
                        {
                            rotate([0, 90, 0]) cylinder(h=card_magazine_door_thickness + (epsilon * 2), r=6, $fn=100);
                        }
                    }
                }
            }
            */
        
            // Cut out holes for mounting hinge
            translate([card_magazine_thickness + card_magazine_hinge_hole_inset - card_magazine_door_hinge_hole_to_edge, -epsilon, card_magazine_height * 0.25])
            {                
                // Cut out the edge so the joint has somewhere to go.
                translate([card_magazine_door_hinge_edge_space*0.5, card_magazine_door_hinge_edge_space * 0.5, -card_magazine_door_hinge_height*0.5])
                {
                    translate([-10, -card_magazine_door_hinge_edge_space*0.5, 0])
                    {
                    #    cube([20, card_magazine_door_hinge_edge_space, card_magazine_door_hinge_height]);
                    }
                }
                
                translate([0, card_magazine_door_hinge_inset, 0])
                {
                    translate([-5, 0, -card_magazine_hinge_hole_distance * 0.5]) rotate([0, 90, 0]) cylinder(r=card_magazine_hinge_hole_radius, h=card_magazine_thickness + 10 + (epsilon * 2), $fn=60);
                    translate([-5, 0, card_magazine_hinge_hole_distance * 0.5]) rotate([0, 90, 0]) cylinder(r=card_magazine_hinge_hole_radius, h=card_magazine_thickness + 10 + (epsilon * 2), $fn=60);                
                    translate([card_magazine_door_thickness * 0.5 + epsilon * 2, 0, -card_magazine_hinge_hole_distance * 0.5]) rotate([0, 90, 0]) cylinder(r=card_magazine_hinge_hole_radius * 1.7, h=card_magazine_thickness * 0.5, $fn=60);
                    translate([card_magazine_door_thickness * 0.5 + epsilon * 2, 0, card_magazine_hinge_hole_distance * 0.5]) rotate([0, 90, 0]) cylinder(r=card_magazine_hinge_hole_radius * 1.7, h=card_magazine_thickness * 0.5, $fn=60);
                }
            }        
            translate([card_magazine_thickness + card_magazine_hinge_hole_inset - card_magazine_door_hinge_hole_to_edge, -epsilon, card_magazine_height * 0.75])
            {        
                // Cut out the edge so the joint has somewhere to go.
                translate([card_magazine_door_hinge_edge_space*0.5, card_magazine_door_hinge_edge_space * 0.5, -card_magazine_door_hinge_height*0.5])
                {
                    translate([-10, -card_magazine_door_hinge_edge_space*0.5, 0])
                    {
                        cube([20, card_magazine_door_hinge_edge_space, card_magazine_door_hinge_height]);
                    }
                }
                
                translate([0, card_magazine_door_hinge_inset, 0])
                {
                    translate([-5, 0, -card_magazine_hinge_hole_distance * 0.5]) rotate([0, 90, 0]) cylinder(r=card_magazine_hinge_hole_radius, h=card_magazine_thickness + 10 + (epsilon * 2), $fn=60);
                    translate([-5, 0, card_magazine_hinge_hole_distance * 0.5]) rotate([0, 90, 0]) cylinder(r=card_magazine_hinge_hole_radius, h=card_magazine_thickness + 10 + (epsilon * 2), $fn=60);                
                    translate([card_magazine_door_thickness * 0.5 + epsilon * 2, 0, -card_magazine_hinge_hole_distance * 0.5]) rotate([0, 90, 0]) cylinder(r=card_magazine_hinge_hole_radius * 1.7, h=card_magazine_thickness * 0.5, $fn=60);
                    translate([card_magazine_door_thickness * 0.5 + epsilon * 2, 0, card_magazine_hinge_hole_distance * 0.5]) rotate([0, 90, 0]) cylinder(r=card_magazine_hinge_hole_radius * 1.7, h=card_magazine_thickness * 0.5, $fn=60);
                }            
            }  
        }
    }
}

// Lifter that attachs to the lead screw to lift cards up.
module card_lifter()
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
                    if (show_card_magazine_lifter)
                    {
                        color("purple") cube([card_width, card_depth, base_plate_height * 0.5]);
                    }
                }
                translate([0, 0, card_magazine_lifter_height])
                {
                    if (show_card_magazine_lifter_top)
                    {
                        color("black") cube([card_width, card_depth, card_magazine_thickness_bottom]);                
                    }
                }                
                
                if (show_card_magazine_lifter)
                {
                    // Arms
                    translate([(card_width*0.5) - (card_magazine_lifter_arm_width * 0.5), (card_depth*0.5) - (lifter_depth*0.5), 0])
                    {
                        arm_depth = lifter_depth - (card_magazine_lifter_hand_depth * 2) + 10;
                        
                        translate([0, 3 + card_magazine_lifter_hand_depth - card_magazine_lifter_rod_plate_depth + bearing_rod_bearing_bearing_to_base_offset - 10, 0])
                        {
                            color("purple") cube([card_magazine_lifter_arm_width, arm_depth - 3, card_magazine_lifter_height]);
                        }
                        
                        // Lead screw plate            
                        translate([(card_magazine_lifter_arm_width*0.5) - (card_magazine_lifter_hand_width*0.5), card_magazine_lifter_lead_rod_plate_offset, 0])
                        {
                            //cube([card_magazine_lifter_hand_width, card_magazine_lifter_hand_depth - card_magazine_lifter_lead_rod_plate_offset, card_magazine_lifter_height]);
                            translate([card_magazine_lifter_hand_width*0.5, card_magazine_lifter_hand_width*0.5 - 1.5, 0])
                            {
                                difference()
                                {
                                    color("purple") cylinder(r=card_magazine_lifter_hand_width*0.5, h=card_magazine_lifter_height);     
                                    translate([0, 0, -epsilon])                               
                                    {
                                        color("purple") cylinder(r=card_magazine_lifter_hand_width*0.4, h=card_magazine_lifter_height * 0.5);
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
    color("purple") translate([-((base_plate_width * 0.5) - (card_magazine_width * 0.5)), -((base_plate_depth * 0.5) - (card_magazine_depth * 0.5)), 0]) // Cancel out magazine lifters offset to get into base plate space
    {
        translate([0, 0, 0])
        {
            translate([(base_plate_width / 2) - (stepping_motor_width/2), base_plate_depth - stepping_motor_depth, 0])
            {
                translate([stepping_motor_width/2, stepping_motor_depth/2, 0])
                {
                    translate([0, 0, card_magazine_thickness_bottom])
                    {
                        if (show_card_magazine_lifter)
                        {
                            double_bearing_mount(0.0, 15);
                        }
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
                        cylinder(r=lead_screw_base_hole_radius + lead_screw_hole_threshold, h=card_magazine_lifter_height + (epsilon * 4) - 10, $fn=60);
                    }
                    cylinder(r=lead_screw_radius + lead_screw_hole_threshold, h=lead_screw_height, $fn=30);
                    
                    translate([0, 0, base_plate_stepping_motor_plate_height + card_magazine_thickness - epsilon])
                    {
                        translate([0, lead_screw_mounting_hole_offset, 0])
                        {
                            cylinder(r=lead_screw_mounting_hole_radius, h=card_magazine_lifter_height * 2 + (epsilon * 4), $fn=30);                    
                        }
                        translate([0, -lead_screw_mounting_hole_offset, 0])
                        {
                            cylinder(r=lead_screw_mounting_hole_radius, h=card_magazine_lifter_height * 2 + (epsilon * 4), $fn=30);                    
                        }
                        translate([lead_screw_mounting_hole_offset, 0, 0])
                        {
                            cylinder(r=lead_screw_mounting_hole_radius, h=card_magazine_lifter_height * 2 + (epsilon * 4), $fn=30);                    
                        }
                        translate([-lead_screw_mounting_hole_offset, 0, 0])
                        {
                            cylinder(r=lead_screw_mounting_hole_radius, h=card_magazine_lifter_height * 2 + (epsilon * 4), $fn=30);                    
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
                cylinder(r=bearing_rod_radius + bearing_rod_hole_threshold, h=lead_screw_height + base_plate_height + epsilon, $fn=30);               
            
                translate([0, 0, base_plate_stepping_motor_plate_height + card_magazine_thickness - epsilon + base_plate_bearing_plate_height])
                {
                //    cylinder(r=bearing_rod_linear_bearing_radius, h=card_magazine_lifter_height + (epsilon * 4), $fn=30);                    
                }
            }
        }
    }     
}

// Line of bins and the extrusion below it.
module bin_line()
{
    translate([ 0, 0, extrusion_long_height ])
    {
        for ( i = [0 : card_bin_count - 1] )
        {
            translate([0, i * (card_bin_depth + card_bin_spacing), 0])
            {
                card_bin();
            }
        }
    }
}

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
    bearing_to_base = bearing_rod_bearing_bearing_to_base_offset;
    bearing_mount_height = 35;
    
    translate([-(card_magazine_lifter_hand_width * 0.5), -bearing_to_base - bearing_rod_clamp_plate_width, 0])
    {
        difference()
        {
            cube([card_magazine_lifter_hand_width, bearing_rod_clamp_plate_width, bearing_mount_height]);
        
            union()
            {
                // Rod bolt holes
                translate([(card_magazine_lifter_hand_width * 0.5), epsilon+5, (bearing_mount_height * 0.5)])
                {
                    translate([card_magazine_lifter_rod_plate_hole_offset_depth, (bearing_rod_clamp_plate_width * 0.5) + 1, card_magazine_lifter_rod_plate_hole_offset_height])
                    {
                        rotate([90, 0, 0]) cylinder(h=bearing_rod_clamp_plate_width + 1, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                        translate([0, -bearing_rod_clamp_plate_width + 4 - epsilon, 0])
                        {
                            rotate([90, 0, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2.2, $fn=30);
                        }
                    }
                    translate([-card_magazine_lifter_rod_plate_hole_offset_depth, (bearing_rod_clamp_plate_width * 0.5) + 1, card_magazine_lifter_rod_plate_hole_offset_height])
                    {
                        rotate([90, 0, 0]) cylinder(h=bearing_rod_clamp_plate_width + 1, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                        translate([0, -bearing_rod_clamp_plate_width + 4 - epsilon, 0])
                        {
                            rotate([90, 0, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2.2, $fn=30);
                        }
                    }
                    translate([card_magazine_lifter_rod_plate_hole_offset_depth, (bearing_rod_clamp_plate_width * 0.5) + 1, -card_magazine_lifter_rod_plate_hole_offset_height])
                    {
                        rotate([90, 0, 0]) cylinder(h=bearing_rod_clamp_plate_width + 1, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                        translate([0, -bearing_rod_clamp_plate_width + 4 - epsilon, 0])
                        {
                            rotate([90, 0, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2.2, $fn=30);
                        }
                    }
                    translate([-card_magazine_lifter_rod_plate_hole_offset_depth, (bearing_rod_clamp_plate_width * 0.5) + 1, -card_magazine_lifter_rod_plate_hole_offset_height])
                    {
                        rotate([90, 0, 0]) cylinder(h=bearing_rod_clamp_plate_width + 1, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                        translate([0, -bearing_rod_clamp_plate_width + 4 - epsilon, 0])
                        {
                            rotate([90, 0, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2.2, $fn=30);
                        }
                    }
                }
            }
            
            translate([0, bearing_rod_clamp_plate_width, 0])
            {
                color("blue") cube([card_magazine_lifter_hand_width, bearing_rod_bearing_bearing_to_base_offset, bearing_mount_height]);
            }
        }
    }
}

// Mount to connect a linear bearing to the lead screw.
// Origin is expected to be the center of the rod.
module double_bearing_mount(width_change = 0.0, hole_offset = 0.0)
{    
    bearing_to_base = bearing_rod_bearing_bearing_to_base_offset + width_change;
    
    translate([-(card_magazine_lifter_hand_width * 0.5), -bearing_to_base - bearing_rod_clamp_plate_width, 0])
    {
        difference()
        {
            cube([card_magazine_lifter_hand_width, bearing_rod_clamp_plate_width, card_magazine_lifter_height]);
        
            union()
            {
                // Rod bolt holes       
                for ( i = [-1, 1] )
                {        
                    if (i != 0)
                    {      
                        rod_hole_offset = hole_offset * i;
                        
                        translate([(card_magazine_lifter_hand_width * 0.5), epsilon+5, (card_magazine_lifter_height * 0.5) + rod_hole_offset])
                        {
                            translate([card_magazine_lifter_rod_plate_hole_offset_depth, (bearing_rod_clamp_plate_width * 0.5) + 1, card_magazine_lifter_rod_plate_hole_offset_height])
                            {
                                rotate([90, 0, 0]) cylinder(h=bearing_rod_clamp_plate_width + 1, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                                translate([0, -bearing_rod_clamp_plate_width + 4 - epsilon, 0])
                                {
                                    rotate([90, 0, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2.2, $fn=30);
                                }
                            }
                            translate([-card_magazine_lifter_rod_plate_hole_offset_depth, (bearing_rod_clamp_plate_width * 0.5) + 1, card_magazine_lifter_rod_plate_hole_offset_height])
                            {
                                rotate([90, 0, 0]) cylinder(h=bearing_rod_clamp_plate_width + 1, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                                translate([0, -bearing_rod_clamp_plate_width + 4 - epsilon, 0])
                                {
                                    rotate([90, 0, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2.2, $fn=30);
                                }
                            }
                            translate([card_magazine_lifter_rod_plate_hole_offset_depth, (bearing_rod_clamp_plate_width * 0.5) + 1, -card_magazine_lifter_rod_plate_hole_offset_height])
                            {
                                rotate([90, 0, 0]) cylinder(h=bearing_rod_clamp_plate_width + 1, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                                translate([0, -bearing_rod_clamp_plate_width + 4 - epsilon, 0])
                                {
                                    rotate([90, 0, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2.2, $fn=30);
                                }
                            }
                            translate([-card_magazine_lifter_rod_plate_hole_offset_depth, (bearing_rod_clamp_plate_width * 0.5) + 1, -card_magazine_lifter_rod_plate_hole_offset_height])
                            {
                                rotate([90, 0, 0]) cylinder(h=bearing_rod_clamp_plate_width + 1, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                                translate([0, -bearing_rod_clamp_plate_width + 4 - epsilon, 0])
                                {
                                    rotate([90, 0, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2.2, $fn=30);
                                }
                            }
                        }
                    }
                }
            }
            
            translate([0, bearing_rod_clamp_plate_width, 0])
            {
                //color("blue") cube([card_magazine_lifter_hand_width, bearing_rod_bearing_bearing_to_base_offset, card_magazine_lifter_height]);
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
                                rotate([0, 90, 0]) cylinder(h=bearing_rod_clamp_plate_width + (epsilon * 2), r=bearing_rod_clamp_screw_radius, $fn=32);
                            }
                            translate([-epsilon, (bearing_rod_clamp_plate_depth * 0.5) + bearing_rod_clamp_rod_to_screw_offset, bearing_rod_clamp_plate_height * 0.5])
                            {
                                rotate([0, 90, 0]) cylinder(h=bearing_rod_clamp_plate_width + (epsilon * 2), r=bearing_rod_clamp_screw_radius, $fn=32);
                            }
                        }
                    }
                }
        
                translate([0, 0, 0])
                {
                    //cylinder(r=10, h=100);
                    //color("blue") cube([bearing_rod_clamp_rod_to_base_offset, bearing_rod_clamp_plate_depth, bearing_rod_clamp_plate_height]);
                }
            }
        }
    }
}

// Mount for the clamp that holds onto the bearing rod.
module rod_pillow_mount_holes()
{        
    translate([0, 0, base_plate_height])
    {
        translate([(base_plate_width / 2) - (stepping_motor_width/2), base_plate_depth - stepping_motor_depth, -stepping_motor_height])
        {
            translate([stepping_motor_width/2, stepping_motor_depth/2, stepping_motor_height])
            {
                translate([pillow_mount_hole_distance * 0.5, 0, -base_plate_height - epsilon])
                {
                    cylinder(r=pillow_mount_hole_radius, h=base_plate_height + (epsilon * 2), $fn=60);
                }
                translate([-pillow_mount_hole_distance * 0.5, 0, -base_plate_height - epsilon])
                {
                    cylinder(r=pillow_mount_hole_radius, h=base_plate_height + (epsilon * 2), $fn=60);
                }
            }
        }
    }
}

module lead_screw_pillow_mount_holes()
{
    translate([0, pillow_mount_hole_distance * 0.5, -base_plate_height - epsilon])
    {
        cylinder(r=pillow_mount_hole_radius, h=base_plate_height + (epsilon * 2), $fn=60);
    }
    translate([0, -pillow_mount_hole_distance * 0.5, -base_plate_height - epsilon])
    {
        cylinder(r=pillow_mount_hole_radius, h=base_plate_height + (epsilon * 2), $fn=60);
    }
}

// Plate at the bottom of the gantry that the magazine sits on.
module base_plate()
{
    translate([-extrusion_short_depth - base_plate_width, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width, extrusion_short_height])
    {
        difference()
        {            
            union()
            {
                if (show_base_plate)
                {
                    difference()
                    {
                        color("indigo") hull()
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
                                translate([(base_plate_width * 0.5) - (card_magazine_width * 0.5), (base_plate_depth * 0.5) - (card_magazine_depth * 0.5), 0])
                                {    
                                    translate([card_magazine_thickness + epsilon, 0, 0])
                                    {    
                                        translate([0, 0, 0])
                                        {
                                            color("brown") card_magazine_indexing_bottom_pegs(card_magazine_index_size + card_magazine_index_tolerance, base_plate_height + (epsilon*2));
                                        }
                                    }
                                }
                            }
                                 
                        }
                    }
                }
                
                translate([0, 0, base_plate_height])
                {
                    // Magazine  
                    translate([(base_plate_width * 0.5) - (card_magazine_width * 0.5), (base_plate_depth * 0.5) - (card_magazine_depth * 0.5), 0])
                    {
                        if (show_card_magazine_top || show_card_magazine_bottom)
                        {
                            card_magazine();                
                        }
                        if (show_card_magazine_door_top || show_card_magazine_door_bottom)
                        {
                            card_magazine_door();                
                        }
                        if (show_card_magazine_lifter || show_card_magazine_lifter_top)
                        {
                            card_lifter();
                        }
                    }
                }
            }
            
            union()
            {                
                translate([0, 0, base_plate_height])
                {
                    card_magazine_width_plus_thresholds = card_width + (card_magazine_tolerance * 2);
                    card_magazine_depth_plus_thresholds = card_depth + (card_magazine_tolerance * 2);
                              
                    // Magazine connector holes
                    translate([(base_plate_width * 0.5) - (card_magazine_width * 0.5), (base_plate_depth * 0.5) - (card_magazine_depth * 0.5), 0])
                    {
                        translate([card_magazine_thickness, card_magazine_thickness, card_magazine_thickness_bottom])
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
                                cylinder(r=stepping_motor_screw_hole_radius, h=base_plate_height, $fn=30);                            
                            }
                            translate([-stepping_motor_screw_hole_offset, stepping_motor_screw_hole_offset, -epsilon])
                            {
                                cylinder(r=stepping_motor_screw_hole_radius, h=base_plate_height, $fn=30);                            
                            }
                            translate([stepping_motor_screw_hole_offset, -stepping_motor_screw_hole_offset, -epsilon])
                            {
                                cylinder(r=stepping_motor_screw_hole_radius, h=base_plate_height, $fn=30);                            
                            }
                            translate([-stepping_motor_screw_hole_offset, -stepping_motor_screw_hole_offset, -epsilon])
                            {
                                cylinder(r=stepping_motor_screw_hole_radius, h=base_plate_height, $fn=30);                            
                            }
                        }
                    }  
                }      
            }
        }
        
        // Mount for rod    
        if (show_base_plate)
        {
            color("indigo") rod_mount();
        }
        
        if (show_externals)
        {
            translate([0, 0, base_plate_height])
            {
                // Stepping motor and lead screw
                translate([(base_plate_width / 2) - (stepping_motor_width/2), 0, -stepping_motor_height - base_plate_stepping_motor_plate_height])
                {
                    color("blue") cube([stepping_motor_width, stepping_motor_depth, stepping_motor_height]);
                    translate([stepping_motor_width/2, stepping_motor_depth/2, stepping_motor_height])
                    {
                        color("blue") cylinder(r=lead_screw_radius, h=lead_screw_height, $fn=30);
                    }
                }
                
                // Bearing rod
                translate([(base_plate_width / 2) - (stepping_motor_width/2), base_plate_depth - stepping_motor_depth, -stepping_motor_height - base_plate_stepping_motor_plate_height])
                {
                    translate([stepping_motor_width/2, stepping_motor_depth/2, stepping_motor_height])
                    {
                        color("blue") cylinder(r=bearing_rod_radius, h=lead_screw_height, $fn=30);
                    }
                }
            }
        }
    }
}

// Scan plate at the top of the magazine where the fun goes down.
module scan_plate()
{
    if (show_scan_plate)
    {
        difference()
        {
            union()
            {
                color("pink") translate([-extrusion_short_depth - base_plate_width, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width, extrusion_short_height + card_magazine_height])
                {
                    scan_plate_gantry_brackets();
                }
                difference()
                {    
                    color("pink") translate([-extrusion_short_depth - base_plate_width, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width, extrusion_short_height + card_magazine_height])
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
                        
                        // Add mount for limit switch.
                        translate([base_plate_width * 0.55, (base_plate_depth * 0.5) + card_magazine_hole_depth * 0.5, base_plate_height])
                        {
                            limit_switch_mount_length = 20;
                            limit_switch_mount_height = 14;
                                    
                            translate([-limit_switch_mount_length*0.5, 0, card_magazine_hole_scan_wall_height_size])
                            {
                                difference()
                                {
                                    // Mount for limit switch
                                    rounded_top_cube(limit_switch_mount_length, card_magazine_hole_scan_wall_size, limit_switch_mount_height);

                                    // Limit switch holes.
                                    translate([0, 0, 0])
                                    {
                                        translate([(limit_switch_mount_length * 0.5) - (limit_switch_mount_hole_distance * 0.5), card_magazine_hole_scan_wall_size + epsilon, 2])
                                        {
                                            hull()
                                            {
                                                rotate([90, 0, 0]) cylinder(h=card_magazine_hole_scan_wall_size + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                                                translate([0, 0, limit_switch_mount_height - limit_switch_mount_hole_radius - 3])
                                                {
                                                    rotate([90, 0, 0]) cylinder(h=card_magazine_hole_scan_wall_size + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                                                }
                                            }
                                        }
                                        translate([(limit_switch_mount_length * 0.5) + (limit_switch_mount_hole_distance * 0.5), card_magazine_hole_scan_wall_size + epsilon, 2])
                                        {
                                            hull()
                                            {
                                                rotate([90, 0, 0]) cylinder(h=card_magazine_hole_scan_wall_size + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                                                translate([0, 0, limit_switch_mount_height - limit_switch_mount_hole_radius - 3])
                                                {
                                                    rotate([90, 0, 0]) cylinder(h=card_magazine_hole_scan_wall_size + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                           /*
                            translate([(-card_magazine_hole_width * 0.5) - card_magazine_hole_scan_wall_size, -limit_switch_mount_length * 0.5, card_magazine_hole_scan_wall_height_size])
                            {
                                difference()
                                {
                                    // Mount for limit switch
                                    cube([card_magazine_hole_scan_wall_size, limit_switch_mount_length, limit_switch_mount_height]);

                                    // Limit switch holes.
                                    translate([0, limit_switch_mount_length * 0.5, 0])
                                    {
                                        translate([-epsilon, -(limit_switch_mount_hole_distance * 0.5), 2])
                                        {
                                            hull()
                                            {
                                                rotate([0, 90, 0]) cylinder(h=card_magazine_hole_scan_wall_size + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                                                translate([0, 0, limit_switch_mount_height * 0.65])
                                                {
                                                    rotate([0, 90, 0]) cylinder(h=card_magazine_hole_scan_wall_size + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                                                }
                                            }
                                        }
                                        translate([-epsilon, (limit_switch_mount_hole_distance * 0.5), 2])
                                        {
                                            hull()
                                            {
                                                rotate([0, 90, 0]) cylinder(h=card_magazine_hole_scan_wall_size + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                                                translate([0, 0, limit_switch_mount_height * 0.65])
                                                {
                                                    rotate([0, 90, 0]) cylinder(h=card_magazine_hole_scan_wall_size + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            */
                        }
                        
                        // Lead screw plate            
                        translate([0, 0, base_plate_height])
                        {
                            motor_width_plus_threshold = stepping_motor_width + (stepping_motor_tolerance * 2);
                            motor_depth_plus_threshold = stepping_motor_depth + (stepping_motor_tolerance * 2);
                                    
                            translate([(base_plate_width / 2) - (motor_width_plus_threshold / 2), -stepping_motor_tolerance, 0])
                            {
                                translate([motor_width_plus_threshold/2, motor_depth_plus_threshold/2, 0])
                                {
                                    rotate([0, 0, 90])
                                    {
                                    //cylinder(r=4, h=100);
                                      //  bearing_mount();
                                    }
                                }
                            }
                        }                
                    }
                        
                    union()
                    {            
                        // Cut trench for motor couplings
                        translate([-extrusion_short_depth, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width, extrusion_short_height + card_magazine_height + base_plate_height])
                        {
                            translate([-scan_plate_motor_mount_width_offset - (motor_full_mount_width * 0.5), -motor_full_mount_depth - motor_full_depth_offset, 0])
                            {
                                difference()
                                {
                                    translate([(motor_full_mount_width * 0.5) - (motor_coupling_trench_width*0.5), motor_full_mount_depth, -base_plate_height - epsilon])
                                    {
                                        cube([motor_coupling_trench_width, motor_coupling_trench_depth, base_plate_height + (epsilon * 2)]);       
                                    }
                                }
                            }
                        }
                    
                        translate([-extrusion_short_depth - base_plate_width, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width, extrusion_short_height])
                        {
                            translate([0, 0, card_magazine_height])
                            {
                                //rod_pillow_mount_holes();
                                                                   
                                translate([0, 0, base_plate_height])
                                {
                                    motor_width_plus_threshold = stepping_motor_width + (stepping_motor_tolerance * 2);
                                    motor_depth_plus_threshold = stepping_motor_depth + (stepping_motor_tolerance * 2);
                                            
                                    translate([(base_plate_width / 2) - (motor_width_plus_threshold / 2), -stepping_motor_tolerance, 0])
                                    {
                                        translate([motor_width_plus_threshold/2, motor_depth_plus_threshold/2, 0])
                                        {
                                            rotate([0, 0, 90])
                                            {
                                                //lead_screw_pillow_mount_holes();
                                            }
                                        }
                                    }
                                }   
                            }
                        
                            rod_holes(false);
                        }
                                      
                        translate([-extrusion_short_depth - base_plate_width, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width, extrusion_short_height])
                        {
                            translate([0, 0, base_plate_height])
                            {             
                                // Card hole   
                                translate([(base_plate_width * 0.5) - (card_magazine_width * 0.5), (base_plate_depth * 0.5) - (card_magazine_depth * 0.5), 0])
                                {       
                                    // Cut our holes for indexing pegs
                                    translate([card_magazine_thickness + epsilon, 0, 0])
                                    {        
                                        translate([0, 0, (card_magazine_height * 0.5) - base_plate_height])
                                        {
                                            color("brown") card_magazine_indexing_top_pegs(card_magazine_index_size + card_magazine_index_tolerance, card_magazine_index_height + card_magazine_index_tolerance + 100);
                                        }
                                    }
                                
                                    translate([card_magazine_thickness, card_magazine_thickness, card_magazine_thickness])
                                    {
                                        cube([card_width + (card_magazine_tolerance * 2), card_depth + (card_magazine_tolerance * 2), card_magazine_height + card_magazine_tolerance]);
                                    }
                                               
                                }
                                
                                // Magazine  
                                translate([(base_plate_width * 0.5) - (card_magazine_width * 0.5), (base_plate_depth * 0.5) - (card_magazine_depth * 0.5), 0])
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
                
                color("pink") translate([-extrusion_short_depth - base_plate_width, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width, extrusion_short_height + card_magazine_height])
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

                            // Add a card stop around the edges.
                            translate([card_magazine_hole_scan_wall_size, card_magazine_hole_scan_wall_size, card_top_spacing])
                            {
                                translate([0, 0, card_stop_size*0.5])
                                {
                                    rotate([-90, -30, 0])
                                    {
                                        cylinder(r=card_stop_size*0.5, h=hole_depth, $fn=60);
                                    }
                                }
                                //cube([card_stop_size, hole_depth, card_stop_size]);
                            }
                            
                            translate([card_magazine_hole_scan_wall_size, card_magazine_hole_scan_wall_size, card_top_spacing])
                            {
                                translate([0, 0, card_stop_size*0.5])
                                {
                                    rotate([0, 90, 0])
                                    {
                                        cylinder(r=card_stop_size*0.5, h=hole_width*0.60, $fn=60);
                                    }
                                }
                                //cube([hole_width, card_stop_size, card_stop_size]);
                            }
                            
                            translate([card_magazine_hole_scan_wall_size, hole_depth + card_magazine_hole_scan_wall_size - card_stop_size, card_top_spacing])
                            {
                                difference()
                                {
                                    translate([0, card_stop_size, card_stop_size*0.5])
                                    {
                                        rotate([0, 90, 0])
                                        {
                                            cylinder(r=card_stop_size*0.5, h=hole_width*0.60, $fn=60);
                                        }
                                    }
                                    translate([hole_width*0.25, 0, 0])
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
                exit_frame()
                {
                    exit_insert_pocket();
                }

                // Motor tube profile.

                translate([-extrusion_short_depth, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width - 78, extrusion_short_height + card_magazine_height + base_plate_height])
                {            
                    translate([-scan_plate_motor_mount_width_offset, 20 + (base_plate_depth * 0.5) - (card_magazine_hole_depth * 0.5), scan_plate_motor_mount_height * 0.5 + scan_plate_motor_height_offset])
                    {
                        rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=scan_plate_motor_tube_sheath_radius + 0.2, $fn=100);
                    }
                }
            
            }            
        }
    }  

    if (show_scan_plate)
    {
        // Motor mount
        translate([-extrusion_short_depth, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width, extrusion_short_height + card_magazine_height + base_plate_height])
        {            
            translate([-scan_plate_motor_mount_width_offset - (motor_full_mount_width * 0.5), -motor_full_mount_depth - motor_full_depth_offset, 0])
            {
                difference()
                {
                    motor_full_mount_width_flare = 45.5;
                    translate([0, 0, -base_plate_height])
                    {
                        cube([motor_full_mount_width, motor_full_mount_depth, motor_full_mount_height]);       
                        hull()
                        {
                            cube([motor_full_mount_width, motor_full_mount_depth + motor_full_depth_offset, base_plate_height]);            
                            translate([-motor_full_mount_width_flare, motor_full_mount_depth + motor_full_depth_offset, 0])   
                            {
                                cube([motor_full_mount_width_flare, 1, base_plate_height]);               
                            }
                        }
                    }
                    union()
                    {
                        translate([(motor_full_mount_width * 0.5) - (motor_coupling_trench_width*0.5), motor_full_mount_depth, -base_plate_height - epsilon])
                        {
                         //   cube([motor_coupling_trench_width, motor_coupling_trench_depth, base_plate_height + (epsilon * 2)]);       
                        }
                        translate([motor_full_mount_width*0.5, -epsilon, scan_plate_motor_mount_height * 0.5 + scan_plate_motor_height_offset])
                        {
                            // Big hole for spigot.                                
                            translate([0, 0, 0]) rotate([-90, 0, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2) + motor_full_mount_depth + 2, r=extrusion_motor_mount_spigot_radius + 2, $fn=60);
                        
                            // Holes to mount motor.
                            translate([stepping_motor_screw_hole_offset,  0, stepping_motor_screw_hole_offset]) rotate([-90, 0, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2) + 10, r=stepping_motor_screw_hole_radius, $fn=60);
                            translate([-stepping_motor_screw_hole_offset, 0, stepping_motor_screw_hole_offset]) rotate([-90, 0, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2) + 10, r=stepping_motor_screw_hole_radius, $fn=60);
                            translate([stepping_motor_screw_hole_offset, 0, -stepping_motor_screw_hole_offset]) rotate([-90, 0, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2) + 10, r=stepping_motor_screw_hole_radius, $fn=60);
                            translate([-stepping_motor_screw_hole_offset, 0, -stepping_motor_screw_hole_offset]) rotate([-90, 0, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2) + 10, r=stepping_motor_screw_hole_radius, $fn=60);
                            
                            hull()
                            {
                                translate([stepping_motor_screw_hole_offset, 10, -stepping_motor_screw_hole_offset]) rotate([-90, 0, 0]) cylinder(h=17, r=stepping_motor_screw_hole_radius * 1.75, $fn=60);
                                translate([stepping_motor_screw_hole_offset, 10, -stepping_motor_screw_hole_offset - 20]) rotate([-90, 0, 0]) cylinder(h=17, r=stepping_motor_screw_hole_radius * 1.75, $fn=60);
                            }
                            hull()
                            {
                                translate([-stepping_motor_screw_hole_offset, 10, -stepping_motor_screw_hole_offset]) rotate([-90, 0, 0]) cylinder(h=17, r=stepping_motor_screw_hole_radius * 1.75, $fn=60);
                                translate([-stepping_motor_screw_hole_offset, 10, -stepping_motor_screw_hole_offset - 20]) rotate([-90, 0, 0]) cylinder(h=17, r=stepping_motor_screw_hole_radius * 1.75, $fn=60);
                            }
                        }
                    }
                }
            }
            
            // Left rod holder
            /*
            translate([-scan_plate_motor_mount_width_offset - (scan_plate_motor_mount_width * 0.5 / 2), (base_plate_depth * 0.5) - (card_magazine_depth * 0.5) - 1, 0])
            {
                // Main motor rod holder
                difference()
                {
                    union()
                    {
                        color("pink") rounded_top_cube(scan_plate_motor_mount_width * 0.5, scan_plate_motor_mount_rod_depth, scan_plate_motor_mount_height * 0.5);
                    }
                    union()
                    {
                        translate([scan_plate_motor_mount_width * 0.25, -epsilon, scan_plate_motor_mount_height * 0.5 + scan_plate_motor_height_offset])
                        {
                            rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_mount_rod_depth + (epsilon * 2), r=scan_plate_motor_tube_sheath_radius + 0.5, $fn=60);
                         
                            translate([0, scan_plate_motor_mount_rod_depth + (epsilon * 2), 0])
                            {
                                //rotate([-90, 0, 0]) cylinder(h=1, r=scan_plate_motor_tube_sheath_radius + 1, $fn=60);
                            }
                        } 
                    }
                }
            }
            */
            
            // Right rod holder
            translate([-scan_plate_motor_mount_width_offset - (scan_plate_motor_mount_width * 0.5 / 2), (base_plate_depth * 0.5) + (card_magazine_depth * 0.5) - scan_plate_motor_mount_rod_depth + 1, 0])
            {
                // Main motor rod holder
                difference()
                {
                    union()
                    {
                        color("pink") rounded_top_cube(scan_plate_motor_mount_width * 0.5, scan_plate_motor_mount_rod_depth, scan_plate_motor_mount_height * 0.5);
                    }
                    union()
                    {
                        translate([scan_plate_motor_mount_width * 0.25, -epsilon, scan_plate_motor_mount_height * 0.5 + scan_plate_motor_height_offset])
                        {
                            rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_mount_rod_depth + (epsilon * 2), r=scan_plate_motor_tube_sheath_radius + 0.2, $fn=60);
                        }
                    }
                }
            }
        }
    }   
}

// Runs to the edge of the scan plate so cards drop straight off the end into the funnel.
exit_insert_length = (base_plate_width * 0.5) + (card_magazine_width * 0.5) - card_magazine_thickness - card_magazine_hole_width;
exit_insert_post_end = exit_insert_length - exit_insert_registration_wall;
exit_channel_half_width = card_magazine_hole_depth * 0.5;
exit_post_y = exit_channel_half_width + (exit_insert_post_width * 0.5);
exit_gate_screw_x = exit_insert_post_offset + (exit_gate_length * 0.5);
exit_insert_screw_x = (exit_insert_post_offset + exit_gate_length + exit_insert_post_end) * 0.5;
exit_post_top = exit_insert_lip_height + exit_insert_post_height;

// Origin is where the exit wall of the magazine hole meets the top of the scan plate, x points out of the magazine.
module exit_frame()
{
    translate([-extrusion_short_depth - (base_plate_width * 0.5) - (card_magazine_width * 0.5) + card_magazine_thickness + card_magazine_hole_width, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width + (base_plate_depth * 0.5), extrusion_short_height + card_magazine_height + base_plate_height])
    {
        children();
    }
}

module exit_insert_pocket()
{
    height = exit_insert_pocket_depth + card_magazine_hole_scan_wall_height_size + epsilon;
    post_pocket_start = exit_insert_post_offset - (exit_insert_tolerance * 2);

    translate([-epsilon, -exit_channel_half_width - exit_insert_tolerance, -exit_insert_pocket_depth])
    {
        cube([exit_insert_length + (epsilon * 2), card_magazine_hole_depth + (exit_insert_tolerance * 2), height]);
    }
    translate([post_pocket_start, -exit_channel_half_width - exit_insert_post_width - exit_insert_tolerance, -exit_insert_pocket_depth])
    {
        cube([exit_insert_post_end - post_pocket_start, card_magazine_hole_depth + ((exit_insert_post_width + exit_insert_tolerance) * 2), height]);
    }
    for (side = [-1, 1])
    {
        translate([exit_insert_screw_x, side * exit_post_y, -exit_insert_pocket_depth - exit_threaded_insert_depth])
        {
            cylinder(r=exit_threaded_insert_radius, h=exit_threaded_insert_depth + epsilon, $fn=30);
        }
    }
}

// Separate part so the ramp can be printed on its side with layer lines running along the card's path.
// Springs under the posts let the screws set the lip height.
module exit_insert()
{
    lead_in_length = exit_insert_lead_in_height / tan(exit_insert_lead_in_angle);
    lip_end = exit_insert_post_offset + exit_gate_length;
    profile = [
        [0, -exit_insert_pocket_depth],
        [0, exit_insert_lip_height - exit_insert_lead_in_height],
        [lead_in_length, exit_insert_lip_height],
        [lip_end, exit_insert_lip_height],
        [exit_insert_length, -exit_insert_pocket_depth + exit_insert_tip_height],
        [exit_insert_length, -exit_insert_pocket_depth]
    ];

    color("orange") difference()
    {
        union()
        {
            rotate([90, 0, 0])
            {
                linear_extrude(card_magazine_hole_depth, center=true)
                {
                    polygon(profile);
                }
            }
            for (side = [-1, 1])
            {
                translate([exit_insert_post_offset, (side * exit_post_y) - (exit_insert_post_width * 0.5), -exit_insert_pocket_depth])
                {
                    cube([exit_insert_post_end - exit_insert_post_offset, exit_insert_post_width, exit_insert_pocket_depth + exit_post_top]);
                }
            }
        }
        for (side = [-1, 1])
        {
            translate([exit_insert_screw_x, side * exit_post_y, -exit_insert_pocket_depth - epsilon])
            {
                cylinder(r=exit_screw_clearance_radius, h=exit_insert_pocket_depth + exit_post_top + (epsilon * 2), $fn=30);
                cylinder(r=exit_spring_radius, h=exit_spring_depth + epsilon, $fn=30);
            }
            translate([exit_gate_screw_x, side * exit_post_y, exit_post_top - exit_spring_depth - exit_threaded_insert_depth])
            {
                cylinder(r=exit_threaded_insert_radius, h=exit_spring_depth + exit_threaded_insert_depth + epsilon, $fn=30);
                translate([0, 0, exit_threaded_insert_depth])
                {
                    cylinder(r=exit_spring_radius, h=exit_spring_depth + epsilon, $fn=30);
                }
            }
        }
    }
}

// Sits on springs above the posts; when screwed fully down the tongue touches the lip, so the screws set the gap only one card can pass.
module exit_gate()
{
    width = card_magazine_hole_depth + (exit_insert_post_width * 2);
    tongue_width = card_magazine_hole_depth - (exit_insert_tolerance * 2);

    color("green") difference()
    {
        union()
        {
            translate([exit_insert_post_offset, -width * 0.5, exit_post_top])
            {
                cube([exit_gate_length, width, exit_gate_thickness]);
            }
            translate([exit_insert_post_offset, -tongue_width * 0.5, exit_insert_lip_height])
            {
                cube([exit_gate_length, tongue_width, exit_insert_post_height + epsilon]);
            }
        }
        for (side = [-1, 1])
        {
            translate([exit_gate_screw_x, side * exit_post_y, exit_post_top - epsilon])
            {
                cylinder(r=exit_screw_clearance_radius, h=exit_gate_thickness + (epsilon * 2), $fn=30);
            }
        }
    }
}

scan_plate_motor_tube_sheath_core_radius = scan_plate_motor_tube_sheath_radius;
scan_plate_motor_tube_sheath_tpu_radius = scan_plate_motor_tube_sheath_radius;

scan_plate_motor_tube_sheath_spoke_count = 10;
                    
// Roller tube that connects to the card dispenser
module motor_tube()
{
    color("grey") translate([-extrusion_short_depth, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width - 78, extrusion_short_height + card_magazine_height + base_plate_height])
    {            
        translate([-scan_plate_motor_mount_width_offset, 20 + (base_plate_depth * 0.5) - (card_magazine_hole_depth * 0.5), scan_plate_motor_mount_height * 0.5 + scan_plate_motor_height_offset])
        {
            // Main motor tube
            difference()
            {
                union()
                {
                    //rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length, r=scan_plate_motor_tube_radius, $fn=100);
                    
                    hull()
                    {
                        rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length, r=scan_plate_motor_tube_sheath_radius * 1.20, $fn=100);                        
                        translate([scan_plate_motor_tube_screw_distance * 0.5, -epsilon, 0]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length + (epsilon * 2), r=scan_plate_motor_tube_screw_hole_radius + 1.5, $fn=60);
                    }
                    hull()
                    {
                        rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length, r=scan_plate_motor_tube_sheath_radius * 1.20, $fn=100);                        
                        translate([-scan_plate_motor_tube_screw_distance * 0.5, -epsilon, 0]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length + (epsilon * 2), r=scan_plate_motor_tube_screw_hole_radius + 1.5, $fn=60);
                    }
                    hull()
                    {
                        rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length, r=scan_plate_motor_tube_sheath_radius * 1.20, $fn=100);                        
                        translate([0, -epsilon, scan_plate_motor_tube_screw_distance * 0.5]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length + (epsilon * 2), r=scan_plate_motor_tube_screw_hole_radius + 1.5, $fn=60);
                    }
                    hull()
                    {
                        rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length, r=scan_plate_motor_tube_sheath_radius * 1.20, $fn=100);                        
                        translate([0, -epsilon, -scan_plate_motor_tube_screw_distance * 0.5]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length + (epsilon * 2), r=scan_plate_motor_tube_screw_hole_radius + 1.5, $fn=60);
                    }                    
                    
                    
                    // Core
                    translate([0, scan_plate_motor_tube_length, 0])
                    {
                        rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=scan_plate_motor_tube_sheath_core_radius, $fn=100);
                                                
                        // Grip points for sleve
                        //translate([0, 0, scan_plate_motor_tube_sheath_core_radius]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                        //translate([0, 0, -scan_plate_motor_tube_sheath_core_radius]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                        //translate([scan_plate_motor_tube_sheath_core_radius, 0, 0]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                        //translate([-scan_plate_motor_tube_sheath_core_radius, 0, 0]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                    }
                    
                    // Taper
                    translate([0, scan_plate_motor_tube_length, 0])
                    {
                        rotate([-90, 0, 0]) cylinder(h=15, r1=scan_plate_motor_tube_sheath_radius * 1.20, r2=scan_plate_motor_tube_sheath_core_radius, $fn=100);
                    }
                    
                }
                union()
                {                
                    translate([0, -epsilon, 0])
                    {
                        rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length + (epsilon * 2) + 150, r=scan_plate_rod_radius + 0.15, $fn=60);
                    }
                    
                    // Holes for screw bolts.
                    translate([scan_plate_motor_tube_screw_distance * 0.5, -epsilon, 0])
                    {
                        rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length + (epsilon * 2), r=scan_plate_motor_tube_screw_hole_radius, $fn=60);
                    }
                    translate([-scan_plate_motor_tube_screw_distance * 0.5, -epsilon, 0])
                    {
                        rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length + (epsilon * 2), r=scan_plate_motor_tube_screw_hole_radius, $fn=60);
                    }
                    translate([0, -epsilon, scan_plate_motor_tube_screw_distance * 0.5])
                    {
                        rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length + (epsilon * 2), r=scan_plate_motor_tube_screw_hole_radius, $fn=60);
                    }
                    translate([0, -epsilon, -scan_plate_motor_tube_screw_distance * 0.5])
                    {
                        rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_length + (epsilon * 2), r=scan_plate_motor_tube_screw_hole_radius, $fn=60);
                    }
                    
                }
            }
        }
    }

    
    if (show_externals)
    {    
        color("blue") translate([-extrusion_short_depth, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width - 78, extrusion_short_height + card_magazine_height + base_plate_height])
        {            
            translate([-scan_plate_motor_mount_width_offset, 20 + (base_plate_depth * 0.5) - (card_magazine_hole_depth * 0.5), scan_plate_motor_mount_height * 0.5 + scan_plate_motor_height_offset])
            {
                translate([0, scan_plate_motor_tube_length, 0])
                {
                    rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=scan_plate_motor_tube_sheath_core_radius + 1, $fn=100);
                                            
                    // Grip points for sleve
                    //translate([0, 0, scan_plate_motor_tube_sheath_core_radius]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                    //translate([0, 0, -scan_plate_motor_tube_sheath_core_radius]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                    //translate([scan_plate_motor_tube_sheath_core_radius, 0, 0]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                    //translate([-scan_plate_motor_tube_sheath_core_radius, 0, 0]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                }
            }
        }
    }
}

// TPU sheath that goes around motor tube.
module motor_tube_tpu_sheath()
{
    color("red") translate([-extrusion_short_depth, -(base_plate_depth/2) + (extrusion_short_depth / 2) + extrusion_short_width - 78, extrusion_short_height + card_magazine_height + base_plate_height])
    {            
        translate([-scan_plate_motor_mount_width_offset, 20 + (base_plate_depth * 0.5) - (card_magazine_hole_depth * 0.5), scan_plate_motor_mount_height * 0.5 + scan_plate_motor_height_offset])
        {
            // Main motor tube
            difference()
            {
                union()
                {
                    translate([0, scan_plate_motor_tube_length + 15, 0])
                    {
                        translate([0, 0, 0])
                        {
                            difference()
                            {
                                //rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length - epsilon, r=scan_plate_motor_tube_sheath_radius, $fn=100);                            
                                //rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=scan_plate_motor_tube_sheath_core_radius, $fn=100);
                                rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length - 15 - epsilon, r=scan_plate_motor_tube_sheath_radius, $fn=100);                            
                                union()
                                {
                                    rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length - 15, r=scan_plate_motor_tube_sheath_core_radius + 0.20, $fn=100);
                                    
                                    translate([0, 0, scan_plate_motor_tube_sheath_core_radius]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                                    translate([0, 0, -scan_plate_motor_tube_sheath_core_radius]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                                    translate([scan_plate_motor_tube_sheath_core_radius, 0, 0]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                                    translate([-scan_plate_motor_tube_sheath_core_radius, 0, 0]) rotate([-90, 0, 0]) cylinder(h=scan_plate_motor_tube_sheath_length, r=0.5, $fn=100);
                                }
                            }
                        }
                    }
                }
            }
        }
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
    camera_mount_width = base_plate_width * 0.45;
    camera_mount_depth = extrusion_short_width;
    camera_mount_arm_width = 25;
    camera_mount_arm_depth = base_plate_depth * 0.78;
    camera_mount_gantry_mount_width = 8;
    camera_mount_gantry_mount_height = base_plate_height * 2.5;
    color("pink") translate([-extrusion_short_depth - camera_mount_width - extrusion_short_width, 0, extrusion_short_height + card_magazine_height + 70])
    {
        difference()
        {
            union()
            {
                cube([camera_mount_width, camera_mount_depth, base_plate_height]);  
                translate([camera_mount_width - camera_mount_gantry_mount_width, 0, 0])     
                {
                    difference()
                    {
                        cube([camera_mount_gantry_mount_width, camera_mount_depth, camera_mount_gantry_mount_height]);       
                        union()
                        {
                            translate([-epsilon, camera_mount_depth*0.5, (base_plate_height + camera_mount_gantry_mount_height) * 0.5])
                            {
                                rotate([0, 90, 0]) extrusion_bolt_slot(20, [1, 0, 0]);
                            }
                        }
                    }
                }
                cube([camera_mount_arm_width, camera_mount_arm_depth, base_plate_height]);      
                                                                    
                hole_radius = IMX179_hole_radius * 1.5;
                hole_offset = -8;
                               
                translate([camera_mount_arm_width * 0.5, extrusion_short_width + (base_plate_depth * 0.5) - 5, -4.8])
                {         
                    translate([8 + hole_offset, (camera_mount_depth * 0.5) + 22 , 12]) 
                    {
                        cylinder(r=hole_radius, h=6, $fn=100);
                    }
                    translate([8 + hole_offset - 4, (camera_mount_depth * 0.5) + 22 - 50.5, 12]) 
                    {
                        cylinder(r=hole_radius, h=6, $fn=100);
                    }
                }   
            }
            union()
            {
                translate([camera_mount_arm_width * 0.5, extrusion_short_width + (base_plate_depth * 0.5), -4.8])
                {
                    hull()
                    {
                        translate([0, -7, 0]) cylinder(h=15, r1=18, r2=9);
                        translate([0, 7, 0]) cylinder(h=15, r1=18, r2=9);
                    }
                }    
                
                hole_radius = IMX179_hole_radius;
                hole_offset = -8;
                               
                translate([camera_mount_arm_width * 0.5, extrusion_short_width + (base_plate_depth * 0.5) - 5, -4.8])
                {         
                    translate([8 + hole_offset, (camera_mount_depth * 0.5) + 22 , 0]) 
                    {
                        cylinder(r=hole_radius, h=20, $fn=100);
                    }
                    translate([8 + hole_offset - 4, (camera_mount_depth * 0.5) + 22 - 50.5, 0]) 
                    {
                        cylinder(r=hole_radius, h=20, $fn=100);
                    }
                }   
            }
        }
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
                    translate([0, extrusion_clamp_corner_radius, extrusion_clamp_corner_radius])                                                                                              rotate([0, 90, 0]) cylinder(r=extrusion_clamp_corner_radius, h=extrusion_clamp_width, $fn=30);
                    translate([0, bearing_rod_clamp_plate_height - extrusion_clamp_corner_radius, extrusion_clamp_corner_radius])                                                                     rotate([0, 90, 0]) cylinder(r=extrusion_clamp_corner_radius, h=extrusion_clamp_width, $fn=30);
                    translate([0, extrusion_clamp_corner_radius, bearing_rod_clamp_plate_depth + extrusion_clamp_height_padding - extrusion_clamp_corner_radius])                             rotate([0, 90, 0]) cylinder(r=extrusion_clamp_corner_radius, h=extrusion_clamp_width, $fn=30);
                    translate([0, bearing_rod_clamp_plate_height - extrusion_clamp_corner_radius, bearing_rod_clamp_plate_depth + extrusion_clamp_height_padding - extrusion_clamp_corner_radius])  rotate([0, 90, 0]) cylinder(r=extrusion_clamp_corner_radius, h=extrusion_clamp_width, $fn=30);
                }
                
            }
            union()
            {
                // Clamp connectors
                translate([-epsilon, bearing_rod_clamp_plate_height * 0.5, (bearing_rod_clamp_plate_depth * 0.5) - bearing_rod_clamp_rod_to_screw_offset])
                {
                    rotate([0, 90, 0]) cylinder(h=extrusion_clamp_width + (epsilon * 2), r=bearing_rod_clamp_screw_radius, $fn=32);
                }
                translate([-epsilon, bearing_rod_clamp_plate_height * 0.5, (bearing_rod_clamp_plate_depth * 0.5) + bearing_rod_clamp_rod_to_screw_offset])
                {
                    rotate([0, 90, 0]) cylinder(h=extrusion_clamp_width + (epsilon * 2), r=bearing_rod_clamp_screw_radius, $fn=32);
                }                
            }
        }
    }
}

// Clamp between extrusion and lead screw.
// Origin should be center of rod.
module extrusion_bearing_mount()
{    
    translate([-extrusion_bearing_width - bearing_rod_bearing_bearing_to_base_offset, -extrusion_bearing_height * 0.5, -(bearing_rod_clamp_plate_depth * 0.5)])
    {
        difference()
        {
            translate([0, 0, -extrusion_bearing_height_padding * 0.5])
            {
                hull()
                {
                    translate([0, extrusion_bearing_corner_radius, extrusion_bearing_corner_radius])                                                                                                rotate([0, 90, 0]) cylinder(r=extrusion_bearing_corner_radius, h=extrusion_bearing_width, $fn=30);
                    translate([0, extrusion_bearing_height - extrusion_bearing_corner_radius, extrusion_bearing_corner_radius])                                                                     rotate([0, 90, 0]) cylinder(r=extrusion_bearing_corner_radius, h=extrusion_bearing_width, $fn=30);
                    translate([0, extrusion_bearing_corner_radius, bearing_rod_clamp_plate_depth + extrusion_bearing_height_padding - extrusion_bearing_corner_radius])                             rotate([0, 90, 0]) cylinder(r=extrusion_bearing_corner_radius, h=extrusion_bearing_width, $fn=30);
                    translate([0, extrusion_bearing_height - extrusion_bearing_corner_radius, bearing_rod_clamp_plate_depth + extrusion_bearing_height_padding - extrusion_bearing_corner_radius])  rotate([0, 90, 0]) cylinder(r=extrusion_bearing_corner_radius, h=extrusion_bearing_width, $fn=30);
                }
            }
            union()
            {
                // Bearing connectors
                translate([-epsilon, (extrusion_bearing_height * 0.5) - card_magazine_lifter_rod_plate_hole_offset_height, (bearing_rod_clamp_plate_depth * 0.5) - card_magazine_lifter_rod_plate_hole_offset_depth])
                {
                    rotate([0, 90, 0]) cylinder(h=extrusion_bearing_width + (epsilon * 2), r=card_magazine_lifter_rod_plate_hole_radius, $fn=32);
                    translate([0, 0, 0])
                    {
                        rotate([0, 90, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2, $fn=32);
                    }
                }
                translate([-epsilon, (extrusion_bearing_height * 0.5) + card_magazine_lifter_rod_plate_hole_offset_height, (bearing_rod_clamp_plate_depth * 0.5) - card_magazine_lifter_rod_plate_hole_offset_depth])
                {
                    rotate([0, 90, 0]) cylinder(h=extrusion_bearing_width + (epsilon * 2), r=card_magazine_lifter_rod_plate_hole_radius, $fn=32);
                    translate([0, 0, 0])
                    {
                        rotate([0, 90, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2, $fn=32);
                    }
                }
                translate([-epsilon, (extrusion_bearing_height * 0.5) - card_magazine_lifter_rod_plate_hole_offset_height, (bearing_rod_clamp_plate_depth * 0.5) + card_magazine_lifter_rod_plate_hole_offset_depth])
                {
                    rotate([0, 90, 0]) cylinder(h=extrusion_bearing_width + (epsilon * 2), r=card_magazine_lifter_rod_plate_hole_radius, $fn=32);
                    translate([0, 0, 0])
                    {
                        rotate([0, 90, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2, $fn=32);
                    }
                }
                translate([-epsilon, (extrusion_bearing_height * 0.5) + card_magazine_lifter_rod_plate_hole_offset_height, (bearing_rod_clamp_plate_depth * 0.5) + card_magazine_lifter_rod_plate_hole_offset_depth])
                {
                    rotate([0, 90, 0]) cylinder(h=extrusion_bearing_width + (epsilon * 2), r=card_magazine_lifter_rod_plate_hole_radius, $fn=32);
                    translate([0, 0, 0])
                    {
                        rotate([0, 90, 0]) cylinder(h=5, r=card_magazine_lifter_rod_plate_hole_radius * 2, $fn=32);
                    }
                }
                
                // Extrusion connectors
                translate([-epsilon, extrusion_bearing_height * 0.5, (bearing_rod_clamp_plate_depth * 0.5)])
                {
                    translate([0, 0, -27])
                    {
                        rotate([0, 90, 0]) cylinder(h=extrusion_bearing_width + (epsilon * 2), r=bearing_rod_clamp_screw_radius, $fn=32);
                        translate([extrusion_bearing_width - 5, 0, 0])
                        {
                            rotate([0, 90, 0]) cylinder(h=5 + epsilon * 2, r=bearing_rod_clamp_screw_radius * 1.5, $fn=32);
                        }
                    }
                    translate([0, 0, 27])
                    {
                        rotate([0, 90, 0]) cylinder(h=extrusion_bearing_width + (epsilon * 2), r=bearing_rod_clamp_screw_radius, $fn=32);
                        translate([extrusion_bearing_width - 5, 0, 0])
                        {
                            rotate([0, 90, 0]) cylinder(h=5 + epsilon * 2, r=bearing_rod_clamp_screw_radius * 1.5, $fn=32);
                        }
                    }
                }
            }
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
                            rotate([0, 90, 0]) cylinder(h=limit_switch_mount_hole_length + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                            translate([0, -(arm_depth - (limit_switch_mount_hole_inset * 2)), 0])
                            {
                                rotate([0, 90, 0]) cylinder(h=limit_switch_mount_hole_length + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                            }
                        }
                    }
                    translate([-epsilon - arm_length_offset, arm_depth - limit_switch_mount_hole_inset, (limit_switch_mount_arm_height * 0.5) - limit_switch_mount_hole_distance])
                    {
                        hull()
                        {
                            rotate([0, 90, 0]) cylinder(h=limit_switch_mount_hole_length + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                            translate([0, -(arm_depth - (limit_switch_mount_hole_inset * 2)), 0])
                            {
                                rotate([0, 90, 0]) cylinder(h=limit_switch_mount_hole_length + (epsilon * 2), r=limit_switch_mount_hole_radius, $fn=32);
                            }
                        }
                    }
                }
            }
        }
    }
}

// The plate that the card mover runs across.
module card_mover_plate()
{    
    bar_mid_height = (card_mover_top_bar_height + card_mover_bottom_bar_height) * 0.5;
    bottom_bar_offset = card_mover_bottom_bar_height - bar_mid_height;
    top_bar_offset = card_mover_top_bar_height - bar_mid_height;
    
    if (show_card_mover_plate)
    {
        translate([-(extrusion_short_depth) + card_mover_bar_offset, (extrusion_short_width * 0.5), card_mover_top_bar_height])
        {
        #    extrusion_clamp_mount();
        }
        translate([-(extrusion_short_depth) + card_mover_bar_offset, (extrusion_short_width * 0.5), card_mover_bottom_bar_height])
        {
        #    extrusion_clamp_mount();
        }
        translate([-(extrusion_short_depth) + card_mover_bar_offset, -(extrusion_short_width * 0.5) + card_mover_plate_length, card_mover_top_bar_height])
        {
        #    extrusion_clamp_mount();
        }
        translate([-(extrusion_short_depth) + card_mover_bar_offset, -(extrusion_short_width * 0.5) + card_mover_plate_length, card_mover_bottom_bar_height])
        {
        #    extrusion_clamp_mount();
        }
    }
    
    if (show_card_mover_plate_motor)
    {        
        translate([0, -extrusion_motor_mount_height, 0])
        difference()
        {
            union()
            {            
                translate([-(extrusion_short_depth) - (extrusion_short_height * 0.5) - (extrusion_motor_mount_width * 0.5), 0, ((card_mover_bottom_bar_height + card_mover_top_bar_height) * 0.5) - (extrusion_motor_mount_depth * 0.5)])
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
                            
                            /*hull()
                            {
                              #  translate([extrusion_motor_mount_corner_radius, 0, extrusion_motor_mount_corner_radius])                                                                           rotate([90, 0, 0]) cylinder(h=extrusion_motor_mount_height, r=extrusion_motor_mount_corner_radius, $fn=60);
                              #  translate([extrusion_motor_mount_corner_radius + extrusion_motor_mount_width - (extrusion_motor_mount_corner_radius * 2), 0, extrusion_motor_mount_corner_radius]) rotate([90, 0, 0]) cylinder(h=extrusion_motor_mount_height, r=extrusion_motor_mount_corner_radius, $fn=60);        
                              #  translate([extrusion_motor_mount_corner_radius, 0, extrusion_motor_mount_corner_radius + extrusion_motor_mount_depth - (extrusion_motor_mount_corner_radius * 2)])                                                                           rotate([90, 0, 0]) cylinder(h=extrusion_motor_mount_height, r=extrusion_motor_mount_corner_radius, $fn=60);
                              #  translate([extrusion_motor_mount_corner_radius + extrusion_motor_mount_width - (extrusion_motor_mount_corner_radius * 2), 0, extrusion_motor_mount_corner_radius + extrusion_motor_mount_depth - (extrusion_motor_mount_corner_radius * 2)]) rotate([90, 0, 0]) cylinder(h=extrusion_motor_mount_height, r=extrusion_motor_mount_corner_radius, $fn=60);
                            }*/
                            
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
                                translate([extrusion_motor_mount_width * 0.5, 0, extrusion_motor_mount_depth * 0.50]) rotate([90, 0, 0]) cylinder(h=40, r=card_magazine_lifter_rod_plate_hole_radius + 3, $fn=60);
                                translate([extrusion_motor_mount_width * 0.5, 15, extrusion_motor_mount_depth * 0.90]) rotate([90, 0, 0]) extrusion_bolt_slot(extrusion_motor_mount_height + 10 + epsilon, [0, 1, 0]);
                            }
                            
                            // Holes to connect rod clamps                            
                            translate([extrusion_motor_mount_width, extrusion_motor_mount_height + (extrusion_short_height * 0.5), (extrusion_motor_mount_depth*0.5) + bottom_bar_offset])
                            {                            
                                // Clamp connectors
                                translate([-epsilon, 0, -bearing_rod_clamp_rod_to_screw_offset])
                                {
                                    rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=32);
                                }
                                translate([-epsilon, 0, +bearing_rod_clamp_rod_to_screw_offset])
                                {
                                    rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=32);
                                }
                            }                        
                            translate([extrusion_motor_mount_width, extrusion_motor_mount_height + (extrusion_short_height * 0.5), (extrusion_motor_mount_depth*0.5) + top_bar_offset])
                            {                            
                                // Clamp connectors
                                translate([-epsilon, 0, -bearing_rod_clamp_rod_to_screw_offset])
                                {
                                    rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=32);
                                }
                                translate([-epsilon, 0, +bearing_rod_clamp_rod_to_screw_offset])
                                {
                                    rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=32);
                                }
                            }   
                        }
                    }                    
                }
            }
            union()
            {
                translate([-(extrusion_short_depth) - (extrusion_short_height * 0.5) - (extrusion_motor_mount_width * 0.5), 0, ((card_mover_bottom_bar_height + card_mover_top_bar_height) * 0.5) - (extrusion_motor_mount_depth * 0.5)])
                {
                    translate([0, -extrusion_motor_mount_thickness, (extrusion_motor_mount_depth - extrusion_motor_mount_arm_height) * 0.5])
                    {
                        translate([extrusion_motor_mount_offset - extrusion_motor_mount_thickness, -extrusion_motor_mount_plate_depth + extrusion_motor_mount_height, 0])
                        {
                            translate([extrusion_motor_mount_thickness + epsilon, extrusion_motor_mount_plate_depth * 0.5, extrusion_motor_mount_arm_height * 0.5])
                            {
                                // Big hole for spigot.                                
                                translate([0, 0, 0]) rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=extrusion_motor_mount_spigot_radius, $fn=60);
                            
                                // Holes to mount motor.
                                translate([0, stepping_motor_screw_hole_offset, stepping_motor_screw_hole_offset]) rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=stepping_motor_screw_hole_radius, $fn=60);
                                translate([0, -stepping_motor_screw_hole_offset, stepping_motor_screw_hole_offset]) rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=stepping_motor_screw_hole_radius, $fn=60);
                                translate([0, stepping_motor_screw_hole_offset, -stepping_motor_screw_hole_offset]) rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=stepping_motor_screw_hole_radius, $fn=60);
                                translate([0, -stepping_motor_screw_hole_offset, -stepping_motor_screw_hole_offset]) rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=stepping_motor_screw_hole_radius, $fn=60);
                            }
                        }
                    }
                }
            }
        }
    }
    
    if (show_card_mover_plate_spindle)
    {
        difference()
        {
            union()
            {            
            //
                translate([-(extrusion_short_depth) - (extrusion_short_height * 0.5) - (extrusion_motor_mount_width * 0.5), extrusion_long_depth + extrusion_motor_mount_height, ((card_mover_bottom_bar_height + card_mover_top_bar_height) * 0.5) - (extrusion_motor_mount_depth * 0.5)])
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
                            
                            /*hull()
                            {
                                translate([extrusion_motor_mount_corner_radius, 0, extrusion_motor_mount_corner_radius])                                                                           rotate([90, 0, 0]) cylinder(h=extrusion_motor_mount_height, r=extrusion_motor_mount_corner_radius, $fn=60);
                                translate([extrusion_motor_mount_corner_radius + extrusion_motor_mount_width - (extrusion_motor_mount_corner_radius * 2), 0, extrusion_motor_mount_corner_radius]) rotate([90, 0, 0]) cylinder(h=extrusion_motor_mount_height, r=extrusion_motor_mount_corner_radius, $fn=60);        
                                translate([extrusion_motor_mount_corner_radius, 0, extrusion_motor_mount_corner_radius + extrusion_motor_mount_depth - (extrusion_motor_mount_corner_radius * 2)])                                                                           rotate([90, 0, 0]) cylinder(h=extrusion_motor_mount_height, r=extrusion_motor_mount_corner_radius, $fn=60);
                                translate([extrusion_motor_mount_corner_radius + extrusion_motor_mount_width - (extrusion_motor_mount_corner_radius * 2), 0, extrusion_motor_mount_corner_radius + extrusion_motor_mount_depth - (extrusion_motor_mount_corner_radius * 2)]) rotate([90, 0, 0]) cylinder(h=extrusion_motor_mount_height, r=extrusion_motor_mount_corner_radius, $fn=60);
                            }*/
                            
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
                                translate([extrusion_motor_mount_width * 0.5, 10, extrusion_motor_mount_depth * 0.50]) rotate([90, 0, 0]) cylinder(h=extrusion_motor_mount_height + epsilon + 10, r=card_magazine_lifter_rod_plate_hole_radius + 3, $fn=60);
                                translate([extrusion_motor_mount_width * 0.5, 0, extrusion_motor_mount_depth * 0.90]) rotate([90, 0, 0]) extrusion_bolt_slot(extrusion_motor_mount_height + epsilon + 10, [0, 1, 0]);
                            }
                            
                            // Holes to connect rod clamps
                            translate([extrusion_motor_mount_width, -extrusion_motor_mount_height - (extrusion_short_height * 0.5), (extrusion_motor_mount_depth*0.5) + bottom_bar_offset])
                            {                     
                                // Clamp connectors
                                translate([-epsilon, 0, -bearing_rod_clamp_rod_to_screw_offset])
                                {
                                    rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=32);
                                }
                                translate([-epsilon, 0, +bearing_rod_clamp_rod_to_screw_offset])
                                {
                                    rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=32);
                                }
                            }                        
                            translate([extrusion_motor_mount_width, -extrusion_motor_mount_height - (extrusion_short_height * 0.5), (extrusion_motor_mount_depth*0.5) + top_bar_offset])
                            {                            
                                // Clamp connectors
                                translate([-epsilon, 0, -bearing_rod_clamp_rod_to_screw_offset])
                                {
                                    rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=32);
                                }
                                translate([-epsilon, 0, +bearing_rod_clamp_rod_to_screw_offset])
                                {
                                    rotate([0, 90, 0]) cylinder(h=20, r=bearing_rod_clamp_screw_radius, $fn=32);
                                }
                            } 
                        }
                    }                    
                }
            }
            union()
            {
                translate([-(extrusion_short_depth) - (extrusion_short_height * 0.5) - (extrusion_motor_mount_width * 0.5), extrusion_long_depth + extrusion_motor_mount_height, ((card_mover_bottom_bar_height + card_mover_top_bar_height) * 0.5) - (extrusion_motor_mount_depth * 0.5)])
                {
                    translate([0, -extrusion_motor_mount_height, (extrusion_motor_mount_depth - extrusion_motor_mount_arm_height) * 0.5])
                    { 
                        translate([extrusion_motor_mount_offset - extrusion_motor_mount_thickness, extrusion_motor_mount_thickness, 0])
                        {
                            translate([extrusion_motor_mount_thickness + epsilon, extrusion_spindle_mount_plate_depth * 0.5, extrusion_motor_mount_arm_height * 0.5])
                            {                      
                                translate([0, 0, 0]) rotate([0, -90, 0]) cylinder(h=extrusion_motor_mount_thickness + (epsilon * 2), r=extrusion_spindle_mount_hole_radius, $fn=60);
                                translate([-extrusion_motor_mount_thickness + 3 - epsilon * 2, 0, 0]) rotate([0, -90, 0]) cylinder(h=3, r=9 * 0.5, $fn=6);
                            }
                        }
                    }
                }
            }
        }
    }
    
    if (show_externals)
    {
        translate([-(extrusion_short_depth) + card_mover_bar_offset, 0, card_mover_top_bar_height])
        {
            rotate([-90, 0, 0])
            {
                color("blue") cylinder(r=card_mover_bearing_rod_radius, h=card_mover_bearing_rod_height, $fn=30);
            }   
        }
        translate([-(extrusion_short_depth) + card_mover_bar_offset, 0, card_mover_bottom_bar_height])
        {
            rotate([-90, 0, 0])
            {
                color("blue") cylinder(r=card_mover_bearing_rod_radius, h=card_mover_bearing_rod_height, $fn=30);
            }   
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
                rotate([0, 90, 0]) cylinder(h=belt_block_cut_depth, r=5.5, $fn=60);
            }
            translate([-epsilon, 0, (belt_block_height * 0.5)+3.8])
            {
                rotate([0, 90, 0]) cylinder(h=belt_block_cut_depth, r=1.5, $fn=60);
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
                rotate([0, 90, 0]) cylinder(h=belt_block_cut_depth, r=6.5 * 0.5, $fn=60);
            }
            translate([-epsilon, 2, (belt_block_height * 0.5) + 3])
            {
                rotate([0, 90, 0]) cylinder(h=belt_block_cut_depth, r=2.5 * 0.5, $fn=60);
            }
        }
    }
}        

// The module that moves across the plate to deliver a card to a specific bin.
module card_mover()
{
    bar_mid_height = (card_mover_top_bar_height + card_mover_bottom_bar_height) * 0.5;
    bottom_bar_offset = card_mover_bottom_bar_height - bar_mid_height;
    top_bar_offset = card_mover_top_bar_height - bar_mid_height;
   
    if (show_card_mover)
    {
        translate([-(extrusion_short_depth) + card_mover_bar_offset - (card_mover_bearing_rod_radius * 0.5), 120, bar_mid_height])
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
                        translate([0, 0, 0])
                        {         
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
                    translate([(card_mover_bearing_rod_radius * 0.5) + bearing_rod_bearing_bearing_to_base_offset, -(card_mover_bearing_mount_height * 0.5), top_bar_offset - (card_mover_bearing_mount_depth * 0.5)])
                    {
                        translate([card_mover_bearing_mount_hole_length - epsilon, card_mover_bearing_mount_height * 0.5, card_mover_bearing_mount_depth * 0.5])
                        {
                            translate([0, card_magazine_lifter_rod_plate_hole_offset_height, card_magazine_lifter_rod_plate_hole_offset_depth])
                            {
                                rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                            }
                            translate([0, card_magazine_lifter_rod_plate_hole_offset_height, -card_magazine_lifter_rod_plate_hole_offset_depth])
                            {
                                rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                            }
                            translate([0, -card_magazine_lifter_rod_plate_hole_offset_height, card_magazine_lifter_rod_plate_hole_offset_depth])
                            {
                                rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                            }
                            translate([0, -card_magazine_lifter_rod_plate_hole_offset_height, -card_magazine_lifter_rod_plate_hole_offset_depth])
                            {
                                rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                            }
                        }
                    }
                    
                    // Bottom bolt holes
                    translate([(card_mover_bearing_rod_radius * 0.5) + bearing_rod_bearing_bearing_to_base_offset, -(card_mover_bearing_mount_height * 0.5), bottom_bar_offset - (card_mover_bearing_mount_depth * 0.5)])
                    {
                        translate([card_mover_bearing_mount_hole_length - epsilon, card_mover_bearing_mount_height * 0.5, card_mover_bearing_mount_depth * 0.5])
                        {
                            translate([0, card_magazine_lifter_rod_plate_hole_offset_height, card_magazine_lifter_rod_plate_hole_offset_depth])
                            {
                                rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                            }
                            translate([0, card_magazine_lifter_rod_plate_hole_offset_height, -card_magazine_lifter_rod_plate_hole_offset_depth])
                            {
                                rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                            }
                            translate([0, -card_magazine_lifter_rod_plate_hole_offset_height, card_magazine_lifter_rod_plate_hole_offset_depth])
                            {
                                rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                            }
                            translate([0, -card_magazine_lifter_rod_plate_hole_offset_height, -card_magazine_lifter_rod_plate_hole_offset_depth])
                            {
                                rotate([0, -90, 0]) cylinder(h=card_mover_bearing_mount_hole_length, r=card_magazine_lifter_rod_plate_hole_radius, $fn=30);
                            }
                        }
                    }
                }
            }            
        }    
    }
    
    // Slide
    if (show_card_mover_slide)
    {
        translate([-(extrusion_short_depth), 120, extrusion_short_height + card_magazine_height + base_plate_height])
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
                translate([0, 0, -15])
                {
                //    #color("red") cube([sg90_width, sg90_depth, 15]);
                }
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
                cylinder(h=sg90_height + (epsilon * 2), r=sg90_hole_radius, $fn=90);
            }
            translate([(sg90_width * 0.5) + (sg90_hole_distance * 0.5), sg90_depth * 0.5, -epsilon])
            {
                cylinder(h=sg90_height + (epsilon * 2), r=sg90_hole_radius, $fn=90);
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
                    rotate([90, 0, 0]) cylinder(r=card_mover_slide_height, h=last_step_actual_depth, $fn=32, center=true);
                }            
                translate([step_width + forward_offset, -step_x_offset, step_height])
                {
                    rotate([90, 0, 0]) cylinder(r=card_mover_slide_height, h=step_actual_depth, $fn=32, center=true);
                }
            }            
        }
    }
}

module brain_plate_psu(holes)
{
    if (!holes)
    {
        if (show_externals)
        {
            translate([0, 0, brain_box_standoff_height])
            {
                color("gray") cube([psu_width, psu_depth, psu_height]);
            }
        }
    }
    
    radius = holes ? brain_box_standoff_inner_radius : brain_box_standoff_outer_radius;
    height_offset = holes ? epsilon - 35 : 0;
    height = holes ? brain_box_standoff_height + 40 : brain_box_standoff_height;
    
    // standoffs
    translate([psu_width - 32, psu_depth - 6, height_offset])
    {
        cylinder(h=height, r=radius, $fn=60);
    }
    translate([psu_width - 32, psu_depth - 6 - 25, height_offset])
    {
        cylinder(h=height, r=radius, $fn=60);
    }
    translate([psu_width - 183.5, psu_depth - 6, height_offset])
    {
        cylinder(h=height, r=radius, $fn=60);
    }
    translate([psu_width - 183.5, psu_depth - 6 - 25, height_offset])
    {
        cylinder(h=height, r=radius, $fn=60);
    }
}

module brain_plate_control_board(holes)
{
    if (!holes)
    {
        if (show_externals)
        {
            translate([0, 0, brain_box_standoff_height])
            {
                color("gray") cube([control_board_width, control_board_depth, control_board_height]);
            }
        }
    }
    
    radius = holes ? brain_box_standoff_inner_radius : brain_box_standoff_outer_radius;
    height_offset = holes ? epsilon - 35 : 0;
    height = holes ? brain_box_standoff_height + 40 : brain_box_standoff_height;
    
    // standoffs
    translate([-5, -5, 0])
    {
        translate([control_board_width, control_board_depth, height_offset])
        {
            cylinder(h=height, r=radius, $fn=60);
        }
        translate([control_board_width - 5, control_board_depth - 84.2, height_offset])
        {
            cylinder(h=height, r=radius, $fn=60);
        }
        translate([control_board_width - 5 - 146, control_board_depth - 84.2, height_offset])
        {
            cylinder(h=height, r=radius, $fn=60);
        }
        translate([control_board_width - 97, control_board_depth, height_offset])
        {
            cylinder(h=height, r=radius, $fn=60);
        }
    }
}

module brain_board_camera_mount(holes)
{
    translate([-20, 0, 0])
    {
        rotate([0, 55, 0])
        {
            translate([0, -(camera_mount_depth*0.5), 0])
            {
                if (!holes)
                {
                    cube([camera_mount_width, camera_mount_depth, camera_mount_height]);
                }
                else
                {
                    translate([camera_mount_width, 0, 0])
                    {
                        hull()
                        {
                            cube([1, camera_mount_depth, camera_mount_height]);
                            translate([50, 0, 0])
                            {
                                cube([1, camera_mount_depth, camera_mount_height]);
                            }
                            translate([10, 0, -90])
                            {
                                cube([1, camera_mount_depth, camera_mount_height]);
                            }
                        }
                    }
                    
                    hull()
                    {
                        translate([121, (camera_mount_depth * 0.5) - 10, 19 - 4]) 
                        {
                            rotate([0, -90, 0]) cylinder(r1=60, r2=10, h=122, $fn=100);
                        }
                        translate([121, (camera_mount_depth * 0.5) + 10, 19 - 4]) 
                        {
                            rotate([0, -90, 0]) cylinder(r1=60, r2=10, h=122, $fn=100);
                        }
                    }
                }
                
                hole_radius = holes ? IMX179_hole_radius : IMX179_hole_radius * 1.5;
                hole_offset = holes ? 4 : 0;
                                        
                translate([8 + hole_offset, (camera_mount_depth * 0.5) + 25 , 19]) 
                {
                    rotate([0, -90, 0]) cylinder(r=hole_radius, h=12 + (hole_offset * 2), $fn=100);
                }
                translate([8 + hole_offset, (camera_mount_depth * 0.5) + 25 - 50.5, 19 - 4]) 
                {
                    rotate([0, -90, 0]) cylinder(r=hole_radius, h=12 + (hole_offset * 2), $fn=100);
                } 
                
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

module brain_plate_lid()
{
    translate([-extrusion_short_depth - brain_plate_width, 0, extrusion_long_depth + (extrusion_long_width * 2)])
    {
        lid_width = brain_plate_width + ((brain_box_lid_wall_thickness + brain_box_lid_threshold) * 2);
        lid_depth = brain_plate_depth + ((brain_box_lid_wall_thickness + brain_box_lid_threshold) * 2);
        lid_inner_width = brain_plate_width + ((brain_box_lid_threshold) * 2);
        lid_inner_depth = brain_plate_depth + ((brain_box_lid_threshold) * 2);
        lid_height = brain_box_wall_thickness * 3;
        
        difference()
        {    
            translate([-(brain_box_lid_wall_thickness + brain_box_lid_threshold), -(brain_box_lid_wall_thickness + brain_box_lid_threshold), brain_box_height - (lid_height - brain_box_wall_thickness)])
            {
                difference()
                {
                    cube([lid_width, lid_depth, lid_height]);
                    translate([brain_box_lid_wall_thickness, brain_box_lid_wall_thickness, -brain_box_wall_thickness])
                    {
                        cube([lid_inner_width, lid_inner_depth, lid_height]);
                    }
                }
            }
            union()
            {      
                peg_size = brain_box_wall_thickness + brain_box_lid_threshold;
                peg_threshold = brain_box_lid_threshold * 0.5;
 
                translate([-peg_threshold, -peg_threshold, brain_box_height])
                {
                    cube([peg_size, peg_size, brain_box_lid_height]);
                }
                translate([brain_plate_width - brain_box_wall_thickness - peg_threshold, -peg_threshold, brain_box_height])
                {
                    cube([peg_size, peg_size, brain_box_lid_height]);
                }              
                translate([-peg_threshold, brain_plate_depth - brain_box_wall_thickness - peg_threshold, brain_box_height])
                {
                    cube([peg_size, peg_size, brain_box_lid_height]);
                }
                translate([brain_plate_width - brain_box_wall_thickness - peg_threshold, brain_plate_depth - brain_box_wall_thickness - peg_threshold, brain_box_height])
                {
                    cube([peg_size, peg_size, brain_box_lid_height]);
                }
                
            }
        }
    }
}

module brain_plate()
{
    translate([-extrusion_short_depth - brain_plate_width, 0, extrusion_long_depth + (extrusion_long_width * 2)])
    {
        difference()
        {    
            union()
            {                        
                if (show_brain_plate)
                {
                    color("orange") 
                    {
                        // Box to contain everything
                        difference()
                        {
                            cube([brain_plate_width, brain_plate_depth, brain_box_height]);
                            //cube([brain_plate_width, brain_plate_depth, brain_plate_height]);
                            translate([brain_box_wall_thickness, brain_box_wall_thickness, brain_plate_height]) 
                            {
                                cube([brain_plate_width - (brain_box_wall_thickness * 2), brain_plate_depth - (brain_box_wall_thickness * 2), brain_box_height]);
                            }
                        }
                        
                        // Indexing pegs for lid.                        
                        translate([0, 0, brain_box_height])
                        {
                            cube([brain_box_wall_thickness, brain_box_wall_thickness, brain_box_lid_height]);
                        }
                        translate([brain_plate_width - brain_box_wall_thickness, 0, brain_box_height])
                        {
                            cube([brain_box_wall_thickness, brain_box_wall_thickness, brain_box_lid_height]);
                        }              
                        translate([0, brain_plate_depth - brain_box_wall_thickness, brain_box_height])
                        {
                            cube([brain_box_wall_thickness, brain_box_wall_thickness, brain_box_lid_height]);
                        }
                        translate([brain_plate_width - brain_box_wall_thickness, brain_plate_depth - brain_box_wall_thickness, brain_box_height])
                        {
                            cube([brain_box_wall_thickness, brain_box_wall_thickness, brain_box_lid_height]);
                        }
                        
                        // Base supports / for connecting to gantry
                        translate([brain_plate_width - (extrusion_short_width * 2), 0, -extrusion_short_width])
                        {
                        //    cube([extrusion_short_width, brain_plate_depth, extrusion_short_width]);
                        }
                        translate([brain_plate_width - extrusion_short_width - (extrusion_short_depth * 0.75), (brain_plate_depth*0.5) - (extrusion_short_width * 0.5), -extrusion_short_width])
                        {
                        //    cube([extrusion_short_depth * 0.75, extrusion_short_width, extrusion_short_width]);
                        }
                    }
                    
                    translate([brain_box_wall_thickness + brain_box_wall_threshold, brain_box_wall_thickness + brain_box_wall_threshold, brain_plate_height])
                    {
                        // psu
                        translate([brain_box_inner_width - psu_width - 5, brain_box_inner_depth - psu_depth - 10, 0])
                        {
                            brain_plate_psu(false);
                        }
                            
                        // control board
                        translate([brain_box_inner_width - control_board_width - 10, brain_box_inner_depth - psu_depth - control_board_depth - 15, 0])
                        {
                            brain_plate_control_board(false);
                        }
                        
                        // Camera mount.
                        translate([30, brain_box_inner_depth * 0.5, 0])
                        {
                            brain_board_camera_mount(false);
                        }
                    }
                }
            }
            union()
            {
                // Logo text
                translate([brain_plate_width-0.9, brain_plate_depth*0.5, (brain_box_height * 0.5) + 20])
                {
                    rotate([90, 0, 90])
                    {
                        linear_extrude(1) text("CARD SORTER", 23, font="Droid Sans:Bold", halign="center", valign="center");
                        translate([0, -40, 0])
                        {
                            linear_extrude(1) text("5000", 30, font="Droid Sans:Bold", halign="center", valign="center");
                        }
                    }
                }
                
                // Warning text
                translate([0.9, (brain_plate_depth*0.5) + 25, (brain_box_height * 0.5) + 15])
                {
                    rotate([90, 0, -90])
                    {
                        linear_extrude(1) text("DANGER OF DEATH", 10, font="Droid Sans:Bold", halign="center", valign="center");
                        translate([0, -20, 0])
                        {
                            linear_extrude(1) text("Exposed high voltage inside", 8, font="Droid Sans:Bold", halign="center", valign="center");
                        }
                        translate([0, -33, 0])
                        {
                            linear_extrude(1) text("Remove power being opening", 8, font="Droid Sans:Bold", halign="center", valign="center");
                        }
                    }
                }
            
                // Holes for attaching to gantry
                translate([brain_plate_width - (extrusion_short_width * 0.5), brain_plate_depth * 0.2, brain_plate_height + epsilon])
                {
                    bolt_hole(tbolt_shank_radius, 30);
                }
                translate([brain_plate_width - (extrusion_short_width * 0.5), brain_plate_depth * 0.5, brain_plate_height + epsilon])
                {
                    bolt_hole(tbolt_shank_radius, 30);
                }
                translate([brain_plate_width - (extrusion_short_width * 0.5), brain_plate_depth * 0.8, brain_plate_height + epsilon])
                {
                    bolt_hole(tbolt_shank_radius, 30);
                }
                
                // Air holes        
                translate([(brain_plate_width * 0.5) - 15, brain_box_wall_thickness*0.5 + epsilon, brain_box_height * 0.5])
                {    
                    brain_board_vent(9, 16, 90);
                }
                translate([(brain_plate_width * 0.5) + 50, brain_plate_depth - brain_box_wall_thickness*0.5 + epsilon, (brain_box_height * 0.5) - 20])
                {    
                    brain_board_vent(9, 10, 70);
                }
            
                // Standoff holes
                translate([brain_box_wall_thickness + brain_box_wall_threshold, brain_box_wall_thickness + brain_box_wall_threshold, brain_plate_height])
                {
                    // psu
                    translate([brain_box_inner_width - psu_width - 5, brain_box_inner_depth - psu_depth - 10, 0])
                    {
                        brain_plate_psu(true);
                    }
                        
                    // control board
                    translate([brain_box_inner_width - control_board_width - 10, brain_box_inner_depth - psu_depth - control_board_depth - 15, 0])
                    {
                        brain_plate_control_board(true);
                    }
                    
                    // Camera mount.
                    translate([30, brain_box_inner_depth * 0.5, 0])
                    {
                        brain_board_camera_mount(true);
                    }
                }

                // Holes on each side for wires
                translate([brain_plate_width - 30, -epsilon, 80])
                {
                    rotate([-90, 0, 0])
                    {
                        cylinder(h=10, r=13, $fn=60);
                    }
                }
                
                // Hole for AC Plug
                translate([-epsilon, 20, (brain_box_height * 0.5) - (ac_plug_height * 0.5)])
                {
                    #cube([ac_plug_width, ac_plug_depth, ac_plug_height]);
                    translate([0, ac_plug_depth*0.5, 0])
                    {
                        scale([1, 1, 0.25]) rotate([0, 90, 0]) #cylinder(h=ac_plug_height, r=ac_plug_depth*0.5);
                    }
                    translate([0, ac_plug_depth*0.5, ac_plug_height])
                    {
                        scale([1, 1, 0.25]) rotate([0, 90, 0]) #cylinder(h=ac_plug_height, r=ac_plug_depth*0.5);
                    }
                    
                    translate([0, (ac_plug_depth*0.5) - (ac_plug_hole_distance * 0.5), ac_plug_height*0.5])
                    {
                        rotate([0, 90, 0])
                        {
                            cylinder(h=10, r=ac_plug_hole_radius, $fn=60);
                        }
                    }
                    translate([0, (ac_plug_depth*0.5) + (ac_plug_hole_distance * 0.5), ac_plug_height*0.5])
                    {
                        rotate([0, 90, 0])
                        {
                            cylinder(h=10, r=ac_plug_hole_radius, $fn=60);
                        }
                    }
                }
            }
        }
    }
}


// Build the model!
if (show_card_bin)
{
    bin_line();
}
if (show_gantry)
{
    gantry();
}
base_plate();
if (show_scan_plate || show_scan_plate_motor_mount_tube || show_scan_plate_motor_mount)
{
    scan_plate();
}
if (show_exit_insert)
{
    exit_frame() exit_insert();
}
if (show_exit_gate)
{
    exit_frame() exit_gate();
}
if (show_brain_plate)
{
    brain_plate();
}
if (show_brain_plate_lid)
{
    brain_plate_lid();
}
if (show_camera_mount)
{
    camera_mount();
}
if (show_card_mover_plate || show_card_mover_plate_motor || show_card_mover_plate_spindle)
{
    card_mover_plate();
}
if (show_card_mover || show_card_mover_slide)
{
    card_mover();
}
if (show_limit_switch_mount)
{  
    translate([-extrusion_short_depth - extrusion_short_width, 0, extrusion_short_height])
    {
        extrusion_limit_switch_mount(0, 0);
    }
}
if (show_limit_switch_mount_small)
{
    translate([-extrusion_short_depth, extrusion_short_width - 3, extrusion_short_height + 140])
    {
        rotate([0, 0, 180])
        {
            extrusion_limit_switch_mount(-6, 10.0);
        }
    }
}
if (show_scan_plate_motor_mount_tube)
{
    motor_tube();
    //motor_tube_tpu_sheath();
}