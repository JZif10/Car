//
// GW_ENGINE_CUTSHEET.scad
//
// REV5
//
// Manufacturing cutsheet engine.
//

include <../DATABASES/GW_CIRCUITS.scad>;
include <../DATABASES/GW_PIN_DATABASE.scad>;

include <GW_ENGINE_WIRE_LENGTH.scad>;

//
// CIRCUIT LOOKUP
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
    circuit_exists(id)

    ?

    CIRCUITS[
        circuit_index(id)
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
// CIRCUIT HELPERS
//

function circuit_gauge(id) =
    circuit_record(id)[3];

function circuit_color(id) =
    circuit_record(id)[4];

//
// CUT LENGTH
//

function cut_length(id) =

route_exists(id)

?

wire_length(id)

:

0;

//
// LABELS
//

function wire_label(id) =

str(
    id,
    "-",
    source_connector(id)
);

//
// CUTSHEET RECORD
//
// [
//     CIRCUIT_ID,
//     GAUGE,
//     COLOR,
//     LENGTH,
//     SOURCE_CONNECTOR,
//     SOURCE_PIN,
//     DEST_CONNECTOR,
//     DEST_PIN,
//     LABEL
// ]
//

function cutsheet_record(id) =
[
    id,

    circuit_gauge(id),

    circuit_color(id),

    cut_length(id),

    source_connector(id),

    source_pin(id),

    destination_connector(id),

    destination_pin(id),

    wire_label(id)
];

//
// COMPLETE CUTSHEET
//

CUTSHEET =
[
    for(c=CIRCUITS)

    cutsheet_record(
        c[0]
    )
];

//
// SINGLE CIRCUIT REPORT
//

module report_circuit(id)
{
    r = cutsheet_record(id);

    echo(
        "========== CIRCUIT =========="
    );

    echo(
        str(
            "ID: ",
            r[0]
        )
    );

    echo(
        str(
            "GAUGE: ",
            r[1]
        )
    );

    echo(
        str(
            "COLOR: ",
            r[2]
        )
    );

    echo(
        str(
            "LENGTH: ",
            r[3]
        )
    );

    echo(
        str(
            "SOURCE: ",
            r[4],
            ":",
            r[5]
        )
    );

    echo(
        str(
            "DESTINATION: ",
            r[6],
            ":",
            r[7]
        )
    );

    echo(
        str(
            "LABEL: ",
            r[8]
        )
    );
}

//
// COMPLETE CUTSHEET REPORT
//

module report_cutsheet()
{
    echo(
        "========== CUTSHEET =========="
    );

    for(r=CUTSHEET)
    {
        echo(
            str(
                r[0],
                " | ",
                r[1],
                " | ",
                r[2],
                " | ",
                r[3],
                " in | ",
                r[4],
                ":",
                r[5],
                " -> ",
                r[6],
                ":",
                r[7]
            )
        );
    }
}

//
// HARNESS CUT REPORT
//

function harness_cutsheet(
    circuit_list
)=
[
    for(id=circuit_list)

    cutsheet_record(id)
];

module report_harness(
    harness_name,
    circuit_list
)
{
    echo(
        str(
            "========== ",
            harness_name,
            " =========="
        )
    );

    for(id=circuit_list)
    {
        echo(
            cutsheet_record(id)
        );
    }
}

//
// VALIDATION
//

module report_missing_pin_data()
{
    echo(
        "===== PIN VALIDATION ====="
    );

    for(c=CIRCUITS)
    {
        if(!pin_exists(c[0]))
        {
            echo(
                str(
                    "MISSING PIN DATA: ",
                    c[0]
                )
            );
        }
    }
}

module report_missing_route_data()
{
    echo(
        "===== ROUTE VALIDATION ====="
    );

    for(c=CIRCUITS)
    {
        if(!route_exists(c[0]))
        {
            echo(
                str(
                    "MISSING ROUTE DATA: ",
                    c[0]
                )
            );
        }
    }
}

module validate_cutsheet()
{
    report_missing_pin_data();

    report_missing_route_data();
}

//
// DEBUG
//

module debug_cutsheet(id)
{
    echo(
        "========== DEBUG =========="
    );

    echo(
        cutsheet_record(id)
    );
}