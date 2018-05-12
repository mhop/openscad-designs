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


$fn=80;


mirror([1,0,0])  main();




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
		//translate ([-50,(237+45)/2-45,-50]) cube( [100,200,100] );
		//translate ([50,(237+45)/2-45,-50]) rotate([0,0,180])cube( [100,200,100] );
	}
}

module kabelbinder2(r=20, b=4,h=2)
{
rotate([-0,-90,0])
teilring2(rr=r, d=b, eckig=h);
translate ([0,-r,0]) rotate([-90,0,90]) quaderabgerundet( l=r, x=b, y=h );
translate ([-r,-2*r,0]) rotate([-90,0,0]) quaderabgerundet( l=2*r, x=b, y=h );
translate ([-r,-b-r+h/4,0]) rotate([-90,0,0]) quaderabgerundet( l=b, x=2*b, y=2*b );
//translate ([0,-r-h,0]) cube( [b,h,r] );

//translate ([-b/2,-r-b-h/2,r]) cube( [2*b,2*b,2*b] );
}

module quaderabgerundet(l=20,x=4,y=2)
	linear_extrude(l)
	intersection() {
		rechteckovalisiert(x=x,y=y);
	}


module ringabgerundet(r=20,x=4,y=2)
{
	rotate_extrude()
	translate( [r,0,0] ) 
	intersection() {
		rechteckovalisiert(x=x,y=y);
	}
}

module rechteckovalisiert(x=4,y=2)
{
	intersection() {
		resize([y*2/3,x*1.5]) 
		circle(y/2);
		translate( [-y/2,-x/2,0] )
		square( [y,x]);
	}
}

module pie_slice(r=5.0,a=40) {
  $fn=64;
  intersection() {
    circle(r=r);
    square(r);
    rotate(a-90) square(r);
  }
}

module teilrohr(r1=10, r2=12, w=90, l=40)
linear_extrude(height=l)
difference() {
pie_slice(r=r2,a=w);
pie_slice(r=r1,a=w);
}




module rohr(abk,abg,yk) {
	translate ([0,-50,4]) rotate([-90,0,0])cylinder(r=15.9/2, h=290);

	translate ([0,242,4])
	platte2();

	translate ([0,-50,4])
	
	platte2();

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

module rohr2() {
	abk=9;
	abg=7;
	yk=195;

	difference() {
		rohr(abk,abg,yk);
		// Ringe für Kabelbinder
		rotate([25,0,0]) translate ([abg,0,20]) ringEckig(4,8);
		rotate([-6.5,0,0]) translate ([abk,yk,38]) ringEckig(4,6.3);
		// unterseite glätten
		translate ([-20,-55,-17]) cube( [50,300,15] );
		// Kabelbinder mitte
		translate ([1,80,1]) rotate([0,90,-90]) kabelbinder2(r=7, b=4, h=2);
		translate ([1,110,1]) rotate([0,90,-90]) kabelbinder2(r=7, b=4, h=2);
	
		translate ([13,-25,-18]) cube( [20,50,50] );
		translate ([13,170,-18]) cube( [20,50,50] );
		rotate([-6.5,0,0])translate ([8,195,16]) cube([10,10,40]);
		rotate([25,0,0])  translate ([8,-12,-5]) cube([10,10,40]);

		translate ([-5,222,-9]) cube( [10,10,10] );

translate ([0,260,12]) rotate([90,90,0])
teilrohr(r1=15,r2=25, w=90, l=350);

	}

}

module rack()
{
	r1=5.2; r2=8;
   translate ([0,-25,0]) rotate([-90,0,0])cylinder(r=r1, h=258);
   rotate([-6.5,0.6,0]) translate ([2*r1-2,195,-170]) cylinder(r=r1, h=230);
   rotate([25,0,0])   translate ([2*r1+1,0,-190])   cylinder(r=r2, h=220);
   rotate([25,0,0])   translate ([0,-74,-243])    cylinder(r=r1, h=220);

translate ([0,233,0])
rotate([90,-90,0])   
platte(r1=r1);
// Bogen
translate ([0,-25,-37.1])
teilring(d=2*r1);
// Schweisnähte nachbilden
 translate ([1,196,0])
 scale([1,1.2,1])
 rotate([0,90,0]) 
 cylinder(r=11/2, h=8);

 translate ([1,0,0])
 scale([1,1.2,1])
 rotate([0,90,0]) 
 cylinder(r=15/2, h=8);

// Hilfslinien
 rotate([25,0,0])   
 translate ([0,-69,-100])
 cube( [5,70,5] );

 rotate([0,0,0])   
 translate ([-20,0,0])
 cube( [5,190,5] );

 rotate([0,0,0])   
 translate ([-20,195,0])
 cube( [5,27.5,5] );
}

module platte2()
{
rotate([90,0,0])
hull() {
cylinder(r=16/2, h=5);
translate ([0,8,0])
cylinder(r=16/2, h=5);
}
}

module platte(r1=5, r2=4.5,d=4)
{
	a=9;
	hull() {
		$fn=20;
		translate ([0,0,0]) cylinder(r=r1,h=d);
		translate ([a,0,0]) cylinder(r=r2,h=d);
	}
    translate ([(r1-r2*0.9),0,d]) cylinder(r1=r1,r2=r2*0.9,h=2*d);
}

module kabelbinder(r=20, b=4,h=2)
{

teilring2(d=h,rr=r, eckig=b);
translate ([0,-r,r+h/2]) cube( [b,r,h] );
translate ([0,-r-h,0]) cube( [b,h,r] );

translate ([-b/2,-r-b-h/2,r]) cube( [2*b,2*b,2*b] );
}

module ringEckig(r, rr, r2=0){
    rotate_extrude()
    translate( [rr,0,0] ) 
	if(r2==0)square(r);
	else square( [r,r2]);
//square( [2,4]);

}

module ring(r, rr){
    rotate_extrude()
    translate( [rr,0,0] )circle( r );
}

module teilring2(rr=36, d=10, w=270, eckig=0)
{
	l=rr+d+eckig;

	difference() {
		translate ([0,0,0])
		rotate([0,90,0])
		if(eckig!=0) ringabgerundet(r=rr,x=d, y=eckig);
		else         ring(d/2,rr);

      if(w<90) {
		translate ([-l/2,0,-l]) 
		 rotate([0,0,0])   
		 cube( [l,l,l] );
	  }
	  if(w<180) {
		translate ([-l/2,0,0]) 
		 rotate([0,0,0])   
		 cube( [l,l,l] );
	  }
		translate ([-l/2,-l,0]) 
		 rotate([0,0,0])   
		 cube( [l,l,l] );

		 translate ([-0,-0,-0]) 
		 rotate([w,0,0])   
		 translate ([-l/2,-l,-l])
		 cube( [l,l,l] );

	}

	}


	module teilring(rr=36, d=10, w=25, eckig=0)
	{
	l=rr+d;

	difference() {
		translate ([0,0,1])
		rotate([0,90,0])
		if(eckig!=0) ringEckig(d/2,rr);
		else         ring(d/2,rr);

		translate ([-l/2,0,-l]) 
		 rotate([0,0,0])   
		 cube( [l,l,2*l] );

		 translate ([-0,-0,-0]) 
		 rotate([w,0,0])   
		 translate ([-l/2,-l,-l])
		 cube( [l,l,l] );
	}
	}

module Arc(r=r){
    difference(){
        ring(r);
        translate( [0,0, -2.5] ) cube( [5,5,5] );
    }
}
