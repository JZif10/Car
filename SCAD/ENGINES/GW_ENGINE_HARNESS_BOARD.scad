//
// GW_ENGINE_HARNESS_BOARD.scad
//
// REV5
//
// Harness Board Visualization
//

include <../DATABASES/GW_CONNECTORS.scad>;
include <../DATABASES/GW_SPLICE_DATABASE.scad>;
include <../DATABASES/GW_CIRCUITS.scad>;

include <GW_ENGINE_WIRE_LENGTH.scad>;

//
// BOARD PARAMETERS
//

BOARD_WIDTH = 120;
BOARD_HEIGHT = 60;

CONNECTOR_SPACING = 12;

//
// POSITION HELPERS
//

function connector_board_x(idx) =
    10 + idx * CONNECTOR_SPACING;

function connector_board_y(idx) =
    10;

function splice_board_x(idx) =
    10 + idx * CONNECTOR_SPACING;

function splice_board_y(idx) =
    40;

//
// BOARD OUTLINE
//

module harness_board_outline()
{
    color("tan")

    translate(
    [
        BOARD_WIDTH/2,
        BOARD_HEIGHT/2,
        0
    ])

    cube(
    [
        BOARD_WIDTH,
        BOARD_HEIGHT,
        0.25
    ],
    center=true
    );
}

//
// POWER ZONE
//

module board_zone_power()
{
    color([1,0,0,0.08])

    translate([60,10,-0.05])

    cube(
    [
        120,
        12,
        0.10
    ],
    center=true
    );
}

//
// NETWORK ZONE
//

module board_zone_network()
{
    color([0,0,1,0.08])

    translate([60,25,-0.05])

    cube(
    [
        120,
        12,
        0.10
    ],
    center=true
    );
}

//
// AUDIO ZONE
//

module board_zone_audio()
{
    color([1,0.5,0,0.08])

    translate([60,40,-0.05])

    cube(
    [
        120,
        12,
        0.10
    ],
    center=true
    );
}

//
// REAR / CAMERA ZONE
//

module board_zone_rear()
{
    color([0,1,1,0.08])

    translate([60,55,-0.05])

    cube(
    [
        120,
        10,
        0.10
    ],
    center=true
    );
}

//
// ZONE LABELS
//

module board_zone_labels()
{
    color("white")

    translate([2,8,1])
    linear_extrude(0.10)
    text("POWER",size=2);

    translate([2,23,1])
    linear_extrude(0.10)
    text("NETWORK",size=2);

    translate([2,38,1])
    linear_extrude(0.10)
    text("AUDIO",size=2);

    translate([2,53,1])
    linear_extrude(0.10)
    text("REAR / CAMERA",size=2);
}

//
// CONNECTOR NODE
//

module board_connector_node(id)
{
    color("blue")

    cylinder(
        d=1.5,
        h=0.5,
        center=false,
        $fn=24
    );

    translate([0,0,0.5])

    color("white")

    linear_extrude(0.10)

    text(
        id,
        size=1.0
    );
}

//
// SPLICE NODE
//

module board_splice_node(id)
{
    color("magenta")

    sphere(
        d=1.5,
        $fn=24
    );

    translate([0,0,1.0])

    color("white")

    linear_extrude(0.10)

    text(
        id,
        size=0.8
    );
}

//
// CONNECTOR PLACEMENT
//

module render_board_connectors()
{
    for(i=[0:len(CONNECTORS)-1])
    {
        translate(
        [
            connector_board_x(i),
            connector_board_y(i),
            0.25
        ])

        board_connector_node(
            CONNECTORS[i][0]
        );
    }
}

//
// SPLICE PLACEMENT
//

module render_board_splices()
{
    for(i=[0:len(SPLICES)-1])
    {
        translate(
        [
            splice_board_x(i),
            splice_board_y(i),
            0.25
        ])

        board_splice_node(
            SPLICES[i][0]
        );
    }
}

//
// HARNESS LINE
//

module board_harness_line(
    p1,
    p2
)
{
    color("red")

    hull()
    {
        translate(p1)

        sphere(
            d=0.25,
            $fn=12
        );

        translate(p2)

        sphere(
            d=0.25,
            $fn=12
        );
    }
}

//
// CONNECTION DISPLAY
//

module render_board_connections()
{
    max_count =
    min(
        len(CONNECTORS),
        len(SPLICES)
    );

    for(i=[0:max_count-1])
    {
        board_harness_line(
        [
            connector_board_x(i),
            connector_board_y(i),
            0.25
        ],

        [
            splice_board_x(i),
            splice_board_y(i),
            0.25
        ]);
    }
}

//
// SUMMARY PANEL
//

module harness_board_summary()
{
    translate(
    [
        5,
        52,
        0.5
    ])

    color("white")

    linear_extrude(0.15)

    text(
        str(
            "CONNECTORS=",
            len(CONNECTORS),
            "\n",
            "SPLICES=",
            len(SPLICES),
            "\n",
            "CIRCUITS=",
            len(CIRCUITS)
        ),
        size=2
    );
}

//
// LEGEND ITEM
//

module legend_item(
    y,
    rgb,
    label
)
{
    color(rgb)

    translate([95,y,0.5])

    cube(
    [
        2,
        2,
        0.5
    ],
    center=true);

    color("white")

    translate([98,y,0.5])

    linear_extrude(0.10)

    text(
        label,
        size=1.2
    );
}

//
// COLOR LEGEND
//

module board_color_legend()
{
    color([0.15,0.15,0.15,0.75])

    translate([105,42,0.4])

    cube(
    [
        28,
        16,
        0.2
    ],
    center=true);

    color("white")

    translate([92,48,0.5])

    linear_extrude(0.10)

    text(
        "LEGEND",
        size=1.5
    );

    legend_item(
        45,
        [1,0,0],
        "POWER"
    );

    legend_item(
        42,
        [0,0,1],
        "NETWORK"
    );

    legend_item(
        39,
        [1,0.5,0],
        "AUDIO"
    );

    legend_item(
        36,
        [0,1,1],
        "REAR/CAMERA"
    );

    legend_item(
        33,
        [0,1,0],
        "BMS"
    );

    legend_item(
        30,
        [1,0,1],
        "SPLICE"
    );
}

//
// REPORTING
//

module report_harness_board()
{
    echo(
        "===== HARNESS BOARD ====="
    );

    echo(
        str(
            "CONNECTORS: ",
            len(CONNECTORS)
        )
    );

    echo(
        str(
            "SPLICES: ",
            len(SPLICES)
        )
    );

    echo(
        str(
            "CIRCUITS: ",
            len(CIRCUITS)
        )
    );
}

//
// MASTER ENTRY
//

module render_harness_board()
{
    harness_board_outline();

    board_zone_power();

    board_zone_network();

    board_zone_audio();

    board_zone_rear();

    board_zone_labels();

    render_board_connectors();

    render_board_splices();

    render_board_connections();

    harness_board_summary();

    board_color_legend();
}