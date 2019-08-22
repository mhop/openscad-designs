

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>


strebenplatte();

module strebenplatte(l=80, b=20, d=3, s=5)
{
    I() {
        U() {
    sc_l=(l-2*s)/l;
    sc_b=(b-2*s)/b;
    w=atan((b-s)/(l-s));
    ls=l/cos(w);

    D() {
        Cu(l, b, d);
        S(sc_l, sc_b, 1) Cu(l, b, d+1);
    }

    Rz(w) Cu(ls, s, d);
    Rz(-w) Cu(ls, s, d);
}
        Cu(l, b, d);
    
    }
}
