

use <lib/shortcuts.scad>;
use <lib/mhop_lib.scad>;

use <EbikePASMount.scad>;

$fn=80;

r_rohr=22/2;
r_delle=9/2;
r_kabel=(5+0.5)/2;
r_loch=3.5/2;

*rohr();

module rohr() {
	color("orange", 1.0) {

	Ry(5) D() {
		hull() {
			Tz(+16) Sy(1.2)Cy(r=r_rohr-1, h=0.1);
			Tz(-16) Sy(1.05)  Cy(r=r_rohr-1, h=0.1);
		}
		Tx(11.5) Tz(15)Cy(r=r_delle, h=30);
		}

		*Ty(50)Ry(3)
		D() {
			Sy(1.2) Cy(r=r_rohr, h=50);
			Tx(14) Cy(r=r_delle, h=51);
		}
	}
}

module block()
	{
		D() {
			Tx(8) Ty(6) rounded_cube(10+5,50,30, r=1);
			Tx(13.5) Ty(5)Cu(7,42,12);
			//Tx(13) Tz(10) Cu(7,35,10);
			Tx(8) Ty(21) Tz(-9) Rx(-26) Ry(20) Cy(r=r_kabel, h=26.5);
			Tx(0.5) Tz(10) Sy(1.2) rounded_ring(ri=r_rohr+2, h=5, b=1.5, rr=0.1);
			Tx(0) Tz(-9) Sy(1.2) rounded_ring(ri=r_rohr+2, h=5, b=1.5, rr=0.1);
			Ry(90) Cy(r=r_loch, h=40);
			Ty(13.5) Ry(90) Cy(r=r_loch, h=40);
			Ty(-13.5) Ry(90) Cy(r=r_loch, h=40);
			Tx(3) Ty(-13.5) Ry(90) Cy(r=r_loch*2.5, h=10);
			Tx(15) Ty(-12.5) Ry(90) Cy(r=5, h=10);
			Tx(15) Ty(25.5) Sz(1.5) Ry(90) Cy(r=4, h=10);
		}
	}



*color("red", 1.0) {
	Tx(14) Ty(1)Cu(7.3,34,11);
}
	
	
*Tx(15) Ry(90) Rz(90) pasMount();

D() {
Tx(-1)block();
rohr();

}

*color("green", 1.0) {
Tx(11)Cu(1,50,50);
Tx(11+9)Cu(1,50,50);
Tx(11-3)Cu(1,50,50);
}
