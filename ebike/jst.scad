
use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>


*T(-200, 903,0) import("/Users/marc/Documents/3d/openscad-designs/lib/connector-JST_B2to8B-XH-A.stl");
jst(4);

module jst(n=3) {
    B=1.9+n*2;
    Ty() Cu(B, 6, 4.5);
    if(n%2==1) {
        pin(0);
        for(i = [1:n/2]) MMx() pin(i*2);
    }
    else {
        for(i = [0:n/2]) MMx() pin(i*2-1);
    }
}



module pin(d)
{
 Tx(d) Ty(-3.4) Tz(4.5/2-1.7) Cu(0.5, 3.4*2, 0.5);
}
