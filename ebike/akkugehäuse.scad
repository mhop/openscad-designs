
use <shortcuts.scad>;
use <box_complete.scad>;
use <rahmen.scad>;
use <Parametric_slide.scad>;
use <XT60_lipo.scad>;
use <rounded_box.scad>;
use <holder.scad>;


rahmen();

akkuL=210;
akkuLk=175;
akkuHk=50;
akkuB=69;
akkuH=125;
rund=10;
wand=3;


slider1x=70;
slider2x=200;
sliderL=40;

view_ober=0;
view_unter=0;
view_mitte=1;


schieneB=85;
Ty(-(schieneB+4)/2) Cu([10,schieneB+4, 7]);
T(x=180,y=-(schieneB+4)/2,z=0) Cu([10,schieneB+4, 7]);
D() {
T(0,0,0) R(90,0,-90)
holder(t=1, clf_partHeight=250, clf_innerWidth = schieneB);

T(240,-schieneB/2, 2)  Rx(10) Cu([10, 10, 10]);
T(40,-schieneB/2, 2)  Rx(10) Cu([150, 10, 10]);
}

//translate([0,0,0]) rotate([90,0,-90])
//holder(t=2, clf_partHeight=50, clf_innerWidth = 85);

//translate([0,-30,50]) rotate([0,90,0]) XT60_holder();



Tx(-15) {
	Tz(19) {
		//mysliders(x1=slider1x, x2=slider2x, l=sliderL) ;
		if(view_mitte) T(20,-155,-12) mybox(outlid=1);
	}
	if (view_ober) 
		T(0,-117,akkuH+16) Rx(180) T(20,-164,0) {
			//mybox(outbox=1);
			myroundedBox();
		}
	//translate([wand+20,akkuB/2+rund+wand,wand+20]) akkuK();
}

w1=4;

module myroundedBox() 
{

	boxL=akkuL+wand*2;
	boxB=akkuB+rund*2+wand*2;

	T(boxL/2,boxB/2,0) 
		rounded_box(xsize=boxL, 
				ysize=boxB,
				zsize=akkuH,
				roundc=rund, 
				thick=wand);

	module dbox()
	{
		dboxL=boxL+wand*2;
		dboxB=boxB+wand*2;
		T(dboxL/2-wand,dboxB/2-wand,-0) 
			rounded_box(xsize=dboxL, 
				ysize=dboxB,
				zsize=10,
				roundc=rund+wand, 
				thick=wand);
	}

	D() {
		mybox(outbox=1);
		dbox();
		T(-0.1,-0.1,-0.1) Cu([akkuL*2,akkuB*2,wand*1.6]);
	}
}


module mysliders(x1, x2, l) 
{
	if(view_unter) {translate([20, -akkuB/2,-18.8]) cube([akkuL+40, akkuB, 6.05]);
	translate([x1-l-10, -akkuB/2,-15]) cube([10, akkuB, 15]);
	translate([x2-l-10, -akkuB/2,-15]) cube([10, akkuB, 15]);
	myslider(x1, l, 2); myslider(x2, l, 2);
	}
	if(view_mitte) {myslider(x1, l, 1); myslider(x2, l, 1);}
}

module myslider(x,l, v) {
translate([x-l,0,wand+3.2])
rotate([180,0,-90])
slide(
Slide_length = l    ,
Slide_width = akkuB     ,
clearance = 0.2      ,//Clearance gap between parts... 0.1 default, 
carriage_length= 3*l   ,
//Viewing Parameters
$fn = 100    ,// Number of facets
View_parts = v//////.. 1=View Rail  2=View carriage 3= carriage for printing 4=assembly
);
}

module mybox(outbox=0, outlid=0)
{
box_wp(
	/* [Box Options] */
	// Dimension: Box outer X-Size [mm]
	box_Size_X          = akkuL+wand*2,
	// Dimension: Box outer Y-Size [mm]
	box_Size_Y          = akkuB+rund*2+wand*2,
	// Dimension: Box Inner height [mm]
	box_Inner_Height    = akkuH,
	// Box bottom/top thickness
	box_BottomTop_Thickness =  wand, // [0.6:0.2:3]
	// Edge corner radius 
	box_Screw_Corner_Radius   =  rund, // [2:1:10]
	// four outer screw hole diameters
	box_Screw_Diameter     =  3.2,// [2:0.2:4]
	// Box wall thickness
	box_Wall_Thickness     =  wand, // [0.4:0.2:3.2]
	outbox=outbox, outlid=outlid
);
}

//oberteil();

/*
translate([13,-10,30])
rotate([0,0,90])
import("/Users/marc/Documents/3d/XT90_pannel_v5.stl");

rotate([0,90,0])
difference() {
import("/Users/marc/Documents/3d/case.stl");
translate([50,3,-100]) cube([100,200,300]);
}
*/

module oberteil() {
difference() {
	gehauese();
	translate([-10, -akkuB, -10]) cube([akkuL*2, akkuB*2, 20]);
	translate([-20,-20/2,26])
	cube([40,25,15]);
}
}


module gehauese() {
difference() {
	minkowski() {
		roh();
		sphere(r=w1);
	}
	roh();
}
	difference() {
		spanten(N=15);
		translate([220, -100/2, -5]) cube([100, 100, 200]);
	}
}



module roh() {
	difference() {
		hull() stege();
		griff(r=18, d=39);
	}
}

module griff(r=20, d=40)
{
		translate([240,100,30]) rotate([90,0,0]) hull() {
			translate([0,d,0]) cylinder(r=r, h=200, center=1);
			cylinder(r=r, h=200, center=1);
		}
}

module spanten(N) {
	difference () {
		stege(N);
		akkuK();
	}
}

module stege(N=20) {
	l=275;
	d=l/N;

	translate([-w1,0,0])
		for (i=[0:N]) {
			platte(i*d, 110-pow(-1+i/N*5.5,3)+sin(30+i*90/N)*60, 90+sin(i/N*180)*10-pow(i/N*3.3,3));
		}
}


module platte(x,h,w)
{
translate([x,-w/2,0])
cube([w1,w,h]);
}

module akkuK() 
{
	color( "LightSkyBlue", 1.0 ) {
		translate([0, -akkuB/2,0]) {	
			translate([akkuL-akkuLk, 0,0]) cube([akkuLk, akkuB, akkuH]);
			translate([0, 0,akkuH-akkuHk]) cube([akkuL, akkuB, akkuHk]);
		}
	}
}
