//Rounded Box
//Released in Thingiverse
//by grotto2 is licensed under the Creative Commons - Attribution license.

rounded_box();

module rounded_box (
xsize=83, //length
ysize=120, //width
zsize=48,  //height
thick=3 ,   //thickness of sides
roundc=15,   //radii of corners
fn_edge_out=100,  //edge outside # of segments
fn_edge_in=40, //edge inside # of segments
fn_corner_out=100,  //corner outside # of segments
fn_corner_in=40 //corner inside # of segments
)
{
 //sides
 translate ([ 0,0,thick/2])
 cube([xsize-(2*roundc),ysize-(2*roundc),thick],center=true);//bottom
  translate ([ 0,(ysize/2)-(thick/2),roundc+(zsize-roundc)/2])
 cube([xsize-(2*roundc),thick,zsize-roundc],center=true);//
  translate ([ 0,-((ysize/2)-(thick/2)),roundc+(zsize-roundc)/2])
 cube([xsize-(2*roundc),thick,zsize-roundc],center=true);//
  translate ([ (xsize/2)-(thick/2),0,roundc+(zsize-roundc)/2])
 cube([thick,ysize-(2*roundc),zsize-roundc],center=true);//
   translate ([ -((xsize/2)-(thick/2)),0,roundc+(zsize-roundc)/2])
 cube([thick,ysize-(2*roundc),zsize-roundc],center=true);//
 
 //edges
 translate ([ 0,((ysize/2)-roundc),roundc])
 rotate([ 0,90,0])
 difference() {
     cylinder(h=xsize-2*roundc,r=roundc,$fn=fn_edge_out,center=true);
     cylinder(h=xsize,r=roundc-thick,$fn=fn_edge_in,center=true);
                 translate ([0, -(roundc+thick/2),0])
    cube([2*roundc+thick,2*roundc+thick,xsize],center=true);
                      translate ([-(roundc+thick/2), 0,0])
    cube([2*roundc+thick,2*roundc+thick,xsize],center=true);
 }
 
  translate ([ 0,-((ysize/2)-roundc),roundc])
 rotate([ 0,90,0])
 difference() {
     cylinder(h=xsize-2*roundc,r=roundc,$fn=fn_edge_out,center=true);
     cylinder(h=xsize,r=roundc-thick,$fn=fn_edge_in,center=true);
                 translate ([0, (roundc+thick/2),0])
    cube([2*roundc+thick,2*roundc+thick,xsize],center=true);
                      translate ([-(roundc+thick/2), 0,0])
    cube([2*roundc+thick,2*roundc+thick,xsize],center=true);
 }
 
   translate ([ ((xsize/2)-roundc),0,roundc])
 rotate([ 90,0,0])
 difference() {
     cylinder(h=ysize-2*roundc,r=roundc,$fn=fn_edge_out,center=true);
     cylinder(h=ysize,r=roundc-thick,$fn=fn_edge_in,center=true);
                 translate ([-(roundc+thick/2), 0,0])
    cube([2*roundc+thick,2*roundc+thick,ysize],center=true);
                      translate ([0, (roundc+thick/2),0])
    cube([2*roundc+thick,2*roundc+thick,ysize],center=true);
 }
 
    translate ([ -((xsize/2)-roundc),0,roundc])
 rotate([ 90,0,0])
 difference() {
     cylinder(h=ysize-2*roundc,r=roundc,$fn=fn_edge_out,center=true);
     cylinder(h=ysize,r=roundc-thick,$fn=fn_edge_in,center=true);
                 translate ([(roundc+thick/2), 0,0])
    cube([2*roundc+thick,2*roundc+thick,ysize],center=true);
                      translate ([0,(roundc+thick/2),0])
    cube([2*roundc+thick,2*roundc+thick,ysize],center=true);
 }
 
  translate ([ -((xsize/2)-roundc),-((ysize/2)-roundc),roundc+(zsize-roundc)/2])
  difference() {
     cylinder(h=zsize-roundc,r=roundc,$fn=fn_edge_out,center=true);
     cylinder(h=zsize,r=roundc-thick,$fn=fn_edge_in,center=true);
                 translate ([0, (roundc+thick/2),0])
    cube([2*roundc+thick,2*roundc+thick,zsize],center=true);
                      translate ([(roundc+thick/2), 0,0])
    cube([2*roundc+thick,2*roundc+thick,zsize],center=true);
 }
 
   translate ([ -((xsize/2)-roundc),((ysize/2)-roundc),roundc+(zsize-roundc)/2])
  difference() {
     cylinder(h=zsize-roundc,r=roundc,$fn=fn_edge_out,center=true);
     cylinder(h=zsize,r=roundc-thick,$fn=fn_edge_in,center=true);
                 translate ([0, -(roundc+thick/2),0])
    cube([2*roundc+thick,2*roundc+thick,zsize],center=true);
                      translate ([(roundc+thick/2), 0,0])
    cube([2*roundc+thick,2*roundc+thick,zsize],center=true);
 }
 
    translate ([ ((xsize/2)-roundc),((ysize/2)-roundc),roundc+(zsize-roundc)/2])
  difference() {
     cylinder(h=zsize-roundc,r=roundc,$fn=fn_edge_out,center=true);
     cylinder(h=zsize,r=roundc-thick,$fn=fn_edge_in,center=true);
                 translate ([0, -(roundc+thick/2),0])
    cube([2*roundc+thick,2*roundc+thick,zsize],center=true);
                      translate ([-(roundc+thick/2), 0,0])
    cube([2*roundc+thick,2*roundc+thick,zsize],center=true);
 }
 
     translate ([ ((xsize/2)-roundc),-((ysize/2)-roundc),roundc+(zsize-roundc)/2])
  difference() {
     cylinder(h=zsize-roundc,r=roundc,$fn=fn_edge_out,center=true);
     cylinder(h=zsize,r=roundc-thick,$fn=fn_edge_in,center=true);
                 translate ([0, (roundc+thick/2),0])
    cube([2*roundc+thick,2*roundc+thick,zsize],center=true);
                      translate ([-(roundc+thick/2), 0,0])
    cube([2*roundc+thick,2*roundc+thick,zsize],center=true);
 }
 //corners
         translate ([ -((xsize/2)-roundc),-((ysize/2)-roundc),roundc])
difference() {
    sphere(roundc, $fn=fn_corner_out);
    sphere(roundc-thick, $fn=fn_corner_in);
    translate ([ 0,0,roundc+thick/2])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
        translate ([ roundc+thick/2,0,0])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
            translate ([0, roundc+thick/2,0])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
 }

          translate ([ -((xsize/2)-roundc),((ysize/2)-roundc),roundc])
difference() {
    sphere(roundc, $fn=fn_corner_out);
    sphere(roundc-thick, $fn=fn_corner_in);
    translate ([ 0,0,roundc+thick/2])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
        translate ([ roundc+thick/2,0,0])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
            translate ([0, -(roundc+thick/2),0])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
 }
 
           translate ([ ((xsize/2)-roundc),((ysize/2)-roundc),roundc])
difference() {
    sphere(roundc, $fn=fn_corner_out);
    sphere(roundc-thick, $fn=fn_corner_in);
    translate ([ 0,0,roundc+thick/2])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
        translate ([ -(roundc+thick/2),0,0])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
            translate ([0, -(roundc+thick/2),0])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
 }
 
           translate ([ ((xsize/2)-roundc),-((ysize/2)-roundc),roundc])
difference() {
    sphere(roundc, $fn=fn_corner_out);
    sphere(roundc-thick, $fn=fn_corner_in);
    translate ([ 0,0,roundc+thick/2])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
        translate ([ -(roundc+thick/2),0,0])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
            translate ([0, (roundc+thick/2),0])
    cube([2*roundc+thick,2*roundc+thick,2*roundc+thick],center=true);
 }
 }