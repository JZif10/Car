//
// GW_ENGINE_CONNECTOR_ACCESS.scad
//
// REV5
//
// Connector accessibility validation.
//

include <../DATABASES/GW_ANCHORS.scad>;
include <../DATABASES/GW_CONNECTORS.scad>;

//
// ACCESS DATABASE
//

CONNECTOR_ACCESS =
[
    [
        "CN001",
        6.0,
        "FRONT",
        "Firewall Bulkhead Connector"
    ],

    [
        "CN090",
        4.0,
        "TOP",
        "Inverter Enable Connector"
    ],

    [
        "DASH_OBD",
        6.0,
        "REAR",
        "OBD-II Diagnostic Connector"
    ],

    [
        "CAN_HUB",
        3.0,
        "SIDE",
        "CAN Service Access"
    ],

    [
        "SWITCH_MAIN",
        3.0,
        "SIDE",
        "Ethernet Service Access"
    ],

    [
        "SWITCH_REAR",
        3.0,
        "SIDE",
        "Rear Ethernet Service Access"
    ],

    [
        "BMS_MODULE",
        4.0,
        "FRONT",
        "BMS Service Access"
    ],

    [
        "CAM_REAR",
        4.0,
        "REAR",
        "Rear Camera Connector"
    ],

    [
        "RTMR_MAIN",
        6.0,
        "TOP",
        "RTMR Main Service Connector"
    ],
    
    [
        "HALO11",
        4.0,
        "FRONT",
        "Halo11 Display Access"
],
    
    [
        "AUD_AMP_MAIN",
        4.0,
        "TOP",
        "Amplifier Service Access"
    ]
   
];

//
// LOOKUPS
//

function connector_access_ids() =
[
    for(a=CONNECTOR_ACCESS)
        a[0]
];

function connector_access_exists(id) =
    len(
        search(
            [id],
            connector_access_ids()
        )
    ) > 0;

function connector_access_record(id) =

let(
    idx =
        search(
            [id],
            connector_access_ids()
        )
)

len(idx) > 0

?

CONNECTOR_ACCESS[idx[0]]

:

[
    id,
    2.0,
    "FRONT",
    "DEFAULT"
];

function access_length(id) =

connector_access_exists(id)

?

connector_access_record(id)[1]

:

2.0;

function access_direction(id) =

connector_access_exists(id)

?

connector_access_record(id)[2]

:

"FRONT";

function access_description(id) =

connector_access_exists(id)

?

connector_access_record(id)[3]

:

"DEFAULT";

//
// POSITION
//

function connector_position(id) =

anchor_position(
    connector_anchor(id)
);

//
// ACCESS VOLUME
//

module connector_access_volume(id)
{
    let(
        pos = connector_position(id),
        len = access_length(id),
        dir = access_direction(id)
    )
    {
        color([0,1,0,0.08])

        if(dir == "FRONT")
        {
            translate(
            [
                pos[0] + len/2,
                pos[1],
                pos[2]
            ])

            cube(
            [
                len,
                2,
                2
            ],
            center=true
            );
        }
        else
        if(dir == "REAR")
        {
            translate(
            [
                pos[0] - len/2,
                pos[1],
                pos[2]
            ])

            cube(
            [
                len,
                2,
                2
            ],
            center=true
            );
        }
        else
        if(dir == "SIDE")
        {
            translate(
            [
                pos[0],
                pos[1] + len/2,
                pos[2]
            ])

            cube(
            [
                2,
                len,
                2
            ],
            center=true
            );
        }
        else
        {
            translate(
            [
                pos[0],
                pos[1],
                pos[2] + len/2
            ])

            cube(
            [
                2,
                2,
                len
            ],
            center=true
            );
        }
    }
}

//
// PASS MARKER
//

module connector_access_pass(pos)
{
    color("lime")

    translate(pos)

    sphere(
        d=0.60,
        $fn=20
    );
}

//
// FAIL MARKER
//

module connector_access_fail(pos)
{
    color("red")

    translate(pos)

    sphere(
        d=1.00,
        $fn=20
    );
}

//
// LABEL
//

module connector_access_label(
    id,
    status
)
{
    let(
        pos = connector_position(id)
    )
    {
        translate(
        [
            pos[0],
            pos[1],
            pos[2] + 4
        ])

        color(
            status == "PASS"
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
            size=0.60
        );
    }
}

//
// SIMPLE ACCESS CHECK
//

function connector_access_ok(id) =

anchor_exists(
    connector_anchor(id)
);

//
// SINGLE CONNECTOR ANALYSIS
//

module analyze_connector_access(id)
{
    connector_access_volume(id);

    if(connector_access_ok(id))
    {
        connector_access_pass(
            connector_position(id)
        );

        connector_access_label(
            id,
            "PASS"
        );
    }
    else
    {
        connector_access_fail(
            connector_position(id)
        );

        connector_access_label(
            id,
            "FAIL"
        );

        echo(
            str(
                "ACCESS FAIL: ",
                id
            )
        );
    }
}

//
// COMPLETE ANALYSIS
//

module analyze_all_connector_access()
{
    for(c=CONNECTORS)
    {
        analyze_connector_access(
            c[0]
        );
    }
}

//
// REPORTING
//

module report_connector_access()
{
    echo(
        "===== CONNECTOR ACCESS REPORT ====="
    );

    for(c=CONNECTORS)
    {
        echo(
            str(
                c[0],
                " | ",
                access_length(c[0]),
                " in | ",
                access_direction(c[0])
            )
        );
    }
}

//
// VALIDATION
//

module validate_connector_access()
{
    echo(
        "===== CONNECTOR ACCESS VALIDATION ====="
    );

    for(c=CONNECTORS)
    {
        if(access_length(c[0]) <= 0)
        {
            echo(
                str(
                    "INVALID ACCESS LENGTH: ",
                    c[0]
                )
            );
        }
    }
}

//
// DATABASE VALIDATION
//

module validate_connector_access_database()
{
    echo(
        "===== CONNECTOR ACCESS DATABASE ====="
    );

    for(c=CONNECTORS)
    {
        if(!connector_access_exists(c[0]))
        {
            echo(
                str(
                    "MISSING ACCESS RECORD: ",
                    c[0]
                )
            );
        }
    }
}

//
// DEBUG
//

module debug_connector_access()
{
    for(c=CONNECTORS)
    {
        echo(
            str(
                c[0],
                " | length=",
                access_length(c[0]),
                " | dir=",
                access_direction(c[0])
            )
        );
    }
}

module debug_connector_positions()
{
    echo("===== CONNECTOR POSITION DEBUG =====");

    for(c=CONNECTORS)
    {
        id = c[0];

        echo(
            str(
                id,
                " | pos=",
                connector_position(id),
                " | len=",
                access_length(id),
                " | dir=",
                access_direction(id)
            )
        );
    }
}