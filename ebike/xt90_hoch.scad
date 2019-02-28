

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

r=3.2/2;

module roh()
{
    D() {
        import("XT90ConnectionPlate01.stl");
        Tx(19.7) Ty(-5) Cu(20,20,20);
        Tx(-29) Ty(9) Cu(20,20,20);
    }
}

module platte()
{
    D() {
        Tx(-3.5) Ty() Tz(-9) Cu(45, 18, 4);
        Tx(15) Tz(-3.5) Rz(30) {
            Cy(r=0.866*(7/2)+0.2, $fn=6, h=10);
            Tz(-5) Cy(r=r, $fn=6, h=10, $fn=60);
        }
        Tx(-21.5) Tz(-3.5) Rz(30) {
            Cy(r=0.866*(7/2)+0.2, $fn=6, h=10);
            Tz(-5) Cy(r=r, $fn=6, h=10, $fn=60);
        }
        Tx(-4.6) Tz(-9) Cu(23,11,5);
    }
}

U() {
    Tz(14) Rx(90) roh();
    platte();

    Tz(-5) {
        MMy() Ty(7.3) Cu(20, 3.4, 10);
        Tx(8.5) Rz() Cu(18, 3.4, 10);
    }
}
