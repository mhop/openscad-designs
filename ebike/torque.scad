
use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>


$fn=100;

//ri=45.2/2; // holowtechradius
ri=45.3/2; // holowtechradius
ri2=36/2; // innenradius

ra=ri+2.5; // außenradius
rkabel=3.1/2;

h=8; // gesamthöhe
d=1; // Dicke Steg am Kabel

h2=3;

ringmy();

module hollowring() 
{
D() {
	U() {
			Cy(r = ra, h=h);
	}
	D() {
		Cy(r = ri, h=h+0.1);
		for (i = [0 : 15]) {
			//Rz(i * 360 / 16) T(0, ri, 0) Cy(r = 1.5, h=h+0.1);
			Rz(i * 360 / 16) T(0, ri+0.4, 0) Cy(r = 1.7, h=h+0.1);
		}
	}
}
}

module ringforum()
{
    D() {
    import("/Users/marc/Downloads/ERiderT9/ERider.stl");
    Tz(0) Ri(R=ra+5, r=ra+0.5, h=11);
    }
}

*hollowring();

module ringmy() {
Tz() D() {
    U() {
        hollowring();
        Tz(h/2-h2/2) Ri(R=ra, r=ri2, h=h2);
    }
    hull() {
        Tz(h/2-h2+0.9) Ty(ri) Rx(90) Cy(r=rkabel, h=20);
        Tz(-h) Ty(ri) Rx(90) Cy(r=rkabel, h=20);
    }
}
}