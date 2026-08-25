//
// GW_FRAME.scad
//
// 1989 Jeep Grand Wagoneer (SJ)
// REV5
//
// Master chassis frame model.
//

//
// FRAME PARAMETERS
//

FRAME_LENGTH = 154.0;
FRAME_WIDTH  = 34.0;

RAIL_HEIGHT     = 6.0;
RAIL_THICKNESS  = 0.188;

CROSSMEMBER_HEIGHT = 4.0;

//
// MOUNTING ZONES
//

ZONE_FRAME_ENGINE =
[
    25,
    0,
    10
];

ZONE_FRAME_MID =
[
    80,
    0,
    10
];

ZONE_FRAME_REAR =
[
    130,
    0,
    10
];

//
// BODY MOUNT DATABASE
//

BODY_MOUNTS =
[
    [20,-18],
    [20,18],

    [55,-18],
    [55,18],

    [95,-18],
    [95,18],

    [130,-18],
    [130,18]
];

//
// GROUND STUD DATABASE
//

GROUND_STUDS =
[
    ["G100",18,-16,10],

    ["G300",55,15,10],

    ["G400",90,14,10],

    ["G500",130,15,10],

    ["G600",130,-15,10]
];

//
// FRAME RAIL PROFILE
//

module frame_rail(
    length,
    height,
    thickness
)
{
    union()
    {
        //
        // Web
        //

        cube(
        [
            length,
            thickness,
            height
        ]);

        //
        // Top Flange
        //

        translate(
        [
            0,
            0,
            height - thickness
        ])

        cube(
        [
            length,
            2.0,
            thickness
        ]);

        //
        // Bottom Flange
        //

        cube(
        [
            length,
            2.0,
            thickness
        ]);
    }
}

//
// LEFT FRAME RAIL
//

module left_frame_rail()
{
    translate(
    [
        10,
        -FRAME_WIDTH / 2,
        4
    ])

    color("dimgray")

    frame_rail(
        FRAME_LENGTH,
        RAIL_HEIGHT,
        RAIL_THICKNESS
    );
}

//
// RIGHT FRAME RAIL
//

module right_frame_rail()
{
    translate(
    [
        10,
        FRAME_WIDTH / 2,
        4
    ])

    mirror([0,1,0])

    color("dimgray")

    frame_rail(
        FRAME_LENGTH,
        RAIL_HEIGHT,
        RAIL_THICKNESS
    );
}

//
// CROSSMEMBER
//

module crossmember(
    xloc,
    width = FRAME_WIDTH + 2
)
{
    translate(
    [
        xloc,
        -width / 2,
        5
    ])

    color("gray")

    cube(
    [
        2.0,
        width,
        CROSSMEMBER_HEIGHT
    ]);
}

//
// BODY MOUNTS
//

module body_mounts()
{
    for(p = BODY_MOUNTS)
    {
        translate(
        [
            p[0],
            p[1],
            10
        ])

        color("orange")

        cylinder(
            d = 1.5,
            h = 1.0,
            $fn = 32
        );
    }
}

//
// GROUND STUD VISUALIZATION
//

module frame_grounds()
{
    for(g = GROUND_STUDS)
    {
        translate(
        [
            g[1],
            g[2],
            g[3]
        ])

        color("green")

        cylinder(
            d = 0.5,
            h = 1.0,
            $fn = 24
        );
    }
}

//
// FRONT CROSSMEMBER
//

module front_crossmember()
{
    crossmember(20);
}

//
// TRANSMISSION CROSSMEMBER
//

module transmission_crossmember()
{
    crossmember(80);
}

//
// REAR CROSSMEMBER
//

module rear_crossmember()
{
    crossmember(150);
}

//
// MASTER FRAME ASSEMBLY
//

module sj_frame()
{
    left_frame_rail();

    right_frame_rail();

    front_crossmember();

    transmission_crossmember();

    rear_crossmember();

    body_mounts();

    frame_grounds();
}

