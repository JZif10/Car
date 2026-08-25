//
// GW_ENGINE_DIGITAL_TWIN.scad
//
// REV5
//
// Master Runtime Engine
//

//
// CONFIGURATION
//

include <../CONFIG/GW_TOGGLES.scad>;

//
// DATABASES
//

include <../DATABASES/GW_ANCHORS.scad>;
include <../DATABASES/GW_ROUTE_GRAPH_DATABASE.scad>;
include <../DATABASES/GW_COMPONENTS.scad>;
include <../DATABASES/GW_CONNECTORS.scad>;
include <../DATABASES/GW_CIRCUITS.scad>;
include <../DATABASES/GW_PIN_DATABASE.scad>;
include <../DATABASES/GW_SPLICE_DATABASE.scad>;
include <../DATABASES/GW_CLEARANCE_DATABASE.scad>;

//
// CORE ENGINES
//

include <GW_ENGINE_MODE_MANAGER.scad>;

include <GW_ENGINE_PLACEMENT.scad>;

include <GW_ENGINE_CONNECTOR_RENDERER.scad>;
include <GW_ENGINE_CONNECTOR_POPULATION.scad>;

include <GW_ENGINE_WIRE_LENGTH.scad>;
include <GW_ENGINE_ROUTE_SOLVER.scad>;

include <GW_ENGINE_HARNESS_GEOMETRY.scad>;

//
// VALIDATION
//

include <GW_ENGINE_BEND_RADIUS.scad>;
include <GW_ENGINE_CLAMP_SPACING.scad>;
include <GW_ENGINE_INTERFERENCE_DETECTION.scad>;
include <GW_ENGINE_SERVICEABILITY.scad>;
include <GW_ENGINE_CONNECTOR_ACCESS.scad>;
include <GW_ENGINE_VALIDATION_OVERLAY.scad>;

//
// MANUFACTURING
//

include <GW_ENGINE_BOM.scad>;
include <GW_ENGINE_CUTSHEET.scad>;
include <GW_ENGINE_LABELS.scad>;
include <GW_ENGINE_AS_BUILT.scad>;

include <GW_ENGINE_HARNESS_BOARD.scad>;
include <GW_ENGINE_HARNESS_BOARD_LAYOUT.scad>;

include <GW_ENGINE_HARNESS_MANUFACTURING.scad>;

include <GW_ENGINE_DXF_EXPORT.scad>;

include <GW_ENGINE_MANUFACTURING_PACKAGE.scad>;

//
// VERSION
//

DIGITAL_TWIN_VERSION =
"REV5";

//
// COMPONENT LAYER
//

module render_component_layer()
{
    if(mode_show_components())
    {
        render_component_system();
    }
}

//
// CONNECTOR LAYER
//

module render_connector_layer()
{
    if(mode_show_connectors())
    {
        render_connector_system();

        render_connector_population_system();
    }
}

//
// ANCHOR LAYER
//

module render_anchor_layer()
{
    if(mode_show_anchors())
    {
        render_all_anchors();
    }
}

//
// ROUTE LAYER
//

module render_route_layer()
{
    if(mode_show_routes())
    {
        render_all_routes();

        render_all_corridors();
    }
}

//
// HARNESS LAYER
//

module render_harness_layer()
{
    if(mode_show_harnesses())
    {
        render_harness_system();
    }
}

//
// VALIDATION LAYER
//

module render_validation_layer()
{
    if(mode_show_validation())
    {
        if(mode_show_bends())
        {
            render_bend_analysis();
        }

        if(mode_show_clamps())
        {
            render_all_clamps();
        }

        if(mode_show_interference())
        {
            analyze_installation();

            render_service_clearance();
        }

        if(mode_show_serviceability())
        {
            analyze_serviceability();
        }

        if(mode_show_connector_access())
        {
            analyze_all_connector_access();
        }

        render_validation_overlay();
    }
}

//
// MANUFACTURING LAYER
//

module render_manufacturing_layer()
{
    if(mode_show_manufacturing())
    {
        generate_manufacturing_package();
    }
}

//
// HARNESS BOARD LAYER
//

module render_harness_board_layer()
{
    if(mode_show_harness_board())
    {
        translate(
        [
            250,
            0,
            0
        ])

        render_harness_board_layout();
    }
}

//
// DIGITAL TWIN
//

module render_digital_twin()
{
    render_component_layer();

    render_connector_layer();

    render_anchor_layer();

    render_route_layer();

    render_harness_layer();

    render_validation_layer();

    render_harness_board_layer();

    render_manufacturing_layer();
}

//
// DATABASE VALIDATION
//

module validate_database_integrity()
{
    echo(
        "===== DATABASE VALIDATION ====="
    );

    for(c=CIRCUITS)
    {
        if(!route_exists(c[0]))
        {
            echo(
                str(
                    "MISSING ROUTE DATA: ",
                    c[0]
                )
            );
        }

        if(!pin_exists(c[0]))
        {
            echo(
                str(
                    "MISSING PIN DATA: ",
                    c[0]
                )
            );
        }
    }
}

//
// DIGITAL TWIN VALIDATION
//

module validate_digital_twin()
{
    echo(
        "===== DIGITAL TWIN VALIDATION ====="
    );

    validate_anchor_database();

    validate_component_database();

    validate_connector_database();

    validate_splice_database();

    validate_clearance_database();

    validate_connector_population();

    validate_connector_access();

    validate_serviceability();

    validate_database_integrity();

    validate_clamp_spacing();
}

//
// SUMMARY
//

module digital_twin_summary()
{
    echo(
        "================================="
    );

    echo(
        str(
            "GW DIGITAL TWIN ",
            DIGITAL_TWIN_VERSION
        )
    );

    echo(
        str(
            "ANCHORS: ",
            len(ANCHORS)
        )
    );

    echo(
        str(
            "ROUTES: ",
            len(ROUTES)
        )
    );

    echo(
        str(
            "COMPONENTS: ",
            len(COMPONENTS)
        )
    );

    echo(
        str(
            "CONNECTORS: ",
            len(CONNECTORS)
        )
    );

    echo(
        str(
            "CIRCUITS: ",
            len(CIRCUITS)
        )
    );

    echo(
        str(
            "SPLICES: ",
            len(SPLICES)
        )
    );

    echo(
        "================================="
    );
}

//
// REPORTS
//

module report_geometry()
{
    report_anchor_database();

    report_component_locations();

    report_connector_locations();

    report_routes();
}

module report_routing()
{
    report_all_routes();

    report_bend_radius();

    report_clamp_counts();

    report_route_solver();
}

module report_harnessing()
{
    report_harnesses();

    report_harness_manufacturing();
}

module report_manufacturing()
{
    report_complete_bom();

    report_cutsheet();

    report_all_labels();

    report_all_connector_populations();

    report_harness_board();

    report_dxf_metadata();
}

module report_quality()
{
    report_as_built_summary();

    report_splice_database();

    report_interference();

    report_serviceability();

    report_connector_access();
}

//
// MASTER REPORT GENERATOR
//

module generate_reports()
{
    if(mode_generate_reports())
    {
        digital_twin_summary();

        report_geometry();

        report_routing();

        report_harnessing();

        report_manufacturing();

        report_quality();
    }
}

//
// MASTER ENTRY POINT
//

module run_digital_twin()
{
    initialize_modes();

    render_digital_twin();

    validate_digital_twin();

    generate_reports();
}