//
// GW_ENGINE_MANUFACTURING_PACKAGE.scad
//
// REV5
//
// Manufacturing package coordinator.
//

include <GW_ENGINE_BOM.scad>;
include <GW_ENGINE_CUTSHEET.scad>;
include <GW_ENGINE_LABELS.scad>;

include <GW_ENGINE_CONNECTOR_POPULATION.scad>;

include <GW_ENGINE_HARNESS_BOARD.scad>;
include <GW_ENGINE_HARNESS_BOARD_LAYOUT.scad>;

include <GW_ENGINE_HARNESS_MANUFACTURING.scad>;

include <GW_ENGINE_DXF_EXPORT.scad>;

//
// REPORTS
//

module manufacturing_reports()
{
    report_complete_bom();

    report_cutsheet();

    report_all_connector_populations();

    report_harness_manufacturing();

    report_harness_board();

    report_dxf_metadata();
}

//
// VISUALIZATION
//

module manufacturing_visuals()
{
    translate([250,0,0])
    render_harness_board_layout();

    translate([450,0,0])
    linear_extrude(0.10)
    render_dxf_preview();
}

//
// MASTER ENTRY
//

module generate_manufacturing_package()
{
    manufacturing_visuals();

    manufacturing_reports();
}