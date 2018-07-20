
use <lib/shortcuts.scad>

include <par.scad>;

rahmen();

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

