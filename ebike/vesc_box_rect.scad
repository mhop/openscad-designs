
use <lib/shortcuts.scad>;
use <lib/mhop_lib.scad>;
use <lib/box_complete.scad>;

include <par.scad>;
use <rahmen.scad>;
//use <vesc_schraubdome.scad>;
use <klemmblock.scad>;
use <vesc_platinenhalter.scad>;

$fn=90;


*tret();

*Tx(-81) Tz(200) Ry(-16) Rz(90) Rx(-90) vesc_schraubdome();

x=240;
y=45;
h=65;

Tx(-85) Tz(145) Ry(16-16) Rx(-90) Rz(90) myboxrect();

module myboxrect(outbox=1, outlid=0)
{
T(-x/2, -y/2, -(h+wand*2)/2)
box_wp(
	/* [Box Options] */
	// Dimension: Box outer X-Size [mm]
	box_Size_X          = x,
	// Dimension: Box outer Y-Size [mm]
	box_Size_Y          = y,
	// Dimension: Box Inner height [mm]
	box_Inner_Height    = h,
	// Box bottom/top thickness
	box_BottomTop_Thickness =  wand*1.5, // [0.6:0.2:3]
	// Edge corner radius 
	box_Screw_Corner_Radius   =  rund, // [2:1:10]
	// four outer screw hole diameters
	box_Screw_Diameter     =  4,// [2:0.2:4]
	// Box wall thickness
	box_Wall_Thickness     =  wand, // [0.4:0.2:3.2]
	outbox=outbox, outlid=outlid
);
}




