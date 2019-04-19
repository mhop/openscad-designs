
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

//module schlitze_N(n=1, l=5, f=
mitte_x=2.5+78.8;
y=4.3;

h_usb=7.4;
b_usb=15.5;
x_usb=mitte_x-18.1;

h_lan=13.8;
b_lan=33.8;
x_lan=mitte_x-18.1+59.85;

module schlitze()
{
/*
translate([2.5+45.2,  4.3-10, -1])    cube([15.6, 8.5+10,  5]);
translate([2.5+65,    4.3-10, -1])    cube([18, 14.5+10, 5]);
translate([2.5+6,     4.3+2, -1])     cylinder(5,2,2, $fn=15);
translate([2.5+6-2,  -4.5, -1])       cube([4,10,5]);
*/
{
    r=2;
    h=5;
    T(mitte_x-34.5, y+h, 0)     Cy(r=r, h=10, $fn=15);
    T(mitte_x-34.5, h/2+r, 0)      Cu(2*r,10,10);
}
{
    T(x_usb, (h_usb+y)/2-0.1, 0) Cu(b_usb, h_usb+y, 10); 
}
{
    T(x_lan, (h_lan+y)/2-0.1, 0) Cu(b_lan, h_lan+y, 10); 
}

}    



difference()
{
dectroh();
schlitze();
luft(hori=0);
}


d=2+0.3;
h_text=2.5;
Tz(d) Tx(x_usb) Ty(h_usb+y+1) txt("USB");
Tz(d) Tx(x_lan-b_lan/4) Ty(h_lan+y+1) txt("LAN1");
Tz(d) Tx(x_lan+b_lan/4) Ty(h_lan+y+1) txt("LAN1");

module txt(t)
{
     linear_extrude(height=1) text(t, size=h_text, halign="center");
}

module luftN(n=1, l=5, b=3, d=3, f=1.0)
{
    h=10;
    for(i=[0:n-1]) {
        Tx(i*d) Tz() hull() {
            Cy(r=b/2, h=h);
            Ty(l+i*f) Cy(r=b/2, h=h);
        }
    }
}


module luft(hori)  
{
    $fn=30;
    d=4.02;
    x=5.8;
    b=1.9;
    r=b/2;
    
    T(x+0*d, 7,0)      luftN(n=1, l=10, b=b, d=d, f=0);
    T(x+1*d, 7,0)      luftN(n=7, l=13, b=b, d=d, f=0.3);
    T(x+8*d, 7,0)      luftN(n=2, l=10, b=b, d=d, f=0);
    //T(x+10*d, 15,0)    luftN(n=7,  l=8,  b=b, d=d, f=0);
    T(x+69,     7,0) luftN(n=1,  l=10, b=b, d=d, f=0);
    T(x+69+1*d, 7,0) luftN(n=4,  l=16, b=b, d=d, f=-0.2);
    T(x+69+5*d, 7,0) luftN(n=3,  l=10, b=b, d=d, f=-0.2);
}