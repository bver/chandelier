
include <constants.scad>
use <three_leaves.scad>
use <bearing_bar.scad>
use <solid_base.scad>

module leaf(open, angle=0) {
    rotate([0, 0, angle]) {        
        translate([0, leaf_radius, 0]) {        
            rotate([open*leaf_open_angle, 0, open*leaf_slide_angle])
                three_leaves();                        
            
            rotate([0, 0, open*leaf_slide_angle]) 
                bearing_bar();
        }            
    }
}

// main
/*
solid_base();
time = 2*abs($t-0.5);
for(a = [0 : 360/leafs : 360])
    leaf(time, a);
*/
time = 2*abs($t-0.5);
base_part();
leaf(0, 0);
