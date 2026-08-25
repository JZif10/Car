//
// GW_ENGINE_LABELS.scad
//
// REV5
//
// Automatic label generation engine.
//
// Depends On:
//
//   GW_CIRCUITS.scad
//   GW_PIN_DATABASE.scad
//   GW_CONNECTORS.scad
//

include <../DATABASES/GW_CIRCUITS.scad>
include <../DATABASES/GW_PIN_DATABASE.scad>
include <../DATABASES/GW_CONNECTORS.scad>

//
// CONFIGURATION
//

WIRE_LABEL_COPIES = 2;

CONNECTOR_LABEL_COPIES = 2;

HARNESS_LABEL_COPIES = 2;

GROUND_LABEL_COPIES = 2;

//
// CIRCUIT HELPERS
//

function circuit_ids() =
[
    for(c=CIRCUITS)
    c[0]
];

//
// PIN LOOKUP
//

function pin_ids() =
[
    for(p=PIN_DATABASE)
    p[0]
];

function pin_index(id) =

search(
    [id],
    pin_ids()
)[0];

function pin_record(id) =

PIN_DATABASE[
    pin_index(id)
];

//
// WIRE LABELS
//

function wire_label(id) =
id;

//
// EXTENDED WIRE LABEL
//
// Used for heat-shrink printing.
//

function heatshrink_label(id) =

str(
    id,
    " ",
    pin_record(id)[1],
    ":",
    pin_record(id)[2]
);

//
// CONNECTOR LABELS
//

function connector_ids() =
[
    for(c=CONNECTORS)
    c[0]
];

//
// GROUND DATABASE
//
// Temporary until a dedicated
// ground database exists.
//

GROUND_IDS =
[
    "G100",
    "G300",
    "G400",
    "G500",
    "G600"
];

//
// HARNESS DATABASE
//
// Temporary until a dedicated
// harness database exists.
//

HARNESS_IDS =
[
    "HB001",
    "HB002",
    "HB003",
    "HB004"
];

//
// WIRE LABEL DATASET
//

WIRE_LABELS =
[
    for(id=circuit_ids())

    [
        wire_label(id),
        WIRE_LABEL_COPIES
    ]
];

//
// HEAT SHRINK LABELS
//

HEATSHRINK_LABELS =
[
    for(id=circuit_ids())

    [
        heatshrink_label(id),
        WIRE_LABEL_COPIES
    ]
];

//
// CONNECTOR LABELS
//

CONNECTOR_LABELS =
[
    for(id=connector_ids())

    [
        id,
        CONNECTOR_LABEL_COPIES
    ]
];

//
// GROUND LABELS
//

GROUND_LABELS =
[
    for(id=GROUND_IDS)

    [
        id,
        GROUND_LABEL_COPIES
    ]
];

//
// HARNESS LABELS
//

HARNESS_LABELS =
[
    for(id=HARNESS_IDS)

    [
        id,
        HARNESS_LABEL_COPIES
    ]
];

//
// UNIFIED EXPORT DATASET
//

LABEL_EXPORT =
concat(
    WIRE_LABELS,
    CONNECTOR_LABELS,
    GROUND_LABELS,
    HARNESS_LABELS
);

//
// REPORTING
//

module report_wire_labels()
{
    echo(
        "========== WIRE LABELS =========="
    );

    for(l=WIRE_LABELS)
    {
        echo(
            str(
                l[0],
                " Qty=",
                l[1]
            )
        );
    }
}

module report_heatshrink_labels()
{
    echo(
        "======= HEATSHRINK LABELS ======="
    );

    for(l=HEATSHRINK_LABELS)
    {
        echo(
            str(
                l[0],
                " Qty=",
                l[1]
            )
        );
    }
}

module report_connector_labels()
{
    echo(
        "====== CONNECTOR LABELS ======"
    );

    for(l=CONNECTOR_LABELS)
    {
        echo(
            str(
                l[0],
                " Qty=",
                l[1]
            )
        );
    }
}

module report_ground_labels()
{
    echo(
        "======== GROUND LABELS ========"
    );

    for(l=GROUND_LABELS)
    {
        echo(
            str(
                l[0],
                " Qty=",
                l[1]
            )
        );
    }
}

module report_harness_labels()
{
    echo(
        "======= HARNESS LABELS ======="
    );

    for(l=HARNESS_LABELS)
    {
        echo(
            str(
                l[0],
                " Qty=",
                l[1]
            )
        );
    }
}

module report_all_labels()
{
    report_wire_labels();

    report_heatshrink_labels();

    report_connector_labels();

    report_ground_labels();

    report_harness_labels();
}
