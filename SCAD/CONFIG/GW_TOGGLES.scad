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