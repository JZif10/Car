//
// GW_CLEARANCE_DATABASE.scad
//
// REV5
//
// Engineering clearance requirements.
//

//
// RECORD FORMAT
//
// [
//     COMPONENT_ID,
//
//     SERVICE_CLEARANCE,
//
//     SIDE_CLEARANCE,
//
//     TOP_CLEARANCE,
//
//     FRONT_CLEARANCE,
//
//     REAR_CLEARANCE,
//
//     DESCRIPTION
// ]
//

CLEARANCES =
[

//
// POWER SYSTEM
//

[
"BAT001",

6.0,
1.0,
1.0,
2.0,
2.0,

"Starting Battery Service Envelope"
],

[
"LITH001",

8.0,
1.0,
1.0,
2.0,
2.0,

"Lithium Battery Service Envelope"
],

[
"INV001",

12.0,
2.0,
3.0,
4.0,
4.0,

"Victron Inverter Cooling & Service"
],

[
"RTMR001",

8.0,
1.0,
2.0,
6.0,
2.0,

"RTMR Fuse/Relay Access"
],

//
// DASH SYSTEMS
//

[
"HALO11",

4.0,
1.0,
1.0,
4.0,
1.0,

"Halo11 Service Clearance"
],

[
"CAN001",

2.0,
0.5,
0.5,
2.0,
0.5,

"CAN Hub Clearance"
],

[
"OBD001",

6.0,
0.5,
0.5,
6.0,
0.5,

"OBD-II Access Envelope"
],

[
"ECU001",

4.0,
1.0,
1.0,
2.0,
2.0,

"Sniper ECU Service Envelope"
],

//
// AUDIO
//

[
"AMP001",

6.0,
1.0,
1.0,
2.0,
2.0,

"Helix Amplifier Service Access"
],

//
// NETWORK
//

[
"SW_MAIN",

3.0,
1.0,
1.0,
2.0,
1.0,

"Main Ethernet Switch"
],

[
"SW_REAR",

3.0,
1.0,
1.0,
2.0,
1.0,

"Rear Ethernet Switch"
],

//
// BMS
//

[
"BMS001",

4.0,
1.0,
1.0,
2.0,
1.0,

"BMS Service Access"
],

//
// CAMERA
//

[
"CAM_REAR_01",

2.0,
0.5,
0.5,
2.0,
0.5,

"Rear Camera Access"
]

];

//
// LOOKUP HELPERS
//

function clearance_ids() =
[
    for(c=CLEARANCES)
        c[0]
];

function clearance_exists(id) =
    len(
        search(
            [id],
            clearance_ids()
        )
    ) > 0;

function clearance_index(id) =
    clearance_exists(id)

    ?

    search(
        [id],
        clearance_ids()
    )[0]

    :

    -1;

function clearance_record(id) =

    clearance_exists(id)

    ?

    CLEARANCES[
        clearance_index(id)
    ]

    :

    [
        id,
        0,
        0,
        0,
        0,
        0,
        "UNDEFINED"
    ];

//
// FIELD HELPERS
//

function service_clearance(id) =
    clearance_record(id)[1];

function side_clearance(id) =
    clearance_record(id)[2];

function top_clearance(id) =
    clearance_record(id)[3];

function front_clearance(id) =
    clearance_record(id)[4];

function rear_clearance(id) =
    clearance_record(id)[5];

function clearance_description(id) =
    clearance_record(id)[6];

//
// REPORTS
//

module report_clearance_database()
{
    echo(
        "===== CLEARANCE DATABASE ====="
    );

    for(c=CLEARANCES)
    {
        echo(
            str(
                c[0],
                " | Service=",
                c[1],
                " in"
            )
        );
    }
}

module report_component_clearance(id)
{
    echo(
        "===== COMPONENT CLEARANCE ====="
    );

    echo(
        str(
            "Component: ",
            id
        )
    );

    echo(
        str(
            "Service: ",
            service_clearance(id)
        )
    );

    echo(
        str(
            "Sides: ",
            side_clearance(id)
        )
    );

    echo(
        str(
            "Top: ",
            top_clearance(id)
        )
    );

    echo(
        str(
            "Front: ",
            front_clearance(id)
        )
    );

    echo(
        str(
            "Rear: ",
            rear_clearance(id)
        )
    );
}

//
// VALIDATION
//

module validate_clearance_database()
{
    echo(
        "===== CLEARANCE VALIDATION ====="
    );

    for(c=CLEARANCES)
    {
        if(c[1] <= 0)
        {
            echo(
                str(
                    "INVALID CLEARANCE: ",
                    c[0]
                )
            );
        }
    }
}
