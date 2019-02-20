

use <lib/shortcuts.scad>;
use <lib/mhop_lib.scad>;

use <rahmen.scad>;
include <par.scad>;

$fn=80;

r_rohr=22/2;
//r_delle=9/2;
r_kabel=(5+0.5)/2;
r_loch=3.5/2;

r_scheibe=67/2;


*tret();

//Tx(0)Ty(13)Tz(27) Rz(90) block();

D()  {
	hs=25;
	
	Ty(72/2-hs/2-1) {
		I() {
			Ty(hs*0.25/2) Sz(1.22) Rx(90) CyR(r1=r_scheibe, r2=r_scheibe-10, h=hs*0.75);
			Tx() Tz((r_scheibe+2)/2) Cu(100,hs,r_scheibe+2);
		}
		Ty(hs*0.25/2) Rx(90) CyR(r1=r_scheibe, r2=r_scheibe-10, h=hs*0.75);
		Tx(-8) Tz(20.5) CuR(50,hs,30);
		Ty(-15) Tz(-r_tret-r_kabel) CuR(15,50,r_kabel*2+2);
	}
	// Kabelbinder
	Tx(-2) Ty(20) Tz(27) Rz(90) wech();
	// Bowdenzüge
	Ty(r_unter/2) Rx(90) CyR(r=r_tret+r_kabel*2, h=r_kabel*2, r_=r_kabel);
	Ty(-r_unter/2) Rz(-20) Rx(90) CyR(r=r_tret+r_kabel*2, h=r_kabel*2, r_=r_kabel);
	Ty() Tz(-30)Cy(r=5/2, h=10);
	tret();
*Ty(12) Tz() Rx(90) 
{
	Ry(-5)To(r=r_kabel, R=r_tret+r_kabel, w2=w_unter+270, w1=w_unter+180);
	*Tx(-53.5) Ty() Rz(w_kett-10)Ry(90) Cy(r=r_kabel, h=100);
	Tx(+52) Ty(14.5) Tz(1.5) Rz(w_unter)Ry(90) Cy(r=r_kabel, h=100);
}
*Ty() Tz() Rx(90) 
{
	Ry(-5)To(r=r_kabel, R=r_tret+r_kabel, w2=w_unter+270, w1=w_unter+180);
	*Tx(-53.5) Ty() Rz(w_kett-10)Ry(90) Cy(r=r_kabel, h=100);
	Tx(+52) Ty(14.5) Tz(1.5) Rz(w_unter)Ry(90) Cy(r=r_kabel, h=100);
}
}
module rohr() {
	color("orange", 1.0) {

	Ry(8) D() {
		hull() {
			Tz(+18) Sy(1.3)Cy(r=r_rohr-1, h=0.1);
			Tz(-17) Sy(1.15)  Cy(r=r_rohr-1, h=0.1);
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

module wech()
{
			Tx(13.5) Ty(5)Cu(7,42,12);
			//Tx(13) Tz(10) Cu(7,35,10);
			Ry(90) Cy(r=r_loch, h=40);
			Ty(13.5) Ry(90) Cy(r=r_loch, h=40);
			Ty(-13.5) Ry(90) Cy(r=r_loch, h=40);
			Tx(3) Ty(-13.5) Ry(90) Cy(r=r_loch*2.5, h=10);
			Tx(15) Ty(-12.5) Ry(90) Cy(r=5, h=10);
			Tx(15) Ty(25.5) Sz(1.5) Ry(90) Cy(r=4, h=10);
			// Kabel
			Tx(6) Ty(26) Tz(1) R(0,98,0) Cy(r=r_kabel, h=40);
			// KAbelbinder
			Tx(-1) Ty(+23) Tz(-24) Rx(90) Sy(1.2) rounded_ring(ri=r_kett_muf+0.5, h=5, b=1.5, rr=0.1);
			Tx(-20) Ty(6) Tz(0) Sy(1) Rx(270-w_sattel) rounded_ring(ri=r_sattel_muf+2, h=5, b=1.5, rr=0.1);
			*Tx(-20) Ty(-26) Tz(-6) Sy(1) Rx(270-w_unter) rounded_ring(ri=r_unter_muf+2, h=5, b=1.5, rr=0.1);
}

module block()
	{
		D() {
			Tx(8) Ty(6) rounded_cube(20+6,50,30, r=1);
			wech();
		}
	}



*color("red", 1.0) {
	Tx(14) Ty(1)Cu(7.3,34,11);
}
	
	
*Tx(15) Ry(90) Rz(90) pasMount();

*D() {
Tx(-3)block();
rohr();

}

*color("green", 1.0) {
Tx(11)Cu(1,50,50);
Tx(11+9)Cu(1,50,50);
Tx(11-3)Cu(1,50,50);
}
