//
// GW_ROUTE_GRAPH_DATABASE.scad
//
// REV5
//
// Vehicle Routing Graph
//
// Each route is represented as
// a sequence of anchor IDs.
//
// Geometry comes from:
//
// GW_ANCHORS.scad
//

//
// ROUTE FORMAT
//
// [
//     CIRCUIT_ID,
//
//     [
//         "NODE_A",
//         "NODE_B",
//         "NODE_C"
//     ]
// ]
//

ROUTES =
[

//
// MAIN POWER
//

[
"ALT_BAT",

[
"ALT_300A",
"BATTERY"
]
],

[
"LITH_MAIN",

[
"BATTERY",
"CARGO_LITHIUM"
]
],

[
"INV_MAIN",

[
"CARGO_LITHIUM",
"CARGO_INV"
]
],

//
// FUEL SYSTEM
//

[
"E110",

[
"RTMR",
"CARGO_MAIN",
"FUEL_PUMP"
]
]
,

//
// CAN BUS
//

[
"C001",

[
"DASH_MAIN",
"DASH_CAN"
]
]
,

[
"C002",

[
"DASH_MAIN",
"DASH_CAN"
]
]
,

//
// OBD
//

[
"OBD_CAN_H",

[
"DASH_CAN",
"DASH_OBD"
]
]
,

[
"OBD_CAN_L",

[
"DASH_CAN",
"DASH_OBD"
]
]
,

//
// AUDIO
//

[
"AUD_REMOTE",

[
"DASH_MAIN",
"AUD_RACK"
]
]
,

[
"AUD_SIGNAL_L",

[
"DASH_MAIN",
"AUD_RACK"
]
]
,

[
"AUD_SIGNAL_R",

[
"DASH_MAIN",
"AUD_RACK"
]
]
,

//
// ETHERNET
//

[
"ETH001",

[
"DASH_MAIN",
"CONSOLE_AFT",
"CARGO_MAIN"
]
]
,

[
"ETH002",

[
"DASH_MAIN",
"CONSOLE_AFT",
"CARGO_MAIN",
"LG_CENTER"
]
]
,

//
// REAR CAMERA
//

[
"CAM_REAR_PWR",

[
"DASH_MAIN",
"CARGO_MAIN",
"LG_HINGE",
"CAM_REAR"
]
]
,

[
"CAM_REAR_VIDEO",

[
"DASH_MAIN",
"CARGO_MAIN",
"LG_HINGE",
"CAM_REAR"
]
]
,

//
// INVERTER ENABLE
//

[
"INV_ENABLE",

[
"DASH_MAIN",
"CONSOLE_AFT",
"CARGO_INV"
]
]
,

//
// BATTERY MONITOR
//

[
"BMS_POS",

[
"CARGO_LITHIUM",
"CARGO_MAIN"
]
]
,

[
"BMS_NEG",

[
"CARGO_LITHIUM",
"G600"
]
]

];

//
// ROUTE LOOKUP HELPERS
//

function route_ids() =
[
    for(r=ROUTES)
    r[0]
];

function route_index(id) =

search(
    [id],
    route_ids()
)[0];

function route_exists(id) =

len(
search(
    [id],
    route_ids()
)
) > 0;

function route_nodes(id) =

ROUTES[
    route_index(id)
][1];

//
// ROUTE VISUALIZATION
//
// Requires:
//
// include <GW_ANCHORS.scad>
//

module render_route_nodes(id)
{
    nodes = route_nodes(id);

    for(n=nodes)
    {
        translate(
            anchor_position(n)
        )

        color("cyan")

        sphere(
            d=1.0,
            $fn=16
        );
    }
}

//
// DEBUG REPORT
//

module report_routes()
{
    echo(
        "========== ROUTES =========="
    );

    for(r=ROUTES)
    {
        echo(
            str(
                r[0],
                " : ",
                len(r[1]),
                " nodes"
            )
        );
    }
}