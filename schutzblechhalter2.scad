/*
 Schutzblechhalter
 
    Autor: Marc Hoppe (mhop@posteo.de), Bielefeld 2018

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

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

$fn=100;

// Schutzblechklammer
klam_r=47.5/2+0.5;   // Radius Schutzblech/Reifenbreite
klam_rr=1.9;         // Radius der Rundung der Haken
klam_b=20;           // Breite des Halters
klam_r_rund=0.5;
klam_dick=2;
klam_w=140;
klam_scaleVert=1.05;

// Befestigung
fest_r_langloch=5.5/2;
fest_dick=10;
fest_h=22;
fest_d_langloch=fest_h-fest_r_langloch*5;

// ----------------------------------------------

wk=(180-klam_w)/2;

MMx() 
{
Tx(-klam_b/2-3) 
Ty(0.2) 
Tz(-klam_b/4)
Ry(180)
henkel_halb(
	h=8,
	b=3,
	ri=0.5,
	rr=0.1,
	L=15,
	H=11
);
}


D() {
	U() {
		scale([1, klam_scaleVert, 1]) rundung();
		Ty(fest_h/2) Tz(klam_b/2-fest_dick/2)   rounded_cube(klam_b, fest_h, fest_dick, r=1);
		Ty(4/2-0.2) rounded_cube(klam_b, 4, klam_b, r=1);
	}
	Ty(fest_h/2+1) Rz(90) langloch(r=fest_r_langloch, d=fest_d_langloch, h=2*klam_b);
}

module rundung()
{
	Ty(-klam_r) Rz((180-klam_w)/2)
		rounded_ring(ri=klam_r, h=klam_b, b=klam_dick, rr=klam_r_rund, w=klam_w);
	Tx((klam_r-klam_rr)*cos(wk)) Ty(-(klam_r-klam_r*sin(wk))) Rz(180+wk) 
		rounded_ring(ri=klam_rr, h=klam_b, b=klam_dick*0.9, rr=klam_r_rund, w=180);
	Tx(-(klam_r-klam_rr)*cos(wk)) Ty(-(klam_r-klam_r*sin(wk))) Rz(180-wk) 
		rounded_ring(ri=klam_rr, h=klam_b, b=klam_dick*0.9, rr=klam_r_rund, w=180);
}
