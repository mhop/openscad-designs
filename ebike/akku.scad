//import("/Users/marc/Downloads/case.stl");
use <rahmen.scad>;


rahmen();

akkuK();
test();


module test()
{
translate([0, -75/2,0]) {

translate([-55,0,0])
cube([300, 75, 10]);

translate([-55,0,0])
cube([50, 75, 130]);


//hull() {
x0=-0;
xn=230;
l=xn-x0;
N=10;
d=l/N;
for (i=[0:N]) {
platte(i*d+x0, 100+sin(45+i*80/N)*60, 90+i/N*10);
	
}
//}
}
}

module akkuG() 
{
	
color( "LightSkyBlue", 1.0 ) {

translate([0, -70/2,0])
{	
translate([205-175,0,0])
cube([175, 70, 175]);
cube([205, 70, 50]);
}
}
}

module akkuK() 
{
color( "LightSkyBlue", 1.0 ) {
translate([0, -70/2,0])
{	
translate([205-175, 0,0])
cube([175, 75, 135]);
cube([205, 75, 50]);
}
}
}



module platte(x,h,w)
{
translate([x,-5,0])
cube([3,w,h]);
}