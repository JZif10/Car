//
// GW_CONNECTOR_LIBRARY.scad
//
// REV5
//
// Canonical Connector Geometry Library
//

$fn = 32;

//
// COMMON PIN CAVITY
//

module pin_cavity()
{
    color("gold")

    cylinder(
        d = 0.08,
        h = 0.15,
        center = true
    );
}

//
// DTM 4
//

module connector_dtm04()
{
    color("dimgray")

    cube(
    [
        1.21,
        0.65,
        0.62
    ],
    center=true);

    translate([-0.20,0.35, 0.12])
        pin_cavity();

    translate([ 0.20,0.35, 0.12])
        pin_cavity();

    translate([-0.20,0.35,-0.12])
        pin_cavity();

    translate([ 0.20,0.35,-0.12])
        pin_cavity();
}

//
// DTM12
//

module connector_dtm12()
{
    color("gray")

    cube(
    [
        1.80,
        1.00,
        1.00
    ],
    center=true);

    for(z=[-0.30,0,0.30])
    {
        for(x=[-0.45,-0.15,0.15,0.45])
        {
            translate([x,0.50,z])
                pin_cavity();
        }
    }
}

//
// DT06
//

module connector_dt06()
{
    color("gray")

    cube(
    [
        1.45,
        0.90,
        0.75
    ],
    center=true);

    for(z=[-0.15,0.15])
    {
        for(x=[-0.25,0,0.25])
        {
            translate([x,0.45,z])
                pin_cavity();
        }
    }
}

//
// DT16
//

module connector_dt16()
{
    color("gray")

    cube(
    [
        2.20,
        1.30,
        1.10
    ],
    center=true);

    for(z=[-0.35,-0.12,0.12,0.35])
    {
        for(x=[-0.52,-0.17,0.17,0.52])
        {
            translate([x,0.65,z])
                pin_cavity();
        }
    }
}

//
// DT12
//

module connector_dt12()
{
    color("gray")

    cube(
    [
        1.80,
        1.00,
        1.00
    ],
    center=true);

    for(z=[-0.35,-0.10,0.15,0.40])
    {
        for(x=[-0.30,0,0.30])
        {
            translate([x,0.50,z])
                pin_cavity();
        }
    }
}

//
// HDP24-60
//

module connector_hdp24_60()
{
    color("black")

    cube(
    [
        4.50,
        2.00,
        3.00
    ],
    center=true);

    //
    // Mounting flange
    //

    color("silver")

    translate([0,-1.10,0])

    cube(
    [
        5.50,
        0.12,
        3.75
    ],
    center=true);

    //
    // Cavity representation
    //

    for(z=[-1.0,-0.5,0,0.5,1.0])
    {
        for(x=[-1.5,-1.0,-0.5,0,0.5,1.0,1.5])
        {
            translate([x,1.05,z])
                pin_cavity();
        }
    }
}

//
// OBD-II
//

module connector_obdii()
{
    color("purple")

    hull()
    {
        translate([-1.2,0,-0.40])
            cube([0.1,0.1,0.1]);

        translate([ 1.2,0,-0.40])
            cube([0.1,0.1,0.1]);

        translate([-0.8,0,0.40])
            cube([0.1,0.1,0.1]);

        translate([ 0.8,0,0.40])
            cube([0.1,0.1,0.1]);
    }

    for(i=[0:7])
    {
        translate(
        [
            -0.85+(i*0.24),
             0.10,
             0.15
        ])
        pin_cavity();

        translate(
        [
            -0.85+(i*0.24),
             0.10,
            -0.15
        ])
        pin_cavity();
    }
}

//
// RJ45
//

module connector_rj45()
{
    color("blue")

    cube(
    [
        0.95,
        0.80,
        0.65
    ],
    center=true);

    for(i=[0:7])
    {
        translate(
        [
            -0.35+(i*0.10),
             0.41,
            -0.20
        ])

        cylinder(
            d = 0.03,
            h = 0.10,
            center = true,
            $fn = 12
        );
    }
}

//
// MASTER CONNECTOR DISPATCHER
//

module render_connector(
    family
)
{
    if(family == "HDP24-60")
    {
        connector_hdp24_60();
    }
    else
    if(family == "DTM04")
    {
        connector_dtm04();
    }
    else
    if(family == "DTM12")
    {
        connector_dtm12();
    }
    else
    if(family == "DT06")
    {
        connector_dt06();
    }
    else
    if(family == "DT12")
    {
        connector_dt12();
    }
    else
    if(family == "DT16")
    {
        connector_dt16();
    }
    else
    if(family == "OBD-II")
    {
        connector_obdii();
    }
    else
    if(family == "RJ45")
    {
        connector_rj45();
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
        center=true);
    }
}