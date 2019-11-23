
use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

use <jst.scad>

$fn=100;

l=70;
b=30;
h=8;

*klemmblockhalter();

klemmplatine();

module jstx(n) {
Tz(4.5) Rz(90) Rx(90) {
    jst(n);
}
}

w1=[3,4,2];
w2=[6,4];
w3=[6,4];

Ty(-13) {
reihe(w1);
Tx(10) reihe(w2);
Tx(20) reihe(w3);
}
module reihe(v) 
{
    function getpinsum(v, n, s=0, r=0) =  s<n ? getpinsum(v,n,s+1,r+v[s]): r;
    
    for(i=[0:len(v)-1]) {
        o=getpinsum(v, i);
        s=v[i]/2*2;
        Ty(o*2+s+i*2) Tx(i*0) jstx(v[i]);
    }
}


module klemmblockhalter()
{
    D() {
        U() {
            *Tx(-l/2+b-3) Tz((b*2)/2) Ty(-(b/2+2.5/2-0.1)) Rx(90) Rz(0) strebenplatte(l=b*2, b=b*2, d=2.5, s=3);
            dome();
            Tz(2.5/2) strebenplatte(l=l, b=b, d=2.5, s=3);
            Ty(-b/2+2.5/2) Tz(h/2) Rx(90) strebenplatte(l=l-5, b=h, d=2.5, s=3, type=0);
            // Lasche
            *Tx(l/2) Ty(-(b/2-3/2)) Tz(10/2) Rx(90) Cu(10, 10, 3);
            *MMx() Tx(l/2+4)  {
                Ty(-b/2+10) schraubhuelse(h_top=46, h_bot=6.5, ri_top=3.5/2, ri_bot=2.5/2, r=4, typ=1);
                Tx(-5) Tz(h-2.5/2) strebenplatte(l=8, b=b-5, d=2.5, s=3, type=0);
                Tx(-4) Ty(-5) Tz(2.5/2) Cu(5, 6, 2.5);
            }
            // Übergang zum VESC
            Tx(-(l/2+3)) Ty() Tz(+(2.5/2)) Cu(8,b,2.5);
            MMy() Tx(-(l/2+2)) Ty(-b/2+2.5/2) Tz(10/2) Cu(9, 2.5, h);
            *Tz(10/2) Tx(-l/2+2.5/2) Ty(-5)  Cu(2.5, 10, 10);
            
        }
        dome(loch=1);
        *MMx() Tx(l/2+4) 
            Ty(-b/2+10) schraubhuelse(h_top=46, h_bot=6.5, ri_top=3.5/2, ri_bot=2.5/2, r=4, typ=1, loch=1);
        Tz(19) klemmplatine(l=l, b=b);
    }
}    

module dome(loch=0)
{
            MMy() MMx() Ty(2.54*4) Tx(2.54*12) dom(loch=loch);
            dom(r_loch=0, r_top=2.2, r_bot=3,  loch=loch);
}

module dom(r_bot=5, r_top=4, r_loch=2, loch=0)
{
    schraubdome(h_top=3, r_top=r_top, r_loch=r_loch, h_loch=7, r_bot=r_bot, h_bot=h, loch=loch);
}

    

module schraubdome(h_top=5, r_top=5, r_loch=4/2, h_loch=7, r_bot=7, h_bot=10, loch=0)
{
    module loch()
    {
        Tz(-h_loch/2+h_top+0.1) Cy(r=r_loch, h=h_loch);
    }
    
    if(loch) {
        Tz(h_bot) loch();
    } else {
        Tz(h_bot) D() {
            U() {
                Tz(h_top/2)   Cy(r=r_top, h=h_top);
                Tz(-h_bot/2) Cy(r=r_bot, h=h_bot);
            }
            loch();
        }
    }
}


module klemmplatine(l=52, b=38, d=1.5)
{
    color("red")
    Cu(l, b,d);
    
 *   color("green") Ty() Tz(7) { 
        MMx() Tx(8*2.54) Rz(90) Cu(27,14,12); 
        Tx(0*2.54) Rz(90)  Cu(27,14,12);
        *Tx(-8) Rz(90) Cu(27,14,12);
        *Tx(-24) Rz(90)Cu(27,14,12);
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

