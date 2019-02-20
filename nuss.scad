
// based on:
//
// André Groß
// www.andre-gross.de
// andregro (a) students. uni-mainz.de

use <lib/shortcuts.scad>

socket = 10;
height = 120;
//handleHeight = 0;
//handleDiameter = 0;
//shaftDiameter = 6;
quarter=6.6;

$fn=100;

// -----------------------------------------

socket_r=socket/sqrt(3)*2; // radius des sechsecks

function socket_to_thread(socket=10) = 
	socket==3.1 ? 1.6:
             socket==4   ? 2:
             socket==5   ? 2.5:
             socket==5.5 ? 3:
             socket==6   ? 3.5:
             socket==7   ? 4:
             socket==8   ? 5:
             socket==10  ? 6:
             socket==11  ? 7:
             socket==13  ? 8:
             socket==16  ? 10:
             socket==17  ? 10:
             socket==18  ? 12:
             socket==19  ? 12:
             socket/2 ; 


wrench(socket,height);


module wrench(socket,height,handleHeight,handleDiameter,shaftDiameter) {
	difference(){
		union(){
			CyR(h=height,r=socket_r/2+1.5, center=false); // plus wandstärke
			//translate([0,0,height-handleHeight-socket])
				cylinder(h=socket,r1=shaftDiameter/2,r2=handleDiameter/2);
			*for (i=[0:3]) {
				rotate(i*45)translate([-handleDiameter/12,-handleDiameter/2,height-handleHeight])cube([handleDiameter/6,handleDiameter,handleHeight]);
			}
			*translate([0,0,height])sphere(handleDiameter/2);
		}
		translate([0,0,-0.1])cylinder(h=socket+0.1, r=socket/2+0.1, $fn=6);
		Tz(socket-0.1) cylinder(h=height-socket-quarter-1-0.2,r=socket_to_thread(socket)/2*1.1);
		translate([0,0,height-quarter/2-1+0.1]) cube([quarter,quarter, quarter+2], center=true);
		//Tx(-10) Cu(20,20,500);
	}
}
