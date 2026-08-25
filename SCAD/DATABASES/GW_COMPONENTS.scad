//
// GW_COMPONENTS.scad
//
// REV5
//
// Canonical physical component database.
//

//
// RECORD FORMAT
//
// [
//     COMPONENT_ID,
//
//     COMPONENT_TYPE,
//
//     ANCHOR_ID,
//
//     SUBSYSTEM,
//
//     DESCRIPTION
// ]
//

COMPONENTS =
[

//
// POWER SYSTEM
//

[
"BAT001",
"BATTERY",
"BATTERY",
"POWER",
"Odyssey PC1500 Starting Battery"
],

[
"LITH001",
"LITHIUM",
"CARGO_LITHIUM",
"POWER",
"Primary Lithium House Battery"
],

[
"INV001",
"INVERTER",
"CARGO_INV",
"POWER",
"Victron Inverter"
],

[
"RTMR001",
"RTMR",
"RTMR",
"POWER",
"Relay And Fuse Center"
],

//
// DASH & CONTROL
//

[
"HALO11",
"HALO11",
"DASH_MAIN",
"INFOTAINMENT",
"Halo11 Head Unit"
],

[
"CAN001",
"CAN_HUB",
"DASH_CAN",
"NETWORK",
"Primary CAN Distribution Hub"
],

[
"OBD001",
"OBD",
"DASH_OBD",
"SERVICE",
"OBD-II Diagnostic Interface"
],

[
"ECU001",
"ECU",
"SNIPER_ECU",
"ENGINE",
"Holley Sniper ECU"
],

//
// AUDIO
//

[
"AMP001",
"HELIX_V8",
"AUD_AMP_MAIN",
"AUDIO",
"Helix V Eight DSP Amplifier"
],

//
// NETWORK
//

[
"SW_MAIN",
"ETH_SWITCH",
"DASH_MAIN",
"NETWORK",
"Primary Ethernet Switch"
],

[
"SW_REAR",
"ETH_SWITCH",
"CARGO_MAIN",
"NETWORK",
"Rear Ethernet Switch"
],

//
// BATTERY MANAGEMENT
//

[
"BMS001",
"BMS",
"CARGO_MAIN",
"POWER",
"Battery Management System"
],

//
// CAMERA SYSTEM
//

[
"CAM_REAR_01",
"CAMERA",
"CAM_REAR",
"CAMERA",
"Rear Camera Module"
]

];

//
// LOOKUP HELPERS
//

function component_ids() =
[
    for(c = COMPONENTS)
        c[0]
];

function component_index(id) =
    search(
        [id],
        component_ids()
    )[0];

function component_exists(id) =
    len(
        search(
            [id],
            component_ids()
        )
    ) > 0;

function component_record(id) =
    COMPONENTS[
        component_index(id)
    ];

//
// FIELD HELPERS
//

function component_type(id) =
    component_record(id)[1];

function component_anchor(id) =
    component_record(id)[2];

function component_subsystem(id) =
    component_record(id)[3];

function component_description(id) =
    component_record(id)[4];

//
// FILTER HELPERS
//

function components_by_subsystem(subsystem) =
[
    for(c = COMPONENTS)

    if(c[3] == subsystem)

    c[0]
];

//
// REPORTING
//

module report_component_database()
{
    echo(
        "======= COMPONENT DATABASE ======="
    );

    for(c = COMPONENTS)
    {
        echo(
            str(
                c[0],
                " | ",
                c[1],
                " | ",
                c[2],
                " | ",
                c[3]
            )
        );
    }
}

module report_component(id)
{
    echo(
        "======= COMPONENT ======="
    );

    echo(
        str(
            "ID: ",
            id
        )
    );

    echo(
        str(
            "Type: ",
            component_type(id)
        )
    );

    echo(
        str(
            "Anchor: ",
            component_anchor(id)
        )
    );

    echo(
        str(
            "Subsystem: ",
            component_subsystem(id)
        )
    );

    echo(
        str(
            "Description: ",
            component_description(id)
        )
    );
}