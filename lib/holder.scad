
use <shortcuts.scad>


// preview[view:northwest, tilt:bottomdiagonal]

/* [holder chinese laser] */



holder(t=3, clf_partHeight=30, clf_innerWidth = 70);
*holder(t=1, clf_partHeight=250, clf_innerWidth = 70);


module holder(t=1,
// min width of the plastic walls.
clf_wall = 2, // plastic walls are 2mm

// we will model the whole thing based on the hole in the middle, since that is all we care about. It should be the measured from the male part on the bie light you want to attach here.
clf_innerWidth = 17.21, // the side to side of the shaft
clf_innerDepth = 3, // the depth the shaft
// height does not matter much for the male part, as it will pass trhu the whole part. So just enter a good height so that it reaches the latch on the bottom.
clf_partHeight = 22.75,
// width of the thumb thing for the latch
clf_handle_width = 11.6
) 
{

if(t==1) clf_main();

if(t==2) holder2();

if(t==3) holder3();
	
module holder2() {
	r=0.1;
	difference() {
		w=clf_innerWidth+clf_wall*2-0.01;
		translate([-w/2,clf_wall-0.01+r,-(clf_partHeight+6.5+0.01)])
			cube([w, clf_innerDepth+clf_wall*2,clf_partHeight+6.5]);
		minkowski() {
			clf_main();
			sphere(r=r);
		}
	}
}

module holder3() {
	r=0.1;
	Tz(clf_partHeight/2) Ty(-(clf_wall+(clf_innerDepth+clf_wall*2)/2))
	difference() {
		w=clf_innerWidth+clf_wall*2-0.01;
		translate([-w/2,clf_wall-0.01+r,-(clf_partHeight+0.01)])
			cube([w, clf_innerDepth+clf_wall*2,clf_partHeight]);
		minkowski() {
			clf_main();
			sphere(r=r);
		}
	}
}

module main_part(){
	latch();
	difference(){
		// the main block where we will chip the pieces away
		cube([ clf_innerWidth/2 + clf_wall, clf_innerDepth+clf_wall*2 , clf_partHeight] );
		main_cuts();
	}
}
module latch(){
	// bottom latch
	translate([ 0, 0, -clf_wall ] ){
		cube( [ clf_handle_width/2 -0.5, clf_wall, clf_wall] );
	}
	// the latching block
	translate([ 0, clf_wall, -3-clf_wall ] ){
		difference() {
		cube( [ 5.20/2, 1.15, 3] );
		translate([ 0, 1.2, 0.5 ] )rotate([25,0,0])cube( [ 5.20/2, 1.15, 5] );
		}
	}
	// the lachking block base
	translate([ 0, 0, -3-clf_wall ] ){
		cube( [ clf_handle_width/2, clf_wall, 3] );
	}
	//handle();
}
module handle(){
	// the handle
	translate([ 0, clf_wall, -3-clf_wall ] ){
		rotate([45, 0, 0])
			difference(){
				cylinder( h=clf_wall, r=clf_handle_width/2);
				color("blue") rotate([0,0,90])
					translate([0, -clf_handle_width/2-0.001,-0.001])
						cube([ clf_handle_width/2+0.002, clf_handle_width+0.002 , clf_handle_width+0.002]);
			}
	}

}

module main_cuts(){
	// the inner shaft
	translate( [ -0.001, clf_wall, -0.001] ){
		cube([ clf_innerWidth/2+0.001, clf_innerDepth, clf_partHeight+0.002] );
	}
	// the front wall opening
	translate( [ -0.001, (clf_wall)+clf_innerDepth-0.001, -0.001] ){
		cube([ clf_innerWidth/2-clf_innerDepth+0.001, clf_wall+0.002, clf_partHeight+0.002] );
	}
	// the two cuts on the side leading to the latch so that it can move back/forth
	translate( [ clf_handle_width/2-0.5, -0.001, -0.001] ){
		cube([ 0.55, clf_wall+0.002, clf_partHeight/10+0.001]);
	}
}

module clf_main(){
	translate([0,0,-clf_partHeight]){
		main_part();
		actual_mirror();
		handle();
	}
}

// mirror the geometry... why the fuck mirror does not copy? that way it is just an alias to rotate()
module actual_mirror(){
	mirror([10,0,0]){
		main_part();
	}
}

}