
$fn=100;

r1=4.2/2;
r2=3.3/2;
d=1.5;
h=5;

module doppelring()
{
translate([0,-(r1+r2),0]) ring(r2, 180) square([d,h]);
ring(r1) square([d,h]);
}

difference() {
doppelring();
translate([0,0,-1]) cylinder(r=r1, h=h+2);
translate([0,-(r1+r2),-1]) cylinder(r=r2, h=h+2);
translate([-(r2*1.6/2),-(r1+r2/2),-1]) cube([r2*1.6,r2,h+2]);
translate([-(r1/2),r1/2, -1]) cube([r1, 2*r1, h+2]);
}

	
module teilring(r=36, w=25)
{
	l=r*5;

	difference() {
		translate ([0,0,1]) rotate([0,0,0]) ring(r) children();
	translate ([-l/2,0,-l/2]) cube( [l,l,l]);
	translate ([-0,-0,-l/2]) rotate([0,0,180+w]) cube( [l,l,l] );   
	}
}

module ring(r){
    rotate_extrude()
    translate( [r,0,0] ) children();
}
