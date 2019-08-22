
use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

//Ty(0.25) Tx(-10.8) import("Dual_Vesc_mounting_plate.stl");


//use <vesc_platinenhalter.scad>;

use <klemmblockhalter.scad>

//Tx(40) Tz() vesc_platinenhalter();



vesc_schraubdome(); 

module vesc_schraubdome() {
$fn=40;

up=1; 
    
h=6;
r=3.5;

r2=4.5;
h2=14;

hs=10;
rs=4/2;

a1=32.5; 
a2=11.5;
b=59;

hh=13;

*Tx(-15.2) Ty(69) Tz(19) Rz(90) Ry(-90) klemmblockhalter();
    
    
    *color("LightGrey")  {
        Tx(a1/2+rs+1) Ty(b/2+rs+1) Tz(h+h2+1) Rz(-90) Rx(90) import("VESC_Board_Dummy.stl");
        Tx(-a1/2-3) Ty(b/2-5) Tz(9) Rz(90) Rx(90)  import("/Users/marc/Documents/3d/openscad-designs/ebike/Capacitors.stl");
    }

module klemm()
{   
    a=80;
    b=35;
    d=2;
    
    *Tx(-60) Tz(50) Cu(a,d,b);
    
    // Platine
    Tx(-65) Tz(67) Ty(5) Ry(90) Rx(-90) klemmplatine();
    
}

module klemmplatine()
{
     Cu(52,42,1);
    
            color("green") Ty() Tz(7) { 
                Tx(16) Rz(90) Cu(27,14,12); 
                Tx() Rz(90)Cu(27,14,12);
                Tx(-16) Rz(90)Cu(27,14,12);
            }
            *color("green") Ty() Tz(6) { 
                MMy() {Tx(12) Ty(8.5) Cu(23,14,12); 
                Tx(-12) Ty(8.5)Cu(23,14,12);
                }
            }
           *color("green") Ty() Tz(7) { 
                Tx() Ty() Cu(60,14,12); 
            
            }
}


*Ty(+60) Tz(25) Tx(-5) Ry(90) Rz(90) klemmplatine();

*Tx(-14) Tz(20) Ty(36) Rx(90) strebenplatte(l=15, b=45, d=5, s=3);
*Tx(-14) Tz(20) Ty(60) Rx(90) strebenplatte(l=15, b=45, d=5, s=3);
*Tx(-14) Tz(20) Ty(85) Rx(90) strebenplatte(l=15, b=45, d=5, s=3);

D() {
    U() {
        Ty(+b/2) D() {
            U() {
                MMx() Tx(a1/2) schraubdome(h=h, r=r, rs=rs, hs=hs, r2=r2, h2=h2);
                balken(l=44.5, b=15, h=3);
            }
            MMx() Tx(a1/2) schraubdome(h=h, r=r, rs=rs, hs=hs, r2=r2, h2=h2, loch=true);
        }
        
        Ty(-b/2) D() {
            U() {
                MMx() Tx(a2/2) schraubdome(h=h, r=r, rs=rs, hs=hs, r2=r2, h2=h2);
                My() balken(l=44.5, b=15, h=3);
            }
            MMx() Tx(a2/2) schraubdome(h=h, r=r, rs=rs, hs=hs, r2=r2, h2=h2, loch=true);
        }

        Ty(+30) U() {
            h=18;
            l=125;
            Tx(-21) Tz(h/2) Ry(90) Rz(90) strebenplatte(l=l, b=h, d=2.5, s=3);
            Tx(+20.7) Tz(3/2) Cu(3, l, 3);
        }

        U() {
            b=44;
            if(!up)
                Tx() Tz(-1.6) Ry(0) Rz(90) strebenplatte(l=87, b=b, d=2.5, s=3);
        }
    } // U()
    Tx(5) Ty(65/2+3) Tz(13) Cu(50, 5, 20);
    MMy() Tx(5) Ty(65/2+3) Tz(13) Cu(50, 5, 20);
}  // D()

*Tz(h+h2+hh/2+1.3) {
Ty(+b/2) MMx() Tx(a1/2) huelse(r=r, rs=rs,h=hh);
Ty(-b/2) MMx() Tx(a2/2) huelse(r=r, rs=rs,h=hh);
}

*Tx() Tz(a1/2+18) Cu(a1+8, b+8, 1);

*Ty(34) Tz(15) Rx(-90) switcher();


module balken(l,h,b, )
{
    gap=0.4;
    if(up) {
    Tz(18/2) Ty(2) Rx(90) strebenplatte(l=l, b=18, d=h, s=3);
    Ty(b/5) Tz(h/2) Cu(l, b, h);
    } else {
    Ty(b-b/5+gap) Tz(h/2) Cu(l,h,3*h);
    Ty(b-b/5+gap-3*h/2+h/2) Tz(h+h/2+gap) Cu(l,3*h,h);
    }
}

module huelse(r=5, rs=4/2, h=10)
{
    D() {
        Cy(r=r, h=h);
        Cy(r=rs, h=h+.1);
    }
}

    
module schraubdome(h=5, r=5, rs=4/2, hs=10, r2=7, h2=10, loch)
{
    module loch()
    {
        Tz(-hs/2+h+0.1) Cy(r=rs, h=hs);
    }
    
    if(loch) {
        Tz(h2) loch();
    } else {
        Tz(h2) D() {
            U() {
                Tz(h/2)   Cy(r=r, h=h);
                Tz(-h2/2) Cy(r=r2, h=h2);
            }
            loch();
        }
    }
}

}

module switcher()
{
    Cu(44,16,1.5);
    Tx(-17) Ty(3) Tz((13+1.5)/2) Cy(r=4, h=13);
    Tx(+17) Ty(-3) Tz((13+1.5)/2) Cy(r=4, h=13);
}