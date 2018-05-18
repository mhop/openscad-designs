
use <shortcuts.scad>
use <mhop_lib.scad>


///////////////////////////////////////////
/// OpenSCAD File by Ken_Applications /////
///////////////////////////////////////////

///The 4 Main Parameters below////////
///are for you to experiment with. ///
/////////// Enjoy ////////////////////

slide();

module slide(
Slide_length = 160    ,
Slide_width = 69     ,
Slide_height=9,
clearance = 0.1      ,//Clearance gap between parts... 0.1 default, 
//Viewing Parameters
$fn = 100    ,// Number of facets
View_parts = 5//////.. 1=View Rail  2=View carriage 3= carriage for printing 4=assembly
)
{


carriage_length= Slide_length;

/////..Below Calculations ..////
r=Slide_height*0.15;//ratio for size of radius
podfcl=Slide_width*0.3;//position of dovtail from center line
rfbt=(Slide_height)/3;//ratio for base thickness
bcr=Slide_height*1.9625;//blue circle radius


if (View_parts ==1) base_rail_extruded ();
if (View_parts ==2) move_carriage ();
if (View_parts ==3) print_carriage();
if (View_parts ==4) base_rail_extruded ();
if (View_parts ==4) move_carriage_clip ();
if (View_parts ==5) move_carriage_clip ();
if (View_parts ==6) base_rail_extruded_clip ();

///////////////////////////////////////////
/////// The Module's used /////////////////

module left_hand_rail()
{
difference()
	{
    rotate(a=-60, v=[0,0,1])
    square([Slide_height*3,Slide_width*0.15],center=true);
    translate([0,(Slide_height*1.5)-r,0]) square([Slide_width,Slide_height*2],center=true);
    translate([0,-(Slide_height*1.5)+r,0]) square([Slide_width,Slide_height*2],center=true);
     }
}



module left_and_right_hand_rail()
{
	mirror(v= [0, 1, 0] )
		translate([podfcl,0,0]) offset(r=r) left_hand_rail();
	translate([-podfcl,0,0]) offset(r=r) left_hand_rail();
}

module base_rail_without_recess()
{
	union() {
		square([Slide_width/2,Slide_height/2],true);
		left_and_right_hand_rail();
		translate([0,-rfbt,0])  square([Slide_width,Slide_height/3],center=true);
	}
}

module base_rail()
{
	difference()
	{
		base_rail_without_recess();
		translate([+(podfcl/3),bcr-Slide_height/6,0])  circle(bcr);
		translate([-(podfcl/3)	,bcr-Slide_height/6,0])  circle(bcr);
		translate([0,Slide_height*2/6,0])  Sq(Slide_width/4,Slide_height);
 }   
    
}


module add_bit()
{
	difference() {
		translate([0,Slide_height-rfbt*2,0])
			square([Slide_width,Slide_height],center=true); 
		translate([0,Slide_height-clearance-rfbt*2,0]) color("green")
			square([Slide_width-clearance*3,Slide_height-clearance],center=true);
	}
}

module top_rail()
{
	offset(r)offset(r=-clearance-r)
	difference(){
		translate([0,Slide_height-rfbt*2,0])
			square([Slide_width,Slide_height],center=true); 
		base_rail_without_recess();
	}

	*union()
		add_bit();
    
    //fill in bottom gap
    *translate([-Slide_width*0.492,-Slide_height*0.166,0]) 
		square([Slide_width*0.165,clearance+0.2],false);
    *translate([Slide_width*0.322,-Slide_height*0.166,0]) 
		square([Slide_width*0.165,clearance+0.2],false);
 
}
 
module top_rail_chamfered ()
{
	difference(){
		top_rail();
	//draw the chamfer squares
	translate([-Slide_width*0.314,-Slide_width*0.049,0]) rotate(a=45, v=[0,0,1]) 
		square(r*2.6,true);
	translate([Slide_width*0.314,-Slide_width*0.049,0]) rotate(a=45, v=[0,0,1])
		square(r*2.6,true);
   translate([-Slide_width*0.5,Slide_width*0.22,0]) rotate(a=45, v=[0,0,1])
		square(r*2.6,true);
   translate([Slide_width*0.5,Slide_width*0.22,0]) rotate(a=45, v=[0,0,1])
		square(r*2.6,true);
	}
}


module base_rail_extruded ()
{
	I() {
			translate([0,0,Slide_height/2]) rotate(a=90,v=[1,0,0])linear_extrude(0,0,Slide_length) 
		base_rail();
		// abrunden
		Ty(-Slide_length/2) Tz(Slide_height/2) 
			rounded_cube(Slide_width, Slide_length, Slide_height, r);
	}
}


module base_rail_extruded_clip ()
{
	D() {
		I() {
			translate([0,0,Slide_height/2]) rotate(a=90,v=[1,0,0])linear_extrude(0,0,Slide_length) 
				base_rail();
			// abrunden
			Ty(-Slide_length/2) Tz(Slide_height/2) 
				rounded_cube(Slide_width, Slide_length, Slide_height, r);
		}
		// gegenlöcher für clip
		Ty(-7) Tz(5*Slide_height/6+0.1) Tx(-(Slide_width/3-1.5))
			Cu(10,6,Slide_height/3);
		Ty(-7) Tz(5*Slide_height/6+0.1) Tx(+(Slide_width/3-1.5))
			Cu(10,6,Slide_height/3);
	}
}

module move_carriage ()
{
   color("Green") {
		translate([0,-0,Slide_height/2]) rotate(a=90,v=[1,0,0])
			linear_extrude(0,0,carriage_length)  top_rail_chamfered();
	}
}  

module move_carriage_clip ()
{
	color("Green") {
		D(){
			U() { 
				Tz(Slide_height/2) rotate(a=90,v=[1,0,0])
					linear_extrude(0,0,carriage_length) top_rail_chamfered();
				// Clip
				Tz(Slide_height+Slide_height/6) Ty(5)
					rounded_cube(Slide_width*0.77, 15, Slide_height/3,r/2);
		// Haken
		Ty(-7) Tz(7*Slide_height/6) Tx(Slide_width/3-1.5) I() { 
			Tz(0)Ty(-2) Rx(30)Cu(10,5,5);
			Tz(-3) Cu(10,5,4);
		}
		Ty(-7) Tz(7*Slide_height/6) Tx(-(Slide_width/3-1.5)) I() {
			Tz(0)Ty(-2) Rx(30)Cu(10,5,5);
			Tz(-3) Cu(10,5,4);
		}
			}
			// Einschnitte für Clip
			Tz(10) Cu(Slide_width*0.46, 1,20);
			Tx(+Slide_width*0.45/2+.5) Ty(-9.5)Tz(10) Cu(1, 20,10);
			Tx(-Slide_width*0.45/2-.5) Ty(-9.5)Tz(10) Cu(1, 20,10);
			Tx(+Slide_width*0.77/2+.5) Ty(-9.5)Tz(10) Cu(1, 20,10);
			Tx(-Slide_width*0.77/2-.5) Ty(-9.5)Tz(10) Cu(1, 20,10);
		}
	}
}


module print_carriage(){
   
 rotate(a=180,v=[0,1,0]) translate([Slide_width+rfbt,0,-rfbt-Slide_height])  move_carriage(); 
   
 } 


//Animate_carriage=1; // 1=Animate  0= No Animation
//if (Animate_carriage==1) translate([0,$t*-Slide_length*1.1,0]) move_carriage();
//if (Animate_carriage==0) move_carriage(); 
 
 
}





















