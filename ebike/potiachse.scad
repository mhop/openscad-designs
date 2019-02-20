

use <lib/shortcuts.scad>

$fn=80;

r1=6/2;
h1=34;
r2=3/2;
h2=1.5;
r3=2/2;
h3=3;

D() {
	U() {
		Tz(0)                   CyR(r=r1, h=h1, $fn=8, r_=0.2);
		Tz((h1+0.5)/2)          CyR(r=r2, h=h2, r_=0.2);
		Tz((h1+h2+h3)/2)        CuR(0.8, 2, h3, r=0);
		*Tz((h1+h2+h3)/2) Rz(90) CuR(0.8, 2, h3, r=0);
	}
	Tz(-h1/2) Rx(90) Cy(r1=0.4, r2=0.05, h=r1*5/4);
}