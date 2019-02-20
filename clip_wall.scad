
use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>

$fn=80;


clipInnerRad = 27/2;
clipThikness = 3.5;
clipHeight = 15;

supportWidth = 0;
supportHeight = 0.3;

r_loch=5/2;

bh=clipHeight+2;

D() {
clipmitblock();
	MMx() {
Tx(clipInnerRad*2-r_loch*3) Ty(clipInnerRad+clipThikness*2/2) Tz(clipHeight/2)  
	{
		 
		Rx(90) Cy(r=r_loch, h=clipThikness*3);
		Ty(-2) Rx(90)Cy(r1=r_loch, r2=r_loch*2 , h=r_loch);
	}}
}

module clipmitblock()
{


rotate([0,0,-90]){
	clip(ir=clipInnerRad-supportWidth/2,t=clipThikness+supportWidth,h=supportHeight);
	translate([0,0,supportHeight])clip();
}
}

module clip(ir=clipInnerRad,t=clipThikness,h=clipHeight){

	difference(){
		cylinder(r=ir+t,h=h,$fn=PI*(ir+t)*5);
		translate([0,0,-.5])
		cylinder(r=ir,h=h+1,$fn=PI*ir*5);

		Tx(-4) rotate([0,0,-45])
		translate([0,0,-.5])
		cube([10e10,10e10,h+1]);
	}

	#for (r=[-55,55]) rotate([0,0,r])
	translate([ir+t,0,0])
	cylinder(r=t,h=h,$fn=PI*t*5);

}