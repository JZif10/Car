//
// GW_COMPONENT_LIBRARY.scad
//
// REV5
//
// Canonical Component Geometry Library
//
// GEOMETRY ONLY
//

//
// COMMON GEOMETRY HELPERS
//

module rounded_box(
    x,
    y,
    z
)
{
    cube(
    [
        x,
        y,
        z
    ],
    center=true
    );
}

//
// CONNECTOR REFERENCE
//

module connector_reference(
    x = 0,
    y = 0,
    z = 0
)
{
    translate([x,y,z])

    color("gold")

    cylinder(
        d = 0.35,
        h = 0.25,
        center = true,
        $fn = 24
    );
}

//
// BATTERY
//
// Odyssey PC1500
//

module battery_model()
{
    color("black")

    rounded_box(
        13,
        7,
        8
    );

    connector_reference(
        -4,
        0,
        4.2
    );

    connector_reference(
         4,
         0,
         4.2
    );
}

//
// LITHIUM BATTERY
//

module lithium_battery_model()
{
    color("royalblue")

    rounded_box(
        15,
        9,
        10
    );

    connector_reference(
        -4,
        0,
        5.0
    );

    connector_reference(
         4,
         0,
         5.0
    );
}

//
// VICTRON INVERTER
//

module inverter_model()
{
    color("navy")

    rounded_box(
        20,
        10,
        5
    );

    color("white")

    translate(
    [
        0,
        0,
        2.55
    ])

    cube(
    [
        8,
        4,
        0.10
    ],
    center=true
    );

    connector_reference(
        -8,
         0,
        -2
    );

    connector_reference(
         8,
         0,
        -2
    );
}

//
// RTMR
//

module rtmr_model()
{
    color("dimgray")

    rounded_box(
        10,
        8,
        4
    );
}

//
// HALO11
//

module halo11_model()
{
    color("black")

    rounded_box(
        8,
        6,
        2
    );

    color("darkslategray")

    translate(
    [
        0,
        0,
        1.05
    ])

    cube(
    [
        7.50,
        5.50,
        0.10
    ],
    center=true
    );

    connector_reference(
        0,
       -3,
       -0.5
    );
}

//
// HOLLEY SNIPER ECU
//

module ecu_model()
{
    color("darkgreen")

    rounded_box(
        8,
        6,
        2
    );

    connector_reference(
       -3,
        0,
       -1
    );

    connector_reference(
        3,
        0,
       -1
    );
}

//
// HELIX V EIGHT
//

module helix_v8_model()
{
    color("silver")

    rounded_box(
        14,
        10,
        2
    );

    connector_reference(
       -5,
        0,
       -0.75
    );

    connector_reference(
        5,
        0,
       -0.75
    );
}

//
// CAN HUB
//

module can_hub_model()
{
    color("green")

    rounded_box(
        4,
        3,
        1
    );
}

//
// OBD-II PORT
//

module obd_port_model()
{
    color("purple")

    rounded_box(
        2,
        1,
        1
    );
}

//
// BMS
//

module bms_model()
{
    color("orange")

    rounded_box(
        5,
        4,
        1.5
    );

    connector_reference(
        0,
       -1.5,
        0
    );
}

//
// ETHERNET SWITCH
//

module ethernet_switch_model()
{
    color("gray")

    rounded_box(
        6,
        4,
        1.5
    );

    connector_reference(
       -2,
        0,
        0
    );

    connector_reference(
        2,
        0,
        0
    );
}

//
// CAMERA
//

module rear_camera_model()
{
    color("black")

    cylinder(
        d = 1.25,
        h = 1,
        center = true,
        $fn = 48
    );

    connector_reference(
        0,
        0,
       -0.6
    );
}

//
// POWER DISTRIBUTION
//

module power_distribution_model()
{
    color("red")

    rounded_box(
        5,
        3,
        2
    );
}

//
// GENERIC AMPLIFIER
//

module amplifier_model()
{
    color("silver")

    rounded_box(
        12,
        8,
        2
    );
}

//
// DISPATCHER
//

module render_component(
    component_type
)
{
    if(component_type == "BATTERY")
    {
        battery_model();
    }
    else if(component_type == "LITHIUM")
    {
        lithium_battery_model();
    }
    else if(component_type == "INVERTER")
    {
        inverter_model();
    }
    else if(component_type == "RTMR")
    {
        rtmr_model();
    }
    else if(component_type == "HALO11")
    {
        halo11_model();
    }
    else if(component_type == "ECU")
    {
        ecu_model();
    }
    else if(component_type == "HELIX_V8")
    {
        helix_v8_model();
    }
    else if(component_type == "CAN_HUB")
    {
        can_hub_model();
    }
    else if(component_type == "OBD")
    {
        obd_port_model();
    }
    else if(component_type == "BMS")
    {
        bms_model();
    }
    else if(component_type == "ETH_SWITCH")
    {
        ethernet_switch_model();
    }
    else if(component_type == "CAMERA")
    {
        rear_camera_model();
    }
    else if(component_type == "PWR_DIST")
    {
        power_distribution_model();
    }
    else if(component_type == "AMPLIFIER")
    {
        amplifier_model();
    }
    else
    {
        color("red")

        cube(
        [
            2,
            2,
            2
        ],
        center=true
        );
    }
}