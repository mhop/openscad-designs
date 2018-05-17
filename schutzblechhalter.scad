/*
 Schutzblechhalter
 
    by Marc Hoppe (mhop@posteo.de), 2018

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

r=47.5/2+0.5;   // Radius Schutzblech/Reifenbreite
rr=1.9;         // Radius der Rundung der Haken
b=20;           // Breite des Halters
r_rund=0.5;
dick=2;
w=140;
scaleVert=1.1;
r_langloch=5.5/2;
d_langloch=5;

wk=(180-140)/2;

D() {
	U() {
		scale([1,scaleVert,1]) rundung();
		Ty(20/2)    rounded_cube(18,b,10, r=1);
		Ty(4/2-0.2) rounded_cube(20,4,20, r=1);
	}
	Ty(12) Rz(90) langloch(r=r_langloch, d=d_langloch, h=2*b);
}

module rundung()
{
	Ty(-r) Rz((180-w)/2)rounded_ring(ri=r, h=b, b=dick, rr=r_rund, w=w);
	Tx((r-rr)*cos(wk)) Ty(-(r-r*sin(wk))) Rz(180+wk) 
		rounded_ring(ri=rr, h=b, b=dick*0.9, rr=r_rund, w=180);
	Tx(-(r-rr)*cos(wk)) Ty(-(r-r*sin(wk))) Rz(180-wk) 
		rounded_ring(ri=rr, h=b, b=dick*0.9, rr=r_rund, w=180);
}
