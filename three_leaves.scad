
include <constants.scad>
use <spur_generator.scad>
use <parametric_involute_gear_v5.0.scad>

module sub_leaf() {
    translate([0, 0, -leaf_z/2]) {
        linear_extrude(leaf_z) polygon([[2*leaf_x/3, 0], [leaf_x/3, 0],
                                        [0,leaf_y], [leaf_x,leaf_y]]);
        translate([0, leaf_y, 0]) 
            rotate([leaf_angle, 0, 0])
                linear_extrude(leaf_z) polygon([[0,0],[leaf_x/2,leaf_y],[leaf_x,0]]);
    }
}

module leaves_n_axis() {     
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
}

module leaves_wheel() {
    circular_pitch = fit_spur_gears(base_teeth, leaf_teeth, bearing_radius + axis_length/2);   
    echo("circular_pitch=", circular_pitch);
    echo("leaf_teeth=", leaf_teeth);
    echo("base_teeth=", base_teeth);
    
    color([0.5, 0.70, 0.5, 1]) difference() {
  
    // cogged wheel        
        //cylinder(bearing_length, bearing_radius, bearing_radius, center=true);
        rotate([0,0,5])
            bevel_gear(outside_circular_pitch=circular_pitch,   
                face_width = bearing_length,
                circles = 0,
                bore_diameter = axis_radius*2,
                cone_distance = axis_length/2,
                pressure_angle = pressure_angle,
                number_of_teeth = leaf_teeth);    
    
    // leaf hole
        translate([0, bearing_length, 0])
        cube([leaf_z, 4*axis_radius, 2*bearing_length], center=true);
        
    }        
}

module three_leaves() {
    leaves_n_axis();
    translate([0.4-axis_length/2, 0, 0]) rotate([0, 90, 0])
        leaves_wheel();
}

// main
three_leaves();
//leaves_wheel();
//leaves_n_axis();
