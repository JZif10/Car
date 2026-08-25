//
// GW_PIN_DATABASE.scad
//
// REV5
//
// Connector cavity assignments.
//
// RECORD FORMAT
//
// [
//     CIRCUIT_ID,
//
//     SOURCE_CONNECTOR,
//     SOURCE_PIN,
//
//     DEST_CONNECTOR,
//     DEST_PIN,
//
//     GAUGE,
//     COLOR
// ]
//

PIN_DATABASE =
[

//
// MAIN POWER
//

[
"ALT_BAT",

"ALT_OUTPUT",
"B+",

"BAT001",
"+",

"2AWG",
"RD"
],

[
"LITH_MAIN",

"BAT001",
"+",

"LITH001",
"+",

"1/0AWG",
"RD"
],

[
"INV_MAIN",

"LITH001",
"+",

"INV001",
"+",

"2/0AWG",
"RD"
],

//
// FUEL PUMP
//

[
"E110",

"CN001",
"A03",

"FUEL_PUMP",
"1",

"12AWG",
"RD/WH"
],

//
// INVERTER ENABLE
//

[
"INV_ENABLE",

"HALO11",
"AUX1",

"CN090",
"1",

"18AWG",
"RD/BL"
],

//
// CAN BUS
//

[
"C001",

"CAN_HUB",
"01",

"CAN_NODE_01",
"01",

"22AWG",
"BU"
],

[
"C002",

"CAN_HUB",
"02",

"CAN_NODE_01",
"02",

"22AWG",
"WH"
],

//
// OBD-II
//

[
"OBD_CAN_H",

"CAN_HUB",
"03",

"DASH_OBD",
"06",

"22AWG",
"BU"
],

[
"OBD_CAN_L",

"CAN_HUB",
"04",

"DASH_OBD",
"14",

"22AWG",
"WH"
],

//
// AUDIO
//

[
"AUD_REMOTE",

"HALO11",
"AMP_REM",

"AUD_AMP_MAIN",
"REM",

"20AWG",
"VT"
],

[
"AUD_SIGNAL_L",

"HALO11",
"LINE_L",

"AUD_AMP_MAIN",
"LINE_L",

"22AWG",
"GY"
],

[
"AUD_SIGNAL_R",

"HALO11",
"LINE_R",

"AUD_AMP_MAIN",
"LINE_R",

"22AWG",
"GY"
],

//
// ETHERNET
//

[
"ETH001",

"SWITCH_MAIN",
"P01",

"SWITCH_REAR",
"P01",

"CAT6",
"ETH"
],

[
"ETH002",

"SWITCH_MAIN",
"P02",

"CAM_REAR",
"P01",

"CAT6",
"ETH"
],

//
// CAMERA SYSTEM
//

[
"CAM_REAR_PWR",

"CAM_PWR_DIST",
"01",

"CAM_REAR",
"PWR",

"20AWG",
"RD/BK"
],

[
"CAM_REAR_VIDEO",

"VIDEO_DIST",
"01",

"CAM_REAR",
"VIDEO",

"COAX",
"VIDEO"
],

//
// BATTERY MANAGEMENT
//

[
"BMS_POS",

"BMS_MODULE",
"POS",

"CARGO_LITHIUM",
"POS",

"18AWG",
"RD"
],

[
"BMS_NEG",

"BMS_MODULE",
"NEG",

"G600",
"01",

"18AWG",
"BK"
]

];

//
// LOOKUP HELPERS
//

function pin_circuit_ids() =
[
    for(p=PIN_DATABASE)
    p[0]
];

function pin_index(id) =
search(
    [id],
    pin_circuit_ids()
)[0];

function pin_exists(id) =
len(
    search(
        [id],
        pin_circuit_ids()
    )
) > 0;

//
// SAFE LOOKUP
//

function pin_record(id)=

pin_exists(id)

?

PIN_DATABASE[
    pin_index(id)
]

:

[
    id,
    "UNDEFINED",
    "UNDEFINED",
    "UNDEFINED",
    "UNDEFINED",
    "UNDEFINED",
    "UNDEFINED"
];

//
// SOURCE HELPERS
//

function source_connector(id) =
pin_record(id)[1];

function source_pin(id) =
pin_record(id)[2];

//
// DESTINATION HELPERS
//

function destination_connector(id) =
pin_record(id)[3];

function destination_pin(id) =
pin_record(id)[4];

//
// WIRE HELPERS
//

function pin_gauge(id) =
pin_record(id)[5];

function pin_color(id) =
pin_record(id)[6];

//
// REPORTING
//

module report_pin_database()
{
    echo(
        "========= PIN DATABASE ========="
    );

    for(p=PIN_DATABASE)
    {
        echo(
            str(
                p[0],
                " : ",
                p[1],
                ":",
                p[2],
                " -> ",
                p[3],
                ":",
                p[4]
            )
        );
    }
}

//
// CONNECTOR POPULATION REPORT
//

module report_connector_population(connector_name)
{
    echo(
        str(
            "===== ",
            connector_name,
            " ====="
        )
    );

    for(p=PIN_DATABASE)
    {
        if(
            p[1] == connector_name
        )
        {
            echo(
                str(
                    p[2],
                    " : ",
                    p[0]
                )
            );
        }
    }
}

//
// DATABASE VALIDATION
//

module validate_pin_database()
{
    echo(
        "===== PIN DATABASE VALIDATION ====="
    );

    for(c=PIN_DATABASE)
    {
        if(c[1] == "UNDEFINED")
        {
            echo(
                str(
                    "INVALID SOURCE: ",
                    c[0]
                )
            );
        }

        if(c[3] == "UNDEFINED")
        {
            echo(
                str(
                    "INVALID DESTINATION: ",
                    c[0]
                )
            );
        }
    }
}