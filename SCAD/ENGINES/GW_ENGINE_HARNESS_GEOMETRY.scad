//
// GW_ENGINE_HARNESS_GEOMETRY.scad
//
// REV5 REV4
//
// Advanced Harness Geometry Engine
//

include <../CONFIG/GW_CONFIG.scad>

include <../DATABASES/GW_ANCHORS.scad>
include <../DATABASES/GW_ROUTE_GRAPH_DATABASE.scad>
include <../DATABASES/GW_CIRCUITS.scad>
include <../DATABASES/GW_SPLICE_DATABASE.scad>

include <GW_ENGINE_WIRE_LENGTH.scad>

//
// DISPLAY OPTIONS
//

SHOW_HARNESSES       = true;
SHOW_LOOMS           = true;
SHOW_BRANCHES        = true;
SHOW_SPLICES         = true;
SHOW_SERVICE_LOOPS   = true;
SHOW_TERMINATIONS    = true;

//
// BASE VISUAL SETTINGS
//

DEFAULT_WIRE_DIA = 0.12;

//
// WIRE DIAMETER TABLE
//

function wire_diameter(gauge)=

gauge == "22AWG"  ? 0.08 :
gauge == "20AWG"  ? 0.10 :
gauge == "18AWG"  ? 0.12 :
gauge == "16AWG"  ? 0.14 :
gauge == "14AWG"  ? 0.16 :
gauge == "12AWG"  ? 0.20 :
gauge == "10AWG"  ? 0.24 :
gauge == "8AWG"   ? 0.28 :
gauge == "4AWG"   ? 0.42 :
gauge == "2AWG"   ? 0.55 :
gauge == "1/0AWG" ? 0.70 :
gauge == "2/0AWG" ? 0.82 :
DEFAULT_WIRE_DIA;

//
// HARNESS DEFINITIONS
//

HB001_ENGINE =
[
"ALT_BAT",
"LITH_MAIN",
"INV_MAIN",
"E110"
];

HB002_DASH =
[
"C001",
"C002",
"OBD_CAN_H",
"OBD_CAN_L"
];

HB003_AUDIO =
[
"AUD_REMOTE",
"AUD_SIGNAL_L",
"AUD_SIGNAL_R"
];

HB004_REAR =
[
"ETH001",
"ETH002",
"CAM_REAR_PWR",
"CAM_REAR_VIDEO",
"INV_ENABLE",
"BMS_POS",
"BMS_NEG"
];

//
// HARNESS COLOR
//

function harness_color(name)=

name == "HB001_ENGINE" ? [1,0,0] :
name == "HB002_DASH"   ? [0,0,1] :
name == "HB003_AUDIO"  ? [1,0.5,0] :
name == "HB004_REAR"   ? [0,1,1] :
[0.7,0.7,0.7];

//
// BUNDLE FILL CALC
//

function harness_wire_count(h)=
len(h);

function bundle_cross_section(h)=

max(
0.05,

harness_wire_count(h)
*
0.02
);

function harness_bundle_diameter(h)=

sqrt(
bundle_cross_section(h)
/
3.14159
)
*
2.0;

//
// GEOMETRY PRIMITIVE
//

module harness_tube(
p1,
p2,
dia
)
{
    hull()
    {
        translate(p1)
        sphere(
            d=dia,
            $fn=20
        );

        translate(p2)
        sphere(
            d=dia,
            $fn=20
        );
    }
}

//
// CIRCUIT LOOKUP
//

function circuit_ids_local() =
[
for(c=CIRCUITS)
c[0]
];

function circuit_idx(id)=

search(
[id],
circuit_ids_local()
)[0];

function circuit_gauge_local(id)=

CIRCUITS[
circuit_idx(id)
][3];

//
// SINGLE CIRCUIT
//

module render_circuit(id)
{
    nodes =
    route_nodes(id);

    dia =
    wire_diameter(
        circuit_gauge_local(id)
    );

    for(i=[0:len(nodes)-2])
    {
        harness_tube(
            anchor_position(nodes[i]),
            anchor_position(nodes[i+1]),
            dia
        );
    }
}

//
// LOOM
//

module render_harness_bundle(
    name,
    circuits
)
{
    color(
        harness_color(name)
    )

    for(c=circuits)
    {
        render_circuit(c);
    }
}

//
// CONNECTOR TERMINATION
//

module termination_marker(pos)
{
    if(SHOW_TERMINATIONS)
    {
        translate(pos)

        color("white")

        sphere(
            d=0.50,
            $fn=16
        );
    }
}

//
// SPLICES
//

module render_splices()
{
    if(SHOW_SPLICES)
    {
        render_all_splices();
    }
}

//
// SERVICE LOOPS
//

module render_service_loops()
{
    if(SHOW_SERVICE_LOOPS)
    {
        if(anchor_exists("LG_HINGE"))
        {
            translate(
                anchor_position(
                    "LG_HINGE"
                )
            )

            color("cyan")

            rotate_extrude($fn=48)

            translate([3,0,0])

            circle(d=0.20);
        }
    }
}

//
// BRANCH VISUALIZATION
//

module branch_marker(pos)
{
    if(SHOW_BRANCHES)
    {
        translate(pos)

        color("magenta")

        sphere(
            d=0.6,
            $fn=16
        );
    }
}

//
// HARNESS LABEL
//

module harness_label(
    txt,
    pos
)
{
    translate(
    [
        pos[0],
        pos[1],
        pos[2]+2
    ])

    color("white")

    linear_extrude(0.10)

    text(
        txt,
        size=0.8
    );
}

//
// INDIVIDUAL HARNESSES
//

module render_hb001()
{
    render_harness_bundle(
        "HB001_ENGINE",
        HB001_ENGINE
    );
}

module render_hb002()
{
    render_harness_bundle(
        "HB002_DASH",
        HB002_DASH
    );
}

module render_hb003()
{
    render_harness_bundle(
        "HB003_AUDIO",
        HB003_AUDIO
    );
}

module render_hb004()
{
    render_harness_bundle(
        "HB004_REAR",
        HB004_REAR
    );
}

//
// REPORTING
//

module report_harness(
    name,
    harness
)
{
    echo(
        str(
            name,
            " circuits=",
            harness_wire_count(harness)
        )
    );

    echo(
        str(
            name,
            " bundle_dia=",
            harness_bundle_diameter(harness)
        )
    );
}

module report_harnesses()
{
    echo(
        "===== HARNESS REPORT ====="
    );

    report_harness(
        "HB001_ENGINE",
        HB001_ENGINE
    );

    report_harness(
        "HB002_DASH",
        HB002_DASH
    );

    report_harness(
        "HB003_AUDIO",
        HB003_AUDIO
    );

    report_harness(
        "HB004_REAR",
        HB004_REAR
    );
}

//
// MASTER ENTRY
//

module render_harness_system()
{
    if(SHOW_HARNESSES)
    {
        render_hb001();

        render_hb002();

        render_hb003();

        render_hb004();

        render_splices();

        render_service_loops();
    }
}