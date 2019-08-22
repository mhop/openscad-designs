//////////////////////////////////////////////////////////////////////////////////////
///
///  eTrexBarMount - Bike handlebar mount for :
///        
///                   -- Garmin eTrex C/Cx/HCx GPS devices
///                      Supports all the eTrex models that come supplied
///                      with a mount clip that can be screwed to the
///                      battery cover (such as the Legend C/Cx/HCx and the
///                      Vista C/Cx/HCx models).
///
///                   -- Garmin eTrex 10/20/30
///
///                   The bar mount is hinged so that it easily opens
///                   for "clipping" it over the handlebar. Thus, there
///                   is no "bending" of the printed material necessary,
///                   implying that it should also be printable in PLA.
///
///                   An M3x25mm bolt plus screw nut are needed for
///                   the axis of the hinge.  And an M4x25mm bolt plus
///                   screw nut are needed for fasteing the mount on the
///                   handlebar.
///
//////////////////////////////////////////////////////////////////////////////////////
///
///  2013-10-09 Heinz Spiess, Switzerland
///
///  released under Creative Commons - Attribution - Share Alike licence
//////////////////////////////////////////////////////////////////////////////////////

$fn = 60;

//////////////////////////////////////////////////////////////////////////////////////
// draw an arc width height h between radius r1..r2 and angles a1..a2
module arc(r1,r2,h,a1=0,a2=0){
     if(a2-a1<=180){
        difference(){
           cylinder(r=r2,h=h);
           translate([0,0,-1])cylinder(r=r1,h=h+2);
           rotate(a2)translate([-r1-r2,0,-1])cube([2*(r1+r2),2*(r1+r2),h+2]);
           rotate(a1+180)translate([-r1-r2,0,-1])cube([2*(r1+r2),2*(r1+r2),h+2]);
        }
     } else {
           difference(){
              cylinder(r=r2,h=h);
              translate([0,0,-1])cylinder(r=r1,h=h+2);
              intersection(){
               rotate(a2)translate([-r1-r2,0,-1])cube([2*(r1+r2),2*(r1+r2),h+2]);
               rotate(a1+180)translate([-r1-r2,0,-1])cube([2*(r1+r2),2*(r1+r2),h+2]);
              }
           }
     }
}
//////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////
//  Slide rail for older Garmin eTrex C/HC/Cx/HCx GPS models (Legend, Vista, Venture etc.)
//  These include a screw-on clip which can be used to attach the device to this counter part.
module etrex1(h=50){

   //h = 50; // height
   d = 8.5;  // depth
   w = 22; // width
   wall = 1.3; //wall size
   rd = 4.2;    //rail depth
   rw = 1.7;   //rail depth
   ro = 13; //inner rail width
   ri = 16.8; //outer rail width
   rh = 10;   //height of rail segment
   re = 1;   //height of rail segment
   cz = 44.5;  //z position of clip cavity
   cw = 9;   //width of clip cavity
   ch = 5;   //height of clip cavity
   cd = 2.5;   //height of clip cavity
   
   
   difference(){
      // main body
      hull(){
         translate([-w/2,-rd/2,0])cube([w,d-rd/2,0.1]);
         translate([-w/2,-rd,rh])cube([w,d,3*rh]);
         translate([-w/2,0,h-0.1])cube([w,d-rd,0.1]);
      }
   
      // clip cavity
      hull(){
         translate([-cw/2,-0.1,cz-ch])cube([cw,0.2,0.1]);
         translate([-cw/2,-0.1,cz-ch/2])cube([cw,cd,ch/2]);
         translate([-cw/2,-0.1,cz+1])cube([cw,0.2,0.1]);
      }
   
      //slide rails
      translate([-ro/2,-rd-0.1,-1])cube([ro,rd+0.1,h+2]);
      for(z=[[0,rh+0.25],[2*rh,2*rh]]){
         translate([-ri/2,-rd+rw,z[0]+rh+re])cube([ri,rd-rw,rh]);
         hull(){
            translate([-ri/2,-rd-0.1,z[0]+2*rh+0.5])cube([ri,0.1,z[1]]);
            translate([-ri/2,-0.1,z[0]+2*rh-1])cube([ri,0.1,z[1]]);
         }
      }
   }
}

//////////////////////////////////////////////////////////////////////////////////////
//  Slide rail for the newer Garmin eTrex 10/20/30 GPS models 
//  (This one should probably work as well for many other newer handheld
//  Garmin GPS devices, such as Colorado, Dakota, GPSMAP, Oregon - but 
//  since I only have an eTrex 20, I have not been able to test that)
module etrex2(D=6,screws=true) {
//D = 6;       // Depth of mount 
Ro = 60;     // outer radius of Garmin back
Ri = 50;     // inner radius of Garmin back
Wt = 31;     // overal total width
Wos = 26;    // with of outer slide rail
Wis = 21;    // with of inner slide rail
Ds = 3.5;     // Depth of slide rail
Hs = 28;     // length f sliding rail
Stop = 1.5;  // thickness of slide stop
Stem_ZOff = 36;
Stem_XOff = 6.0;
Stem_W = 10;
Ht = Hs-Stop+Stem_ZOff+Stem_XOff/2; // overall height

