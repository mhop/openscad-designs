/*
	ebike-Akkubox

    Autor: Marc Hoppe (mhop@posteo.de), Bielefeld 2018

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

use <lib/shortcuts.scad>;
use <lib/box_complete.scad>;
use <lib/slide.scad>;
use <lib/mhop_lib.scad>;

use <xt90.scad>;
use <rahmen.scad>;
use <vesc_platinenhalter.scad>;

include <par.scad>;

view_ober=1;
view_unter=0;
view_mitte=1;

$fn=80; 


Tx(akkuL/2+xt90b+20) Tz(akkuH/2-150) Ry(0) Rz(180) Rx(180) rahmen();

//Rx(180) Rz(180)akkuK();
Tx(-0) 
{
    akkuK();
}
xt90b=20;
xt90h=40;

gehL=akkuL+2*wand+2*rund+15;


D() {
Tx(8) Rx(90) mybox();
Tz(akkuH/2-rund) Tx((akkuL+xt90b*2)/2) Ty(akkuB/2) Cu(xt90b*2, akkuB, xt90h*2+rund);
}

Tz(akkuH/2-xt90h/2) Tx(akkuL/2+xt90b/2) Ty(-4) Ry(-90) import("XT90ConnectionPlate01.stl");

Ty(akkuB/2) {
    Tz(akkuH/2+wand-2)  myslide();
    Tz(-akkuH/5) Tx(gehL/2+6) Ry(90) myslide();
}

        Tx(95) Tz(akkuH/2+10) Rz(90) vesc_platinenhalter();





module myslide()
{
					slide(
						Slide_length = akkuB,
						Slide_width = 40,
						Slide_height=10,
						View_parts = 1
					);
}

module mybox(outbox=1, outlid=0)
{
	x=gehL;
	y=akkuH+2*wand;
	h=akkuB;
    
	
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


*D() {
	U() {
		*akkubox();

		// Unterplatte -----------
		*Ty((akkuB+30)) Tz((wand+6)) { 
			D() {
				unterplatte();
				Ty(-akkuB-akkuB/2+5) Tz(akkuH/2+6) Cu(akkuL, 12, 8);
			}
		}

		// Controllerbox --------
		*Tz(wand+1) Tx((akkuL+rund*2+cbL-7)/2) controllerbox(l=cbL);
        *Tx(60) Tz(130) Ry(90) controllerbox(l=cbL);

		// Halter ------------------------------
		Tz(78) Tx(0) {
				halter();
		}
	}

Tx(akkuL/2+17) Tz(akkuH/2+21) Rz(180) Rx(180) rahmen();
} // D()...

// --------------------------------------------------------------

module halter()
{
	ab_schieneB=akkuB/2;
	cb_schieneB=akkuB+wand*3;
	ab_schienel=30;
	ab_schieneL=akkuL+wand*2;
	blockL=10;
	h=wand*3;

	l_up=akkuL+cbL+rund;
	b_up=akkuB+2*rund+2*wand;

	ls=cbL-2*r_sattel;
	bs=akkuB;
  
	Rz(180) Tx(-cbL-rund*2)  {
		I() { 
			U() {
				AkkuboxSchieneAussen(l=ab_schieneL, b=ab_schieneB);
				// Block mit Ausschnitten
				Tx((l_up+50+-akkuL-wand*2)/2+rund*2) {
					D() {
						rounded_cube(l=l_up+50, h=h, b=b_up, r=rund/2);
						flasch_abstand=65;
						Tx(ab_schieneB/3)
					  Ty(wand+0.1) 	{
						Tx(0) Tz(-h/2+h/2-0.1) 
							Cu(ab_schieneB-wand, cb_schieneB+wand, h*2);
						Tx(ab_schieneB*2) Tz(-h/2+h/2-0.1) 
							Cu(ab_schieneB-wand, cb_schieneB+wand, h*2);
						Tx(-ab_schieneB*2) Tz(-h/2+h/2-0.1) 
							Cu(ab_schieneB-wand, cb_schieneB+wand, h*2);
						}
						Tx(-((l_up+50)/2-ls/2)) Cu(ls,cb_schieneB-2*wand,h+10.1);
					}
					ControllerboxSchieneAussen(ls, cb_schieneB);
				}
			}
			*Tx((l_up-ab_schieneL)/2+rund*2) {
				rounded_cube(l=l_up, h=h, b=b_up, r=rund/2);
				Tx(l_up/2+20/4) Tz(wand)Cu(20,bs*0.9,wand);
			}
		} // I()
	}
	
	module ControllerboxSchieneAussen(l,b)
	{
		Tx(-(l_up/2)+0.2) Tz(-h+wand/2) {
			D() {
			Rz(90) 
			slide(
				Slide_length = l,
				Slide_width = b,
				Slide_height=h,
				View_parts = 5
			);
			dy=9.8;
			Tx(l/2) Ty(+(b/2-dy)) Tz(2) Rx(+10) Cu(l/2, 10, 10);
			Tx(l/2) Ty(-(b/2-dy)) Tz(2) Rx(-10) Cu(l/2, 10, 10);
			}
		}
	}
	
	module AkkuboxSchieneAussen(l,b)
	{
		block1x=blockL;
		block2x=l/2-ab_schienel/2;
		block3x=l-(ab_schienel+blockL+wand);

		Rx(180) {
			// Stop-Blöcke 
			//Tx(block1x-blockL/2) Cu(blockL, b-wand, h);
			//Tx(block2x-blockL/2) Cu(blockL, b-wand, h);
			//Tx(block3x-blockL/2) Cu(blockL, b-wand, h);
			//D() {
			Tx(l-b-b/2) Ty(-akkuB/2-wand){
				T(0,0,h-1.7) R(180,0,0)
					slide(
						Slide_length = akkuB,
						Slide_width = b,
						Slide_height=h,
						View_parts = 5
					);
				T(-2*b,0,h-1.7) R(180,0,0)
					slide(
						Slide_length = akkuB,
						Slide_width = b,
						Slide_height=h,
						View_parts = 5
					);
				T(-4*b,0,h-1.7) R(180,0,0)
					slide(
						Slide_length = akkuB,
						Slide_width = b,
						Slide_height=h,
						View_parts = 5
					);
				}
/*				// Schienen anschraegen
				l1=block2x-block1x-ab_schienel-blockL/2;
				l2=block3x-block2x-ab_schienel-blockL/2;
				l3=l-block3x-ab_schienel-blockL/2;
				dy=9.8;
				Tx(block1x+ab_schienel+l1/2)     Ty(-(b/2-dy)) Tz(5) Rx(+10) Cu(l1, 10, 10);
				Tx(block1x+ab_schienel+l1/2)     Ty(+(b/2-dy)) Tz(5) Rx(-10) Cu(l1, 10, 10);
				Tx(block2x+ab_schienel+l2/2+0.1) Ty(-(b/2-dy)) Tz(5) Rx(+10) Cu(l2, 10, 10);
				Tx(block2x+ab_schienel+l2/2+0.1) Ty(+(b/2-dy)) Tz(5) Rx(-10) Cu(l2, 10, 10);
				Tx(block3x+ab_schienel+l3/2+0.1) Ty(-(b/2-dy)) Tz(5) Rx(+10) Cu(l3, 10, 10);
				Tx(block3x+ab_schienel+l3/2+0.1) Ty(+(b/2-dy)) Tz(5) Rx(-10) Cu(l3, 10, 10);
				*/
			//}
		}
	}
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
			Tx(-5) Tz(-88) Ry(0) Rx(-90) 
				henkel_knick(L=akkuH, H=40, ri=akkuB/6, h=akkuB/3, b=3, rr=3);
			*Tx(55) Tz(-85) Ry(0) Rx(-90) 
				henkel(L=akkuH*0.8, H=akkuB, ri=akkuB/6, h=akkuB/3, b=3, rr=3);
			Tz(40) Tx(97) Ty(-akkuB/4) Ry(90) 
				Cy(r1=12, r2=23, h=20, center=true);
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
			rounded_box(l=abL, b=abB, h=akkuH, r=rund, w=wand);
			Tz(akkuH/2-rund)Cu([300,300,rund*2]);
		}
	}

}

module myroundedBox() 
{
	T(abL/2, abB/2,0) ;

	module dbox()
	{
		dboxL=abL+wand*2;
		dboxB=abB+wand*2;
		T(dboxL/2-wand,dboxB/2-wand,-0) ;
	}

	D() {
		mybox(outbox=1);
		dbox();
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

module akkuK2() 
{
//	T(-akku2L/2, -akkuB/2,-akku2H/2)
	color( "LightSkyBlue", 1.0 ) {
			Cu(akku2L, akku2B, akku2H);
	}
}

/*

module henkel_alt()
{
Tz(-1.5)
D() {
Tx(-69) Rx(90) donut(r=65, rr=10);
	Tx(-(akkuL/2-100)) Cu([200,200,200]);
}
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
  
*/

  
