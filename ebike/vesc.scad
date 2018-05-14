
use <lib/shortcuts.scad>
use <lib/box_complete.scad>;

use <henkel.scad>

akkuL=210;
akkuLk=175;
akkuHk=50;
akkuB=69;
akkuH=125;
rund=6;
wand=3;


controllerbox();

*Tx(28) Ty(-15) Tz(30) Ry(-90) 
	vesc_holder();

Tx(44) Ty(-15) Tz(-28) Ry(90) 
	vesc_caps();
Tx(30) Ty(-15) Tz(-28) Ry(90) 
	vesc_caps();





module vesc_holder()
{
	h=23;
	R=8/2;
	ri=3/2;

	vesc_board();
	Tz(-14)
		vesc_caps();

	x=29;
	y1=6;
	y2=16;
	Tz(-h/2+0.5) {
		Tx(+x) Ty(+y1) Ri(R=R, r=ri, h = h);
		Tx(+x) Ty(-y1) Ri(R=R, r=ri, h = h);
		Tx(-x) Ty(+y2) Ri(R=R, r=ri, h = h);
		Tx(-x) Ty(-y2) Ri(R=R, r=ri, h = h);
	}
	Tz(+h/3/2-h+0.5) Tx(x) Cu(2*R, 2*y1, h/3);
	Tz(+h/3/2-h+0.5) Tx(-x) Cu(2*R, 2*y2, h/3);
}

module vesc_board()
{
	Tx(-32.5) Ty(19.5) Tz(1) Rx(90) 
		import("VESC_Board_Dummy.stl");
}

module vesc_caps()
{
	Rx(90) Ry(180) Tx(25) Ty(0) Tz(-20) import("Capacitors.stl");
}

module controllerbox() 
{
	l=akkuB*1.4; 
	b=akkuB+2*rund+2*wand;
	h=akkuH+rund+wand*2+wand;
	
	// deckel abgerundet
	D() {	
	 rounded_box(l=l, b=b, h=h, r=rund, w=wand);
		Ry(4)Tx(25)Cu(100,b*2,h*2);
		//Tz(-wand-1+40) Tx(-(akkuL+rund*2+akkuB*1.5-14)/2+100) Ty(-akkuB/3) Ry(90)  xt90();
	}
	
	// unterteil abgerundet
	Tx(0.4)D() {	
		rounded_box(l=l, b=b, h=h, r=rund, w=wand);
		Ry(4)Tx(-45)Cu(40,b*2,h*2);
		// Loecher oben für Kabel
		rloch=4;
		rduenn=8;
		Tx(18) Ty(b/4)  Tz(-h/2) Cy(r=rloch, h=10);
		Tx(18) Ty(-b/4) Tz(-h/2) Cy(r=rloch, h=10);
		// wand um wand/2 verdünnern für gummidichtungen
		Tx(18) Ty(b/4)  Tz(-h/2+6-(wand/2)) Cy(r=rduenn, h=5);
		Tx(18) Ty(-b/4) Tz(-h/2+6-(wand/2)) Cy(r=rduenn, h=5);
	}
	*Tx(12) Ry(-90) vesc_box();

// Schloss
Tx(-33) Ty(-33) Tz(50) Ry(180) Rx(-90) {
	Cy(r=18/2, h=22);
	Tz(20/2) Tx(47/2) Cu(47,18,2);
}

	
}


module vesc_box()
{
	l=akkuB-wand; 
	b=akkuB+2*rund-wand;
	h=akkuH+2*wand;

	// Wasserdichte Box unten abgeschnitten
	Tz(-3*l/8) D() {
		//Tx(l/2+22) Ty(-39) Tz(-h/2+wand) Ry(0) Ry(-90)
		mycontrollerbox(outbox=1,x=h, y=b, h=l);
		Tz(-akkuH/2+l/4) Cu(akkuH*2,akkuH,akkuH);
	}
	// aussen verbreitern damit auf jeden fall mit aussenwand verbunden
	dw=wand;
	D() {
		Cu(h+dw,b+dw,l/4+dw);
		Tz(1)Cu(h-2*dw,b-2*dw,l/4+dw+10);
	}

	// Deckel dazu
	*Tz(l/4.1-1)mycontrollerbox(outlid=1,x=h, y=b, h=l);

	*U() {
		 // Deckel
		 Tx(-wand*3.5+6) Tz((akkuH+10)/2)Ty(-akkuB-39-22)Ry(90)
			mycontrollerbox(outlid=1);
		h_xt90halter=38;
		*Tx(-h_xt90halter+4*wand) Ty(-akkuB/2+10) Tz(akkuH/4+5) Ry(90) 
			Cu(40, 25, h_xt90halter);

		// xt90 halter
		*Tz(-wand-1) Tx(-(akkuL+rund*2+akkuB*1.5-14)/2) 
		*D() {
			Tz(40) Tx(97) Ty(-akkuB/4) Ry(90) 
				Cy(r1=12, r2=23, h=20, center=true);
			Tz(40) Tx(100) Ty(-akkuB/3) Ry(90)  xt90();
		}
	}
}

module mycontrollerbox(outbox=0, outlid=0, x,y,h)
{

if(outbox) T(-x/2, -y/2, -(h+wand)/2)
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
	outbox=outbox, outlid=0
);
if(outlid) Rx(180) T(-x/2, -y-y/2-12, -(wand))
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
	outbox=0, outlid=outlid
);
}