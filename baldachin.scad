/*
	baldachin

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

// Typ (top mit skirt drucken)
part = "all"; // [base, top, all]

// Kugel Radius aussen
ra=40; // [20-200]

// Wanddicke
d=2; 

// Schraube Radius 
rs=2;

// Kabel Radius
rk=3.5;

//$fn=50;
$fn=200;

////////////////////////////////////////////////////////////////////////

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>
use <lib/bayonet container v1-2.scad>

// Kugel Radius innen
ri=ra-d; 

dbi=ra*2-ra*(1-cos(30))*2-9.3; // innendurchmesser bayonet


if (part == "base") {
    D() {
        unten();
        *Tz(-9)Cy(r=2*ra, h=50);
    }
} else if (part=="top") {
    Tz(0.1) 
    D() {
        oben();
        *Tz(46)Cy(r=2*ra, h=50);
    }
} else {
    unten();
    Tx(ra*2+5) Tz(-ra/2+3) oben();
}

module oben()
{
    Tz(ra/2+4) Rx(180) {
        D() {
            bayonet("base");
            Cy(r=2*ra, h=7);
        }
    }
    D() {
        halbkugel();
        Tz(0) Cy(r=ra+1, h=ra);
    }
    // Innenring zur besseren Haftung beim drucken
    Tz(ra/2-2.85) Ri(R=dbi/2, r=dbi/2-5, h=0.3);
}


module unten()
{
    // halbkugel
    D() {
        halbkugel();
        Tz(ra) Cy(r=ra+1, h=ra); // Kabeldurchführung
        Cy(r=dbi/2+3.5, h=ra+0.1); // Platz füe bayonet
    }

    // Bayonet
    Tz(ra/2-5)
    D() {
        bayonet("lid");
        //Unterteil abschneiden
        Cy(r=2*ra, h=3);
    }

    // Haltesteg
    D() {
        h=rs;
        r=rs;
        b=rs*7;
        d=rs*2;
        
        Tz(1) Cu(b,2*ra-1.5,h);
        Tz(h/2) {
            Rz(90)            langloch_senk(r=r, d=d, h=h+0.1);
            Ty(ra/3*2)        langloch_senk(r=r, d=d, h=h+0.1);
            Ty(-ra/3*2)Rz(90) langloch_senk(r=r, d=d, h=h+0.1);
        }
    }

    // schraege unter bayonet
    d=3;
    Tz(ra/2-5.5) D() {
        Cy(r1=dbi/2+6+d-3, r2=dbi/2+1+d, h=5);
        Cy(r1=dbi/2+6,     r2=dbi/2+0,   h=5.1);
    }

}

module bayonet(typ)
{
    bayonet_container(
        _part = typ, // [base,lid,separator]
        // minimum interior diameter of container
        _insideDiameter = dbi,
        // height of the container's interior space
        _interiorHeight = 1,
        // exterior style of the part
        _style = "round", // [round, round thin, tapered, polygon, crown, flipped crown]
        // for the polygon and crown styles (no effect on other styles)
        _numberOfSides = 9,
        // the thinnest walls of the container will use this value
        _minimumWallThickness = 1.0,
        // horizontal thickness used for the top of the lid or bottom of the base
        _topBottomThickness = 1.0,
        // height of the lip between lid and base
        _lipHeight = 3.0,
        // how much the locking bayonets protrude (larger values may be needed for larger diameters)
        _bayonetDepth = 1.6,
        // gap to place between moving parts to adjust how tightly the pieces fit together
        _partGap = 0.4,
        // use lower resolutions to adjust values, set to high for final rendering
        _resolution = $fn // [30:Low, 60:Medium, 120:High]
    );
}

module halbkugel()
{
    D() {
        D() {
            Tz(0)    SpH(r=ra);
            Tz(-0.1) SpH(r=ri);
        }
        Tx(ra) Tz(rk) Ry(90) Cy(r=rk, h=ra+0.1);
        Tx(ra)               Cu(2*rk,2*rk,2*rk);
    }
}