/*
    (c) by Marc Hoppe, 2018

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

use<lib/shortcuts.scad>
use<lib/mhop_lib.scad>

$fn=80;



mirror([1,0,0])  
main();
*ringabgerundet();

*kabelbinder2();

// ----------------------------------

module main() 
{
	difference() {
		rohr2();
		rack();

		// ZUM TESTEN WEGLASSEN
		//translate ([-10,210,4])  cube( [20,20,15] );
		//translate ([-10,115,4])  cube( [20,70,15] );
		//translate ([-10,-40,4])  cube( [20,22,15] );
		//translate ([-10,10,4])  cube( [20,65,15] );
		//translate ([-10,90,4])  cube( [20,15,15] );

		// halb
		// hinten
		translate ([-50,(237+45)/2-45,-50]) cube( [100,200,100] );
		// vorn
		*translate ([50,(237+45)/2-45,-50]) rotate([0,0,180])cube( [100,200,100] );
	}
}

// ----------------------------------

module rohr2() {
	abk=9;
	abg=7;
	yk=195;

	D() {
		rohr(abk,abg,yk);
		// Ringe für Kabelbinder
		Rx(25,0,0) T(abg,0,20)  ringEckig(4,8);
		Rx(-6.5)   T(abk,yk,38) ringEckig(4,6.3);
		// unterseite glätten
		#T(-20,-70,-15.5) Cu(50,350,15, center=false);
		// Kabelbinder mitte
		Ty(15-15) {
			T(0, 80,-4.5) Sz(1.5)Ry(45) R(0,90,-90) kabelbinder2(r=9, b=4, h=2);
			Ty(-15)Tz(5) Ry(-190) Ty(95) Rx(90) ringabgerundet(r=8, x=8, y=5, w=160);
		}
		Ty(15-15) {
			T(0,110,-4.5) Sz(1.5)R(0,90,-90) kabelbinder2(r=9, b=4, h=2);
			Ty(-15)Tz(5) Ry(-190) Ty(125) Rx(90) ringabgerundet(r=8, x=8, y=5, w=160);
		}
		T(13,-25,-18) cube([20,50,50]);
		T(13,170,-18) cube([20,50,50]);
		Rx(-6.5,0,0) T(8,195,16) cube([10,10,40]);
		Rx(25)       T(8,-12,-5) cube([10,10,40]);

		T(-5,222,-9) cube([10,10,10]);

		T(0,260,12) R(90,90,0) teilrohr(r1=15,r2=25, w=90, l=350);
	}
}

// ----------------------------------

module rohr(abk,abg,yk) {
	T(0,-50,4) Rx(-90) cylinder(r=15.9/2, h=290);

	T(0,242,4) platte2();

	T(0,-50,4) platte2();

// senkrechte stummel
	rotate([-6.5,0,0])translate ([abk,yk,16]) { 
		difference() {
			cylinder(r=7, h=30);
			translate ([-10,4,-1]) cube([20,10,40]);
		}
	}
	rotate([25,0,0])translate ([abg,0,-9]) {
		difference() {
			cylinder(r=9, h=37);
			translate ([-10,-13,-1]) cube([20,10,40]);
		}
	}
}


// ----------------------------------

module kabelbinder2(r=20, b=4,h=2)
{
	Ry(90) teilring2(rr=r, d=b, eckig=h, w=360);
	*translate ([-12.5, -r+4.5, 0]) rotate([-90,0,50]) quaderabgerundet( l=r, x=b, y=h );
	*translate ([-r,-2*r,0]) rotate([-90,0,0]) quaderabgerundet( l=2*r, x=b, y=h );
	*translate ([-r-2,-b-r+h/4+12,0]) rotate([-90,0,-30]) quaderabgerundet( l=b, x=2*b, y=2*b );
}

// ----------------------------------

module quaderabgerundet(l=20,x=4,y=2)
	linear_extrude(l)
	intersection() {
		rechteckovalisiert(x=x,y=y);
	}

// ----------------------------------

module pie_slice(r=5.0,a=40) {
  $fn=64;
  intersection() {
    circle(r=r);
    square(r);
    rotate(a-90) square(r);
  }
}

// ----------------------------------

module teilrohr(r1=10, r2=12, w=90, l=40)
linear_extrude(height=l)
difference() {
pie_slice(r=r2,a=w);
pie_slice(r=r1,a=w);
}

// ----------------------------------

module rack()
{
	r1=5+1; r2=8+1;

	T(0,-25,0) Rx(-90) Cy(r=r1, h=258, center=false);
	R(-6.5,0.6,0) T(2*r1-2, 195, -170) cylinder(r=r1, h=230);
	R(25,0,0)     T(2*r1+1, 0,   -190) cylinder(r=r2, h=220);
	R(25,0,0)     T(0,     -74,  -243) cylinder(r=r1, h=220);

	T(0,233,0) R(90,-90,0) platte(r1=r1);
	
	// Bogen
	T(0,-25,-35.1) Rx(180) teilring(d=2*r1, w=120);
	
	// Schweisnähte nachbilden
	T(1,196,0) S(1, 1.2, 1) Ry(90) cylinder(r=11/2, h=8);
	Tx(1)      S(1, 1.2, 1) Ry(90) cylinder(r=15/2, h=8);

	// Hilfslinien
	Rx(25) T(0,-69,-100) cube( [5,70,5] );

	Tx(-20) cube( [5,190,5] );

	T(-20,195,0) cube( [5,27.5,5] );
}

// ----------------------------------

module platte2()
{
	Rx(90) hull() {
		cylinder(r=16/2, h=5);
		Ty(8) cylinder(r=16/2, h=5);
	}
}

// ----------------------------------

module platte(r1=5, r2=4.5,d=4)
{
	a=9;
	hull() {
		$fn=20;
		Tx(0) cylinder(r=r1,h=d);
		Tx(a) cylinder(r=r2,h=d);
	}
  T((r1-r2*0.9),0,d) cylinder(r1=r1,r2=r2*0.9,h=2*d);
}

// ----------------------------------

module kabelbinder(r=20, b=4,h=2)
{
/*Ry(-180) rounded_ring(ri=r-h/2, h=b, b=h, rr=0.01, w=270);
Tx(-r/2) Ty(-r) Cu(r,h,b);
Tx(-r) Ty(-r) Rz(90) Cu(2*r,h,b);
Tx(-r) Ty(-r-b/4) Cu(b*3/2, b, 2*b);
*/
	teilring2(d=h,rr=r, eckig=b);
	T(0,-r,r+h/2) cube( [b,r,h] );
	T(0,-r-h,0)   cube( [b,h,r] );
	T(-b/2,-r-b-h/2,r) cube( [2*b,2*b,2*b] );
}

