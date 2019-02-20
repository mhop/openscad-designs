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

a=90;
d=2;
b=44-1.5;
h=8;
r=6.5;

$fn=100;


roll_h=22;
roll_d=a/2+2;

disp_l=13;
disp_l2=30.5;
disp_d_loch=25.5;
disp_loch_r=1;
disp_b=10;
disp_b2=11;
disp_h=6;
disp_h2=7;
disp_h3=10.5;

aus_l=disp_l2+10.1;
aus_h=21;
aus_b=disp_b2+0.1;

r_schraube=3.1/2;
r_loch=4/2;
h_loch=7;

dome_r=r_loch+1.2;
dome_h=roll_h-disp_h2+d-0.2;

kabel_d=8;
kabel_x=70;
kabel_y=b-21;
kabel2_d=6;
kabel_d2=13;
kabel_h2=2.5;

kabel_e_x=a/2;
kabel_e_y=18;
kabel_e_d=9;
kabel_e_d2=14;

geh_r=0.8;
geh_dx=77;
geh_dx2=83;
geh_dy=39;

winkel_r=1.5;
winkel_d=40;

w=80;

*deckel();
seite_ausgang();
*seite_eingang();

*Tz(dome_h) display(); 

module display()
{
    C("grey")
    D() {
        U() {
            Tz(disp_h/2) Cu(disp_l, disp_b, disp_h);
            Cu(disp_l2, disp_b2, disp_h2-disp_h);
            Tz(-(disp_h3-disp_h2)/2) Cu(disp_l, disp_b, disp_h3-disp_h2);
        }
        MMx() Tx(disp_d_loch/2) Cy(r=disp_loch_r, h=5);
    }
}

module seite_eingang()
{
    D() {
        U() {
            basis();
            h=1;
            Tx(-a/2+kabel_e_x) Ty(-b/2+kabel_e_y) Tz(h/2+d/2) Cy(r=kabel_e_d2/2+1, h=h);
        }
        eingang_kabel();
    }
}

module seite_ausgang()
{
    D() {
        U() {
            basis();
            schraubendome();
            h=1;
            Tx(-a/2+kabel_x) Ty(-b/2+kabel_y) Tz(h/2+d/2) Cy(r=kabel_e_d2/2+1, h=h);
        }
        ausgang_kabel();
    }
}

module schraubendome()
{
   // Schraubendome
    MMx() {
        Tx(disp_d_loch/2) Tz(roll_h-aus_h/2)
        Tz(-(disp_h-d)) D() {
            U() {
                Cy(r=dome_r, h=dome_h);
                Tx(dome_r+2/2) Cu(dome_r*2+2, dome_r*2, dome_h);
                h=dome_h*4/5;
                Tx(dome_r) Ty(+dome_r) Tz(-(dome_h-h)/2) Cu(dome_r*4, aus_b-dome_r*2, h);
            }
            Tz((dome_h-h_loch-d)/2+1.1) Cy(r=r_loch, h=h_loch);
        }
    }
}

module ausgang_kabel()
{
    Tx(kabel_x-a/2) Ty(kabel_y-b/2)  Tz(-11+kabel_h2-0.1) {
        Cy(r=kabel_d/2, h=20);
        Tx(-10*sin(w)-kabel_d*cos(w)) Tz(10+kabel_d/2+kabel_d*cos(w)) Ry(-w) Cy(r=kabel_d/2, h=20);
        Tz(10) Rx(90) rohrbogen(r=kabel_d/2, w=w);
        Tz(10-kabel_h2/2) Cy(r=kabel_d2/2, h=kabel_h2);
    }
    My()Tx(-15) Ty(-6) Tz(kabel2_d*2/3)  Rz(25) Ry(90) Cy(r=kabel2_d/2, h=20);
}

module eingang_kabel()
{
    Tx(kabel_e_x-a/2) Ty(kabel_e_y-b/2)  Tz(-11+d/2+kabel_h2-0.1) {
        Tz(5) Cy(r=kabel_e_d/2, h=20);
        Tz(8-kabel_h2/2) Cy(r=kabel_e_d2/2, h=kabel_h2);
    }
    My() Tx(-15) Ty(-6) Tz(kabel2_d/2+d/2)  Rz(25) Ry(90) Cy(r=kabel2_d/2, h=20);
}

module basis() 
{
    D() {
        U() {
            // Bleche
            CuR(a, b, d, r=0.8);
            Ty(-b/2+d/2) Tz(h/2-d/2) CuR(a-20, d, h, r=0.5);
            // Aufroller
            MMx() Tx(roll_d/2) Tz(10) Cy(r=r, h=roll_h);
            Tz(10)                    Cu(roll_d, 2*r, roll_h);
        }
        // Ausschnitt voltmeter
        Ty(0) Tz(roll_h-aus_h/2+0.1) Cu(aus_l, aus_b, aus_h);
        // Schraubenlöcher
        MMx() Tx(roll_d/2) Tz(roll_h-h_loch/2+0.1) Cy(r=r_loch, h=h_loch);
        // Löcher gehäuseschrauben
        MMx() Tx(geh_dx/2) Ty(geh_dy/2) Cy(r=geh_r, h=2*d);
        MMx() Tx(geh_dx2/2) Ty(-geh_dy/2) Cy(r=geh_r, h=2*d);
        // Löcher winkel
        MMx() Tx(winkel_d/2) Ty(-b/2+d/2) Tz(h/2) Rx(90) Cy(r=winkel_r, h=2*d);
    }
}

module deckel()
{
    Tz(roll_h) {
        rr=7;
        D() {
            U() {
                MMy() MMx() Tx(a/2-rr) Ty(b/2-rr) Tz(0) CyR(r=rr, h=d, r_=0.5);
                CuR(a-2*rr, b, d, r=0.5);
                CuR(a, b-2*rr, d, r=0.5);
                // Ausschnitt Passung
                Ty(0) Tz(-(d/2+1/2)) Cu(aus_l-0.4, aus_b-0.4, 1);
            }
                // Ausschnitt Passung
                Ty(0) Tz(-(d/2+1/2)) Cu(aus_l-1, aus_b-1, 1.1);
            Cu(disp_l, disp_b, 2*d+0.1);
            MMx() Tx(roll_d/2) Tz(0.3) loch_senk(r=r_schraube);
        }
    }
}