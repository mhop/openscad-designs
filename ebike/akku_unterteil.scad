
akkuL=205;
akkuLk=175;
akkuHk=50;
akkuB=75;
akkuH=135;

w1=4;

akkuK();




unterteil(w1,15) roh();
unterteil(w1/2,20)  roh();
//halter();



module unterteil(d, h) {
	difference() {
		gehaeuse(d) children();
		translate([-10, -75, h]) cube([270*2, 75*2, 50]);
	}
}


module gehaeuse(d) {
	difference() {
		grow(d) children();
		children();
	}
}

module grow(d) {
	minkowski() {
		children();
		sphere(r=d);
	}
}


module roh() {
hull()
stege();
}

module halter()  {
translate([200,100,4])
rotate([90,0,-90])
difference() {
import("/Users/marc/Documents/3d/case.stl");
translate([50,0,-100]) cube([100,200,300]);
translate([50,-15,-110]) cube([100,30,100]);
}
}

module stege(N=20)  {
	l=275;
	d=l/N;

	translate([-w1,0,0])
		for (i=[0:N]) {
			platte(i*d, 30, 90+sin(i/N*180)*10-pow(i/N*3.3,3));
		}
}


module platte(x,h,w)
{
translate([x,-w/2,0])
cube([w1,w,h]);
}

module akkuK() 
{
	color( "LightSkyBlue", 1.0 ) {
		translate([0, -akkuB/2,0]) {	
			translate([akkuL-akkuLk, 0,0]) cube([akkuLk, akkuB, akkuH]);
			translate([0, 0,akkuH-akkuHk]) cube([akkuL, akkuB, akkuHk]);
		}
	}
}
