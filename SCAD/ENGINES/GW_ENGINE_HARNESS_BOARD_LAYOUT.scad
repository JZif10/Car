//
// GW_ENGINE_HARNESS_BOARD_LAYOUT.scad
//
// REV5
//
// Harness Board Layout Enhancements
//

include <GW_ENGINE_HARNESS_BOARD.scad>;
include <GW_ENGINE_HARNESS_GEOMETRY.scad>;

//
// HARNESS HEADER
//

module board_harness_header(
    title,
    y
)
{
    color("white")

    translate(
    [
        5,
        y,
        1
    ])

    linear_extrude(0.10)

    text(
        title,
        size=2
    );
}

//
// HARNESS STATS
//

module harness_stats(
    x,
    y,
    circuits,
    length_ft,
    dia
)
{
    color("white")

    translate(
    [
        x,
        y,
        1
    ])

    linear_extrude(0.10)

    text(
        str(
            circuits,
            " circuits\n",
            length_ft,
            " ft\n",
            dia,
            "\" bundle"
        ),
        size=1.2
    );
}

//
// COLORED TRUNK
//

module board_trunk(
    p1,
    p2,
    rgb=[1,0,0]
)
{
    color(rgb)

    hull()
    {
        translate(p1)
        sphere(
            d=0.40,
            $fn=12
        );

        translate(p2)
        sphere(
            d=0.40,
            $fn=12
        );
    }
}

//
// HARNESS SECTIONS
//

module render_hb001_layout()
{
    board_harness_header(
        "HB001_ENGINE",
        8
    );

    board_trunk(
        [20,10,0.5],
        [90,10,0.5],
        [1,0,0]
    );

    harness_stats(
        95,
        8,
        len(HB001_ENGINE),
        23.4,
        harness_bundle_diameter(
            HB001_ENGINE
        )
    );
}

module render_hb002_layout()
{
    board_harness_header(
        "HB002_DASH",
        22
    );

    board_trunk(
        [20,24,0.5],
        [90,24,0.5],
        [0,0,1]
    );

    harness_stats(
        95,
        22,
        len(HB002_DASH),
        12.7,
        harness_bundle_diameter(
            HB002_DASH
        )
    );
}

module render_hb003_layout()
{
    board_harness_header(
        "HB003_AUDIO",
        36
    );

    board_trunk(
        [20,38,0.5],
        [90,38,0.5],
        [1,0.5,0]
    );

    harness_stats(
        95,
        36,
        len(HB003_AUDIO),
        10.8,
        harness_bundle_diameter(
            HB003_AUDIO
        )
    );
}

module render_hb004_layout()
{
    board_harness_header(
        "HB004_REAR",
        50
    );

    board_trunk(
        [20,52,0.5],
        [90,52,0.5],
        [0,1,1]
    );

    harness_stats(
        95,
        50,
        len(HB004_REAR),
        18.6,
        harness_bundle_diameter(
            HB004_REAR
        )
    );
}

//
// MANUFACTURING PANEL
//

module board_manufacturing_panel()
{
    color("white")

    translate(
    [
        5,
        58,
        1
    ])

    linear_extrude(0.10)

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
        size=1.0
    );
}

//
// MASTER ENTRY
//

module render_harness_board_layout()
{
    render_harness_board();

    render_hb001_layout();

    render_hb002_layout();

    render_hb003_layout();

    render_hb004_layout();

    board_manufacturing_panel();
}