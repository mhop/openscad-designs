////////////////////////////////////////////////
//  Parametric circuit board mount  ////////////
////////////////////////////////////////////////
/// OpenSCAD File V1.0 by Ken_Applications /////
/////////  OpenSCAD version 2015.03-2 //////////
////////       16 - 12 - 2018              /////
////////////////////////////////////////////////

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>
*color("green") {
	Tz(9.5) Ty(-32.5) Tx(-19.5) Rx(90)Ry(90) 
		import("ebike/VESC_Board_Dummy.stl");
}

//Parameters/////
x_dimension=39;
y_dimension=65.3;
spring_height=2;
//gap_under_board=3;
gap_under_board=35;
gap_under_board_2=10;
corner_support=0; // [1=support 0=no support]
board_thickness=1.8;
topoffset=15;
rtopoffset=3.2/2;


///// Tab parameters ////////
Tab_Width=11;
fixing_hole_size=4;
chamfer=0; // [1=chamfer  0= no chamfer]


gap_under_board_3=gap_under_board_2+6;
y_dimension_2=Tab_Width/4*9;

///////////////////////////////////////////////
Tab_Height=spring_height;

//calculations//+
y_thick=y_dimension/16;
x_straight=x_dimension-(4*y_thick);
hgt_with_gap=spring_height+gap_under_board+board_thickness*2;
gap_with_spring=gap_under_board+spring_height;
//////////////////////////////////////////////////////////////


offr=8;
*Tz(gap_under_board-gap_under_board_3+35) {
	D() {
		Cu(x_dimension+offr, y_dimension+offr, spring_height);
		Cu(x_dimension+offr-y_thick*3, y_dimension+offr-y_thick*3, spring_height+1);
	Tx(-x_dimension/2) Ty(-y_dimension/2) Tz(-spring_height-0.1)
		holes_grid(2,2,x_dimension,y_dimension, 4.5, topoffset-1);
	}
}

MMy() {
	Ty((-y_dimension+y_dimension_2-Tab_Width/2)/2) Tz(gap_under_board-gap_under_board_3) {
		Rx(0)	D() {
			Cu(x_dimension, y_dimension_2, spring_height);
			Cu(x_dimension-y_thick*2, y_dimension_2-y_thick*2, spring_height+0.1);
		}
	}
}

//insert tabs
translate([0,-(y_dimension/2)-Tab_Width/2,0]) tab();
translate([0,+(y_dimension/2)+Tab_Width/2,0]) rotate([0,0,180]) tab();

D() { 
	spring_mount ();
	MMx() Tx(x_dimension/2+y_thick+1.2) Cu(5,100,10);
	MMy() Ty(y_dimension/2+y_thick+1.2) Cu(100,5,10);
MMy() Ty(-(y_dimension/2)-Tab_Width/2+8) Tz(3) cylinder(h=Tab_Height*3+7, d1=fixing_hole_size, d2=fixing_hole_size, center=true,$fn=60);
}


module spring_mount (){
difference(){
	union() {
		linear_extrude(height=spring_height) 5bends();
		if (corner_support==1)  {
			translate([-x_dimension/2,-y_dimension/2,0]) 
				holes_grid(2,2,x_dimension,y_dimension,y_thick*4,gap_with_spring);
		}
		if (corner_support==0)  {
			translate([-x_dimension/2,-y_dimension/2,0]) 
				holes_grid(2,2,x_dimension,y_dimension,y_thick*4,gap_with_spring-gap_under_board);
		}
		D() {
			translate([-x_dimension/2,-y_dimension/2,0]) 
				holes_grid(2,2,x_dimension,y_dimension,y_thick*2,hgt_with_gap+topoffset);
			if(topoffset!=9)
				translate([-x_dimension/2,-y_dimension/2,hgt_with_gap+1.1]) 
			holes_grid(2,2,x_dimension,y_dimension, rtopoffset, topoffset-1);
		}
	}

	//The board
	#translate([0,0,(board_thickness/2)+gap_under_board+spring_height+0.15]) 	
		cube([x_dimension+0.3,y_dimension,board_thickness],true);
	#translate([0,0,(board_thickness/2)+gap_under_board+spring_height+0.15-gap_under_board_2]) 	
		cube([x_dimension+0.3,y_dimension,board_thickness],true);
    h_cap=14;
    #Tz(board_thickness+gap_under_board+spring_height+0.15+h_cap/2+0.1) Cy(r=2, h=h_cap);
}
}

$fn=100;
$vpr = [60, 0, 345];//cnc view point
//$vpd=(360);


module holes_grid (holesX,holesY,X_Space,Y_Space,holeDiameter,thickness,){
      for (i=[0:holesX-1]) {
        for (j=[0:holesY-1]) {
	 	translate([X_Space*i,Y_Space*j,thickness/2-.1]) Cu(holeDiameter*2/3,holeDiameter*2/3,thickness+0.2, center=true);
    }
  }
}

module c_shape(c_thick,straight_len)
{
	difference() { 
		union() {
			difference(){
				circle(c_thick*2);
				translate([c_thick*3,0,0]) square([c_thick*6,c_thick*6],true) ;
			}  
			translate([straight_len/2,0,0]) square([straight_len,c_thick*4],true);
		}
		circle(c_thick);
		translate([(straight_len/2)+0.1,0,0]) square([straight_len+.2,c_thick*2],true);
	}
}



module 5bends(){
translate([-(x_dimension/2)+2*y_thick,0,0]){
c_shape(y_thick,x_straight);
translate([x_straight,y_thick*3,0]) rotate([0,0,180]) c_shape(y_thick,x_straight);
translate([x_straight,-y_thick*3,0]) rotate([0,0,180]) c_shape(y_thick,x_straight);
translate([0,y_thick*6,0]) rotate([0,0,0]) c_shape(y_thick,x_straight);
translate([0,-y_thick*6,0]) rotate([0,0,0]) c_shape(y_thick,x_straight);
translate([y_thick+x_straight,(y_dimension/2)-y_thick/2,0]) square([y_thick*2,y_thick],true);   
translate([y_thick+x_straight,-(y_dimension/2)+y_thick/2,0]) square([y_thick*2,y_thick],true);   
}
}



module tab (){

Ty(8)  
difference(){
union(){
linear_extrude(height=Tab_Height*3) circle(fixing_hole_size/5*6,$fn=60);
//translate([-Tab_Width/2,0,0]) cube([Tab_Width,Tab_Width/2,Tab_Height],false);
}
translate([0,0,3]) cylinder(h=Tab_Height*3+7, d1=fixing_hole_size, d2=fixing_hole_size, center=true,$fn=60);
Tz(Tab_Height*2+0.1) Cy(r=0.866*(7/2)+0.2, $fn=6, h=4);
if (chamfer==1)  {
translate([0,0,Tab_Height-(fixing_hole_size/2)+.1]) cylinder(h=fixing_hole_size/2, d1=fixing_hole_size, d2=fixing_hole_size+4, center=false,$fn=60);
}

}
}