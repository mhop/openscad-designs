

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>


//l=50;
//b=30;
//d=1.5;

//bb=2*d;
//dd=d*5;

platinenschiene(); 

module platinenschiene(l=50, b=30, d=1.5, bbn=2, ddn=5)
{
    bb=bbn*d;
    dd=ddn*d;

D() {
    Cu(l+bb, b+2*bb, dd);
    
    Tx(bb/2+d/2) Cu(l-d+0.1, b-2*d, dd+1);
    Tz((dd-d)/2-d)Tx(bb/2) Cu(l+0.1,b,d);
    Tz(dd/2-d) Tx(l/2) Cu(bb+0.1,b,d*2+0.1);
}
Tz(-dd/2+d/2) Tx(l/2) Cu(bb, b, d);
}
