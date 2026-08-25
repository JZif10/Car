//
// GW_FLOORPAN.scad
//
// 1989 Jeep Grand Wagoneer (SJ)
//
// REV5
//
// Interior floor structure
// and electrical mounting zones.
//

//
// FLOOR PARAMETERS
//

FLOOR_LENGTH = 170.0;
FLOOR_WIDTH  = 60.0;
FLOOR_THICKNESS = 0.125;

//
// TRANSMISSION TUNNEL
//

TUNNEL_LENGTH = 60.0;
TUNNEL_WIDTH  = 12.0;
TUNNEL_HEIGHT = 8.0;

//
// FRONT SEAT REFERENCE LOCATIONS
//

DRIVER_SEAT_POS =
[
    50,
    -15,
    12
];

PASSENGER_SEAT_POS =
[
    50,
    15,
    12
];

//
// REAR SEAT REFERENCE
//

REAR_SEAT_POS =
[
    92,
    0,
    12
];

//
// ELECTRONICS ZONES
//

CONSOLE_ZONE =
[
    60,
    0,
    18
];

AUDIO_RACK_ZONE =
[
    110,
    15,
    8
];

CARGO_ZONE =
[
    145,
    15,
    18
];

LITHIUM_ZONE =
[
    150,
    18,
    8
];

INVERTER_ZONE =
[
    150,
    -18,
    10
];

//
// FLOOR PANEL
//

module floor_surface()
{
    translate(
    [
        90,
        0,
        2
    ])

    color("silver")

    cube(
    [
        FLOOR_LENGTH,
        FLOOR_WIDTH,
        FLOOR_THICKNESS
    ],
    center=true);
}

//
// TRANSMISSION TUNNEL
//

module transmission_tunnel()
{
    translate(
    [
        60,
        0,
        6
    ])

    color("lightgray")

    cube(
    [
        TUNNEL_LENGTH,
        TUNNEL_WIDTH,
        TUNNEL_HEIGHT
    ],
    center=true);
}

//
// FRONT SEAT MOUNTS
//

module front_seat_mounts()
{
    color("orange")

    translate(DRIVER_SEAT_POS)

    cube(
    [
        2,
        2,
        0.5
    ],
    center=true);

    translate(PASSENGER_SEAT_POS)

    cube(
    [
        2,
        2,
        0.5
    ],
    center=true);
}

//
// REAR SEAT MOUNT
//

module rear_seat_mount()
{
    color("orange")

    translate(REAR_SEAT_POS)

    cube(
    [
        4,
        2,
        0.5
    ],
    center=true);
}

//
// CONSOLE MOUNTING AREA
//

module console_mount_zone()
{
    translate(CONSOLE_ZONE)

    color([0,0,1,0.35])

    cube(
    [
        18,
        12,
        0.25
    ],
    center=true);
}

//
// AUDIO RACK AREA
//

module audio_rack_zone()
{
    translate(AUDIO_RACK_ZONE)

    color([1,0,0,0.35])

    cube(
    [
        24,
        16,
        0.25
    ],
    center=true);
}

//
// CARGO ELECTRONICS AREA
//

module cargo_electronics_zone()
{
    translate(CARGO_ZONE)

    color([0,1,0,0.35])

    cube(
    [
        18,
        12,
        0.25
    ],
    center=true);
}

//
// LITHIUM BATTERY BAY
//

module lithium_bay()
{
    translate(LITHIUM_ZONE)

    color([0,0,1,0.50])

    cube(
    [
        15,
        9,
        3
    ],
    center=true);
}

//
// INVERTER PLATFORM
//

module inverter_bay()
{
    translate(INVERTER_ZONE)

    color([1,0,0,0.50])

    cube(
    [
        24,
        12,
        2
    ],
    center=true);
}

//
// REFERENCE MARKERS
//

module floor_reference_points()
{
    color("yellow")

    translate(CONSOLE_ZONE)
        sphere(d=1);

    translate(AUDIO_RACK_ZONE)
        sphere(d=1);

    translate(CARGO_ZONE)
        sphere(d=1);

    translate(LITHIUM_ZONE)
        sphere(d=1);

    translate(INVERTER_ZONE)
        sphere(d=1);
}

//
// MASTER FLOORPAN ASSEMBLY
//

module floor_pan()
{
    floor_surface();

    transmission_tunnel();

    front_seat_mounts();

    rear_seat_mount();

    console_mount_zone();

    audio_rack_zone();

    cargo_electronics_zone();

    lithium_bay();

    inverter_bay();

    floor_reference_points();
}