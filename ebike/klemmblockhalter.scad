
use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

*klemmblockhalter();
klemmblockhalter2();

module klemmblockhalter2()
{
Tz(9) klemmplatine(l=80, b=30);
MMy() MMx() Ty(8) Tx(36) dom();
}    
    
module dom()
{
schraubdome(h_top=3, r_top=4, r_loch=2, h_loch=5, r_bot=5, h_bot=5);
}

module schraubdome(h_top=5, r_top=5, r_loch=4/2, h_loch=10, r_bot=7, h_bot=10, loch=0)
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
            #loch();
        }
    }
}





module klemmblockhalter()
{
    l=65;
    b=35;

D() {
Ty(-0.5) {

*Tx(l/2-15) Ty(15/2-3/2) Ry(90) Cu(52, 3,6);
*Tx() Ty(15/2-3/2) Ry(90) Cu(52, 3,6);
Tx(-b/2) Ry(90) strebenplatte(l=l, b=15, d=3, s=3);
Tx(-0.8)              platte_mit_clip(l=b+1, b=15, d=5, s=3);
Tx(-0.8) Tz(l/2-0.5)  platte_mit_clip(l=b+1, b=15, d=5, s=3);
Tx(-0.8) Tz(-l/2+0.5) platte_mit_clip(l=b+1, b=15, d=5, s=3);
}
#Ty(-8.2) Rx(90) Rz(90) klemmplatine(l=l, b=b, d=1.5);
Tx(2) Ty(15/2-3/2-0.1) Ry(90) Cu(l+5, 4,6);
}

}
module klemm()
{   
    a=80;
    b=35;
    d=2;
    
    Tx(-60) Tz(50) Cu(a,d,b);
    
    // Platine
    Tx(-65)Tz(67) Ty(5) Ry(90) Rx(-90) klemmplatine();
    
}

module klemmplatine(l=52, b=38, d=1.5)
{
    color("red")
    Cu(l, b,d);
    
    color("green") Ty() Tz(7) { 
        Tx(24) Rz(90) Cu(27,14,12); 
        Tx(8) Rz(90)Cu(27,14,12);
        Tx(-8) Rz(90)Cu(27,14,12);
        Tx(-24) Rz(90)Cu(27,14,12);
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

module platte_mit_clip(l=40, b=15, d=5, s=3)
{
    *clip(l=b+c, b=5, d=2);
    strebenplatte(l=l, b=b, d=d, s=s);
    Tx(-l/2+s/2) Ty(-s) Cu(s, b+s, d);
    c=1.5;
    Tx(l/2+s/2) Ty(-b/2-c) Ry(-90) Rz(90) clip(l=b+c, b=5, d=2);
}    

module clip(l=25, b=5, d=2)
{
    l3eck=d*3;
    ll=l+l3eck;
    lb=l/4;

    Tx(l/2) {
        Cu(l, b, d);
        Tx(l/2-lb/2) Tz(1/2) Cu(lb, b, d+1);
        Tx(-l/2-l3eck/2) Tz(-d/2/2) Cu(l3eck, b, d/2);
        Tx(-l/2) Ty(-b/2) Rz(180) Rx(90) rounded_prism(a=l3eck,b=d+1,h=b,r=0.01);
    }
}