
include <constants.scad>

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
        translate([0, 0, -leaf_z*4.17])
            cylinder(bearing_length/2-tolerance, axis_radius*2, axis_radius*2, center=true);
    }
}

// main
bearing_bar();