  difference(){
    union(){
    // slide rail
    difference(){
       intersection(){
          translate([-D,-Wt/2,0])cube([Wt,Wt,Hs]);
          translate([-D,0,Hs/2])rotate(a=90,v=[0,1,0])cylinder(r=Hs/sqrt(2)+0.5,h=2*Hs);
          translate([-2*D+sqrt(Wt*Wt+4*D*D)/2,0,-1])cylinder(r=sqrt(Wt*Wt+4*D*D)/2+1.4,h=2*Hs);
       }
       intersection(){
          translate([Ro,0,-1])cylinder(r=Ro,h=Ht+2,$fn=120);
	  union(){
	     translate([0,-Wos/2,-1])cube([Ds,Wos,Hs-Stop+1]);
	     translate([0,-Wis/2,-1])cube([10,Wis,Ht+2]);
	  }
       }
       translate([Ds+Ri,0,-1])cylinder(r=Ri,h=Hs+2,$fn=120);
       // screw hole with nut cavity
       //translate([0,0,Hs/2])rotate(a=90,v=[0,1,0])translate([0,0,-Hs])cylinder(r=2.2,h=2*Hs);
       //translate([0,0,Hs/2])rotate(a=90,v=[0,-1,0])translate([0,0,-1])rotate(30)cylinder(r=4.1,h=1+3.5,$fn=6);
    }
    // middle part
    difference(){
        hull(){
            translate([-D,-Wt/2,Hs])cube([D,Wt,0.1]);
            translate([-D,-Wt/2,Hs+(Wt-1.5*Stem_W)/2])cube([D-2.5,Wt,0.1]);
	}
	for(s=[-1,1]) translate([-D-1,s*Wt/2,Hs+(Wt-1.5*Stem_W)/2-0.1])
	    rotate(a=90,v=[0,1,0])cylinder(h=D+2,r=(Wt-1.5*Stem_W)/2);
    }
    // upper part of stem
    hull(){
        translate([-D,-0.75*Stem_W,Hs+(Wt-1.5*Stem_W)/2-0.1])cube([D-2.5,1.5*Stem_W,0.1]);
        translate([2,-Stem_W/2,Ht-2])cube([Stem_XOff*.3,Stem_W,1]);
        translate([2,0,Ht-2])rotate(a=90,v=[0,1,0])cylinder(h=.5,r=Stem_W/2);
    }
        translate([2.5,0,Ht-1])rotate(a=75,v=[0,1,0])translate([-3,0,-0.7])cylinder(h=2.3,r=.6*Stem_W);
    // click part of stem
    hull(){
       translate([2,-Stem_W/2,Ht-1.2*Stem_XOff+1])cube([1,Stem_W,Stem_XOff-2]);
       translate([Stem_XOff,-Stem_W*.3,Ht-Stem_XOff/2-1/2])cube([0.1,0.6*Stem_W,0.75]);
    }          
    }
    // screw holes with nut cavity at 10mm and 30mm 
    if(screws)for(Hh = [8,28])translate([0,0,Hh]){
       rotate(a=90,v=[0,1,0])translate([0,0,-Hs])cylinder(r=2.2,h=2*Hs);
       rotate(a=90,v=[0,-1,0])translate([0,0,-1])rotate(30)cylinder(r=4.2,h=1+3.5,$fn=6);
    }
  }
}


//////////////////////////////////////////////////////////////////////////////////////
// This is the bike handlebar mount for the Garmin eTrex GPS device.
// The bar diameter is configurable within some reasonable range (about 20-30mm)
// A 25mm M3 bolt and screw nut are needed for the axis of the hinge.
// A 20mm or 25mm M4 bolt and screw nut are needed for fastening the mount on the bar.
//
//////////////////////////////////////////////////////////////////////////////////////
module eTrexBarMount(e=1,w=20,h=50,bar=25,p=0){
   //e=1;    // 1=etrex1() for eTrex C/Cx/HCx models with screw-on clip
             // 0=no slide rail, just the handlebar mount (use p>0 for thicker plate)
   //bar=28; // diameter of bar
   //h = 40; // height
   //w = 20; // width
   //p = 0;  // extra plate thickness 
   wall = 6; // wall thickness
   gap = 5;  // gap allowing "overfastening" of the mount
   eps = 0.6;// separation between the two opposite hinge sides
   m3 = 3.2; // m3 screw diameter
   m4 = 4.3; // m4 screw diameter
   d = 8.5;  // depth of clip-on part (module etrex1)
   rd = 4.2; // rail depth of clip-on part (module etrex1)
   sup = 1.5;// width of support bridges below the hinge (must be cut after printing!)

