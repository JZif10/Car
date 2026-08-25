//
// GW_ANCHORS.scad
//
// REV5
//
// Physical coordinate database.
//
// Coordinate System:
//
// X = Front -> Rear
// Y = Driver -> Passenger
// Z = Floor -> Roof
//
// Firewall Plane = X = 0
//
// Engine Bay     = Negative X
// Passenger Cabin = Positive X
//

ANCHORS =
[

//
// FIREWALL
//

[
"FW_CN001",
[0,12,36],
"CONNECTOR",
"Main Bulkhead Connector"
],

[
"FW_MAIN_GROMMET",
[0,16,30],
"PASS_THROUGH",
"Primary Harness Grommet"
],

[
"G100",
[-1,22,10],
"GROUND",
"Firewall Ground"
],

[
"RTMR",
[-4,20,30],
"ELECTRICAL",
"Relay And Fuse Center"
],

[
"SNIPER_ECU",
[-2,8,34],
"ECU",
"Holley Sniper ECU"
],

//
// ENGINE BAY
//

[
"BATTERY",
[-18,18,12],
"POWER",
"Odyssey PC1500"
],

[
"ALT_300A",
[-12,-12,28],
"POWER",
"300A Alternator"
],

[
"STARTER",
[-10,-6,8],
"POWER",
"Starter Motor"
],

[
"ENG_LH_FRONT",
[-30,-18,18],
"LIGHTING",
"Left Front Lighting Branch"
],

[
"ENG_RH_FRONT",
[-30,18,18],
"LIGHTING",
"Right Front Lighting Branch"
],

//
// FUEL SYSTEM
//

[
"FUEL_PUMP",
[180,18,12],
"FUEL",
"Rear Fuel Pump"
],

//
// DASH
//

[
"DASH_MAIN",
[15,0,40],
"DASH",
"Halo11 Head Unit"
],

[
"DASH_CAN",
[24,6,38],
"NETWORK",
"CAN Hub"
],

[
"DASH_OBD",
[30,-6,30],
"SERVICE",
"OBD-II Port"
],

//
// CONSOLE
//

[
"CONSOLE_FWD",
[60,0,18],
"CONSOLE",
"Forward Console"
],

[
"CONSOLE_AFT",
[76,0,18],
"CONSOLE",
"Aft Console"
],

//
// AUDIO
//

[
"AUD_RACK",
[110,15,8],
"AUDIO",
"Audio Rack"
],

[
"AUD_AMP_MAIN",
[110,15,10],
"AUDIO",
"Helix V Eight"
],

[
"AUD_SUB",
[135,0,10],
"AUDIO",
"JL Audio Subwoofer"
],

//
// CARGO
//

[
"CARGO_MAIN",
[145,15,18],
"CARGO",
"Rear Electronics"
],

[
"CARGO_LITHIUM",
[150,18,8],
"POWER",
"100Ah Lithium Battery"
],

[
"CARGO_INV",
[150,-18,10],
"POWER",
"Victron Inverter"
],

//
// LIFTGATE
//

[
"LG_HINGE",
[175,0,55],
"LIFTGATE",
"Liftgate Harness Transition"
],

[
"LG_CENTER",
[185,0,58],
"LIFTGATE",
"Liftgate Centerline"
],

//
// CAMERA SYSTEM
//

[
"CAM_REAR",
[188,0,60],
"CAMERA",
"Rear Camera"
],

//
// CHASSIS GROUNDS
//

[
"G300",
[55,15,10],
"GROUND",
"Dash Ground"
],

[
"G400",
[90,14,10],
"GROUND",
"Audio Ground"
],

[
"G500",
[130,15,10],
"GROUND",
"Rear Electronics Ground"
],

[
"G600",
[130,-15,10],
"GROUND",
"Inverter Ground"
]

];

//
// LOOKUP HELPERS
//

function anchor_ids() =
[
    for(a=ANCHORS)
        a[0]
];

function anchor_exists(id) =
    len(
        search(
            [id],
            anchor_ids()
        )
    ) > 0;

function anchor_index(id) =
    anchor_exists(id)
    ?
    search(
        [id],
        anchor_ids()
    )[0]
    :
    -1;

function anchor_position(id) =
    anchor_exists(id)
    ?
    ANCHORS[
        anchor_index(id)
    ][1]
    :
    [0,0,0];

function anchor_type(id) =
    anchor_exists(id)
    ?
    ANCHORS[
        anchor_index(id)
    ][2]
    :
    "UNDEFINED";

function anchor_description(id) =
    anchor_exists(id)
    ?
    ANCHORS[
        anchor_index(id)
    ][3]
    :
    "UNDEFINED";

//
// VISUALIZATION
//

module render_anchor(id)
{
    translate(
        anchor_position(id)
    )

    color("yellow")

    sphere(
        d=1.0,
        $fn=16
    );
}

module render_all_anchors()
{
    for(a=ANCHORS)
    {
        render_anchor(
            a[0]
        );
    }
}

//
// REPORTS
//

module report_anchor_database()
{
    echo(
        "========== ANCHORS =========="
    );

    for(a=ANCHORS)
    {
        echo(
            str(
                a[0],
                " @ ",
                a[1]
            )
        );
    }
}

//
// VALIDATION
//

module validate_anchor_database()
{
    echo(
        "===== ANCHOR DATABASE ====="
    );

    for(a=ANCHORS)
    {
        if(len(a[1]) != 3)
        {
            echo(
                str(
                    "INVALID ANCHOR: ",
                    a[0]
                )
            );
        }
    }
}