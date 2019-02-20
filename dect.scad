
use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>


module dect1()
{
#translate([-30.3,-26.7,-166.5]) import("/Users/marc/Pictures/dect.stl");
translate([-30.3,-26.7,-166.5]) import("dect.stl");
translate([20,0,0]) cube([122,18,1.2]);
translate([20,4.4,0]) cube([122,15,2.5]);
}

module dect2()
{
difference () {
    dect1();
    translate([-5,0,-10.00]) cube([155,30,10]);
}
}

module dectroh() 
{
difference () {
    dect2();
    translate([-5,0,+2.5]) cube([155,30,10]);
}
}

module schlitze()
{
/*
translate([2.5+45.2,  4.3-10, -1])    cube([15.6, 8.5+10,  5]);
translate([2.5+65,    4.3-10, -1])    cube([18, 14.5+10, 5]);
translate([2.5+6,     4.3+2, -1])     cylinder(5,2,2, $fn=15);
translate([2.5+6-2,  -4.5, -1])       cube([4,10,5]);
*/
mitte_x=2.5+78.8;
y=4.3;
{
    r=2;
    h=5;
    T(mitte_x-34.5, y+h, 0)     Cy(r=r, h=10, $fn=15);
    T(mitte_x-34.5, h/2+r, 0)      Cu(2*r,10,10);
}
{
    h2=7.3;
    b2=15.7;
    T(mitte_x-18.1, (h2+y)/2-0.1, 0) Cu(b2, h2+y, 10); 
}
{
    h3=13.7;
    b3=32.4;
    T(mitte_x-18.1+59.85, (h3+y)/2-0.1, 0) Cu(b3, h3+y, 10); 
}
}    



difference()
{
dectroh();
schlitze();
luft(hori=0);
}

module luft(hori)  
{


$fn=30;
if(hori==1) {
for(i=[0:3])
translate([14,7.5+i*4,-0.1])  //   cube([30, 1.5,  5]);
        hull() {
            translate ([0,0,0]) cylinder(r=1.5/2,h=5);
            translate ([30,0,0]) cylinder(r=1.5/2,h=5);
        }    
}
else {
d=4.02;
x=5.8;
r=2/2;
    for(i=[0:9])
    translate([x+i*d,7,-0.1])    
        hull() {
            translate ([0,0,0]) cylinder(r=r,h=5);
            translate ([0,13+i*0.3,0]) cylinder(r=r,h=5);
        }    
    for(i2=[0:6])
    translate([x+10*d+i2*d,15,-0.1])    
        hull() {
            translate ([0,0,0]) cylinder(r=r,h=5);
            translate ([0,8,0]) cylinder(r=r,h=5);
        }    
    for(i=[0:7])
    translate([x+17*d+i*d,7,-0.1])    
        hull() {
            translate ([0,0,0]) cylinder(r=r,h=5);
            translate ([0,16-i*0.2,0]) cylinder(r=r,h=5);
        }    
}
}