   difference(){
      union(){

         // etrex mount with slide rail
         if(e==1)translate([w/2,-d-p+rd+0.1,0])etrex1(h=h);
         if(e==2) translate([w/2,-6-p+0.1,0])rotate(-90)etrex2(screws=false);

	 // main body
         hull(){
            union(){
	       intersection(){
	          // square frame
                  translate([0,-p,0])cube([w,bar+wall+p,h]);
                  // rounded lower part
                  translate([-1,wall,h/2])rotate(90,[0,1,0])cylinder(r=bar,h=w+2);
		  if(e==2)translate([-1,h/2-p,h/2])rotate(90,[0,1,0])cylinder(r=0.515*h,h=w+2);
               }
	       // base plate, needed for vertical printing
               translate([0,-p,0])cube([w,bar/2+wall+gap/2+p,wall]);
	    }
         }
      }
      
      // main cavity for handlebar
      translate([-1,bar/2,h/2])rotate(90,[0,1,0])cylinder(r=bar/2,h=w+2);

      // grooves in handlebar cavity
      for(x=[0.15*w,0.5*w,0.85*w])
          translate([x-1,bar/2,h/2])rotate(90,[0,1,0])cylinder(r=bar/2+0.75,h=2);

      // central widening for easier printing and better adjustability for slightly
      // larger handebar diameters
      hull(){
          translate([-1,bar/2-wall,h/2-bar/2+1.5])cube([w+2,2*wall,bar-3]);
          translate([-1,bar/2-3,h/2-bar/2-wall/2+2])cube([w+2,6,bar+wall-4]);
      }

      // vertical separation of hinge parts
      for(x=[0.28*w,0.72*w]) translate([x-eps/2,bar/2,0.5*(h+h/2+bar/2)])
         rotate(90,[0,1,0])cylinder(r=wall,h=eps);
      // round cut for the two outer parts of th hinge
      for(x=[0,0.72*w]) translate([x-eps/2,bar/2,0.5*(h+h/2+bar/2)])
         rotate(90,[0,1,0])arc(r1=wall-eps/2,r2=wall+eps/2,h=0.28*w+eps,a1=20,a2=180);
      // round cut for the inner part of th hinge
      for(x=[0.28*w]) translate([x-eps/2,bar/2,0.5*(h+h/2+bar/2)])
         rotate(90,[0,1,0])arc(r1=wall-eps/2,r2=wall+eps/2,h=0.44*w+eps,a2=-20,a1=-200);
      // hole for M3 bolt used for the hinge axis
      translate([-1,bar/2,0.5*(h+h/2+bar/2)])rotate(90,[0,1,0])
         rotate(30)cylinder(r=m3/2,h=w+2,$fn=6);

      // gap cut-out for mounting bolt
      translate([-1,bar/2-wall,-1])cube([w+2,gap,h/2]);

      // hole for M4x25mm bolt used to fix the mount on the handlebar
      translate([w/2,-d-1,w/4+1])rotate(a=-90,v=[1,0,0])cylinder(r=m4/2,h=h,$fn=6);
      // deepening for head of M4 bolt
      translate([w/2,-d-p-1,w/4+1])rotate(a=-90,v=[1,0,0])
         rotate(22.5)cylinder(r1=6,r2=4,h=d+p+2,$fn=8);
      // hexagonal deepening to hold M$ nut (it's tight on purpose, I use the hot soldering
      // iron to push the screw nut in, so it sticks firmly)
      translate([w/2,18,w/4+1])rotate(a=-90,v=[1,0,0])cylinder(r=3.5/cos(30),h=d+1.5,$fn=6);
      // base for support bridges
      for(s=[-1,+1])
      translate([-1,bar/2+s*0.65*wall-1,h/2+bar/2+0.5])cube([w+2,2,0.75]);
      //translate([-1,bar/2-0.7*wall,h/2+bar/2+0.5])cube([w+2,1.4*wall,0.5]);
   }

   // support bridges underneath hinge (cut with knife after printing!)
   for(x=[0+sup/2,
       0.28*w-eps/2-sup/2,0.28*w+eps/2+sup/2,
       0.72*w-eps/2-sup/2,0.72*w+eps/2+sup/2,
       w-sup/2])
           translate([x-sup/2,bar/2-wall,h/2+bar/2+0.5])cube([sup,2*wall,0.75]);


}

// ...on the following lines you have to activate the desired object by uncommenting...

// The following are for eTrex Legend/Vista/Venture C/Cx/HC/HCx (using e=1)
//eTrexBarMount(e=1,w=22,h=49.0,bar=25.2);
//eTrexBarMount(e=1,w=22,h=48,bar=22.5);
//eTrexBarMount(e=1,w=22,h=50,bar=28.2);
//translate([0,-50,0])eTrexBarMount(e=1,w=22,h=48,bar=22.5);
//translate([0,50,0])eTrexBarMount(e=1,w=22,h=50,bar=28.2);

// The following are for the newer eTrex 10/20/30 (using e=2)
eTrexBarMount(e=2,w=20,h=49.0,bar=25.2,p=3);
//eTrexBarMount(e=2,w=20,h=48.0,bar=22.5,p=3);
//eTrexBarMount(e=2,w=20,h=50.0,bar=28.2,p=3);

// just the 25mm barmount, no etrex slide rail
//eTrexBarMoun(e=0,w=22,h=49.0,bar=25.2,p=5);
