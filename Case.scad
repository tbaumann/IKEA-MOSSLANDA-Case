
depth = 108.5;
height = 58.5;
width = 130;
ledge_height = 19;
ledge_depth = 11;
slot_width = 2.5;
slot_height = 27;
slot_spacing = 7;
wall_thickness = 2.5;

slots_left = 12;
slots_front = 15;

include <Chamfers-for-OpenSCAD/Chamfer.scad>;
    



// Rough box
color("white") difference() {
    //cube([depth,width,height]);
    chamferCube([depth,width,height], [[0, 0, 1, 1], [0, 1, 1, 0], [1, 1, 1, 1]], 1);
    
    // Make hollow
    translate([wall_thickness, wall_thickness, 0])
        cube([depth-wall_thickness*2,width-wall_thickness*2,height-wall_thickness]);
    
    // Ledge cutout
    cube([ledge_depth,width,ledge_height]);
    
    // Cable hole
    translate([0,width-wall_thickness,0])
        cube([7+ledge_depth,7,7]);
    
    // Space for PCB in back
    translate([depth-wall_thickness,wall_thickness,0]) 
        cube([wall_thickness, width-wall_thickness*2, 5]);
    
    airholes_left();
    airholes_front();
}


module airholes_front(){
    translate([0,((width/2) - ((slot_spacing * slots_front) - slot_width)/2),height-10-slot_height/2])
        rotate(a=[90,0,90])
            lineup(slots_front, slot_spacing){
                slot(20, slot_width);
            }
    
}

module airholes_left(){
    translate([((depth/2) - ((slot_spacing * slots_left) - slot_width)/2),width,height-10-slot_height/2])
        rotate(a=[90,0,0])
            lineup(slots_left, slot_spacing){
                slot(20, slot_width);
            }
}

module lineup(num, space) {
   for (i = [0 : num-1])
     translate([ space*i, 0, 0 ]) children(0);
}

module slot(channel_hight, channel_width){
    union(){
        cube([channel_width, channel_hight - channel_width, wall_thickness]);
        translate([channel_width/2, 0, 0]){
            cylinder(h=wall_thickness, d=channel_width, center=false, $fn=50);
            translate([0, channel_hight - channel_width, 0]){
                cylinder(h=wall_thickness, d=channel_width, center=false, $fn=50);
            }  
        }
    }
}                     
    
