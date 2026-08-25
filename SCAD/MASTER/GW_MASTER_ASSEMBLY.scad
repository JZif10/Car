//
// GW_MASTER_ASSEMBLY.scad
//
// REV5
//
// Master project entry point.
//

//
// CONFIGURATION
//

include <../CONFIG/GW_CONFIG.scad>;
include <../CONFIG/GW_TOGGLES.scad>;

//
// VEHICLE GEOMETRY
//

include <../MODELS/GW_FRAME.scad>;
include <../MODELS/GW_FIREWALL.scad>;
include <../MODELS/GW_FLOORPAN.scad>;
include <../MODELS/GW_SJ_BODY.scad>;

//
// DIGITAL TWIN
//

include <../ENGINES/GW_ENGINE_DIGITAL_TWIN.scad>;

//
// VEHICLE GEOMETRY
//

module render_vehicle_geometry()
{
    if(SHOW_BODY)
    {
        sj_body();
    }

    if(SHOW_FRAME)
    {
        sj_frame();
    }

    if(SHOW_FIREWALL)
    {
        translate([0,0,24])

        firewall();
    }

    if(SHOW_FLOORPAN)
    {
        floor_pan();
    }
}

//
// MASTER VEHICLE
//

module vehicle()
{
    render_vehicle_geometry();
}

//
// DIGITAL TWIN
//

module electrical_system()
{
    run_digital_twin();
}

//
// COMPLETE ASSEMBLY
//

module master_assembly()
{
    vehicle();

    electrical_system();
}

//
// ENTRY POINT
//

master_assembly();
