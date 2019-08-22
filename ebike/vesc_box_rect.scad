
use <lib/shortcuts.scad>;
use <lib/mhop_lib.scad>;
use <lib/box_complete.scad>;

include <par.scad>;
use <rahmen.scad>;
use <vesc_schraubdome.scad>;
use <vesc_platinenhalter.scad>;

$fn=90;


tret();
*myboxCtrl();
*klemmplatine();

*D() {
U() {*tret();
mybox();
}
        *Tx(-100)  Ty(80/2+1) Tz(100) Cu(300,80,300); // Deckel abschneiden
        *Tx(-100)  Ty(-80/2-1) Tz(100) Cu(300,80,300); // Deckel abschneiden
}

*Tx(-65) Tz(140) Ry(-16) Rz(90) Rx(-90) vesc_schraubdome();
*Tx(-100) Tz(105) Ry(-13) Rz(90) Rx(90) vesc_platinenhalter();

x=240;
y=45;
h=85;
Tx(-85) Tz(145) Ry(-16) Rx(-90) Rz(90) myboxrect();

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
	box_Screw_Diameter     =  3.2,// [2:0.2:4]
	// Box wall thickness
	box_Wall_Thickness     =  wand, // [0.4:0.2:3.2]
	outbox=outbox, outlid=outlid
);
}





module mybox()
{
    D() {
        U() {
            D() {
                myboxout();
                myboxin();
            }
            Tx(-58) Ty(16.5) Tz(165) Ry(-18) Cu(15,15,30); // Batteriekabel
            Tx(-65) Ty() Tz(30) Ry(0) Rz(180) kabelsteg();
            Tx(-90+9) Ty() Tz(10) Cu(7,20,15); // Befestigungslasche
            klemm(); 
        }
        Tx(-50) Tz(15) Cu(30,10,10); // Loch unten
        Tx(-100)  Ty(64) Tz(100) Cu(200,80,300); // Deckel abschneiden
        *Tx(-120) Ty(65) Tz(100) Cu(80,200,300);
        Tx(-50) Ty(22) Tz(150) { // Batteriekabel Ausschnitt
         Tx(1.5) Tz(12) Ry(15) Cu(20,5,10); 
         Tx(-8.5) Tz(23) Ry(-18) Cu(10,5,25);
        }
        tret();
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
    d=2.5;
    D() {
        T(-d-1,0,d) S((60-d)/60, (60-d)/60, (80-d)/80) myboxraw();
        Tx(0) tret(r_off=d);
    }
}

module myboxraw()
{
    r=1;

    hull() 
    MMy() 
    {
        Tx(-95)  Ty(35) Tz(17)  Sp(r=r);
        Tx(-5)   Ty(25) Tz(15)  Sp(r=r);
        Tx(-140) Ty(35) Tz(220) Sp(r=r);
        Tx(-60)  Ty(25) Tz(200) Sp(r=r);
    }
}

module klemm()
{   
    a=80;
    b=35;
    d=2;
    
    *Tx(-60) Tz(50) Cu(a,d,b);
    
    // Platine
    *Tx(-65)Tz(67) Ty(5) Ry(90) Rx(-90) klemmplatine();
    
}

module klemmplatine()
{
     Cu(52,35,1);
    
            *color("green") Ty() Tz(7) { 
                Tx(16) Rz(90) Cu(27,14,12); 
                Tx() Rz(90)Cu(27,14,12);
                Tx(-16) Rz(90)Cu(27,14,12);
            }
            color("green") Ty() Tz(6) { 
                MMy() {Tx(12) Ty(8.5) Cu(23,14,12); 
                Tx(-12) Ty(8.5)Cu(23,14,12);
                }
            }
           *color("green") Ty() Tz(7) { 
                Tx() Ty() Cu(60,14,12); 
            
            }
}


module kabelsteg()
{
    l=100;
    b=40;
    d=2;
    h=12;
    x=13;
    
    for(i=[0:4]) {
        Tx(-l/2+16+i*x)Ty(-b/2+2) Tz(h/2) zahn(h=h);
    }
    Cu(l,b,d); // Kabelschutzsteg
}

module zahn(h=12)
{
    b=6; 
    h2=4;
    d=4;
    x=1;
    r=0.5;
    
    CuR(b,d,h, r=r);
    Tz((h-h2)/2) Ty(x/2) CuR(b+2*x,d+x,h2, r=r);
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


