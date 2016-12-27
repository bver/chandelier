
include <constants.scad>

module sub_leaf() {
    translate([0, 0, -leaf_z/2]) {
        linear_extrude(leaf_z) polygon([[2*leaf_x/3, 0], [leaf_x/3, 0],
                                        [0,leaf_y], [leaf_x,leaf_y]]);
        translate([0, leaf_y, 0]) 
            rotate([leaf_angle, 0, 0])
                linear_extrude(leaf_z) polygon([[0,0],[leaf_x/2,leaf_y],[leaf_x,0]]);
    }
}

module three_leaves() {      
    difference() {
        union() {
            color([0.1, 0.3, 0.2, 1]) 
                translate([leaf_x/20, 0, 0]) 
                    rotate([0, 0, -leaf_wide_angle])
                        sub_leaf();
            
            color([0.2, 0.5, 0.2, 1]) 
                translate([-leaf_x/2, 0, 0])
                    sub_leaf();
            
            color([0.1, 0.99, 0.1, 1]) 
                translate([-leaf_x/20, 0, 0])
                    rotate([0, 0, leaf_wide_angle]) 
                        translate([-leaf_x, 0, 0])
                            sub_leaf();
        }
        // remove central corners
        translate([0, -axis_radius, 0])
            cube([axis_length, 2*axis_radius, axis_radius], center=true);
    }
 
    // axis
    color([0.3, 0.70, 0.3, 1]) rotate([0, 90, 0])
        cylinder(axis_length, axis_radius, axis_radius, center=true);

    // cogged wheel
    color([0.5, 0.70, 0.5, 1]) translate([-axis_length/2, 0, 0]) rotate([0, 90, 0])
        cylinder(bearing_length, axis_radius*2.2, axis_radius*2.2, center=true);

}

// main
three_leaves();