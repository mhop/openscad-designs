
use <lib/shortcuts.scad>

rahmen();

module rahmen()
{
	rg=28/2;
	rk=13/2;
	strebZ=-rk;

// Hilfslinien
//Tx(20) Tz(230/2) Cu(10,10,230);
//Tx(220) Tz(155/2) Cu(10,10,155);

//translate([220,0,0]) rotate([0,10,0])cube([5,5,130]);
color("orange", 1.0) {


// Sitzrohr
rotate([0,4,0])
translate([-rg,0,-50])
cylinder(r=rg,h=400, center=1);
// Oberrohr
Tx(500) Tz(75)
rotate([0,-70,0])
cylinder(r=rg,h=600, center=1);

	
// Streben
translate([-150,49,strebZ])
rotate([0,90,-2.5])
cylinder(r=rk,h=500,center=1);

translate([-150,-49, strebZ])
rotate([0,90,2.5])
cylinder(r=rk,h=500, center=1);

steg(x=-rg/2, l=96);

// Flaschenhalterstege
s1x=160;
s2x=225;
steg(x=s1x, l=83);
steg(x=s2x, l=79);
}


module steg(x,l)
{
	translate([x-rk,l/2, strebZ])
	rotate([90,0,0])
	cylinder(r=rk,h=l, center=1);
}


}

