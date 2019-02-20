/*
 
 
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

$fn=80;

l=20;
dl=10;
dh=2;
h=5;
b1=3;
b2=2;


//Ry(90) Cy(d=b2/2, h=l);
//Tx(Cu(l/3, b1, b1);

D() {
rounded_trapez(l1=l, l2=l, b1=b1,b2=b2,h=h,r=b2/2);
Tz(+h/2-dh/2-b2/3) Cu(dl,2*b1, dh); 
}
Tz(h/2-b2/2) Ry() Cy(r=b2/2, h=dl);