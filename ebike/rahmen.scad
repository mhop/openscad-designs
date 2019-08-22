
use <lib/shortcuts.scad>
use <../weld.scad>

include <par.scad>;

*rahmen();

tret();


*U() {
Tx(-25) Tz(-20) Cu(5,60,5);
Tx(-95) Tz(-20) Cu(5,80,5);
Tx(-60) Tz(-20) Cu(75,5,5);
Tx(-70) Tz(150) Ry(270-w_sattel) Cu(5,5,270);
Tx(-79) Tz(120) Ry(-12) Cu(50,5,5);
}

module tret(weld=5, r_off=0) {
	color("lightyellow", 1.0) {
		l=200;
//weld(weld) {
	// Sattelrohr
	Ry(270-w_sattel) Tz(-2*l/2) Cy(r=r_sattel_muf+r_off,h=2*l);

	// Unterrohr
	Ry(270-w_unter) Tz(-l/2)Cy(r=r_unter_muf+r_off,h=l);

	// Tretlager
	Rx(90) Cy(r=r_tret+r_off, h=b_tret);

    // Kettenstreben
	Rz(-6) Ry(270-w_kett) Ty(+16) Tz(l/2)Cy(r=r_kett_muf+r_off, h=l);
	Rz(+6) Ry(270-w_kett) Ty(-16) Tz(l/2)Cy(r=r_kett_muf+r_off, h=l);
    // STEG
    steg_x=-95;
	Tx(steg_x) Tz(8) Rx(90) Cy(r=r_steg+r_off, h=50);
	//Tx(-25) Cu(5,10,5);
//}

    T(-130, 47, 290) R(0,90-4,-2.15) Cy(r=r_kett_muf+r_off,h=l);

Ty((b_tret/2-l_tret_loch1)) Ry(w_tret_loch) Cy(r=r_tret_loch+r_off, h=60);
Ty((b_tret/2-l_tret_loch2)) Ry(w_tret_loch+10) Cy(r=r_tret_loch+r_off, h=60);

    
    *Ty(-50) Tx(-r_blech+10-90) Ry(30) Rx(90) 
          RiS(R=r_blech-10+r_off, r=50, h= 100, w1 = 30, $fn=100); 
    Tx(-r_blech+steg_x) Tz(40) Ry(45) Rx(90) RiS(R=r_blech+r_off, r=50, h= 100, w1 = 35, $fn=100); 
	} // color
}

module rahmen()
{
	rk=13.0/2;
	strebZ=-rk;

// Hilfslinien
//Tx(-62) Cu(64,5,5);
Tx(-96) Cu(5,5,100);
//Tx(20) Tz(230/2) Cu(10,10,230);
//Tx(220) Tz(155/2) Cu(10,10,155);
//translate([220,0,0]) rotate([0,10,0])cube([5,5,130]);

color("orange", 1.0) {


// Sattelrohr
rotate([0,4,0])
translate([-r_sattel,0,-380])
cylinder(r=r_sattel,h=650, center=1);
// Oberrohr
Tx(500) Tz(75)
rotate([0,-70,0])
cylinder(r=r_ober,h=600, center=1);
// Unterrohr
Tx(-40) Tz(-300)
rotate([0,+70,0])
cylinder(r=r_unter,h=900, center=1);

// Tretlager
Tx(-30) Ty(73/2) Tz(-300)
rotate([90,0,0])
cylinder(r=r_tret,h=73, center=1);

	
// Streben
translate([-150,47,strebZ])
rotate([0,90,-2.15])
cylinder(r=rk,h=800,center=1);

translate([-150,-47, strebZ])
rotate([0,90,2.15])
cylinder(r=rk,h=800, center=1);

steg(x=-r_sattel/2, l=96);

// Flaschenhalterstege
s1x=160;
s2x=225;
steg(x=s1x, l=83);
steg(x=s2x, l=79);
}


module steg(x,l)
{
	translate([x-rk,l/2, strebZ])
	{
		rotate([90,0,0])
			cylinder(r=rk,h=l, center=1);
	}
	// Hilfslinien Flaschenhalterlöcher
	//Tx(x-rk) Cy(r=2, h=40);
}


}

