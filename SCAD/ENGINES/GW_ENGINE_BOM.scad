//
// GW_ENGINE_BOM.scad
//
// REV5
//
// Self-updating BOM engine.
//

include <../CONFIG/GW_CONFIG.scad>;

include <../DATABASES/GW_CIRCUITS.scad>;
include <../DATABASES/GW_CONNECTORS.scad>;
include <../DATABASES/GW_PIN_DATABASE.scad>;

include <GW_ENGINE_WIRE_LENGTH.scad>;

//
// UTILITIES
//

function sum_list(
    values,
    index=0
)=

(index >= len(values))

?

0

:

values[index]

+

sum_list(
    values,
    index+1
);

//
// SUPPORTED WIRE TYPES
//

WIRE_TYPES =
[
    "22AWG",
    "20AWG",
    "18AWG",
    "16AWG",
    "14AWG",
    "12AWG",
    "10AWG",
    "8AWG",
    "4AWG",
    "2AWG",
    "1/0AWG",
    "2/0AWG",
    "CAT6",
    "COAX"
];

//
// CIRCUIT FILTERS
//

function circuits_for_wire_type(type)=
[
    for(c=CIRCUITS)

    if(
        c[3] == type
        &&
        route_exists(c[0])
    )

    c[0]
];

//
// WIRE LENGTH TOTALS
//

function wire_type_length(type)=

sum_list(
[
    for(id=circuits_for_wire_type(type))

    wire_length(id)
]
);

//
// PURCHASE LENGTHS
//

function purchase_length(type)=

wire_type_length(type)

*
PURCHASE_FACTOR;

function purchase_feet(type)=

inches_to_feet(
    purchase_length(type)
);

//
// WIRE BOM
//

BOM_WIRE =
[
    for(type=WIRE_TYPES)

    [
        type,
        purchase_feet(type)
    ]
];

//
// CONNECTOR COUNTS
//

function connector_count(
    family
)=

len(
[
    for(c=CONNECTORS)

    if(
        c[1] == family
    )

    c
]
);

function connector_families()=
[
    "HDP24-60",
    "DTM04",
    "DTM12",
    "DT06",
    "DT12",
    "DT16",
    "RJ45",
    "OBD-II",
    "OEM"
];

//
// CONNECTOR BOM
//

BOM_CONNECTORS =
[
    for(f=connector_families())

    [
        f,
        connector_count(f)
    ]
];

//
// TERMINALS
//

function terminal_qty()=
len(PIN_DATABASE);

function seal_qty()=
len(PIN_DATABASE);

//
// HARNESS MATERIALS
//

function harness_wire_total(
    harness
)=

harness_length(
    harness
);

function harness_loom_total(
    harness
)=

loom_length(
    harness
);

//
// REPORTS
//

module report_wire_bom()
{
    echo(
        "========== WIRE BOM =========="
    );

    for(entry=BOM_WIRE)
    {
        if(entry[1] > 0)
        {
            echo(
                str(
                    entry[0],
                    " : ",
                    entry[1],
                    " ft"
                )
            );
        }
    }
}

module report_connector_bom()
{
    echo(
        "======= CONNECTOR BOM ======="
    );

    for(entry=BOM_CONNECTORS)
    {
        if(entry[1] > 0)
        {
            echo(
                str(
                    entry[0],
                    " : ",
                    entry[1]
                )
            );
        }
    }
}

module report_terminal_bom()
{
    echo(
        "======== TERMINALS ========"
    );

    echo(
        str(
            "TERMINALS : ",
            terminal_qty()
        )
    );

    echo(
        str(
            "SEALS : ",
            seal_qty()
        )
    );
}

module report_complete_bom()
{
    report_wire_bom();

    report_connector_bom();

    report_terminal_bom();
}

//
// VALIDATION
//

module validate_bom()
{
    echo(
        "===== BOM VALIDATION ====="
    );

    for(c=CIRCUITS)
    {
        if(!route_exists(c[0]))
        {
            echo(
                str(
                    "NO ROUTE: ",
                    c[0]
                )
            );
        }

        if(!pin_exists(c[0]))
        {
            echo(
                str(
                    "NO PIN DATA: ",
                    c[0]
                )
            );
        }
    }
}

//
// DEBUG
//

module report_wire_type(type)
{
    echo(
        str(
            type,
            " LENGTH = ",
            wire_type_length(type),
            " in"
        )
    );

    echo(
        str(
            type,
            " PURCHASE = ",
            purchase_feet(type),
            " ft"
        )
    );
}