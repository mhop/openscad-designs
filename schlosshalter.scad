$fn=80;


halter1(l=62);


//translate ([19,-10,-1]) cube([5,20,100]);


module halter1(l)
{
	rk=13/2;
	a=13.5;
	difference() {
		hull() {
			translate ([0,0,0]) platte(rk=rk, rg=10, a=a);
			translate ([0,0,l]) platte(rk=rk, rg=10, a=a);
		}
		ab=a+rk-3.5-5;
		fuehrung(l, off=15, d=3.5, steg=6, ab=ab+0.3); // etwas höher
		rundfuehrung();
		abr=a+rk-2.5;
		riegel(off=48, d=5, ab=abr);
		schloss(l, dm=13.5);
		klemmung(13.5/2, 2);
	}
}


module rundfuehrung() 
{
l=62;
steg=6;
w=13;

translate ([11.5,0,l-steg/2])
rotate([-90,0,-90])
rohrhalb(ri=steg/2,ra=20,l=3.5);

translate ([15,0,l-w/2])
rotate([-90,0,-90])
rohrhalb(ri=w/2,ra=20,l=10);

translate ([13,-10,l-4])
rotate([-90,0,0])
rohrviertel(ri=w/2,ra=20,l=20);

//translate ([19.62,-10,-1]) cube([5,20,l+5]);
}

module rohrhalb(ri, ra, l)
{
difference() {
	rohr(ri, ra, l);
	translate ([-ra-0.1,0,-0.1]) cube([ra*2+0.2,ra+0.2,l+0.2]);
}
}

module klemmung(r, d)
{
rschl=r-1.5;
len=15;
a=11;
rl=5/2;
translate ([rschl+2, 5, len/2-a/2]) cube([a,a,a]);
translate ([rschl+2, -5-a, len/2-a/2]) cube([a,a,a]);
translate ([rschl-1, -d/2,-0.1]) cube([17,d,len+5]);
translate ([rschl+2+a/2,0,len/2]) rotate([90,0,0]) cylinder(r=rl, h=40, center=true);
}


module schraege()
{
translate ([-20+18,-10,42]) 
rotate([-90,0,0])
rohrviertel(20,28,20);
}

module rohrviertel(ri,ra,l)
{
	difference() {
		rohr(ri,ra,l);
		translate ([-ra,0,-0.1]) cube([ra*2,ra,l+0.2]);
		translate ([-ra,-ra,-0.1]) cube([ra,ra*2,l+0.2]);
	}
}



module schloss(l, dm)
{
	translate ([0,0,-5]) cylinder(r=dm/2, h=l+10);
}

module riegel(off, d, ab)
{
	w=20;
	translate ([ab,-w/2, off]) cube([10,w,d]);
}

module fuehrung(l, off, d, steg, ab)
{
	w=20;
	translate ([ab, steg/2,  off]) cube([d,w,l]);
	translate ([ab,-steg/2-w,off]) cube([d,w,l]);
}

module platte(rk,rg,a)
{
	d=1;
	hull() {
		translate ([0,0,0]) cylinder(r=rg,h=d);
		translate ([a,0,0]) cylinder(r=rk,h=d);
	}
}

module rohr(ri,ra,l)
{
	difference() {
	cylinder(r=ra, h=l);
	translate ([0,0,-0.1])cylinder(r=ri, h=l+0.2);
	}
}





