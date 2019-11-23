
use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

use <klemmblockhalter_jst.scad>

*Tx(40) Tz() vesc_platinenhalter();



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



Tx() Ty(56) Tz(0) Ry(0) Rz(90)  klemmblockhalter();
    

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
                My() balken2(l=44.5, b=15, h=3);
            }
            MMx() Tx(a2/2) schraubdome(h=h, r=r, rs=rs, hs=hs, r2=r2, h2=h2, loch=true);
        }

        Ty(0) U() {
            h=18;
            Tx(-21) Tz(h/2) Ry(90) Rz(90) strebenplatte(l=l, b=h, d=2.5, s=3);
            *Tx(-21) Ty(b/2+6) Tz(h/2) Ry(90) strebenplatte(d=2.5, b=12, l=h);    

            Tx(+20.7) Tz(3/2) Cu(3, l, 3);
        }

        U() {
            b=44;
            if(!up)
                Tx() Tz(-1.6) Ry(0) Rz(90) strebenplatte(l=87, b=b, d=2.5, s=3);
        }

    } // U()
    MMy() Tx(5.5) Ty(65/2+3) Tz(13) Cu(50, 5, 20);
}  // D()

l=60;


module balken(l,h,b, )
{
    gap=0.4;
    if(up) {
    Tz(14/2) Ty(2) Rx(90) strebenplatte(l=l, b=14, d=h, s=3, type=0);
    Ty(b/5) Tz(h/2) Cu(l, b, h);
    } else {
    Ty(b-b/5+gap) Tz(h/2) Cu(l,h,3*h);
    Ty(b-b/5+gap-3*h/2+h/2) Tz(h+h/2+gap) Cu(l,3*h,h);
    }
}

module balken2(l,h,b, )
{
    gap=0.4;
    if(up) {
        Tz(14/2) Ty(2) Rx(90) strebenplatte(l=l, b=14, d=h, s=3, type=0);
    } else {
        Ty(b-b/5+gap) Tz(h/2) Cu(l,h,3*h);
    T   y(b-b/5+gap-3*h/2+h/2) Tz(h+h/2+gap) Cu(l,3*h,h);
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
        #Tz(h2) loch();
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