
use <lib/shortcuts.scad>

ls=70;
bs=30;
h=10;

!ausschnitt(-ls/2-0.1, 0, l=ls, b=bs, h=h)
	Cu(ls*2,bs*2,h);

einschub(-ls/2-0.1, 0, l=ls, b=bs, h=h)
	Cy(r=30, h=10);

Tz(50)	Cy(r=30, h=10);

module einschub(dx, dy, l, b, h)
{
	d=h/3;
	dd=d*2;

	//Tx(-dx) Ty(-dy)
	D() {
		 I() {
			 children();
			 //Tx(dx-h) Ty(dy) Cu(l+2*h,b+2*h,h);
		 }
		 minkowski() {
			D() {
				children();
				Tx(dx) Ty(dy) {
					Tz(-0.1) Cu(l,b,h+1);
					Tz(-0.1) Cu(l,b+2*dd,d);
				}
			}
			Sp(0.2);
		}
	}
}

module ausschnitt(dx,dy,l,b,h) 
{
	d=h/3;
	dd=d*2;
	//Tx(-dx) Ty(-dy)
	D() {
		children();
		Tx(dx) Ty(dy) {
			Tz(-0.1) Cu(l,b,h+1);
			Tz(-0.1) Cu(l,b+2*dd,d);
		}
	}
}


