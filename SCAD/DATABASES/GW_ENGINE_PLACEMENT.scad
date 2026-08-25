//
// GW_ENGINE_PLACEMENT.scad
//
// REV5
//
// Automatic component placement engine.
//
// Depends On:
//
//   GW_COMPONENTS.scad
//   GW_ANCHORS.scad
//   GW_COMPONENT_LIBRARY.scad
//

include <../DATABASES/GW_COMPONENTS.scad>
include <../DATABASES/GW_ANCHORS.scad>

include <../MODELS/GW_COMPONENT_LIBRARY.scad>

//
// COMPONENT POSITION
//

function component_position(id) =

anchor_position(
    component_anchor(id)
);

//
// COMPONENT RENDERING
//

module render_component_by_id(id)
{
    translate(
        component_position(id)
    )
    {
        render_component(
            component_type(id)
        );
    }
}

//
// COMPONENT LABEL MARKER
//

module render_component_marker(id)
{
    translate(
        component_position(id)
    )

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
    render_component_by_id(id);

    render_component_marker(id);
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
        render_component_instance(
            c
        );
    }
}

//
// ALL COMPONENTS
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
// DATABASE REPORTS
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

module report_subsystems()
{
    echo(
        "====== SUBSYSTEMS ======"
    );

    for(c = COMPONENTS)
    {
        echo(
            str(
                c[0],
                " : ",
                component_subsystem(
                    c[0]
                )
            )
        );
    }
}

//
// INSTALLATION CHECK
//

module report_missing_anchors()
{
    echo(
        "====== ANCHOR VALIDATION ======"
    );

    for(c = COMPONENTS)
    {
        anchor_id =
            component_anchor(
                c[0]
            );

        if(
            !anchor_exists(
                anchor_id
            )
        )
        {
            echo(
                str(
                    "MISSING ANCHOR: ",
                    c[0],
                    " -> ",
                    anchor_id
                )
            );
        }
    }
}

//
// DIGITAL TWIN VALIDATION
//

module validate_component_database()
{
    report_missing_anchors();

    report_component_locations();
}

//
// MASTER ENTRY
//

module render_component_system()
{
    render_all_components();
}