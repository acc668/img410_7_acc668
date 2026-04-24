// AETHERYTE – PART 2: COLLAR

$fn = 50;

base1_size = [70, 70, 10];
base2_size = [55, 55, 8];
base3_size = [40, 40, 6];

collar_radius = 9;
collar_height = 10;
tolerance = 0.4;
orb_r = 4;

bottom_crystal_length = 13;

bay_tab_count = 3;
bay_tab_w = 8;
bay_tab_h = 2.5;
bay_tab_r = collar_radius + 3;
bay_entry_h = 3;

base_top = base1_size[2] + base2_size[2] + base3_size[2];

union()
{
    collar();
    bottom_crystal();
}

module collar()
{
    difference()
    {
        union()
        {
            // main tapered collar body
            translate([0, 0, base_top + 2])
                cylinder(h = collar_height,
                         r1 = collar_radius + 3,
                         r2 = collar_radius, $fn = 50);

            // collar stem
            translate([0, 0, base_top - bay_entry_h - bay_tab_h])
                cylinder(h = bay_entry_h + bay_tab_h + 2,
                         r = bay_tab_r - bay_tab_h - tolerance, $fn = 50);

            // bayonet tabs
            for (i = [0 : bay_tab_count - 1])
            {
                rotate([0, 0, i * (360 / bay_tab_count)])
                rotate([0, 0, -bay_tab_w / 2])
                rotate_extrude(angle = bay_tab_w, $fn = 100)
                    translate([bay_tab_r - bay_tab_h,
                               base_top - bay_tab_h - bay_entry_h])
                        square([bay_tab_h, bay_tab_h]);
            }

            // decorative rim ring on collar top
            translate([0, 0, base_top + collar_height + 2])
            difference()
            {
                cylinder(h = 2, r = collar_radius + 1, $fn = 50);
                translate([0, 0, -1])
                    cylinder(h = 4, r = collar_radius - 2, $fn = 50);
            }
        }

        // hollow core
        translate([0, 0, base_top - bay_entry_h - bay_tab_h - 1])
            cylinder(h = collar_height + bay_entry_h + bay_tab_h + 6,
                     r = collar_radius - 4, $fn = 50);

        // hemispherical socket cup
        translate([0, 0, base_top + collar_height + 2])
            sphere(r = orb_r + tolerance, $fn = 40);

        // decorative vertical slots
        for (i = [0 : 3])
            rotate([0, 0, i * 90])
                translate([collar_radius - 1, -1, base_top + 6])
                    cube([4, 2, collar_height - 4]);
    }
}

// four downward shards around collar base
module bottom_crystal()
{
    for (i = [0 : 3])
    {
        rotate([0, 0, i * 90])
        translate([collar_radius - 1, 0, base_top + 3])
        rotate([0, 160, 45])
        union()
        {
            cylinder(h = bottom_crystal_length / 2,
                     r1 = 1, r2 = 3, $fn = 4);
            translate([0, 0, bottom_crystal_length / 2])
                cylinder(h = bottom_crystal_length / 2,
                         r1 = 3, r2 = 0, $fn = 4);
        }
    }
}
