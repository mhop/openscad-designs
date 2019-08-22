
use <lib/shortcuts.scad>;
use <lib/mhop_lib.scad>;
use <lib/box_complete.scad>;

include <par.scad>;
use <rahmen.scad>;
use <vesc_schraubdome.scad>;

$fn=90;

x=150;
y=70;
h=60;

*tret();
*myboxCtrl();
mybox();

module mybox()
{
    D() {
        myboxout();
        myboxin();
        Tx(-100) Ty(65) Tz(100) Cu(200,80,200);
        *Tx(-120) Ty(65) Tz(100) Cu(80,200,200);
    }
}

module myboxout()
{
    D() {
        myboxraw();
        tret(r_off=0);
    }
}

module myboxin()
{
    d=4;
    D() {
        T(-d,0,d) S((60-d)/60, (60-d)/60, (80-d)/80) myboxraw();
        Tx(0) tret(r_off=d);
    }
}

module myboxraw()
{
    r=1;

    hull() MMy() 
    {
        Tx(-85)  Ty(35) Tz(17)  Sp(r=r);
        Tx(-5)   Ty(25) Tz(15)  Sp(r=r);
        Tx(-125) Ty(35) Tz(170) Sp(r=r);
        Tx(-50)  Ty(25) Tz(150) Sp(r=r);
    }
}

module myboxCtrl(outbox=1, outlid=0)
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
	box_Screw_Diameter     =  3.2,// [2:0.2:4]
	// Box wall thickness
	box_Wall_Thickness     =  wand, // [0.4:0.2:3.2]
	outbox=outbox, outlid=outlid
);
}


