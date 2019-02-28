

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

r=3.2/2;
$fn=80;
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
    D() {
        Tz(14) Rx(90) roh();
        Tz(18) Cu(50, 30, 12);
    }
    *platte();


    hg=40;
    w=45; //50;
    D() {
        Tz(3) Tx() Ry(w) Tz(2+hg/2) {
            Ty(1.4) Rz(90) CuR(15, 3, hg, r=1);
            Tx(1) Ty(8.9) Tz(-(hg)/2) Rz(90) Ry(-90) rounded_prism(hg,10,3,r=1); //Cu(19, 3.4, hg);
        }
        #Tx(1.5) Tz(5) Cu(10, 12, 20);
    }
    
}
