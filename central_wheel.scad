
include <constants.scad>
use <spur_generator.scad>
use <parametric_involute_gear_v5.0.scad>

module wheel() {        
        // cogged wheel        
        circular_pitch = fit_spur_gears(bearing_teeth, central_teeth, leaf_radius*1.01); 
        translate([0, 0, -central_length])
            gear(circular_pitch = circular_pitch,
                 number_of_teeth = central_teeth,
                 pressure_angle = pressure_angle,
                 bore_diameter = 0,
                 circles = 6,
                 hub_diameter = axis_radius/5,
                 rim_width = axis_radius/5,
                 gear_thickness = bearing_length/2,
                 rim_thickness = bearing_length/2,
                 hub_thickness = bearing_length/2);
            
        // axis
        translate([0, 0, -central_length*0.6])
            cylinder(central_length*0.5, axis_radius, axis_radius, center=true);            
}

module cap() {
        translate([0, 0, -leaf_z*2.5]) difference() {
            cylinder(bearing_length/2, axis_radius*1.5, axis_radius*1.5, center=true);
            cylinder(bearing_length/2, axis_radius, axis_radius, center=true);
        }
}

module central_wheel() {
    wheel();
    cap();
}

// main
central_wheel();

