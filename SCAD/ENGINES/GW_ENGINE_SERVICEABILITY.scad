//
// GW_ENGINE_SERVICEABILITY.scad
//
// REV5
//
// Installation and service validation engine.
//

include <../DATABASES/GW_ANCHORS.scad>;
include <../DATABASES/GW_COMPONENTS.scad>;
include <../DATABASES/GW_CLEARANCE_DATABASE.scad>;

//
// DISPLAY OPTIONS
//

SHOW_SERVICE_VOLUMES = true;
SHOW_SERVICE_LABELS  = true;

//
// REFERENCE VOLUMES
//

FIREWALL_PLANE_X = 0;

//
// COMPONENT POSITION
//

function component_position(id)=

anchor_position(
    component_anchor(id)
);

//
// COMPONENT DIMENSIONS
//
// Must match interference engine.
//

function component_dims(id)=

id=="BAT001"      ? [13,7,8] :
id=="LITH001"     ? [15,9,10] :
id=="INV001"      ? [20,10,5] :
id=="RTMR001"     ? [10,8,4] :
id=="HALO11"      ? [8,6,2] :
id=="CAN001"      ? [4,3,1] :
id=="OBD001"      ? [2,1,1] :
id=="ECU001"      ? [8,6,2] :
id=="AMP001"      ? [14,10,2] :
id=="SW_MAIN"     ? [6,4,1.5] :
id=="SW_REAR"     ? [6,4,1.5] :
id=="BMS001"      ? [5,4,1.5] :
id=="CAM_REAR_01" ? [1.25,1.25,1] :
[2,2,2];

//
// INSTALLATION CLEARANCE VOLUME
//

function service_volume_dims(id)=

let
(
    dims = component_dims(id),
    svc  = service_clearance(id)
)

[
    dims[0] + svc,
    dims[1] + svc,
    dims[2] + svc
];

//
// VISUAL PASS
//

module service_pass(pos)
{
    color("lime")

    translate(pos)

    sphere(
        d=0.60,
        $fn=20
    );
}

//
// VISUAL FAIL
//

module service_fail(pos)
{
    color("red")

    translate(pos)

    sphere(
        d=1.00,
        $fn=20
    );
}

//
// SERVICE VOLUME
//

module service_volume(id)
{
    if(SHOW_SERVICE_VOLUMES)
    {
        color([0,1,0,0.06])

        translate(
            component_position(id)
        )

        cube(
            service_volume_dims(id),
            center=true
        );
    }
}

//
// SERVICE LABEL
//

module service_label(
    id,
    status
)
{
    if(SHOW_SERVICE_LABELS)
    {
        pos =
            component_position(id);

        translate(
        [
            pos[0],
            pos[1],
            pos[2] + 6
        ])

        color(
            status=="PASS"
            ?
            "lime"
            :
            "red"
        )

        linear_extrude(0.10)

        text(
            str(
                id,
                " ",
                status
            ),
            size=0.75
        );
    }
}

//
// SIMPLE ACCESS CHECK
//
// First-order approximation.
//
// Firewall-side equipment
// should not be buried behind
// the firewall.
//

function firewall_access_ok(id)=

component_position(id)[0]

>

FIREWALL_PLANE_X

||

id=="BAT001"
||
id=="RTMR001"
||
id=="ECU001";

//
// COMPONENT REVIEW
//

module analyze_component_serviceability(id)
{
    service_volume(id);

    if(
        firewall_access_ok(id)
    )
    {
        service_pass(
            component_position(id)
        );

        service_label(
            id,
            "PASS"
        );
    }
    else
    {
        service_fail(
            component_position(id)
        );

        service_label(
            id,
            "FAIL"
        );

        echo(
            str(
                "SERVICE ACCESS FAIL: ",
                id
            )
        );
    }
}

//
// COMPLETE ANALYSIS
//

module analyze_serviceability()
{
    for(c=COMPONENTS)
    {
        analyze_component_serviceability(
            c[0]
        );
    }
}

//
// REPORTING
//

module report_serviceability()
{
    echo(
        "===== SERVICEABILITY REPORT ====="
    );

    for(c=COMPONENTS)
    {
        id = c[0];

        echo(
            str(
                id,
                " | Service Clearance=",
                service_clearance(id),
                " in"
            )
        );
    }
}

//
// SPECIALIZED CHECKS
//

module report_power_system_serviceability()
{
    echo(
        "===== POWER SYSTEM SERVICEABILITY ====="
    );

    echo(
        str(
            "BAT001 Service = ",
            service_clearance("BAT001")
        )
    );

    echo(
        str(
            "LITH001 Service = ",
            service_clearance("LITH001")
        )
    );

    echo(
        str(
            "INV001 Service = ",
            service_clearance("INV001")
        )
    );
}

module report_connector_serviceability()
{
    echo(
        "===== CONNECTOR SERVICEABILITY ====="
    );

    echo(
        "CN001 requires firewall access"
    );

    echo(
        "RTMR requires fuse access"
    );

    echo(
        "OBD connector requires operator access"
    );
}

//
// VALIDATION
//

module validate_serviceability()
{
    echo(
        "===== SERVICEABILITY VALIDATION ====="
    );

    for(c=COMPONENTS)
    {
        id = c[0];

        if(
            service_clearance(id)
            <=
            0
        )
        {
            echo(
                str(
                    "INVALID SERVICE CLEARANCE: ",
                    id
                )
            );
        }
    }
}