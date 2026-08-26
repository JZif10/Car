//BeginFolder CONFIG

//beginFile GW_CONFIG.scad
//
// GW_CONFIG.scad
//
// REV5
//
// Global project configuration.
//
// This file should contain ONLY:
//
// - Project metadata
// - Vehicle metadata
// - Engineering constants
// - Display options
// - Manufacturing factors
//
// No geometry.
// No routes.
// No circuits.
//

//
// PROJECT
//

PROJECT_NAME =
"1989 Jeep Grand Wagoneer";

PROJECT_CODE =
"GW_REV5";

PROJECT_REVISION =
"REV5";

//
// VEHICLE
//

VEHICLE_PLATFORM =
"SJ";

VEHICLE_YEAR =
1989;

//
// COORDINATE SYSTEM
//
// X = Front -> Rear
// Y = Driver -> Passenger
// Z = Floor -> Roof
//

COORD_SYSTEM =
"SJ_STANDARD";

//
// LENGTH UNITS
//

LENGTH_UNIT =
"INCH";

//
// ROUTING
//

SERVICE_LOOP_FACTOR =
1.10;

//
// CLAMPING
//

CLAMP_SPACING =
18.0;

MIN_BEND_RADIUS =
2.0;

//
// LOOMING
//

LOOM_FACTOR =
1.05;

//
// PURCHASING
//

PURCHASE_FACTOR =
1.15;

//
// DESIGN RULES
//

MAX_LENGTH_VARIANCE_PERCENT =
5.0;

//
// VISUALIZATION
//

SHOW_FRAME =
true;

SHOW_FIREWALL =
true;

SHOW_FLOORPAN =
true;

SHOW_COMPONENTS =
true;

SHOW_ANCHORS =
true;

SHOW_ROUTES =
true;

SHOW_HARNESSES =
true;

//
// REPORTS
//

GENERATE_BOM =
true;

GENERATE_CUTSHEET =
true;

GENERATE_LABELS =
true;

GENERATE_AS_BUILT =
true;

//
// ELECTRICAL SYSTEMS
//

ENABLE_CAN_BUS =
true;

ENABLE_ETHERNET =
true;

ENABLE_AUDIO =
true;

ENABLE_CAMERA_SYSTEM =
true;

ENABLE_INVERTER =
true;

ENABLE_LITHIUM_SYSTEM =
true;

//
// POWER SYSTEM
//

STARTING_BATTERY_MODEL =
"ODYSSEY_PC1500";

HOUSE_BATTERY_MODEL =
"LITHIUM_100AH";

INVERTER_MODEL =
"VICTRON";

//
// NETWORKING
//

NETWORK_BACKBONE =
"ETHERNET";

CAN_SPEED =
500000;

//
// DOCUMENTATION
//

LABEL_COPIES =
2;

CONNECTOR_LABEL_COPIES =
2;

HARNESS_LABEL_COPIES =
2;

GROUND_LABEL_COPIES =
2;

//
// DEBUG
//

DEBUG_MODE =
true;

REPORT_STARTUP_SUMMARY =
true;

RENDER_REFERENCE_POINTS =
true;

//
// HELPER REPORT
//

module report_config()
{
    echo(
        "========== CONFIG =========="
    );

    echo(
        str(
            "PROJECT: ",
            PROJECT_CODE
        )
    );

    echo(
        str(
            "REVISION: ",
            PROJECT_REVISION
        )
    );

    echo(
        str(
            "VEHICLE: ",
            VEHICLE_YEAR,
            " ",
            VEHICLE_PLATFORM
        )
    );

    echo(
        str(
            "SERVICE LOOP: ",
            SERVICE_LOOP_FACTOR
        )
    );

    echo(
        str(
            "PURCHASE FACTOR: ",
            PURCHASE_FACTOR
        )
    );
}
//endFile GW_CONFIG.scad

//beginFile GW_TOGGLES.scad
//
// GW_TOGGLES.scad
//
// REV5
//
// Master display and runtime controls.
//

//
// VEHICLE
//

SHOW_FRAME           = true;
SHOW_FIREWALL        = true;
SHOW_FLOORPAN        = true;
SHOW_BODY            = true;

//
// ELECTRICAL
//

SHOW_COMPONENT_LAYER = true;
SHOW_CONNECTOR_LAYER = true;
SHOW_ANCHOR_LAYER    = true;
SHOW_ROUTE_LAYER     = true;
SHOW_HARNESS_LAYER   = true;

//
// MANUFACTURING
//

SHOW_HARNESS_BOARD   = false;
SHOW_HARNESS_BOARD_LAYOUT = false;
SHOW_DXF_PREVIEW = false;
SHOW_MANUFACTURING_PACKAGE = false;

//
// VALIDATION
//

SHOW_VALIDATION_LAYER = true;

SHOW_CLAMPS           = true;
SHOW_BEND_ANALYSIS    = true;
SHOW_INTERFERENCE     = true;
SHOW_SERVICEABILITY   = true;
SHOW_CONNECTOR_ACCESS = true;

//
// CONNECTORS
//

SHOW_CONNECTOR_LABELS      = true;
SHOW_UNUSED_CAVITIES       = true;
SHOW_POPULATED_CAVITIES    = true;
SHOW_WIRE_EXITS            = true;

//
// HARNESSES
//

SHOW_HARNESSES            = true;
SHOW_LOOMS                = true;
SHOW_BRANCHES             = true;
SHOW_SPLICES              = true;
SHOW_SERVICE_LOOPS        = true;
SHOW_TERMINATIONS         = true;
SHOW_HARNESS_LABELS       = true;

//
// BODY REFERENCE GEOMETRY
//

