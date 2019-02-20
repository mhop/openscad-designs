
use <lib/shortcuts.scad>;
use <lib/mhop_lib.scad>;

include <par.scad>;
use <rahmen.scad>;

$fn=90;


r_kabel=(5+0.5)/2;
r_bowd=(4.5+0.5)/2;
r_koax=(3.5+0.5)/2;

*tret();

halter();

module halter()
{
	D()  {
		hs=15;
		
		Ty(72/2-hs/2-1) {
			// Pas-Halteblock
			Tx(-4.5) Ty(hs/(3*2))Tz(-18.5) CuR(52, hs*2/3, 35, r=1.5);
			// Haltebalken
			l_halt=b_tret*0.71;
			Ty(-l_halt/2) Tz() Rx(90) 
				RiS(R=r_tret+r_bowd*2+4, h=l_halt, w1=w_kett-90, w2=w_unter-90+4);
		}
		// Kabelbinder, pas-sensor, usw
		Tx(1.5) Ty(20) Tz(-27.5) Rz(90) wech();
		// Bowdenzüge
		Ty(10) Rz(+10) Rx(90) CyR(r=r_tret+r_kabel*2, h=r_bowd*2, r_=r_bowd);
		Ty(-14.5)  Rz(-15) Rx(90) CyR(r=r_tret+r_bowd*2, h=r_bowd*2, r_=r_bowd);
		Ty(-(b_tret/2-l_tret_loch1)/2-3.5) Rz(-0) Rx(90) CyR(r=r_tret+r_koax*2, h=r_koax*2, r_=r_koax);
		// befestigungs(lang)löcher
		ll=6;
		Ty((b_tret/2-l_tret_loch1)) Ry(w_tret_loch) Rz(90) langloch(r=r_tret_loch, h=70, d=5);
		D() {
			d_loch=l_tret_loch2-l_tret_loch1;
			d=d_loch+ll;
			Ty(b_tret/2-l_tret_loch1-d_loch/2) Ry(w_tret_loch) Rz(90) langloch(r=r_tret_loch*2.5, h=75, d=d);
			Ty(b_tret/2-l_tret_loch1-d_loch/2) Ry(w_tret_loch) Rz(90) langloch(r=r_tret_loch*2.5+0.1, h=55, d=d);
		}
		Ty((b_tret/2-l_tret_loch2)) Ry(w_tret_loch) Rz(90) langloch(r=r_tret_loch, h=70, d=ll);
		// Rahmenrohre
		tret();
	}
}

module wech()
{
	// PAS-Sensor Aussparung mit Abrundungen
	Tx(13.5) Ty(5) Cu(7,42,12);
	Tx(15) Ty(-12.5) Ry(90) Cy(r=5, h=10);
	Tx(15) Ty(25.5) Sz(1.5) Ry(90) Cy(r=4, h=10);
	// Loecher für Führungen und Verschraubung
	r_loch=3.5/2;
	Tx(10) {
		Ty()     Ry(90) Cy(r=r_loch, h=5);
		Ty(13.5) Ry(90) Cy(r=r_loch, h=5);
	}
	Tx(10) Ty(-13.5) Ry(90) Cy(r=r_loch, h=20);
	Tx(3)  Ty(-13.5) Ry(90) Cy(r=r_loch*2.5, h=10);
	// PAS Kabel
	Tx(8) Ty(24) Tz(2) R(0,110, 30) Cy(r=r_kabel, h=12);
	// Kabelbinder
	Tx(-1.5) Ty(+26) Tz(30) Rx(95) Sy(1.2) 
		rounded_ring(ri=r_kett_muf+0.5, h=5, b=1.5, rr=0.1);
}


