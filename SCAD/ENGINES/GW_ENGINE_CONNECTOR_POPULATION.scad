//
// GW_ENGINE_CONNECTOR_POPULATION.scad
//
// REV5
//
// Connector cavity population visualization.
//

include <../DATABASES/GW_ANCHORS.scad>;
include <../DATABASES/GW_CONNECTORS.scad>;
include <../DATABASES/GW_PIN_DATABASE.scad>;

include <../CONNECTORS/GW_CONNECTOR_LIBRARY.scad>;

//
// DISPLAY CONTROLS
//

SHOW_CONNECTOR_LABELS = true;

SHOW_UNUSED_CAVITIES = true;

SHOW_POPULATED_CAVITIES = true;

SHOW_WIRE_EXITS = true;

//
// POPULATION HELPERS
//

function connector_population(connector_id)=
[
    for(p=PIN_DATABASE)

    if(
        p[1] == connector_id
    )

    p[2]
];

function connector_population_count(connector_id)=

len(
    connector_population(
        connector_id
    )
);

function unused_cavity_count(connector_id)=

max(
    0,

    connector_pin_count(
        connector_id
    )

    -

    connector_population_count(
        connector_id
    )
);

//
// CONNECTOR POSITION
//

function connector_position(id)=

anchor_position(
    connector_anchor(id)
);

//
// LABEL
//

module connector_population_label(
    id,
    pos
)
{
    if(SHOW_CONNECTOR_LABELS)
    {
        translate(
        [
            pos[0],
            pos[1],
            pos[2] + 3
        ])

        color("white")

        linear_extrude(0.10)

        text(
            str(
                id,
                " (",
                connector_population_count(id),
                "/",
                connector_pin_count(id),
                ")"
            ),
            size = 0.75
        );
    }
}

//
// POPULATED PIN
//

module populated_pin()
{
    if(SHOW_POPULATED_CAVITIES)
    {
        color("lime")

        sphere(
            d = 0.12,
            $fn = 12
        );
    }
}

//
// UNUSED PIN
//

module unused_pin()
{
    if(SHOW_UNUSED_CAVITIES)
    {
        color("red")

        sphere(
            d = 0.12,
            $fn = 12
        );
    }
}

//
// WIRE EXIT INDICATOR
//

module wire_exit()
{
    if(SHOW_WIRE_EXITS)
    {
        color("yellow")

        cylinder(
            d = 0.10,
            h = 0.50,
            center = false,
            $fn = 12
        );
    }
}

//
// GENERIC PIN VISUALIZATION
//

module render_pin_population(
    connector_id
)
{
    pop_count =
        connector_population_count(
            connector_id
        );

    total =
        connector_pin_count(
            connector_id
        );

    //
    // Simple row layout
    //

    for(i=[0:total-1])
    {
        translate(
        [
            -0.5 + (i * 0.15),
            0.75,
            0
        ])
        {
            if(i < pop_count)
            {
                populated_pin();
            }
            else
            {
                unused_pin();
            }
        }
    }
}

//
// CONNECTOR INSTANCE
//

module render_connector_population(
    id
)
{
    pos =
        connector_position(id);

    translate(pos)
    {
        render_connector(
            connector_family(id)
        );

        render_pin_population(
            id
        );

        translate([0,1,0])
        wire_exit();
    }

    connector_population_label(
        id,
        pos
    );
}

//
// ALL CONNECTORS
//

module render_all_connector_populations()
{
    for(c=CONNECTORS)
    {
        render_connector_population(
            c[0]
        );
    }
}

//
// REPORTING
//

module report_connector_population(
    connector_id
)
{
    echo(
        str(
            connector_id,
            " : ",
            connector_population_count(
                connector_id
            ),
            "/",
            connector_pin_count(
                connector_id
            ),
            " populated"
        )
    );
}

module report_all_connector_populations()
{
    echo(
        "===== CONNECTOR POPULATION ====="
    );

    for(c=CONNECTORS)
    {
        report_connector_population(
            c[0]
        );
    }
}

//
// VALIDATION
//

module validate_connector_population()
{
    echo(
        "===== CONNECTOR POPULATION VALIDATION ====="
    );

    for(c=CONNECTORS)
    {
        if(
            connector_population_count(
                c[0]
            )

            >

            connector_pin_count(
                c[0]
            )
        )
        {
            echo(
                str(
                    "OVERPOPULATED: ",
                    c[0]
                )
            );
        }
    }
}

//
// MASTER ENTRY
//

module render_connector_population_system()
{
    render_all_connector_populations();
}