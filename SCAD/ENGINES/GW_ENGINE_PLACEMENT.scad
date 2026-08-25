//
// GW_ENGINE_PLACEMENT.scad
//
// REV5
//
// Automatic component placement engine.
//

include <../DATABASES/GW_COMPONENTS.scad>;
include <../DATABASES/GW_ANCHORS.scad>;

include <../MODELS/GW_COMPONENT_LIBRARY.scad>;

//
// COMPONENT POSITION LOOKUP
//

function component_position(id) =

anchor_position(
    component_anchor(id)
);

//
// COMPONENT LABEL
//

module component_label(
    id,
    pos
)
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
        id,
        size = 1.0
    );
}

//
// COMPONENT MARKER
//

module component_marker(
    pos
)
{
    translate(pos)

    color("yellow")

    sphere(
        d = 1.0,
        $fn = 16
    );
}

//
// SINGLE COMPONENT
//

module render_component_instance(id)
{
    pos = component_position(id);

    translate(pos)
    {
        render_component(
            component_type(id)
        );
    }

    component_marker(pos);

    component_label(
        id,
        pos
    );
}

//
// SUBSYSTEM RENDERING
//

module render_subsystem(subsystem_name)
{
    comps =
    components_by_subsystem(
        subsystem_name
    );

    for(c = comps)
    {
        render_component_instance(c);
    }
}

//
// COMPLETE COMPONENT DATABASE
//

module render_all_components()
{
    for(c = COMPONENTS)
    {
        render_component_instance(
            c[0]
        );
    }
}

//
// REPORTING
//

module report_component_locations()
{
    echo(
        "====== COMPONENT LOCATIONS ======"
    );

    for(c = COMPONENTS)
    {
        echo(
            str(
                c[0],
                " @ ",
                component_position(
                    c[0]
                )
            )
        );
    }
}

module report_component_inventory()
{
    echo(
        "====== COMPONENT INVENTORY ======"
    );

    for(c = COMPONENTS)
    {
        echo(
            str(
                c[0],
                " | ",
                component_type(c[0]),
                " | ",
                component_subsystem(c[0])
            )
        );
    }
}

//
// ANCHOR VALIDATION
//

module report_missing_anchors()
{
    echo(
        "====== ANCHOR VALIDATION ======"
    );

    for(c = COMPONENTS)
    {
        this_anchor =
        component_anchor(
            c[0]
        );

        if(
            !anchor_exists(
                this_anchor
            )
        )
        {
            echo(
                str(
                    "MISSING ANCHOR: ",
                    c[0],
                    " -> ",
                    this_anchor
                )
            );
        }
    }
}

//
// COMPONENT VALIDATION
//

module validate_component_database()
{
    report_missing_anchors();

    report_component_locations();
}

//
// MASTER COMPONENT SYSTEM
//

module render_component_system()
{
    render_all_components();
}