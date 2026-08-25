//
// GW_SPLICE_DATABASE.scad
//
// REV5
//
// Master splice database.
//

//
// RECORD FORMAT
//
// [
//     SPLICE_ID,
//
//     ANCHOR_ID,
//
//     TYPE,
//
//     HARNESS,
//
//     [
//         CIRCUITS
//     ],
//
//     DESCRIPTION
// ]
//

SPLICES =
[

//
// DASH NETWORK SPLICE
//

[
"SP001",

"DASH_CAN",

"SEALED_SPLICE",

"HB002_DASH",

[
    "C001",
    "C002",
    "OBD_CAN_H",
    "OBD_CAN_L"
],

"CAN Backbone Distribution"
],

//
// AUDIO DISTRIBUTION
//

[
"SP002",

"AUD_RACK",

"SEALED_SPLICE",

"HB003_AUDIO",

[
    "AUD_REMOTE",
    "AUD_SIGNAL_L",
    "AUD_SIGNAL_R"
],

"Audio Distribution Point"
],

//
// REAR ETHERNET BRANCH
//

[
"SP003",

"CARGO_MAIN",

"SEALED_SPLICE",

"HB004_REAR",

[
    "ETH001",
    "ETH002"
],

"Rear Network Distribution"
],

//
// CAMERA BRANCH
//

[
"SP004",

"LG_HINGE",

"SEALED_SPLICE",

"HB004_REAR",

[
    "CAM_REAR_PWR",
    "CAM_REAR_VIDEO"
],

"Liftgate Camera Branch"
]

];

//
// LOOKUP HELPERS
//

function splice_ids() =
[
    for(s=SPLICES)
        s[0]
];

function splice_index(id) =
search(
    [id],
    splice_ids()
)[0];

function splice_exists(id) =
len(
    search(
        [id],
        splice_ids()
    )
) > 0;

function splice_record(id) =
splice_exists(id)

?

SPLICES[
    splice_index(id)
]

:

[
    id,
    "UNDEFINED",
    "UNDEFINED",
    "UNDEFINED",
    [],
    "UNDEFINED"
];

//
// FIELD HELPERS
//

function splice_anchor(id) =
splice_record(id)[1];

function splice_type(id) =
splice_record(id)[2];

function splice_harness(id) =
splice_record(id)[3];

function splice_circuits(id) =
splice_record(id)[4];

function splice_description(id) =
splice_record(id)[5];

//
// VISUALIZATION
//

module render_splice(id)
{
    pos =
        anchor_position(
            splice_anchor(id)
        );

    translate(pos)

    color("yellow")

    sphere(
        d = 0.90,
        $fn = 20
    );

    translate(
    [
        pos[0],
        pos[1],
        pos[2] + 1.5
    ])

    color("white")

    linear_extrude(0.10)

    text(
        id,
        size = 0.5
    );
}

module render_all_splices()
{
    for(s=SPLICES)
    {
        render_splice(
            s[0]
        );
    }
}

//
// REPORTING
//

module report_splice_database()
{
    echo(
        "===== SPLICE DATABASE ====="
    );

    for(s=SPLICES)
    {
        echo(
            str(
                s[0],
                " | ",
                s[1],
                " | ",
                len(s[4]),
                " circuits"
            )
        );
    }
}

//
// VALIDATION
//

module validate_splice_database()
{
    echo(
        "===== SPLICE VALIDATION ====="
    );

    for(s=SPLICES)
    {
        if(
            !anchor_exists(
                s[1]
            )
        )
        {
            echo(
                str(
                    "MISSING ANCHOR: ",
                    s[0],
                    " -> ",
                    s[1]
                )
            );
        }

        if(
            len(s[4]) == 0
        )
        {
            echo(
                str(
                    "EMPTY SPLICE: ",
                    s[0]
                )
            );
        }
    }
}