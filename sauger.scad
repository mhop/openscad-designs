

use <lib/shortcuts.scad>
$fn=80;

D() {
adapter();
*Tz(50) Ty(50) Cu(100,100,100);
}

module adapter()
{
difference() {
import("festool_vac_cl_adapter.stl");
//import("/Users/marc/Downloads/Festool_RO150E.STL");
//translate([18,50,2.5]) cube([5,5,36]);

translate([0,0,15]) 
rotate([180,0,0]) 
cylinder(h =15, r1 = 34/2, r2 = 35.5/2, center = false);
}


difference() {
cylinder(h = 22, r1 = 34/2+2, r2 = 35.5/2+2, center = false);
translate([0,0,-1]) cylinder(h =25, r1 = 34/2, r2 = 35.5/2, center = false);
translate([0,0,-3]) cylinder(h =5, r1 = 37/2, r2=34/2, , center = false);
}
}
