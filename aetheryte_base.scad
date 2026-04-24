// AETHERYTE – PART 1: BASE

$fn = 50;

base1_size = [70, 70, 10];
base2_size = [55, 55, 8];
base3_size = [40, 40, 6];

collar_radius = 9;
tolerance     = 0.4;

bay_tab_count = 3;
bay_tab_w = 8;
bay_tab_h = 2.5;
bay_tab_r = collar_radius + 3;
bay_entry_h = 3;
bay_lock_depth = 3;

base_top = base1_size[2] + base2_size[2] + base3_size[2];

base();

module base()
{
    difference()
    {
        union()
        {
            // tier 1
            translate([-base1_size[0]/2, -base1_size[1]/2, 0])
                cube(base1_size);

            // decorative notches tier 1
            for (i = [0 : 7])
                rotate([0, 0, i * 45])
                    translate([base1_size[0]/2 - 3, -2, 2])
                        cube([4, 4, 6]);

            // tier 2
            translate([-base2_size[0]/2, -base2_size[1]/2, base1_size[2]])
                cube(base2_size);

            // decorative notches tier 2
            for (i = [0 : 3])
                rotate([0, 0, i * 90])
                    translate([base2_size[0]/2 - 2, -3, base1_size[2] + 1])
                        cube([3, 6, 5]);

            // tier 3
            translate([-base3_size[0]/2, -base3_size[1]/2,
                       base1_size[2] + base2_size[2]])
                cube(base3_size);
        }

        // recess on tier 3 top
        translate([-(base3_size[0] - 12)/2,
                   -(base3_size[1] - 12)/2,
                    base_top - 2])
            cube([base3_size[0] - 12, base3_size[1] - 12, 3]);

        // cross channel on tier 3
        for (rot = [0, 90])
            rotate([0, 0, rot])
                translate([-base3_size[0]/2, -1.5,
                            base1_size[2] + base2_size[2]])
                    cube([base3_size[0], 3, 3]);

        // central bore for collar stem
        translate([0, 0, base_top - bay_entry_h - bay_tab_h - 1])
            cylinder(h = bay_entry_h + bay_tab_h + 2,
                     r = bay_tab_r + tolerance, $fn = 50);

        // bayonet L-channels
        for (i = [0 : bay_tab_count - 1])
        {
            rotate([0, 0, i * (360 / bay_tab_count)])
            {
                // vertical entry slot
                rotate([0, 0, -bay_tab_w / 2])
                rotate_extrude(angle = bay_tab_w + tolerance, $fn = 100)
                    translate([bay_tab_r - tolerance, 0])
                        square([bay_tab_h + tolerance * 2,
                                bay_entry_h + bay_tab_h + 2]);

                // horizontal lock pocket
                rotate([0, 0, -bay_tab_w / 2])
                rotate_extrude(angle = bay_lock_depth + bay_tab_w + tolerance,
                               $fn = 100)
                    translate([bay_tab_r - tolerance,
                               base_top - bay_tab_h - bay_entry_h])
                        square([bay_tab_h + tolerance * 2,
                                bay_tab_h + tolerance]);
            }
        }
    }
}
