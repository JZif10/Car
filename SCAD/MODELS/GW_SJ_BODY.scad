//
// GW_SJ_BODY.scad
//
// 1989 Jeep Grand Wagoneer
//
// REV5
//
// Body envelope model.
//
// Coordinate System:
//
// Firewall = X 0
//
// Engine Bay  = Negative X
//
// Cabin       = Positive X
//

//
// OVERALL BODY
//

SJ_LENGTH = 189.0;
SJ_WIDTH  = 76.8;
SJ_HEIGHT = 67.5;

//
// ENGINE BAY
//

ENGINE_BAY_LENGTH = 35;
ENGINE_BAY_WIDTH  = 60;
ENGINE_BAY_HEIGHT = 36;

//
// CABIN
//

CABIN_LENGTH = 140;
CABIN_WIDTH  = 62;
CABIN_HEIGHT = 44;

//
// CARGO
//

CARGO_LENGTH = 50;
CARGO_WIDTH  = 60;
CARGO_HEIGHT = 30;

//
// LIFTGATE
//

LIFTGATE_LENGTH = 10;
LIFTGATE_WIDTH  = 50;
LIFTGATE_HEIGHT = 20;

//
// BODY ENVELOPE
//

module body_envelope()
{
    color(
    [
        0.7,
        0.7,
        0.7,
        0.08
    ])

    translate(
    [
        95,
        0,
        34
    ])

    cube(
    [
        SJ_LENGTH,
        SJ_WIDTH,
        SJ_HEIGHT
    ],
    center=true
    );
}

//
// ENGINE BAY
//

module engine_bay_volume()
{
    color(
    [
        1,
        0,
        0,
        0.07
    ])

    translate(
    [
        -17,
        0,
        24
    ])

    cube(
    [
        ENGINE_BAY_LENGTH,
        ENGINE_BAY_WIDTH,
        ENGINE_BAY_HEIGHT
    ],
    center=true
    );
}

//
// CABIN
//

module cabin_volume()
{
    color(
    [
        0,
        0,
        1,
        0.05
    ])

    translate(
    [
        95,
        0,
        30
    ])

    cube(
    [
        CABIN_LENGTH,
        CABIN_WIDTH,
        CABIN_HEIGHT
    ],
    center=true
    );
}

//
// CARGO
//

module cargo_volume()
{
    color(
    [
        0,
        1,
        0,
        0.05
    ])

    translate(
    [
        145,
        0,
        18
    ])

    cube(
    [
        CARGO_LENGTH,
        CARGO_WIDTH,
        CARGO_HEIGHT
    ],
    center=true
    );
}

//
// LIFTGATE
//

module liftgate_volume()
{
    color(
    [
        1,
        1,
        0,
        0.08
    ])

    translate(
    [
        185,
        0,
        55
    ])

    cube(
    [
        LIFTGATE_LENGTH,
        LIFTGATE_WIDTH,
        LIFTGATE_HEIGHT
    ],
    center=true
    );
}

//
// DRIVER SEAT ENVELOPE
//

module driver_seat_envelope()
{
    color(
    [
        1,
        0.5,
        0,
        0.10
    ])

    translate(
    [
        50,
        -15,
        12
    ])

    cube(
    [
        22,
        22,
        24
    ],
    center=true
    );
}

//
// PASSENGER SEAT ENVELOPE
//

module passenger_seat_envelope()
{
    color(
    [
        1,
        0.5,
        0,
        0.10
    ])

    translate(
    [
        50,
        15,
        12
    ])

    cube(
    [
        22,
        22,
        24
    ],
    center=true
    );
}

//
// LEFT CARGO CAVITY
//

module cargo_left_cavity()
{
    color(
    [
        0,
        1,
        1,
        0.10
    ])

    translate(
    [
        145,
        -25,
        18
    ])

    cube(
    [
        20,
        8,
        18
    ],
    center=true
    );
}

//
// RIGHT CARGO CAVITY
//

module cargo_right_cavity()
{
    color(
    [
        0,
        1,
        1,
        0.10
    ])

    translate(
    [
        145,
        25,
        18
    ])

    cube(
    [
        20,
        8,
        18
    ],
    center=true
    );
}

//
// BODY REFERENCE PLANES
//

module firewall_plane()
{
    color("red")

    translate(
    [
        0,
        0,
        24
    ])

    cube(
    [
        0.15,
        60,
        40
    ],
    center=true
    );
}

//
// MASTER BODY
//

module sj_body()
{
    body_envelope();

    engine_bay_volume();

    cabin_volume();

    cargo_volume();

    liftgate_volume();

    driver_seat_envelope();

    passenger_seat_envelope();

    cargo_left_cavity();

    cargo_right_cavity();

    firewall_plane();
}