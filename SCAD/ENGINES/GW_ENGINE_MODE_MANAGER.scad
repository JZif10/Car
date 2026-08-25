//
// GW_ENGINE_MODE_MANAGER.scad
//
// REV5
//
// Global mode controller.
//
// Modes:
//
// PRESENTATION
// ENGINEERING
// MANUFACTURING
//

//
// MODE SELECTION
//
// Only ONE should be true.
//

MODE_PRESENTATION  = false;
MODE_ENGINEERING   = true;
MODE_MANUFACTURING = false;

//
// PRESENTATION MODE
//

function mode_show_frame() =
    MODE_PRESENTATION
    ? true
    : SHOW_FRAME;

function mode_show_firewall() =
    MODE_PRESENTATION
    ? true
    : SHOW_FIREWALL;

function mode_show_floorpan() =
    MODE_PRESENTATION
    ? true
    : SHOW_FLOORPAN;

function mode_show_body() =
    MODE_PRESENTATION
    ? true
    : SHOW_BODY;

function mode_show_components() =
    MODE_PRESENTATION
    ? true
    : SHOW_COMPONENT_LAYER;

function mode_show_connectors() =
    MODE_PRESENTATION
    ? true
    : SHOW_CONNECTOR_LAYER;

function mode_show_harnesses() =
    MODE_PRESENTATION
    ? true
    : SHOW_HARNESS_LAYER;

function mode_show_routes() =
    MODE_PRESENTATION
    ? false
    : SHOW_ROUTE_LAYER;

function mode_show_anchors() =
    MODE_PRESENTATION
    ? false
    : SHOW_ANCHOR_LAYER;

//
// ENGINEERING MODE
//

function mode_show_validation() =
    MODE_ENGINEERING
    ? true
    : SHOW_VALIDATION_LAYER;

function mode_show_clamps() =
    MODE_ENGINEERING
    ? true
    : SHOW_CLAMPS;

function mode_show_bends() =
    MODE_ENGINEERING
    ? true
    : SHOW_BEND_ANALYSIS;

function mode_show_interference() =
    MODE_ENGINEERING
    ? true
    : SHOW_INTERFERENCE;

function mode_show_serviceability() =
    MODE_ENGINEERING
    ? true
    : SHOW_SERVICEABILITY;

function mode_show_connector_access() =
    MODE_ENGINEERING
    ? true
    : SHOW_CONNECTOR_ACCESS;

//
// MANUFACTURING MODE
//

function mode_show_manufacturing() =
    MODE_MANUFACTURING
    ? true
    : SHOW_MANUFACTURING_PACKAGE;

function mode_show_harness_board() =
    MODE_MANUFACTURING
    ? true
    : SHOW_HARNESS_BOARD;

//
// REPORT CONTROL
//

function mode_generate_reports() =
    MODE_MANUFACTURING
    ? true
    : GENERATE_REPORTS;

//
// STATUS REPORT
//

module report_mode_status()
{
    echo(
        "===== MODE MANAGER ====="
    );

    if(MODE_PRESENTATION)
    {
        echo(
            "MODE: PRESENTATION"
        );
    }

    if(MODE_ENGINEERING)
    {
        echo(
            "MODE: ENGINEERING"
        );
    }

    if(MODE_MANUFACTURING)
    {
        echo(
            "MODE: MANUFACTURING"
        );
    }
}

//
// VALIDATION
//

module validate_modes()
{
    if(
        (MODE_PRESENTATION && MODE_ENGINEERING)
        ||
        (MODE_PRESENTATION && MODE_MANUFACTURING)
        ||
        (MODE_ENGINEERING && MODE_MANUFACTURING)
    )
    {
        echo(
            "WARNING: MULTIPLE MODES ENABLED"
        );
    }

    if(
        !MODE_PRESENTATION
        &&
        !MODE_ENGINEERING
        &&
        !MODE_MANUFACTURING
    )
    {
        echo(
            "WARNING: NO MODE ENABLED"
        );
    }
}

//
// INITIALIZATION
//

module initialize_modes()
{
    validate_modes();

    report_mode_status();
}