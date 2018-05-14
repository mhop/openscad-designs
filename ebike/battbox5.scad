
use <lib/shortcuts.scad>;
use <lib/box_complete.scad>;
use <lib/slide.scad>;
use <lib/misc.scad>;

use <xt90.scad>;
use <rahmen.scad>;
use <henkel.scad>;
use <vesc.scad>;
use <einschub.scad>;

akkuL=210;
akkuLk=175;
akkuHk=50;
akkuB=69;
akkuH=125;
rund=6;
wand=3;

view_ober=1;
view_unter=0;
view_mitte=1;

$fn=80;

*Rx(180) Rz(180)akkuK();
*Tx(akkuL/2+17) Tz(akkuH/2+20) Rz(180) Rx(180) rahmen();

D() {

{

*akkubox();

// Unterplatte -----------
*Ty((akkuB+30)) Tz((wand+6))
{	D() {
		unterplatte();
	Ty(-akkuB-akkuB/2+5) Tz(akkuH/2+6) Cu(akkuL, 12, 8);
	}
}

// Controllerbox --------
*Tz(wand+1) Tx((akkuL+rund*2+akkuB*1.5-13)/2) 
	controllerbox();
h_up=wand*3;
l_up=akkuL*1.5;
b_up=akkuB+2*rund+2*wand;
l_einschub=70;
*Tx(l_up/2-l_einschub/2-75)Tz((akkuH/2+2*rund+h_up/2)-1) Rz(0)
einschub(l_up/2-l_einschub/2, 0, l_einschub, 30, h_up) 
	rounded_cube(l=l_up, h=h_up, b=b_up, r=rund/2);


Tz(78) Tx(0) {
	D() {
	halter();
			// Loecher für Flaschenhalterung
			Tx(-31) langloch(r=3, d=8, h=30);
			Tx(-96) langloch(r=3, d=8, h=30);
			Tx(-akkuL/2+7) Ty(20.5)Tz(2*wand+5/2-2) Cu(23,15,5);
			Tx(-akkuL/2+7) Ty(-20.5) Tz(2*wand+5/2-2) Cu(23,15,5);
			Tx(-akkuL/2-4) Ty(0) Tz(2*wand+5/2-2) Cu(5,50,5);
	}
}

}

//Tx(akkuL/2+17) Tz(akkuH/2+20) Rz(180) Rx(180) rahmen();


}

// --------------------------------------------------------------

module halter()
{
	schieneB=akkuB;
	schieneL=15;
	blockL=10;
	h=wand*3;
	l=akkuL+wand*2;
	block1x=blockL+wand;
	block2x=l/2-schieneL/2;
	block3x=l-(schieneL+blockL+wand);

	Rx(180) Rz(180) Tx(-l/2)  {
	Tx(block1x-blockL/2) Cu(blockL,schieneB+wand*2, h);
	Tx(block2x-blockL/2) Cu(blockL,schieneB+wand*2, h);
	Tx(block3x-blockL/2) Cu(blockL,schieneB+wand*2, h);
	D() {
			T(l-1,0,h-1.5) R(180,0,90)
					slide(
					Slide_length = l,
					Slide_width = schieneB+wand*3,
					Slide_height=3*wand,
					View_parts = 5//////.. 1=View Rail  2=View carriage 3= carriage for printing 4=assembly
					);
		    // Schienen anschraegen
			l1=block2x-block1x-schieneL-blockL/2;
			l2=block3x-block2x-schieneL-blockL/2;
			l3=l-block3x--schieneL-blockL/2;
			Tx(block1x+schieneL+l1/2)   Ty(-schieneB/2+5) Tz(5) Rx(+10) Cu(l1, 10, 10);
			Tx(block1x+schieneL+l1/2)   Ty(+schieneB/2-5) Tz(5) Rx(-10) Cu(l1, 10, 10);
			Tx(block2x+schieneL+l2/2+0.1) Ty(-schieneB/2+5) Tz(5) Rx(+10) Cu(l2, 10, 10);
			Tx(block2x+schieneL+l2/2+0.1) Ty(+schieneB/2-5) Tz(5) Rx(-10) Cu(l2, 10, 10);
			Tx(block3x+schieneL+l3/2+0.1) Ty(-schieneB/2+5) Tz(5) Rx(+10) Cu(l3, 10, 10);
			Tx(block3x+schieneL+l3/2+0.1) Ty(+schieneB/2-5) Tz(5) Rx(-10) Cu(l3, 10, 10);
		}
	}

	h_up=wand*3;
	l_up=akkuL*1.5-2;
	b_up=akkuB+2*rund+2*wand;
	Tz(0) Tx(49) {
		D() {
			ausschnitt(l_up/2-70/2+0.1, 0 ,70, 30, h_up)
				rounded_cube(l=l_up, h=h_up, b=b_up, r=rund/2);
			Tx(-55) Tz(-h_up/2+h/2-0.1) Cu(l, schieneB+wand*2, h);
			Tx(-l_up/2+27/2) Tz(h/2) Cu(27, 15, h);
			// einschub hinten
		}
	}
	//rounded_box(l=l_up, h=h_up, b=b_up, r=rund/2);
}

// --------------------------------------------------------------

module unterplatte()
{
	schieneB=akkuB;

	l=akkuL+2*wand;
	b=akkuB+2*wand+2*rund;
	h=6*rund;


