/*
	mhop_lib

    Autor: Marc Hoppe (mhop@posteo.de), Bielefeld 2018

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

// Requires openscad >= 2016.XX]

use <shortcuts.scad>

*langloch();
*henkel_knick();
*henkel_halb(	h=20,
	b=5,
	ri=10,
	rr=2,
	L=200,
	H=50);
rounded_prism(10,5,2, r=1);
*rounded_ring();
*rounded_trapez();
*loch_senk();
*rohrbogen();
$fn=50;



module MMx() { children(); mirror([1, 0, 0]) children(); }
module MMy() { children(); mirror([0, 1, 0]) children(); } 
module MMz() { children(); mirror([0, 0, 1]) children(); }

module loch_senk(r=1.5)
{
    h=r;
    Cy(r1=r, r2=2*r, h=h);
    Tz(-h+0.1)Cy(r=r, h=h);
}

module langloch_senk(r=2.5,d=8,h=20)
{
	hull() {
	Tx(-d/2) Cy(r1=r, r2=2*r+0.1, h=h+0.1);
	Tx(+d/2) Cy(r1=r, r2=2*r, h=h);
	}
}

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

module rounded_trapez(l1=15,l2=10,b1=8,b2=5,h=5,r=1)
{
    hull() MMy() {
        T(-(l1/2-r), +(b1/2-r),    -(h/2-r))   Sp(r=r);
        T(+l1/2-r,   +(b1/2-r),    -(h/2-r))   Sp(r=r);
        T(-(l2/2-r), +(b2/2-r),    h/2-r) Sp(r=r);
        T(+l2/2-r,   +(b2/2-r),    h/2-r) Sp(r=r);
    }
}

module rounded_prism(a,b,h,r=0.1)
{
	//T(-a/2+r, -b/2+r, -h/2+r) 
	T(r, r, r) 
	{ 
		d=2*r;
		hull() {
			Sp(r=r);
			Tx(a-d) Sp(r=r);
			Ty(b-d) Sp(r=r);
			Tz(h-d) Sp(r=r);
			Tz(h-d) Tx(a-d) Sp(r=r);
			Tz(h-d) Ty(b-d) Sp(r=r);
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

module henkel_knick(
	h=25,
	b=8,
	ri=10,
	rr=2,
	L=200,
	H=40,
  w=20
)
{
	hm=H-ri-b-2*rr;
	D() {
	U() {
	Ty(hm-H/2) {
	Tx(L/2-b-ri-2*rr)henkel_halb(h,b,ri,rr,L,H);
	Rz(w) Mx(1)
		Tx(L/2-b-ri-2*rr)henkel_halb(h,b,ri,rr,L,H);
  Ty() Rz(90)rounded_ring(ri=ri, h=h, b=b, rr=rr, w=w);
	}
}
	Ty(-L/2-H/2) Rx(-90) Cy(r=L, h=L);
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

module rohrbogen(r=5, w=30)
{
    Tx(-r)
rotate_extrude(angle=w) 
    Tx(r) { 
        Ci(r = r) ;
    }
}

module rounded_ring(ri=100, h=50, b=10, rr=10, w=360)
{
	r=ri+rr/2;
	Tz(-h/2)
rotate_extrude(angle=w) 
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
		Tx(rr) Ty(rr) Ci(r = rr) ;
		Tx(rr) Ty(h-rr) Ci(r=rr);
		Tx(b-rr) Tx(rr) Ci(r=rr);
		Tx(b-rr) Ty(h-rr) Ci(r=rr);
		Tx(b/2) Ty(h/2) square([b-2*rr,h], center=true);
		Tx(b/2) Ty(h/2) square([b,h-2*rr], center=true);
		
		
		}
}



module fillet(r=1.0,steps=3,include=true) 
{
    if(include) for (k=[0:$children-1]) 
    {
        children(k);
    }
    for (i=[0:$children-2] ) 
    {
        for(j=[i+1:$children-1] ) 
        {
            fillet_two(r=r,steps=steps) 
            {
                children(i);
                children(j);
                intersection() 
                {
                    children(i);
                    children(j);
                }
            }
        }
    }
}

module fillet_two(r=1.0,steps=3) 
{
    for(step=[1:steps]) 
    {
        hull() 
        {
            render() intersection() 
            {
                children(0);
                offset_3d(r=r*step/steps) children(2);
            }
            render() intersection() 
            {
                children(1);
                offset_3d(r=r*(steps-step+1)/steps) children(2);
            }
        }
    }
}

module offset_3d(r=1.0) 
{
    for(k=[0:$children-1]) minkowski() 
    {
        children(k);
        sphere(r=r,$fn=8);
    }
}
