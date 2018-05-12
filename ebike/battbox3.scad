use <shortcuts.scad>;


akkuL=210;
akkuLk=175;
akkuHk=50;
akkuB=69;
akkuH=125;
rund=10;
wand=3;


$fn=20;

akkuK();

module griffmulde(){
Tx(20)Cu([1,1,30]);
D() {
Cy(r=20, h=20);
donut(r=23, rr=10);
Tx(-4)donut(r=15, rr=6.2);
}
}


module boxgriff() {
D(){
box2();
Tz(akkuH/2) Tx(255) S([2, 4.6, 4.5]) Rx(90) griffmulde();
}
}

*D() {
	minkowski() {
		boxgriff();
		sphere(r=3);
	}
	box();
	Tz(-5) Cu([500,200,11]);
}

module donut(r=20, rr=10)
{
	rotate_extrude(convexity = 10) Tx(r) Ci(r = rr);
}


module box2()
{
	T(akkuL/2, 0, akkuH/2) box();
	T(akkuL-135,0,akkuH/2) box(x=10, scaleX=15);
}

module box(x=0, scaleX=akkuL*1.1/20)
{
  scale([scaleX,akkuB*1.3/20,(akkuH+6)/20]) {
      intersection()
      {
        Tx(x) cube([20,20,20], center=true);
        sphere(15);
        Ry(90) Cy(r=26/2, h=100);
      }
  }
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
