use <lib/shortcuts.scad>

$fn=80;

ri=85/2;
ra=95/2;
rk=6/2;

D() {
Cy(r=ra, h=2*rk);
Cy(r=ri, h=2*rk+0.1);
Tx(ri) Cu(2*ri,rk*2,rk*2+0.1);
}
