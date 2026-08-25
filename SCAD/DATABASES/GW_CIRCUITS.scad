//
// GW_CIRCUITS.scad
//
// REV5
//
// Canonical circuit database.
//

//
// RECORD FORMAT
//
// [
//     CIRCUIT_ID,
//
//     SOURCE,
//
//     DESTINATION,
//
//     GAUGE,
//
//     COLOR,
//
//     CLASS,
//
//     DESCRIPTION
// ]
//

CIRCUITS =
[

//
// POWER DISTRIBUTION
//

[
"ALT_BAT",

"ALT_300A",

"BATTERY",

"2AWG",

"RD",

"POWER",

"Alternator To Battery"
],

[
"LITH_MAIN",

"BATTERY",

"CARGO_LITHIUM",

"1/0AWG",

"RD",

"POWER",

"Battery To Lithium Bank"
],

[
"INV_MAIN",

"CARGO_LITHIUM",

"CARGO_INV",

"2/0AWG",

"RD",

"POWER",

"Inverter Main Feed"
],

[
"INV_ENABLE",

"DASH_MAIN",

"CARGO_INV",

"18AWG",

"RD/BL",

"CONTROL",

"Inverter Enable"
],

//
// FUEL SYSTEM
//

[
"E110",

"RTMR",

"FUEL_PUMP",

"12AWG",

"RD/WH",

"POWER",

"Fuel Pump Feed"
],

//
// CAN BUS
//

[
"C001",

"DASH_CAN",

"CAN_NODE_01",

"22AWG",

"BU",

"CAN",

"CAN High"
],

[
"C002",

"DASH_CAN",

"CAN_NODE_01",

"22AWG",

"WH",

"CAN",

"CAN Low"
],

//
// OBD-II
//

[
"OBD_CAN_H",

"DASH_CAN",

"DASH_OBD",

"22AWG",

"BU",

"CAN",

"OBD CAN High"
],

[
"OBD_CAN_L",

"DASH_CAN",

"DASH_OBD",

"22AWG",

"WH",

"CAN",

"OBD CAN Low"
],

//
// AUDIO
//

[
"AUD_REMOTE",

"DASH_MAIN",

"AUD_RACK",

"20AWG",

"VT",

"AUDIO",

"Amplifier Remote Turn-On"
],

[
"AUD_SIGNAL_L",

"DASH_MAIN",

"AUD_RACK",

"22AWG",

"GY",

"AUDIO",

"Left Audio Signal"
],

[
"AUD_SIGNAL_R",

"DASH_MAIN",

"AUD_RACK",

"22AWG",

"GY",

"AUDIO",

"Right Audio Signal"
],

//
// ETHERNET
//

[
"ETH001",

"DASH_MAIN",

"CARGO_MAIN",

"CAT6",

"ETH",

"NETWORK",

"Rear Ethernet Backbone"
],

[
"ETH002",

"DASH_MAIN",

"LG_CENTER",

"CAT6",

"ETH",

"NETWORK",

"Liftgate Ethernet"
],

//
// CAMERA SYSTEMS
//

[
"CAM_REAR_PWR",

"DASH_MAIN",

"CAM_REAR",

"20AWG",

"RD/BK",

"CAMERA",

"Rear Camera Power"
],

[
"CAM_REAR_VIDEO",

"DASH_MAIN",

"CAM_REAR",

"COAX",

"VIDEO",

"CAMERA",

"Rear Camera Video"
],

//
// BATTERY MANAGEMENT
//

[
"BMS_POS",

"CARGO_LITHIUM",

"CARGO_MAIN",

"18AWG",

"RD",

"BMS",

"Battery Monitor Positive"
],

[
"BMS_NEG",

"CARGO_LITHIUM",

"G600",

"18AWG",

"BK",

"BMS",

"Battery Monitor Negative"
]

];

//
// LOOKUP HELPERS
//

function circuit_ids() =
[
    for(c=CIRCUITS)
    c[0]
];

function circuit_index(id) =

search(
    [id],
    circuit_ids()
)[0];

function circuit_exists(id) =

len(
search(
    [id],
    circuit_ids()
)
) > 0;

function circuit_record(id) =

CIRCUITS[
    circuit_index(id)
];

function circuit_source(id) =

circuit_record(id)[1];

function circuit_destination(id) =

circuit_record(id)[2];

function circuit_gauge(id) =

circuit_record(id)[3];

function circuit_color(id) =

circuit_record(id)[4];

function circuit_class(id) =

circuit_record(id)[5];

function circuit_description(id) =

circuit_record(id)[6];

//
// REPORTING
//

module report_circuit_database()
{
    echo(
        "========= CIRCUITS ========="
    );

    for(c=CIRCUITS)
    {
        echo(
            str(
                c[0],
                " | ",
                c[3],
                " | ",
                c[5],
                " | ",
                c[6]
            )
        );
    }
}
