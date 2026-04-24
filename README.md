# Project 7: CSG

A 3D-printable model of the Aetheryte crystal from Final Fantasy XIV, built in OpenSCAD. The model is split into four separate printable parts that assemble together using a bayonet-style lock and a ball-in-socket rotating joint.

## Parts

- **aetheryte_base.scad** – The three-tiered decorative base. Includes bayonet L-channels in the top tier that receive the collar.
- **aetheryte_collar.scad** – The ornate collar mount with bayonet tabs that lock into the base. Features a hemispherical socket on top for the rotating crystal assembly.
- **aetheryte_crystal.scad** – The crystal cluster and orb assembly. The orb sits in the collar socket and can rotate freely. Includes divots on the sides to receive the ring support bars.
- **aetheryte_ring.scad** – The large tilted orbital ring with prongs, outer crystal spikes, and support bars that seat into the crystal divots.

## Assembly Instructions

1. Print all four parts.
2. Drop the **crystal** orb down into the **collar** socket.
3. Align the **collar** bayonet tabs with the entry slots in the **base**, press down, then twist ~45° to lock.
4. Slide the **ring** down over the crystal from the top until the support bar tips seat into the crystal divots.

## Print Settings Per Part

| Part | Infill | Layer Height | Shells | Notes |
|------|--------|--------------|--------|-------|
| Base | 10% | 0.2mm | 2 | No special requirements |
| Collar | 10% | 0.2mm | 3–4 | Extra shells needed for bayonet tab strength |
| Crystal | 10% | 0.2mm | 2 | Pin is small but shells fill it naturally |
| Ring | 10% | 0.2mm | 2 | Support bars increased to 3mm diameter for printability |

## Print Notes

- Recommended filament: PLA or PLA+
- Print the base and collar flat on the bed
- Print the crystal and ring upright
- A `tolerance` variable at the top of each file can be adjusted if fits are too tight or too loose (default: 0.4mm)

## Author(s)

Name: Alexandra Curry  
Email: [acc668@nau.edu]

## Known Issues

Some elements of the model do not perfectly replicate the reference design. Achieving a closer match to certain geometric details such as the organic clustering of the crystal spires and the exact curvature of the orbital ring proved difficult to refine without introducing conflicts in the surrounding geometry. The overall form and proportions are representative of the Aetheryte design, but minor visual discrepancies exist.
