


$fn=120;

a=63;
r=25/2;

difference() {
teil1();
translate([0,0,-a/2]) cube([a+1,a+1,a], center=true);
}

module teil1() {

intersection() {
rotate_extrude()
difference() {
union() {
translate([a/2,-18.4,0]) circle(r=2*r);
translate([10,-7,0]) square([15, 10]);
translate([0,-5,0]) square([10, 5]);
}
translate([7,25,0]) circle(r=2*r);
translate([0,-22,0]) square([40, 20]);
}
cube([a,a,20], center=true);
cylinder(r=a/2, h=15, center=true);
}

difference() {
cube([a,a,13.2], center=true);
cylinder(r=a/2, h=13.3, center=true);
}

color("green") {
sphere(r=r);
}

}