	Rx(180) I() {
		mybox(outlid=1);
		Tx(0)Ty(b+12) Tz(-46.2)  
		D() {
			rounded_box(l=l, b=b, h=h, r=rund*0.8);
			Tx(  l/2-rund)  Ty(  b/2-rund)  Tz(-h/2) Cy(r=6, h=5);
			Tx(-(l/2-rund)) Ty(  b/2-rund)  Tz(-h/2) Cy(r=6, h=5);
			Tx(  l/2-rund)  Ty(-(b/2-rund)) Tz(-h/2) Cy(r=6, h=5);
			Tx(-(l/2-rund)) Ty(-(b/2-rund)) Tz(-h/2) Cy(r=6, h=5);
		}
	}
	
	
	
    // Schienen
	Ty(-schieneB/2-b/2-20) Tz(akkuH/2+wand+0.1) 
	{
		D() {
			U(){
				Tx(-(akkuL/2-(30-10)/2-30))  Tz(-4.5) Rz(-90) 
					slide(
					Slide_length = 30+10,
					Slide_width = schieneB,
					Slide_height=3*wand,
					View_parts = 1//////.. 1=View Rail  2=View carriage 3= carriage for printing 4=assembly
					);
				Tx(+akkuL/2-30/2-10) Tz(-4.5) Rz(-90) 
					slide(
					Slide_length = 30,
					Slide_width = schieneB,
					Slide_height=3*wand,
					View_parts = 1//////.. 1=View Rail  2=View carriage 3= carriage for printing 4=assembly
					);
				Tx(0) Tz(-4.5)Rz(-90) 
					slide(
					Slide_length = 30,
					Slide_width = schieneB,
					Slide_height=3*wand,
					View_parts = 1//////.. 1=View Rail  2=View carriage 3= carriage for printing 4=assembly
					);
				}
				Tx(-(akkuL/2-15/2)-wand) Ty(akkuB/2+3) Tz(2*wand) Cu(15,15,25);
			Tx(-(akkuL/2-15/2)-wand) Ty(-akkuB/2-3) Tz(2*wand) Cu(15,15,25);
		}
	}

}

// --------------------------------------------------------------

module akkubox()
{
	D() {
		U() {
			box_oben_ohne();
			oben_abrunden();
			Tx(-akkuL/2-wand-akkuB/4) Tz(5) Ry(90) Rx(-90) 
				henkel(L=akkuH*.9, H=akkuB/2, ri=akkuB/6, h=akkuB/3, b=3, rr=3);
			Tz(40) Tx(97) Ty(-akkuB/4) Ry(90) 
				Cy(r1=12, r2=23, h=20, center=true);
		}
		//Tz(40) Tx(100) Ty(-akkuB/3) Ry(90)  xt90();
	}
}


module box_oben_ohne()
{
D() {
	mybox(outbox=1);
	Tz(-akkuH/2-wand+2)Cu([300,300,wand*2]);
}
}

module oben_abrunden()
{
Tz(-rund+2) 
D() {
	rounded_box(l=akkuL+wand*2, b=akkuB+(rund+wand)*2, h=akkuH, r=rund, w=wand);
	Tz(akkuH/2-rund)Cu([300,300,rund*2]);
}
}

module henkel_alt()
{
Tz(-1.5)
D() {
Tx(-69) Rx(90) donut(r=65, rr=10);
	Tx(-(akkuL/2-100)) Cu([200,200,200]);
}
}

module myroundedBox() 
{

	boxL=akkuL+wand*2;
	boxB=akkuB+rund*2+wand*2;

	T(boxL/2,boxB/2,0) ;

	module dbox()
	{
		dboxL=boxL+wand*2;
		dboxB=boxB+wand*2;
		T(dboxL/2-wand,dboxB/2-wand,-0) ;
	}

	D() {
		mybox(outbox=1);
		dbox();
		//T(-0.1,-0.1,-0.1) Cu([akkuL*2,akkuB*2,wand*1.6]);
	}
}

module mybox(outbox=0, outlid=0)
{
	x=akkuL+wand*2;
	y=akkuB+rund*2+wand*2;
	h=akkuH;
T(-x/2, -y/2, -(h+wand)/2)
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

module boxwuerfel() 
{
	D() {
		fx=(akkuL+50+wand*2)/(akkuL+50);
		fy=(akkuB+wand*2)/akkuB;
		fz=(akkuH+wand*2)/akkuH;
		
		scale([fx,fy,fz]) boxgriff();
		Tx(wand)T(akkuL/2, 0, akkuH/2) box();
		//Tx(wand) boxgriff();
		Tz(-5) Cu([500,200,11]);
	}
}


module boxgriff() 
{
	D(){
		box2();
		Tz(akkuH/2) Tx(255) S([2, 4.6, 4.5]) Rx(90) griffmulde();
	}
}

module griffmulde()
{
	D() {
		Cy(r=20, h=20);
		donut(r=23, rr=10);
		Tx(-4)donut(r=15, rr=6.2);
	}
}

module donut(r=20, rr=10)
{
	rotate_extrude(convexity = 10) Tx(r) Ci(r = rr);
}


module box2()
{
	T(akkuL/2, 0, akkuH/2) box();
	T(akkuL-135,0,akkuH/2) box(x=10, scaleX=15);
}

module box(x=0, scaleX=akkuL*1.1/20)
{
  scale([scaleX,akkuB*1.3/20,(akkuH+6)/20]) {
      intersection()
      {
        Tx(x) cube([20,20,20], center=true);
        sphere(15);
        Ry(90) Cy(r=26/2, h=100);
      }
  }
}
  
  

  
module akkuK() 
{
	T(-akkuL/2, 0,-akkuH/2)
	color( "LightSkyBlue", 1.0 ) {
		translate([0, -akkuB/2,0]) {	
			translate([akkuL-akkuLk, 0,0]) cube([akkuLk, akkuB, akkuH]);
			translate([0, 0,akkuH-akkuHk]) cube([akkuL, akkuB, akkuHk]);
		}
	}
}
