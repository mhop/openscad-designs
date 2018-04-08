/*
 Bowdenzug-/Kabelhalter inspired by
 'Cable Guide' by 'rufuswenlock' (https://www.thingiverse.com/thing:931817)

    by Marc Hoppe, 2018

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

dr=30;
delta=0.7;

dr1=6.9;
dr2=0;
dl1=5;
dl2=3;

dbohr=5.1;

dsockel=10;
hsockel=1.9;

dsenk=10;
hsenk=3;


// -----------------------------------------------

h=max(dsockel, dsenk)+delta*2;
da=dr+max(dr1, dr2, dl1, dl2)*2+delta*2.5;

main();

// -----------------------------------------------

module main()
{
	difference() {
		cylinder(r=da/2,h=h, center=1);

		// Rohr weg
		translate([0,0,-1]) cylinder(r=dr/2,h=h+2, center=1);
		// untere Hälfte weg
		translate([-(da/2+5), 0, -1]) cube([da+10, da+5, h+2]);
		// Bohrung
		translate([0,-dr/2+2,h/2]) rotate([90,0,0]) cylinder(r=dbohr/2, da-dr+2, center=1);
		// Aussparung für Anlötsockel
		translate([0,-dr/2+10,h/2]) rotate([90,0,0]) cylinder(r=dsockel/2, hsockel+10, center=1);
		// Senkung für Schraube
		translate([0,-da/2+hsenk,h/2]) rotate([90,0,0]) cylinder(r=dsenk/2, hsenk+10, center=1);
		// Aussparungen für Kabel
		cables(dr1, dr2);
		mirror([1,0,0]) cables(dl1, dl2);
		}
}

// ---------------------------------------------------

module cables(d1,d2) {

	rges=dsockel/2+delta;

	w1deg=(rges+d1/2)/(dr/2)*180/3.14;
	cable(w=w1deg, d=d1);
	r1ges= d1!=0 ? rges+d1+delta : rges;

	w2deg=(r1ges+d2/2)/(dr/2)*180/3.14;
	cable(w=w2deg, d=d2);
	r2ges= d2!=0 ? r1ges+d2+delta : r1ges;

	w3deg=(r2ges)/(dr/2)*180/3.14;
	rotate([0,0,-90+w3deg]) {
		translate([0,0,-1]) cube([da,30,h+2]);
		r3=(da-dr)/4;
		translate([dr/2+r3,-r3,-1]) difference() {
			cube([r3*3,r3*3,h+2]);
			translate([0,0,-1])  cylinder(r=r3, h=h+4, center=1);
		}
	}
}

// -----------------------------------------------

module cable(w, d)
{
	rotate([0,0,-90+w]) {
		translate([dr/2+d/2,0,-1]) cylinder(r=d/2, h+2, center=1);
		translate([dr/2-(da-dr)/2+d/2,-d/2,-1]) cube([(da-dr)/2,d,h+2]);
	}
}
