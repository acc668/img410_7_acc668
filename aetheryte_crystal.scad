// AETHERYTE – PART 3: CRYSTAL ASSEMBLY (orb + pin + cluster)

$fn = 50;

base1_size = [70, 70, 10];
base2_size = [55, 55, 8];
base3_size = [40, 40, 6];
collar_height = 10;
orb_r = 4;

ring_z = 52;
ring_thickness = 2.5;
support_bar_r = 1.5;
divot_r = support_bar_r + 0.4;
divot_depth = 2.5;

base_top = base1_size[2] + base2_size[2] + base3_size[2];
orb_z = base_top + collar_height + 2;

crystal_assembly();

module crystal_assembly()
{
    difference()
    {
        union()
        {
            // orb – sits in collar socket
            translate([0, 0, orb_z])
                sphere(r = orb_r, $fn = 40);

            // connecting pin: orb to cluster base
            translate([0, 0, orb_z])
                cylinder(h = 6, r = 1.5, $fn = 16);

            // crystal cluster
            crystal_cluster(orb_z + 6);
        }

        // two divots on opposite sides of the crystal body
        // the ring support bars slide in here to hold the ring in place
        for (i = [0 : 1])
        {
            rotate([0, 0, i * 180])
            translate([0, 0, ring_z + ring_thickness / 2])
            rotate([0, 90, 0])
                cylinder(h = divot_depth, r = divot_r, $fn = 16);
        }
    }
}

module crystal_cluster(z0)
{
    // central tall spire
    translate([0, 0, z0])
    rotate([0, 0, 45])
    union()
    {
        cylinder(h = 18, r1 = 2, r2 = 10, $fn = 4);
        translate([0, 0, 18])
            cylinder(h = 38, r1 = 10, r2 = 0, $fn = 4);
    }

    // secondary spire – left
    translate([-5, 2, z0 - 2])
    rotate([5, -8, 38])
    union()
    {
        cylinder(h = 10, r1 = 1, r2 = 5, $fn = 4);
        translate([0, 0, 10])
            cylinder(h = 22, r1 = 5, r2 = 0, $fn = 4);
    }

    // secondary spire – right
    translate([5, -2, z0 - 2])
    rotate([-5, 8, 20])
    union()
    {
        cylinder(h = 10, r1 = 1, r2 = 5, $fn = 4);
        translate([0, 0, 10])
            cylinder(h = 20, r1 = 5, r2 = 0, $fn = 4);
    }

    // small rear accent spire
    translate([2, 5, z0])
    rotate([10, 3, 60])
    union()
    {
        cylinder(h = 6, r1 = 1, r2 = 3, $fn = 4);
        translate([0, 0, 6])
            cylinder(h = 14, r1 = 3, r2 = 0, $fn = 4);
    }

    // lower body cluster fragment
    translate([-4, -3, z0 - 4])
    rotate([-4, -6, 50])
    union()
    {
        cylinder(h = 5, r1 = 1, r2 = 3.5, $fn = 4);
        translate([0, 0, 5])
            cylinder(h = 10, r1 = 3.5, r2 = 0, $fn = 4);
    }
}
