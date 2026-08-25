//
// GW_ENGINE_WIRE_LENGTH.scad
//
// REV5
//
// Automatic wire length calculations.
//
// Uses:
//
// GW_CONFIG.scad
// GW_ANCHORS.scad
// GW_ROUTE_GRAPH_DATABASE.scad
//

include <../CONFIG/GW_CONFIG.scad>;

include <../DATABASES/GW_ANCHORS.scad>;
include <../DATABASES/GW_ROUTE_GRAPH_DATABASE.scad>;

//
// BASIC GEOMETRY
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
// UNIT CONVERSIONS
//

function inches_to_feet(x)=
x / 12.0;

function feet_to_inches(x)=
x * 12.0;

//
// ROUTE LOOKUP
//

function route_positions(id)=

[
    for(n=route_nodes(id))

    anchor_position(n)
];

//
// SINGLE SEGMENT LENGTH
//

function segment_length(
    start_node,
    end_node
)=

distance3d(

    anchor_position(start_node),

    anchor_position(end_node)

);

//
// RAW ROUTE LENGTH
//

function raw_route_length(id)=

route_exists(id)

?

_route_length(
    route_nodes(id),
    0
)

:

0;

function _route_length(
    nodes,
    index
)=

(index >= len(nodes)-1)

?

0

:

distance3d(

    anchor_position(
        nodes[index]
    ),

    anchor_position(
        nodes[index+1]
    )

)

+

_route_length(
    nodes,
    index+1
);

//
// SERVICE LOOPS
//

function service_loop_length(length)=

length
*
SERVICE_LOOP_FACTOR;

//
// FINAL WIRE LENGTH
//

function wire_length(id)=

route_exists(id)

?

service_loop_length(
    raw_route_length(id)
)

:

0;

//
// CLAMP CALCULATIONS
//

function clamp_count(id)=

max(
    1,

    ceil(
        wire_length(id)
        /
        CLAMP_SPACING
    )
);

//
// HARNESS LENGTH
//

function harness_length(
    circuit_list
)=

_sum_lengths(
    circuit_list,
    0
);

function _sum_lengths(
    circuit_list,
    index
)=

(index >= len(circuit_list))

?

0

:

wire_length(
    circuit_list[index]
)

+

_sum_lengths(
    circuit_list,
    index+1
);

//
// LOOM CALCULATIONS
//

function loom_length(
    circuit_list
)=

harness_length(
    circuit_list
)

*
LOOM_FACTOR;

//
// ROUTE VISUALIZATION
//

module render_route(id)
{
    nodes =
        route_nodes(id);

    color("cyan")

    for(i=[0:len(nodes)-2])
    {
        hull()
        {
            translate(
                anchor_position(
                    nodes[i]
                )
            )

            sphere(
                d=0.35,
                $fn=12
            );

            translate(
                anchor_position(
                    nodes[i+1]
                )
            )

            sphere(
                d=0.35,
                $fn=12
            );
        }
    }
}

//
// ALL ROUTES
//

module render_all_routes()
{
    for(r=ROUTES)
    {
        render_route(
            r[0]
        );
    }
}

//
// REPORTING
//

module report_route_length(id)
{
    echo(

        str(

            id,

            " RAW = ",

            raw_route_length(id),

            " in"

        )

    );
}

module report_wire_length(id)
{
    echo(

        str(

            id,

            " = ",

            wire_length(id),

            " in"

        )

    );
}

module report_clamps(id)
{
    echo(

        str(

            id,

            " CLAMPS = ",

            clamp_count(id)

        )

    );
}

module report_all_routes()
{
    echo(
        "========= WIRE LENGTH REPORT ========="
    );

    for(r=ROUTES)
    {
        report_wire_length(
            r[0]
        );
    }
}

//
// ROUTE VALIDATION
//

module report_missing_routes()
{
    echo(
        "===== ROUTE VALIDATION ====="
    );

    for(r=ROUTES)
    {
        if(!route_exists(r[0]))
        {
            echo(
                str(
                    "MISSING ROUTE: ",
                    r[0]
                )
            );
        }
    }
}

//
// DEBUG
//

module debug_route(id)
{
    echo(
        "=============================="
    );

    echo(
        str(
            "ROUTE: ",
            id
        )
    );

    echo(
        route_positions(id)
    );

    echo(
        str(
            "RAW LENGTH: ",
            raw_route_length(id)
        )
    );

    echo(
        str(
            "WIRE LENGTH: ",
            wire_length(id)
        )
    );

    echo(
        str(
            "CLAMPS: ",
            clamp_count(id)
        )
    );
}