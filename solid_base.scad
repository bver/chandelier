
include <constants.scad>

module base_part() {
  color([0.4, 0.4, 0.4, 1]) difference() {
    translate([0, leaf_radius/2+axis_radius*2, -leaf_z*3.66])  
        cube([axis_length*1.6, leaf_radius, axis_radius*1.4], center=true);

    union() {      
        translate([0, leaf_radius, -leaf_z*3]) 
            cylinder(bearing_length*2, axis_radius+tolerance, axis_radius+tolerance, center=true);
        
        translate([0, leaf_radius, -leaf_z*3-bearing_length]) 
            cylinder(bearing_length, axis_radius*2+tolerance, axis_radius*2+tolerance, center=true);
    }
  }
}

module solid_base() {
    for(angle = [0 : 360/leafs : 360])
        rotate([0, 0, angle])
            base_part();
}

// main
solid_base();

