

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

r=3.2/2;

module roh()
{
D() {
import("XT90ConnectionPlate01.stl");
    Tx(19.7) Ty(-5) Cu(20,20,20);
    Tx(-29) Ty(9) Cu(20,20,20);
    *Tx(-21.2) Ty(-9.6) Tz(7) Rx(0) Rz(30) Cy(r=0.866*(7/2)+0.2, $fn=6, h=10);
}
}

module platte()
{
    D() {
        Tx(-8) Ty(-5.3) Tz(-7) Cu(50, 17.7, 3);
        Tx(-17) Ty(-10) Tz(-7) Cu(15,11,4);
    }
}

D() {
U() {
    roh();
    platte();
}
Tx(-8) Ty(-6) Tz(-10) Cu(50.1, 20, 3);
Tx(-28.5) Ty(-6) Tz(-2) Rx(0) Rz(30) {
    Cy(r=0.866*(7/2)+0.2, $fn=6, h=10);
    Tz(-5) Cy(r=r, $fn=6, h=10, $fn=60);
}
Tx(+13) Ty(-6) Tz(-2) Rx(0) Rz(30) {
    Cy(r=0.866*(7/2)+0.2, $fn=6, h=10);
    Tz(-5) Cy(r=r, $fn=6, h=10, $fn=60);
}
}



*Ty(-6.2) Tz(-8) 
{
    D() {
    Rx(-90) import("XT90ConnectionPlate01.stl");
    Tz(15.0) Cu(60,30,30);
    }
    Tx(-5) Tz(-1.5) Cu(25,15,4);
}