// ----------------------------------

module ringEckig(r, rr, r2=0, w=45)
{
	rotate_extrude(abgle=w) Tx(rr) {
		if(r2==0)square(r);
		else     square([r,r2]);
	}
}

// ----------------------------------

module ring(r, rr, w)
{
	rotate_extrude(angle=w) Tx(rr) circle( r );
}

// ----------------------------------

module teilring2(rr=36, d=10, w=270, eckig=0)
{
	Ry(90) {
		if(eckig!=0) ringabgerundet(r=rr,x=d, w=w, y=eckig);
		else         ring(d/2,rr, w=w);
	}
}

// ----------------------------------

module teilring(rr=36, d=10, w=25, eckig=0)
{
	l=rr+d;

	Tz(1) Ry(90)
		if(eckig!=0) ringEckig(d/2, rr, w);
		else         ring(d/2, rr, w);
}

// ----------------------------------

module ringabgerundet(r=20,x=4,y=2, w=270)
{
	rotate_extrude(angle=w) Tx(r) I() rechteckovalisiert(x=x,y=y);
}

// ----------------------------------

module rechteckovalisiert(x=4,y=2)
{
	intersection() {
		resize([y*2/3,x*1.5]) 
		circle(y/2);
		translate( [-y/2,-x/2,0] )
		square( [y,x]);
	}
}

// ----------------------------------


module Arc(r=r){
    difference(){
        ring(r);
        translate( [0,0, -2.5] ) cube( [5,5,5] );
    }
}
