
include <constants.scad>
use <spur_generator.scad>
use <parametric_involute_gear_v5.0.scad>

module trench() {
    translate([0, leaf_radius, -leaf_z*3]) difference() {
        cylinder(bearing_length*.6, axis_length*0.50, axis_length*0.55, center=true);
        cylinder(bearing_length*.6, axis_length/2-bearing_radius, axis_length/2-bearing_radius, center=true);
    }
}

module base_part() {   
  color([0.4, 0.4, 0.4, 1]) difference() {
    translate([0, leaf_radius/2+axis_radius*2, -leaf_z*3.66])  
        cube([axis_length*1.6, leaf_radius, axis_radius*1.4], center=true);     

    union() {      
        translate([0, leaf_radius, -leaf_z*3]) 
            cylinder(bearing_length*2, axis_radius+tolerance, axis_radius+tolerance, center=true);
        
        translate([0, leaf_radius, -leaf_z*3-bearing_length]) 
            cylinder(bearing_length, axis_radius*2+tolerance, axis_radius*2+tolerance, center=true);       
        
        trench();

        translate([0, 0, -leaf_radius]) rotate([0,0,-30])
            cube([2*leaf_radius, 2*leaf_radius, leaf_radius]);  
        translate([0, 0, -leaf_radius]) rotate([0,0,120])
            cube([2*leaf_radius, 2*leaf_radius, leaf_radius]);  
    }
  }
  
  
  // cogged wheel
  base_teeth = round(leaf_teeth * leaf_open_angle / leaf_slide_angle);
  circular_pitch = fit_spur_gears(base_teeth, leaf_teeth, bearing_radius + axis_length/2);    
  difference() {
       translate([0, leaf_radius, -bearing_radius*1.18]) 
           bevel_gear(outside_circular_pitch=circular_pitch,   
                face_width = bearing_length,
                circles = 0,
                bore_diameter = 0,
                gear_thickness = 0,
                cone_distance = axis_length/2,
                pressure_angle = pressure_angle,
                number_of_teeth = base_teeth);
 
       translate([-leaf_radius, leaf_radius+axis_radius*2, -leaf_radius])
           cube([2*leaf_radius, 2*leaf_radius, leaf_radius]);  
  }
}

module solid_base() {
    for(angle = [0 : 360/leafs : 360])
        rotate([0, 0, angle])
            base_part();
}

// main
base_part();
//solid_base();

