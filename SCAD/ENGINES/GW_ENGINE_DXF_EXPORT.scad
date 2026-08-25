//
// GW_ENGINE_DXF_EXPORT.scad
//
// REV5
//
// DXF Export Preparation Engine
//
// NOTE:
// OpenSCAD cannot directly write DXF text files.
// This engine prepares DXF-compatible geometry
// and coordinate reporting.
//
// Future REV6:
// Direct DXF generation pipeline.
//

include <../DATABASES/GW_CONNECTORS.scad>;
include <../DATABASES/GW_SPLICE_DATABASE.scad>;
include <../DATABASES/GW_CIRCUITS.scad>;

//
// DXF ORIGIN
//

DXF_ORIGIN =
[
    0,
    0
];

//
// CONNECTOR COORDINATES
//

function dxf_connector_x(idx) =
10 + idx * 12;

function dxf_connector_y(idx) =
10;

//
// SPLICE COORDINATES
//

function dxf_splice_x(idx) =
10 + idx * 12;

function dxf_splice_y(idx) =
40;

//
// CONNECTOR MARKERS
//

module dxf_connector_marker(
    x,
    y
)
{
    translate(
    [
        x,
        y
    ])

    circle(
        d=1.5,
        $fn=24
    );
}

//
// SPLICE MARKERS
//

module dxf_splice_marker(
    x,
    y
)
{
    translate(
    [
        x,
        y
    ])

    square(
    [
        1.5,
        1.5
    ],
    center=true
    );
}

//
// DXF BOARD OUTLINE
//

module dxf_board_outline()
{
    square(
    [
        120,
        60
    ]);
}

//
// DXF CONNECTORS
//

module dxf_connectors()
{
    for(i=[0:len(CONNECTORS)-1])
    {
        dxf_connector_marker(
            dxf_connector_x(i),
            dxf_connector_y(i)
        );
    }
}

//
// DXF SPLICES
//

module dxf_splices()
{
    for(i=[0:len(SPLICES)-1])
    {
        dxf_splice_marker(
            dxf_splice_x(i),
            dxf_splice_y(i)
        );
    }
}

//
// DXF PREVIEW
//

module render_dxf_preview()
{
    dxf_board_outline();

    dxf_connectors();

    dxf_splices();
}

//
// REPORTING
//

module report_dxf_coordinates()
{
    echo(
        "===== DXF CONNECTOR COORDINATES ====="
    );

    for(i=[0:len(CONNECTORS)-1])
    {
        echo(
            str(
                CONNECTORS[i][0],
                ",",
                dxf_connector_x(i),
                ",",
                dxf_connector_y(i)
            )
        );
    }

    echo(
        "===== DXF SPLICE COORDINATES ====="
    );

    for(i=[0:len(SPLICES)-1])
    {
        echo(
            str(
                SPLICES[i][0],
                ",",
                dxf_splice_x(i),
                ",",
                dxf_splice_y(i)
            )
        );
    }
}

//
// BOARD DATA EXPORT
//

module report_dxf_metadata()
{
    echo(
        "===== DXF METADATA ====="
    );

    echo(
        str(
            "BOARD WIDTH=",
            120
        )
    );

    echo(
        str(
            "BOARD HEIGHT=",
            60
        )
    );

    echo(
        str(
            "CONNECTORS=",
            len(CONNECTORS)
        )
    );

    echo(
        str(
            "SPLICES=",
            len(SPLICES)
        )
    );
}

//
// MASTER ENTRY
//

module export_dxf_layout()
{
    render_dxf_preview();

    report_dxf_coordinates();

    report_dxf_metadata();
}