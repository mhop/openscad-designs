
use <shortcuts.scad>

*langloch();
henkel();

module MMx() { children(); mirror([1, 0, 0]) children(); }
module MMy() { children(); mirror([0, 1, 0]) children(); } 
module MMz() { children(); mirror([0, 0, 1]) children(); }

module langloch(r=2.5,d=8,h=20)
{
	hull() {
	Tx(-d/2) Cy(r=r, h=h);
	Tx(+d/2) Cy(r=r, h=h);
	}
}
	
module rounded_box(l,b,h,r,w)
{
	ri=r-w;
	off1=-w*2;
	off2=0;
	D() {
		rounded_cube(l=l+off2, b=b+off2, h=h+off2, r=r);
		rounded_cube(l=l+off1, b=b+off1, h=h+off1, r=ri);
	}
}


module rounded_cube(l,b,h,r=0.1)
{
	T(-l/2+r, -b/2+r, -h/2+r) { 
		d=2*r;
		hull() {
			Sp(r=r);
			Tx(l-d) Sp(r=r);
			Ty(b-d) Sp(r=r);
			Ty(b-d) Tx(l-d) Sp(r=r);
			Tz(h-d) Sp(r=r);
			Tz(h-d) Tx(l-d) Sp(r=r);
			Tz(h-d) Ty(b-d) Sp(r=r);
			Tz(h-d) Ty(b-d) Tx(l-d) Sp(r=r);
		}
	}
}

module zeppelin(r=5,h=20)
{
	Tz(h/2-r)    Sp(r=r);
	Tz(0)        Cy(r=r, h=h-2*r);
	Tz(-(h/2-r)) Sp(r=r);
}

module henkel(
	h=20,
	b=5,
	ri=10,
	rr=2,
	L=200,
	H=50
)
{
	hm=H-ri-b-2*rr;

	Ty(hm-H/2) {
	henkel_halb(h,b,ri,rr,L,H);
	Mx(1)
		henkel_halb(h,b,ri,rr,L,H);
	}
}

module henkel_halb(h,b,ri,rr,L,H)
	{
	lm=L-2*ri-4*rr-2*b;
	hm=H-ri-b-2*rr;

	Tx(lm/2) 
		rounded_ring(ri=ri, h=h, b=b, rr=rr, w=90);
	Ty(ri+b/2+rr/2) 
		rounded_block(h=h, b=b, l=lm, rr=rr);
	Ty(-hm/2) Tx(L/2-b/2-rr-rr/2) Rz(90) 
		rounded_block(h=h, b=b, l=hm, rr=rr);
	}

module rounded_ring(ri=100, h=50, b=10, rr=10, w=360)
{
	r=ri+rr/2;
	Tz(-h/2)
rotate_extrude(convexity = 10, angle=w) 
	Tx(r) { 
		Ci(r = rr) ;
		Ty(h) Ci(r=rr);
		Tx(b) Ci(r=rr);
		Tx(b) Ty(h) Ci(r=rr);
		Tx(b/2) Ty(h/2) square([b,2*rr+h], center=true);
		Tx(b/2) Ty(h/2) square([b+2*rr,h], center=true);
		
		
		}
}


module rounded_block(l=100, h=50, b=10, rr=10)
{
	Rx(90) Ry(90) Tx(-b/2) Tz(-l/2) Ty(-h/2) 
	linear_extrude(height=l) 
	{ 
		Ci(r = rr) ;
		Ty(h) Ci(r=rr);
		Tx(b) Ci(r=rr);
		Tx(b) Ty(h) Ci(r=rr);
		Tx(b/2) Ty(h/2) square([b,2*rr+h], center=true);
		Tx(b/2) Ty(h/2) square([b+2*rr,h], center=true);
		
		
		}
}
