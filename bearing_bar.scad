
include <constants.scad>
use <spur_generator.scad>
use <parametric_involute_gear_v5.0.scad>

module bearing_bar() {
    color([0.7, 0.70, 0.3, 1]) {
        // 2 bearings
        rotate([0, 90, 0]) {
            for (sig = [1,-1]) translate([0, 0, sig*axis_length/5.31])
                difference() { 
                    cylinder(bearing_length, axis_radius*2, axis_radius*2, center=true);
                    cylinder(bearing_length, axis_radius+tolerance, axis_radius+tolerance, center=true);
                }
        }
        
        // bar
        translate([0, 0, -leaf_z*2])
            cube([4*bearing_length, axis_radius*2, axis_radius], center=true);
        
        // bearing axe
        translate([0, 0, -leaf_z*3])
            cylinder(bearing_length*2-tolerance, axis_radius, axis_radius, center=true);
        
        // cogged wheel        
        circular_pitch = fit_spur_gears(bearing_teeth, central_teeth, leaf_radius*1.01); 
        translate([0, 0, -central_length])
            //cylinder(bearing_length/2-tolerance, axis_radius*2, axis_radius*2, center=true);
            gear(circular_pitch = circular_pitch,
                 number_of_teeth = bearing_teeth,
                 pressure_angle = pressure_angle,
                 bore_diameter = 0,
                 gear_thickness = bearing_length/2,
                 rim_thickness = bearing_length/2,
                 hub_thickness = bearing_length/2);
        
    }
}

// main
bearing_bar();

