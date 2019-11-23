
use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

use <jst.scad>

$fn=100;

l=18*2;
b=15*2;
h=8;

klemmblockhalter();

module klemmblockhalter()
{
    D() {
        U() {
            dome();
            Tz(2.5/2) strebenplatte(l=l, b=b, d=2.5, s=3);
            Ty(-b/2+2.5/2) Tz(h/2) Rx(90) strebenplatte(l=l-5, b=h, d=2.5, s=3, type=0);
            // Übergang zum VESC
            Tx(-(l/2+3)) Ty() Tz(+(2.5/2)) Cu(8,b,2.5);
            MMy() Tx(-(l/2+2)) Ty(-b/2+2.5/2) Tz(10/2) Cu(9, 2.5, h);
        }
        dome(loch=1);
        #Tz(12) klemmplatine(l=l, b=b);
    }
}    

module dome(loch=0)
{
            MMy() MMx() Ty(2*5) Tx(2*8) dom(loch=loch);
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
        Ty(10) Tz(-h_loch/2+h_top+0.1) Cy(r=r_loch, h=h_loch);
        Cu(7,7,7);
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

    module jstx(n) {
        Tz(4.5) Rz(90) Rx(90) {
            jst(n);
        }
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

    w1=[3,4,2]; // gas, torque/pas, key
    w2=[6,4];   // motor, licht
    w3=[6,4];   // can, Bluetooth
    w4=[6,4];   // ??, ??

    color("red")
    Cu(l, b,d);

    Tx(-5*2-1) Ty(-11) {
        reihe(w1);
        Tx(3*2) reihe(w2);
        Tx(7*2) reihe(w3);
        Tx(10*2) reihe(w4);
    }

}

