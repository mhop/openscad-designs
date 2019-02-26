

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

dw=2;

a=70;
a2=50-2*dw;
b=120;
b2=100;

d=5;
h=60+dw*2;

r=5;
rs=4/2;

*platte();

D() {
    U() {
        schraubdome();
        gehaeuse();
    }
    // unten abflachen
    Tz(-h/2) Cu (200, 200, 3);
    // aufschneiden
    *Tx(a/2-5) Cu (20, 200,200);
}


module aussen()
{
 rounded_trapez(l1=a,l2=a2, b1=b, b2=b2,h=h,r=1.5);
}

module schraubdome()
{
    I() {
        aussen();
        //Tz(-d/2) S((a-dw*2)/a, (b-dw*2)/b, 1) aussen();
        MMy() MMx() Tx(a/2-(r+1)) Ty(b/2-(r+1)) {
            D() {
                Cy(r=r, h=h);
                Tz(-0.1) Cy(r=rs, h=h);
            }
            //#Tz(-h/2+4.6) Cy(r=rs, h=6.5); // gewindeeinsatz
        }
    }
}

module platte()
{
Tz(-(h/2+d/2)) Cu(a, b, d);
}

module gehaeuse()
{
    D() {
        aussen();
        Tz(-d/2) S((a-dw*2)/a, (b-dw*2)/b, 1) aussen();
    }
}



