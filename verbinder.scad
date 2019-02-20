
use <lib/shortcuts.scad>


knick(60, 5, 30, 2, 90);

module knick(b=60, d=5, l=20, w=1.5, ang=10)
{

module rohr() {
	D() {
		Cu(b+2*w, l, d+2*w);
		intersection() {
		union() {
		Ty(-w/2)Cu(b, l, d);
		Rx(90)Tx(l-d+w/2)Cy(r=d, h=l+0.1);
		Rx(90)Tx(-(l-d+w/2))Cy(r=d, h=l+0.1);
		}
		Ty(-w/2)Cu(b+w*2, l+0.1, d);
		}
	
	
	}
}

Ty(-l/2) rohr();

Tz((d+2*w)/2) Ry(90)
	rotate_extrude(angle=ang) Tx((d+2*w)/2) Sq(d+w*2, b+2*w);

Tz((d+2*w)/2) Rx(ang)
	Tz(-(d+2*w)/2)Ty(l/2) Rx(180) rohr();

}

