//
// GW_ENGINE_CONNECTOR_RENDERER.scad
//
// REV5
//
// Connector rendering and placement engine.
//

include <../DATABASES/GW_CONNECTORS.scad>;
include <../DATABASES/GW_ANCHORS.scad>;
include <../DATABASES/GW_PIN_DATABASE.scad>;

include <../CONNECTORS/GW_CONNECTOR_LIBRARY.scad>;

//
// CONNECTOR POSITION
//

function connector_position(id) =

anchor_position(
    connector_anchor(id)
);

//
// CONNECTOR LABEL
//

module connector_label(
    id,
    pos
)
{
    translate(
    [
        pos[0],
        pos[1],
        pos[2] + 2
    ])

    color("white")

    linear_extrude(0.10)

    text(
        id,
        size = 0.75
    );
}

//
// CONNECTOR REFERENCE MARKER
//

module connector_marker(pos)
{
    translate(pos)

    color("yellow")

    sphere(
        d = 0.75,
        $fn = 16
    );
}

//
// SINGLE CONNECTOR INSTANCE
//

module render_connector_instance(id)
{
    pos =
        connector_position(id);

    translate(pos)
    {
        render_connector(
            connector_family(id)
        );
    }

    connector_marker(pos);

    connector_label(
        id,
        pos
    );
}

//
// ALL CONNECTORS
//

module render_all_connectors()
{
    for(c = CONNECTORS)
    {
        render_connector_instance(
            c[0]
        );
    }
}

//
// CONNECTOR POPULATION REPORT
//

module report_connector_population(
    connector_name
)
{
    echo(
        str(
            "===== ",
            connector_name,
            " ====="
        )
    );

    for(p = PIN_DATABASE)
    {
        if(p[1] == connector_name)
        {
            echo(
                str(
                    p[2],
                    " : ",
                    p[0]
                )
            );
        }
    }
}

//
// COMPLETE POPULATION REPORT
//

module report_all_connector_population()
{
    echo(
        "===== CONNECTOR POPULATION REPORT ====="
    );

    for(c = CONNECTORS)
    {
        report_connector_population(
            c[0]
        );
    }
}

//
// CONNECTOR LOCATION REPORT
//

module report_connector_locations()
{
    echo(
        "===== CONNECTOR LOCATIONS ====="
    );

    for(c = CONNECTORS)
    {
        echo(
            str(
                c[0],
                " @ ",
                connector_position(
                    c[0]
                )
            )
        );
    }
}

//
// DATABASE VALIDATION
//

module validate_connector_database()
{
    echo(
        "===== CONNECTOR VALIDATION ====="
    );

    for(c = CONNECTORS)
    {
        //
        // Anchor Exists?
        //

        if(
            !anchor_exists(
                connector_anchor(
                    c[0]
                )
            )
        )
        {
            echo(
                str(
                    "MISSING ANCHOR: ",
                    c[0],
                    " -> ",
                    connector_anchor(
                        c[0]
                    )
                )
            );
        }

        //
        // Pin Count Check
        //

        if(
            connector_pin_count(
                c[0]
            ) <= 0
        )
        {
            echo(
                str(
                    "INVALID PIN COUNT: ",
                    c[0]
                )
            );
        }
    }
}

//
// CONNECTOR SYSTEM ENTRY
//

module render_connector_system()
{
    render_all_connectors();
}