//
// GW_ENGINE_BEND_RADIUS.scad
//
// REV5
//
// Bend Radius & Routing Validation
//

include <../CONFIG/GW_CONFIG.scad>

include <../DATABASES/GW_CIRCUITS.scad>
include <../DATABASES/GW_ROUTE_GRAPH_DATABASE.scad>
include <../DATABASES/GW_ANCHORS.scad>

include <GW_ENGINE_WIRE_LENGTH.scad>

//
// BEND RADIUS DATABASE
//

function minimum_bend_radius(type)=

type == "CAT6"      ? 1.00 :
type == "COAX"      ? 1.50 :
type == "22AWG"     ? 0.50 :
type == "20AWG"     ? 0.75 :
type == "18AWG"     ? 1.00 :
type == "16AWG"     ? 1.50 :
type == "14AWG"     ? 2.00 :
type == "12AWG"     ? 3.00 :
type == "10AWG"     ? 4.00 :
type == "8AWG"      ? 4.00 :
type == "4AWG"      ? 6.00 :
type == "2AWG"      ? 8.00 :
type == "1/0AWG"    ? 10.00 :
type == "2/0AWG"    ? 12.00 :
1.00;

//
// SIMPLE BEND ESTIMATION
//
// Future REV6 will use true spline geometry.
// REV5 uses node-to-node angle estimation.
//

function vector(a,b)=
[
    b[0]-a[0],
    b[1]-a[1],
    b[2]-a[2]
];

function vec_mag(v)=
sqrt(
    v[0]*v[0] +
    v[1]*v[1] +
    v[2]*v[2]
);

function dot(a,b)=
a[0]*b[0] +
a[1]*b[1] +
a[2]*b[2];

function bend_angle(p1,p2,p3)=

let(
    v1 = vector(p2,p1),
    v2 = vector(p2,p3),

    m1 = vec_mag(v1),
    m2 = vec_mag(v2)
)

(m1 == 0 || m2 == 0)

?

0

:

acos(
    dot(v1,v2)/(m1*m2)
);

//
// CIRCUIT LOOKUP
//

function circuit_ids_local() =
[
    for(c=CIRCUITS)
        c[0]
];

function circuit_index_local(id)=
search(
    [id],
    circuit_ids_local()
)[0];

function circuit_type(id)=
CIRCUITS[
    circuit_index_local(id)
][3];

//
// VALIDATION
//

function bend_requirement(id)=
minimum_bend_radius(
    circuit_type(id)
);

//
// VISUAL PASS MARKER
//

module bend_pass_marker(pos)
{
    color("lime")

    translate(pos)

    sphere(
        d=0.60,
        $fn=16
    );
}

//
// VISUAL FAIL MARKER
//

module bend_fail_marker(pos)
{
    color("red")

    translate(pos)

    sphere(
        d=0.80,
        $fn=16
    );
}

//
// BEND ANALYSIS
//

module analyze_route(id)
{
    nodes =
        route_nodes(id);

    if(len(nodes) > 2)
    {
        for(i=[1:len(nodes)-2])
        {
            p1 =
                anchor_position(
                    nodes[i-1]
                );

            p2 =
                anchor_position(
                    nodes[i]
                );

            p3 =
                anchor_position(
                    nodes[i+1]
                );

            angle =
                bend_angle(
                    p1,
                    p2,
                    p3
                );

            //
            // REV5 placeholder:
            // anything over ~135°
            // considered acceptable.
            //

            if(angle > 135)
            {
                bend_pass_marker(
                    p2
                );
            }
            else
            {
                bend_fail_marker(
                    p2
                );
            }
        }
    }
}

//
// RENDER ALL BEND CHECKS
//

module render_bend_analysis()
{
    for(c=CIRCUITS)
    {
        if(
            route_exists(c[0])
        )
        {
            analyze_route(
                c[0]
            );
        }
    }
}

//
// CLAMP SPACING CHECK
//

module validate_clamp_spacing()
{
    echo(
        "===== CLAMP VALIDATION ====="
    );

    for(r=ROUTES)
    {
        echo(
            str(
                r[0],
                " clamps=",
                clamp_count(r[0])
            )
        );
    }
}

//
// REPORTS
//

module report_bend_radius()
{
    echo(
        "===== BEND RADIUS ====="
    );

    for(c=CIRCUITS)
    {
        echo(
            str(
                c[0],
                " -> ",
                bend_requirement(
                    c[0]
                ),
                " in"
            )
        );
    }
}