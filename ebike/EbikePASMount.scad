
facets = 180.0;
slop = 0.4;

ringThick = 3.4;
id1 = 41.0;
pid1 = id1 + slop;
h1 = 3.0;

id2 = 39.0;
pid2 = id2 + slop;
h2 = 15.0;

// Radius of the circle that the magnets will be placed at
magnetCenterRadius = 37.0;

sensorHoleSpacing = 27.0;
sensorHoleDia = 3.5;
sensorHeight = 11.0;
sensorLength = 33.0;
sensorBackspace = 8.15;

//mountHeight = 5.0;
mountHeight = 1.0;
mountRecessThick = 1.0;

overallD = id1 + (2.0 * ringThick);
overallH = h1 + h2;

module holesPair(off, height, dia)
{
	for ( rt = [0.0, 180.0] )
	{
		rotate([0.0, 0.0, rt])
			translate([off, 0.0, -0.01])
				cylinder(h = height+1, d = dia, $fn = facets);
	}
}

module ringInner()
{

	h1plus = h1 + sensorBackspace;

	translate([0.0, 0.0, -sensorBackspace])
		cylinder(h = sensorBackspace, d1 = pid1 + 5.0, d2 = pid1, $fn = facets);

	cylinder(h = h1, d = pid1, $fn = facets);

	translate([0.0, 0.0, h1])
		cylinder(h = h2 + 1.0, d = pid2, $fn = facets);
}

module ringOuter()
{
	cylinder(h = overallH, d = overallD, $fn = facets);
}

module sensorMountClip()
{
	// clip the outer ring

	translate([0.0, 0.0, -sensorBackspace])
	{
		clipR = magnetCenterRadius + (0.5 * sensorHeight);

		*difference()
		{
			translate([0,0,-0.1]) cylinder(h = mountHeight+1, r = (clipR + 10.0), $fn = facets);
			cylinder(h = mountHeight, r = clipR, $fn = facets);
		}
	}
}

module sensorMount()
{

	// sensor mount
	y = magnetCenterRadius - (0.5 * sensorHeight);

	translate([-sensorLength / 2.0, y, -sensorBackspace])
	{
		linear_extrude(mountHeight) square([sensorLength, sensorHeight]);

		*translate([0.0, -sensorHeight, 0.0])
		{
			linear_extrude(mountHeight) square([sensorLength, sensorHeight]);

			translate([0.0, -3.8, 0.0])
				linear_extrude(mountHeight) square([sensorLength, 3.8]);
		}

		// fill gap between ring and sensor mount

		*translate([0.0, -sensorHeight - 3.8, mountHeight])
		{
			linear_extrude(sensorBackspace)
				square([sensorLength, sensorHeight]);
		}
	}
}

module outerShell()
{
	ringOuter();
	sensorMount();
}

module discard()
{
	ringInner();

	// clip section between ring and mount
	translate([0.0, 0.0, -3.15])
	{
		h1 = sensorBackspace + mountHeight;

		difference()
		{
			cylinder(h = h1, d = 65.0, $fn = facets);
			cylinder(h = h1, d1 = 55.0, d2 = 50.0, $fn = facets);
		}
	}

	translate([0.0, magnetCenterRadius, -sensorBackspace])
	{
		holesPair(0.5 * sensorHoleSpacing, mountHeight, sensorHoleDia);
		translate([0, 0, -0.1])cylinder(h = mountHeight+1, d = sensorHoleDia, $fn = facets);

/*
		// recess for screw head
		recessHeight = mountHeight - mountRecessThick;

		translate([0.5 * sensorHoleSpacing, 0.0, 0.0])
			cylinder(h = recessHeight+0.01, d = 5.0, $fn = facets);
*/
	}

	sensorMountClip();
}

module pasMount()
{
  translate([0, -37, 7.65])
	difference()
	{
		//outerShell();
		sensorMount();
		discard();
	}
}

pasMount();
