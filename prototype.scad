
$fn = 50;

leaf_x = 6;
leaf_y = 19;
leaf_z = 0.8;
leaf_angle = 30;
leaf_wide_angle = 20;
leaf_open_angle = 90;
leaf_slide_angle = 50;
leaf_radius = 12;
leafs = 6;

axis_length = 10;
axis_radius = 1;
bearing_length = 1.25;
tolerance = 0.1;

module sub_leaf() {
    translate([0, 0, -leaf_z/2]) {
        linear_extrude(leaf_z) polygon([[2*leaf_x/3, 0], [leaf_x/3, 0],
                                        [0,leaf_y], [leaf_x,leaf_y]]);
        translate([0, leaf_y, 0]) 
            rotate([leaf_angle, 0, 0])
                linear_extrude(leaf_z) polygon([[0,0],[leaf_x/2,leaf_y],[leaf_x,0]]);
    }
}

module moveable_3_leaf() {      
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
            cube([axis_length - 2*(bearing_length+tolerance), axis_radius*2, axis_radius], center=true);
        
        // bearing axe
        translate([0, 0, -leaf_z*3])
            cylinder(bearing_length*2-tolerance, axis_radius, axis_radius, center=true);
        translate([0, 0, -leaf_z*4.17])
            cylinder(bearing_length/2-tolerance, axis_radius*2, axis_radius*2, center=true);
    }
}

module base() {
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

module leaf(open, angle=0) {
    rotate([0, 0, angle]) {        
        translate([0, leaf_radius, 0]) {        
            rotate([open*leaf_open_angle, 0, open*leaf_slide_angle])
                moveable_3_leaf();                        
            
            rotate([0, 0, open*leaf_slide_angle]) 
                bearing_bar();
        }      
        
        base();
    }
}

//bearing_bar(); base();
//sub_leaf();
//leaf(0);
//leaf(1);
//leaf(0,360/6);

time = 2*abs($t-0.5);
for(a = [0 : 360/leafs : 360])
    leaf(time, a);
