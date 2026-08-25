//
// GW_ENGINE_ROUTE_SOLVER.scad
//
// REV5
//
// Vehicle Routing Corridor Engine
//

include <../DATABASES/GW_ANCHORS.scad>;
include <../DATABASES/GW_ROUTE_GRAPH_DATABASE.scad>;

//
// CORRIDOR DATABASE
//
// Physical wiring corridors.
//
// These are routing channels,
// not electrical routes.
//

CORRIDORS =
[
    [
        "ENGINE",

        [
            [-20,15,24],
            [-10,15,30],
            [0,12,36]
        ]
    ],

    [
        "DASH",

        [
            [0,12,36],
            [15,0,40],
            [30,0,30]
        ]
    ],

    [
        "CONSOLE",

        [
            [30,0,30],
            [60,0,18],
            [76,0,18]
        ]
    ],

    [
        "ROCKER",

        [
            [76,0,18],
            [110,15,8],
            [145,15,18]
        ]
    ],

    [
        "CARGO",

        [
            [145,15,18],
            [150,18,8],
            [150,-18,10]
        ]
    ],

    [
        "LIFTGATE",

        [
            [145,15,18],
            [175,0,55],
            [185,0,58]
        ]
    ]
];

//
// CORRIDOR LOOKUP
//

function corridor_ids() =
[
    for(c=CORRIDORS)
        c[0]
];

function corridor_exists(id) =
    len(
        search(
            [id],
            corridor_ids()
        )
    ) > 0;

function corridor_index(id) =
    corridor_exists(id)

    ?

    search(
        [id],
        corridor_ids()
    )[0]

    :

    -1;

function corridor_nodes(id) =

    corridor_exists(id)

    ?

    CORRIDORS[
        corridor_index(id)
    ][1]

    :

    [];

//
// VISUALIZATION
//

module render_corridor(id)
{
    pts =
        corridor_nodes(id);

    color("lightblue")

    for(i=[0:len(pts)-2])
    {
        hull()
        {
            translate(pts[i])

            sphere(
                d = 0.50,
                $fn = 12
            );

            translate(pts[i+1])

            sphere(
                d = 0.50,
                $fn = 12
            );
        }
    }
}

module render_all_corridors()
{
    for(c=CORRIDORS)
    {
        render_corridor(
            c[0]
        );
    }
}

//
// ROUTE -> CORRIDOR MAPPING
//

function route_corridor(route_id)=

route_id == "ALT_BAT"        ? "ENGINE" :

route_id == "LITH_MAIN"      ? "ROCKER" :

route_id == "INV_MAIN"       ? "CARGO" :

route_id == "INV_ENABLE"     ? "ROCKER" :

route_id == "E110"           ? "ROCKER" :

route_id == "C001"           ? "DASH" :

route_id == "C002"           ? "DASH" :

route_id == "OBD_CAN_H"      ? "DASH" :

route_id == "OBD_CAN_L"      ? "DASH" :

route_id == "AUD_REMOTE"     ? "ROCKER" :

route_id == "AUD_SIGNAL_L"   ? "ROCKER" :

route_id == "AUD_SIGNAL_R"   ? "ROCKER" :

route_id == "ETH001"         ? "ROCKER" :

route_id == "ETH002"         ? "LIFTGATE" :

route_id == "CAM_REAR_PWR"   ? "LIFTGATE" :

route_id == "CAM_REAR_VIDEO" ? "LIFTGATE" :

route_id == "BMS_POS"        ? "CARGO" :

route_id == "BMS_NEG"        ? "CARGO" :

"ROCKER";

//
// ROUTE POSITIONS
//

function physical_route_positions(route_id)=

corridor_nodes(
    route_corridor(route_id)
);

//
// DISTANCE
//

function distance3d(a,b)=

sqrt(
    pow(b[0]-a[0],2)
    +
    pow(b[1]-a[1],2)
    +
    pow(b[2]-a[2],2)
);

//
// CORRIDOR LENGTH
//

function corridor_length(route_id)=

_corridor_length(
    physical_route_positions(route_id),
    0
);

function _corridor_length(
    pts,
    idx
)=

(idx >= len(pts)-1)

?

0

:

distance3d(
    pts[idx],
    pts[idx+1]
)

+

_corridor_length(
    pts,
    idx + 1
);

//
// FINAL VEHICLE LENGTH
//

function vehicle_route_length(route_id)=

corridor_length(route_id)

*
SERVICE_LOOP_FACTOR;

//
// ROUTE VISUALIZATION
//

module render_vehicle_route(route_id)
{
    pts =
        physical_route_positions(
            route_id
        );

    color("orange")

    for(i=[0:len(pts)-2])
    {
        hull()
        {
            translate(pts[i])

            sphere(
                d=0.25,
                $fn=12
            );

            translate(pts[i+1])

            sphere(
                d=0.25,
                $fn=12
            );
        }
    }
}

//
// REPORTS
//

module report_route_solver()
{
    echo(
        "===== ROUTE SOLVER ====="
    );

    for(r=ROUTES)
    {
        echo(
            str(
                r[0],
                " -> ",
                vehicle_route_length(
                    r[0]
                ),
                " in"
            )
        );
    }
}
