//
// GW_ENGINE_CLAMP_SPACING.scad
//
// REV5
//
// Clamp placement and validation engine.
//

include <../CONFIG/GW_CONFIG.scad>

include <../DATABASES/GW_ANCHORS.scad>
include <../DATABASES/GW_ROUTE_GRAPH_DATABASE.scad>

include <GW_ENGINE_WIRE_LENGTH.scad>

//
// CLAMP PARAMETERS
//

DEFAULT_CLAMP_SPACING = CLAMP_SPACING;

MAX_POWER_CLAMP_SPACING = 12.0;

MAX_SIGNAL_CLAMP_SPACING = 18.0;

MAX_NETWORK_CLAMP_SPACING = 12.0;

//
// INTERPOLATION
//

function lerp(a,b,t)=
[
    a[0] + (b[0]-a[0])*t,
    a[1] + (b[1]-a[1])*t,
    a[2] + (b[2]-a[2])*t
];

//
// ROUTE SEGMENT LENGTH
//

function route_segment_length(
    a,
    b
)=

distance3d(
    a,
    b
);

//
// REQUIRED CLAMP COUNT
//

function route_clamp_count(id)=

max(
    1,
    ceil(
        wire_length(id)
        /
        DEFAULT_CLAMP_SPACING
    )
);

//
// CLAMP POSITION GENERATION
//
// First-order approximation.
//
// REV6 will use corridor-aware routing.
//

module render_clamp(
    pos
)
{
    translate(pos)

    color("lime")

    cylinder(
        d = 0.40,
        h = 0.50,
        center = true,
        $fn = 16
    );
}

//
// ROUTE CLAMP VISUALIZATION
//

module render_route_clamps(id)
{
    nodes =
        route_nodes(id);

    for(i=[0:len(nodes)-2])
    {
        p1 =
            anchor_position(
                nodes[i]
            );

        p2 =
            anchor_position(
                nodes[i+1]
            );

        seg_len =
            distance3d(
                p1,
                p2
            );

        clamp_count_seg =
            max(
                1,
                ceil(
                    seg_len
                    /
                    DEFAULT_CLAMP_SPACING
                )
            );

        for(c=[0:clamp_count_seg])
        {
            t =
                c
                /
                max(
                    1,
                    clamp_count_seg
                );

            render_clamp(
                lerp(
                    p1,
                    p2,
                    t
                )
            );
        }
    }
}

//
// ALL ROUTE CLAMPS
//

module render_all_clamps()
{
    for(r=ROUTES)
    {
        render_route_clamps(
            r[0]
        );
    }
}

//
// REPORTING
//

module report_clamp_counts()
{
    echo(
        "===== CLAMP REPORT ====="
    );

    for(r=ROUTES)
    {
        echo(
            str(
                r[0],
                " : ",
                route_clamp_count(
                    r[0]
                ),
                " clamps"
            )
        );
    }
}

//
// VALIDATION
//

module validate_clamp_spacing()
{
    echo(
        "===== CLAMP VALIDATION ====="
    );

    for(r=ROUTES)
    {
        len_in =
            wire_length(
                r[0]
            );

        clamp_qty =
            route_clamp_count(
                r[0]
            );

        actual_spacing =
            len_in
            /
            clamp_qty;

        if(
            actual_spacing
            >
            DEFAULT_CLAMP_SPACING
        )
        {
            echo(
                str(
                    "FAIL: ",
                    r[0],
                    " spacing=",
                    actual_spacing
                )
            );
        }
    }
}