//
// GW_CONNECTORS.scad
//
// REV5
//
// Canonical connector database.
//

//
// RECORD FORMAT
//
// [
//     CONNECTOR_ID,
//
//     FAMILY,
//
//     PIN_COUNT,
//
//     ANCHOR_ID,
//
//     APPLICATION,
//
//     DESCRIPTION
// ]
//

CONNECTORS =
[

//
// PRIMARY POWER & BULKHEAD
//

[
"CN001",
"HDP24-60",
60,
"FW_CN001",
"MAIN_BULKHEAD",
"Primary Firewall Bulkhead Connector"
],

//
// INVERTER
//

[
"CN090",
"DT06",
6,
"CARGO_INV",
"INVERTER",
"Victron Inverter Control Connector"
],

//
// CAN HUB
//

[
"CAN_HUB",
"DT12",
12,
"DASH_CAN",
"CAN",
"Primary CAN Distribution Hub"
],

//
// OBD-II
//

[
"DASH_OBD",
"OBD-II",
16,
"DASH_OBD",
"SERVICE",
"OBD-II Diagnostic Port"
],

//
// AUDIO SYSTEM
//

[
"HALO11",
"OEM",
24,
"DASH_MAIN",
"AUDIO",
"Halo11 Head Unit Connector"
],

[
"AUD_AMP_MAIN",
"DT16",
16,
"AUD_AMP_MAIN",
"AUDIO",
"Helix V Eight Amplifier"
],

//
// BATTERY MANAGEMENT
//

[
"BMS_MODULE",
"DTM12",
12,
"CARGO_MAIN",
"BMS",
"Lithium Battery Management System"
],

//
// ETHERNET SWITCHES
//

[
"SWITCH_MAIN",
"RJ45",
8,
"DASH_MAIN",
"NETWORK",
"Primary Ethernet Switch"
],

[
"SWITCH_REAR",
"RJ45",
8,
"CARGO_MAIN",
"NETWORK",
"Rear Ethernet Switch"
],

//
// CAMERA SYSTEM
//

[
"CAM_REAR",
"DTM04",
4,
"CAM_REAR",
"CAMERA",
"Rear Camera Interface"
],

//
// POWER DISTRIBUTION
//

[
"RTMR_MAIN",
"HDP24-60",
60,
"RTMR",
"POWER",
"Relay And Fuse Center"
]

];

//
// LOOKUP HELPERS
//

function connector_ids() =
[
    for(c=CONNECTORS)
        c[0]
];

function connector_exists(id) =
    len(
        search(
            [id],
            connector_ids()
        )
    ) > 0;

function connector_index(id) =
    connector_exists(id)

    ?

    search(
        [id],
        connector_ids()
    )[0]

    :

    -1;

function connector_record(id) =

    connector_exists(id)

    ?

    CONNECTORS[
        connector_index(id)
    ]

    :

    [
        id,
        "UNDEFINED",
        0,
        "UNDEFINED",
        "UNDEFINED",
        "UNDEFINED"
    ];

//
// FIELD HELPERS
//

function connector_family(id) =
    connector_record(id)[1];

function connector_pin_count(id) =
    connector_record(id)[2];

function connector_anchor(id) =
    connector_record(id)[3];

function connector_application(id) =
    connector_record(id)[4];

function connector_description(id) =
    connector_record(id)[5];

//
// FILTER HELPERS
//

function connectors_by_application(app) =
[
    for(c=CONNECTORS)

    if(c[4] == app)

    c[0]
];

//
// REPORTING
//

module report_connector_database()
{
    echo(
        "======= CONNECTOR DATABASE ======="
    );

    for(c=CONNECTORS)
    {
        echo(
            str(
                c[0],
                " | ",
                c[1],
                " | ",
                c[2],
                " pins | ",
                c[4]
            )
        );
    }
}

module report_connector(id)
{
    echo(
        "======= CONNECTOR ======="
    );

    echo(
        str(
            "ID: ",
            id
        )
    );

    echo(
        str(
            "Family: ",
            connector_family(id)
        )
    );

    echo(
        str(
            "Pin Count: ",
            connector_pin_count(id)
        )
    );

    echo(
        str(
            "Anchor: ",
            connector_anchor(id)
        )
    );

    echo(
        str(
            "Application: ",
            connector_application(id)
        )
    );

    echo(
        str(
            "Description: ",
            connector_description(id)
        )
    );
}

//
// VALIDATION
//

module validate_connector_database()
{
    echo(
        "===== CONNECTOR DATABASE ====="
    );

    for(c=CONNECTORS)
    {
        if(
            !anchor_exists(
                c[3]
            )
        )
        {
            echo(
                str(
                    "MISSING ANCHOR: ",
                    c[0],
                    " -> ",
                    c[3]
                )
            );
        }

        if(
            c[2] <= 0
        )
        {
            echo(
                str(
                    "INVALID PIN COUNT: ",
                    c[0]
                )
            );
        }
    }
}
