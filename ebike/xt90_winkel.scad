

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

D() {
import("XT90ConnectionPlate01.stl");
    Tx(19.7) Ty(-5) Cu(20,20,20);
    Tx(-29) Ty(9) Cu(20,20,20);
}
Ty(-6.2) Tz(-8) 
{
    D() {
    Rx(-90) import("XT90ConnectionPlate01.stl");
    Tz(15.0) Cu(60,30,30);
    }
    Tx(-5) Tz(-1.5) Cu(25,15,4);
}
