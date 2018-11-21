// Customizable cable clip
// by Frederic RIBLE F1OAT / 2018/11/05
// remixed to Customizable  cable-clamp
// by Marc Hoppe 2018/11/21

cables_count = 1; // [1:10]

// (in mm)
cables_diameter = 7.5;

// (in mm)
cables_spacing = 0;

// (in mm)
thickness = 2;

// (in mm)
gap = -1;

// (in mm)
width = 12;

// (in mm)
screw_diameter = 5.5;

// length y-axis
len=5;
// (in mm) z-axis offset
d=20;

// 1: clamp, 0: clip
clamp=1;


// Following variables are not parameters -----------------

epsilon = 0.1+0;
$fn=64+0;

outer = cables_diameter+2*thickness;

if(clamp==1) clamp();
else         cip();


module clamp() {
    difference() {
    clip();
    translate([0,0,-10]) rotate([0,0,50]) rotate_extrude(angle=120)
        square([width*2,width*2]);
    }
    rotate([0,0,80]) translate([0,(cables_diameter+thickness)/2,0])
        cylinder(h=width, d=thickness, center=true);
    rotate([0,0,-40]) translate([0,(cables_diameter+thickness)/2,0])
        cylinder(h=width, d=thickness, center=true);
}


module clip() {
    difference() {
        union() {
            for (c=[0:cables_count-1]) {
                translate([0,c*(cables_diameter+cables_spacing),0]) {
                    cylinder(h=width, d=outer, center=true);
                }
            }
            translate([outer/2-thickness-gap/2, -width/2-outer/2, 0]) {
                rotate([0, 90, 0]) {
                    bracket(len,d);
                }
            }
        }
        cut = width+outer/2;
        #translate([outer/2-thickness, -cut-epsilon-len, -width/2-epsilon-d]) {
            rotate([0, -90, 0]) {
                cube([width+2*epsilon+d, cut+2*epsilon+len, gap]);
            }
        }
        for (c=[0:cables_count-1]) {
            translate([0,c*(cables_diameter+cables_spacing),0]) {
                cylinder(h=width+epsilon+d, d=cables_diameter, center=true);
            }
            translate([0,c*(cables_diameter+cables_spacing),-d/2-width]) {
                cube([cables_diameter+thickness*3, cables_diameter+thickness*2, d+width], center=true);
            }
        }
        ll = (cables_count-1)*(cables_diameter+cables_spacing);
        translate([0,ll/2,0]) {
            cube([cables_diameter*0.6, ll, width+2*epsilon], center=true);
        }
    }
}

module bracket(len=0, d=0) {
    len2=len+(width/2+outer/2);
    dy=-(len2-(width/2+outer/2));
    translate([d,dy,0])
    difference() {
        union() {
            translate([-d, -width/2, -thickness-gap/2]) {
                cube([abs(d) ,width, 2*thickness+gap]);
            }
            translate([-d, 0, 0]) {
            cylinder(h=2*thickness+gap, d=width, center=true);
            }
            translate([-width/2-d, 0, -thickness-gap/2]) {
                cube([width, len2, 2*thickness+gap]);
            }
            cylinder(h=2*thickness+gap, d=width, center=true);
        }
        cylinder(h=2*thickness+gap+2*epsilon, d=screw_diameter, center=true);
    }
}
