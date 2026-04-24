// AETHERYTE – PART 4: RING ASSEMBLY

$fn = 50;

ring_radius    = 32;
ring_thickness = 2.5;
ring_z         = 52;

collar_radius = 9;

prong_count = 4;
prong_out = ring_radius;
prong_z = ring_z + 2;

small_crystal_count = 4;
small_crystal_out = ring_radius;
small_crystal_z = ring_z;
small_crystal_length = 14;

support_bar_r = 1.5;

union()
{
    halo_ring();
    ring_supports();
    prongs();
    outer_crystals();
}

// halo ring
module halo_ring()
{
    translate([0, 0, ring_z])
    rotate([20, 0, 0])
    difference()
    {
        cylinder(h = ring_thickness, r = ring_radius, $fn = 100);
        translate([0, 0, -1])
            cylinder(h = ring_thickness + 2,
                     r = ring_radius - ring_thickness - 1, $fn = 100);
    }
}

// ring supports
module ring_supports()
{
    support_length = ring_radius - collar_radius;

    for (i = [0 : 1])
    {
        rotate([0, 0, i * 180])
        translate([collar_radius, 0, ring_z + ring_thickness / 2])
        rotate([0, 90, 0])
            cylinder(h = support_length, r = support_bar_r, $fn = 12);
    }
}

// prongs – four diamond spikes on the ring
module prong()
{
    rotate([0, 0, 45])
    union()
    {
        cylinder(h = 6, r1 = 0, r2 = 2.5, $fn = 4);
        translate([0, 0, 6])
            cylinder(h = 6, r1 = 2.5, r2 = 0, $fn = 4);
    }
}

module prongs()
{
    for (i = [0 : prong_count - 1])
    {
        rotate([0, 0, i * (360 / prong_count)])
        translate([prong_out, 0, prong_z])
        rotate([0, 90, 0])
            prong();
    }
}

// outer crystals – up/down spike pairs on the ring
module outer_crystal_spike(len = small_crystal_length)
{
    rotate([0, 0, 45])
    union()
    {
        cylinder(h = len / 2, r1 = 1.5, r2 = 3.5, $fn = 4);
        translate([0, 0, len / 2])
            cylinder(h = len / 2, r1 = 3.5, r2 = 0, $fn = 4);
    }
}

module crystal_mount()
{
    cylinder(h = 3, r = 2.5, $fn = 16);
}

module outer_crystals()
{
    for (i = [0 : small_crystal_count - 1])
    {
        rotate([0, 0, i * (360 / small_crystal_count) + 45])
        translate([small_crystal_out, 0, small_crystal_z])
        union()
        {
            crystal_mount();

            translate([0, 0, 3])
                outer_crystal_spike(small_crystal_length);

            rotate([180, 0, 0])
                outer_crystal_spike(small_crystal_length);
        }
    }
}
