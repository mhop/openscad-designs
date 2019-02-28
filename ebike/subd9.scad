//

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

h=12;
r=3.5/2;

module spacer(h)
{
    /*D() {
        Tz(-2.5) Ty(-6.5) Tx(-15.7) import("DB9_Spacer_5mm_OS.STL");
        MMx() Tx(12.3) Cy(r=1.6, h=20);
    }
    */

    D() {
        Tz() Cu(35, 17, 1);
        MMx() Tx(12.3) Cy(r=r, h=10);
        hull() MMx() {
            Tx(6.2+1) Ty(3.3+1) Cy(r=2, h=10);
            Tx(7.4+1) Ty(-3.3-1) Cy(r=2, h=10);
        }
    }

}

module spacerh(h)
{
    
    Tz(+h/4) spacer();
    Tz(-h/4) spacer();
    Sz((h-1)/1) spacer();
}

*Tz(10) spacer();



D() {
    spacerh(h);    
    //Tx() Ty(-7) Cu(12.5, 4, 15);
    //MMx() Tx(12/2+12/2) Tz(5) Cu(12, 20, 10);
    Tx() Ty(-8) Cu(24, 4, 15);
    MMx() Tx(12/2+23/2) Tz(h/2) Cu(12, 20, h);
    Ty(-1.8) Tz(h/2) Cu(25, 16, h);
}


Ty(20)
Rx(180) D() {
    spacerh(h);    
    //My() Tx() Ty(-7) Cu(12.5,4,15);
    //MMx() Tx(12/2+12/2) Tz(-5) Cu(12,20,10);
    Tx() Ty(+8) Cu(24, 4, 15);
    MMx() Tx(12/2+23/2) Tz(-h/2) Cu(12, 20, h);
    Ty(1.8) Tz(-h/2) Cu(25, 16, h);
}

