

use <lib/shortcuts.scad>
use <lib/mhop_lib.scad>


a=80;
b=30;
e=3;
h=50;

module Tri(a)
{
	polygon(points=[[0,0], [0, a], [a,0]]);
}


va=[ [-a/2,-b/2], [a/2,-b/2], 
     [a/2, b/2-e], [a/2-e, b/2],
     [-a/2+e,b/2],[-a/2,b/2-e] ];


linear_extrude(height=h)
polygon(points=va);


