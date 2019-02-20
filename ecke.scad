

use <lib/shortcuts.scad>

b=80/2;
h=20;
d=2;
rr=1;
brett=5;
gurt=20/2;

//Tx(-b/2) Ty(-b/2) Tz(h/2) Ry(90) Cu(h,b,d);

//Tz(-b/2) Rx(90) Cu(b,b,d);
//Ty(-b/2) Cu(b,b,d);


D() {
	U() {
rotate_extrude(angle=90) Tx(-h-5-3*d)schnitt();
Ty(20) Rx(90) linear_extrude(20) Tx(-h-5-3*d)schnitt();
Ty() Rz(90) Rx(90) linear_extrude(20) Tx(-h-5-3*d)schnitt();
	}
#Tz(20) Tx() Ty() Cy(h=50, r=4);
}
module schnitt() 
{
rounded_rect(b,d);
Tx(4*h/3) rounded_rect(b,d);
Tx(4*h/3-(brett+d)) rounded_rect(b,d);
Ty(b) rounded_rect(d,4*h/3);
Tx(-5) Ty(gurt) rounded_rect(d,5);
}

module rounded_rect(h,b,rr=0.5)
{
		Ci(r = rr) ;
		Ty(h) Ci(r=rr);
		Tx(b) Ci(r=rr);
		Tx(b) Ty(h) Ci(r=rr);
		Tx(b/2) Ty(h/2) square([b,2*rr+h], center=true);
		Tx(b/2) Ty(h/2) square([b+2*rr,h], center=true);
}
