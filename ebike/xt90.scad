


use <lib/shortcuts.scad>;

xt90();


module xt90(l=30) {
	plug(l);
	

}

module xt90_Cube()
{
	D() {
	b=20;
	h=27;
	t=20;
	
	Tx(-h/2) Ty(-b/2) Tz(-t/2) cube([h,b,t]);
	plug();
}
}

module plug(l=30)
{
 /*
	gemessen: h=21,3
	b=10,8 (10,2)
	bschmal=5,5
	hkurz=18;
*/
h=l;
	
	
x1=18;
x2=21.3;
y1=2.5;
y2=8;
Tx(-x2/2) Ty(-y2/2)
hull() {
		      Cy(r=0.1, h=h);
Tx(x1)        Cy(r=0.1, h=h);
Tx(x2) Ty(y1) Cy(r=0.1, h=h);
Tx(x2) Ty(y2-y1) Cy(r=0.1, h=h);
Ty(y2) Cy(r=0.1, h=h);
Tx(x1) Ty(y2) Cy(r=0.1, h=h);
}
}

