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