SHOW_SEAT_ENVELOPES       = true;
SHOW_CARGO_CAVITIES       = true;
SHOW_LIFTGATE_VOLUME      = true;
SHOW_FIREWALL_REFERENCE   = true;

//
// REPORTS
//

GENERATE_REPORTS          = true;

REPORT_GEOMETRY           = true;
REPORT_ROUTING            = true;
REPORT_HARNESSING         = true;
REPORT_MANUFACTURING      = true;
REPORT_QUALITY            = true;
//endFile GW_TOGGLES.scad

//ENDfolder CONFIG

//BeginFolder CONNECTORS

//beginFile GW_CONNECTOR_LIBRARY.scad
//
// GW_CONNECTOR_LIBRARY.scad
//
// REV5
//
// Canonical Connector Geometry Library
//

$fn = 32;

//
// COMMON PIN CAVITY
//

module pin_cavity()
{
    color("gold")

    cylinder(
        d = 0.08,
        h = 0.15,
        center = true
    );
}

//
// DTM 4
//

module connector_dtm04()
{
    color("dimgray")

    cube(
    [
        1.21,
        0.65,
        0.62
    ],
    center=true);

    translate([-0.20,0.35, 0.12])
        pin_cavity();

    translate([ 0.20,0.35, 0.12])
        pin_cavity();

    translate([-0.20,0.35,-0.12])
        pin_cavity();

    translate([ 0.20,0.35,-0.12])
        pin_cavity();
}

//
// DTM12
//

module connector_dtm12()
{
    color("gray")

    cube(
    [
        1.80,
        1.00,
        1.00
    ],
    center=true);

    for(z=[-0.30,0,0.30])
    {
        for(x=[-0.45,-0.15,0.15,0.45])
        {
            translate([x,0.50,z])
                pin_cavity();
        }
    }
}

//
// DT06
//

module connector_dt06()
{
    color("gray")

    cube(
    [
        1.45,
        0.90,
        0.75
    ],
    center=true);

    for(z=[-0.15,0.15])
    {
        for(x=[-0.25,0,0.25])
        {
            translate([x,0.45,z])
                pin_cavity();
        }
    }
}

//
// DT16
//

module connector_dt16()
{
    color("gray")

    cube(
    [
        2.20,
        1.30,
        1.10
    ],
    center=true);

    for(z=[-0.35,-0.12,0.12,0.35])
    {
        for(x=[-0.52,-0.17,0.17,0.52])
        {
            translate([x,0.65,z])
                pin_cavity();
        }
    }
}

//
// DT12
//

module connector_dt12()
{
    color("gray")

    cube(
    [
        1.80,
        1.00,
        1.00
    ],
    center=true);

    for(z=[-0.35,-0.10,0.15,0.40])
    {
        for(x=[-0.30,0,0.30])
        {
            translate([x,0.50,z])
                pin_cavity();
        }
    }
}

//
// HDP24-60
//

module connector_hdp24_60()
{
    color("black")

    cube(
    [
        4.50,
        2.00,
        3.00
    ],
    center=true);

    //
    // Mounting flange
    //

    color("silver")

    translate([0,-1.10,0])

    cube(
    [
        5.50,
        0.12,
        3.75
    ],
    center=true);

    //
    // Cavity representation
    //

    for(z=[-1.0,-0.5,0,0.5,1.0])
    {
        for(x=[-1.5,-1.0,-0.5,0,0.5,1.0,1.5])
        {
            translate([x,1.05,z])
                pin_cavity();
        }
    }
}

//
// OBD-II
//

module connector_obdii()
{
    color("purple")

    hull()
    {
        translate([-1.2,0,-0.40])
            cube([0.1,0.1,0.1]);

        translate([ 1.2,0,-0.40])
            cube([0.1,0.1,0.1]);

        translate([-0.8,0,0.40])
            cube([0.1,0.1,0.1]);

        translate([ 0.8,0,0.40])
            cube([0.1,0.1,0.1]);
    }

    for(i=[0:7])
    {
        translate(
        [
            -0.85+(i*0.24),
             0.10,
             0.15
        ])
        pin_cavity();

        translate(
        [
            -0.85+(i*0.24),
             0.10,
            -0.15
        ])
        pin_cavity();
    }
}

//
// RJ45
//

module connector_rj45()
{
    color("blue")

    cube(
    [
        0.95,
        0.80,
        0.65
    ],
    center=true);

    for(i=[0:7])
    {
        translate(
        [
            -0.35+(i*0.10),
             0.41,
            -0.20
        ])

        cylinder(
            d = 0.03,
            h = 0.10,
            center = true,
            $fn = 12
        );
    }
}

//
// MASTER CONNECTOR DISPATCHER
//

module render_connector(
    family
)
{
    if(family == "HDP24-60")
    {
        connector_hdp24_60();
    }
    else
    if(family == "DTM04")
    {
        connector_dtm04();
    }
    else
    if(family == "DTM12")
    {
        connector_dtm12();
    }
    else
    if(family == "DT06")
    {
        connector_dt06();
    }
    else
    if(family == "DT12")
    {
        connector_dt12();
    }
    else
    if(family == "DT16")
    {
        connector_dt16();
    }
    else
    if(family == "OBD-II")
    {
        connector_obdii();
    }
    else
    if(family == "RJ45")
    {
        connector_rj45();
    }
    else
    {
        color("red")

        cube(
        [
            2,
            2,
            2
        ],
        center=true);
    }
}
//endFile GW_CONNECTOR_LIBRARY.scad

//ENDfolder CONNECTORS

//BeginFolder DATABASE

//NOTE: The DATABASE folder was not found or does not exist in the repository

//ENDfolder DATABASE
