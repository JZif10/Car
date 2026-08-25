//
// GW_ENGINE_AS_BUILT.scad
//
// REV5
//
// Installed vehicle tracking
// and digital twin reconciliation.
//

//
// STATUS CONSTANTS
//

STATUS_PENDING  = "PENDING";
STATUS_PASS     = "PASS";
STATUS_FAIL     = "FAIL";
STATUS_REWORK   = "REWORK";
STATUS_APPROVED = "APPROVED";

//
// TECHNICIANS
//

TECHNICIANS =
[
    ["JAZ","Jeremy A. Zifchock"],
    ["TEC01","Technician 01"],
    ["TEC02","Technician 02"]
];

//
// AS-BUILT CIRCUITS
//
// [
//   TYPE,
//   CIRCUIT_ID,
//   DESIGN_LENGTH,
//   INSTALLED_LENGTH,
//   TECH,
//   DATE,
//   STATUS
// ]
//

AS_BUILT_CIRCUITS =
[
];

//
// AS-BUILT CONNECTORS
//
// [
//   TYPE,
//   CONNECTOR_ID,
//   INSTALLED,
//   TECH,
//   DATE,
//   STATUS
// ]
//

AS_BUILT_CONNECTORS =
[
];

//
// AS-BUILT HARNESSES
//
// [
//   TYPE,
//   HARNESS_ID,
//   STATE,
//   TECH,
//   DATE,
//   STATUS
// ]
//

AS_BUILT_HARNESSES =
[
];

//
// QC RESULTS
//
// [
//   TEST_TYPE,
//   TARGET,
//   RESULT,
//   TECH,
//   DATE
// ]
//

AS_BUILT_QC =
[
];

//
// ENGINEERING CHANGE ORDERS
//
// [
//   ECN,
//   DESCRIPTION,
//   DATE,
//   STATUS
// ]
//

ECN_DATABASE =
[
];

//
// VARIANCE CALCULATIONS
//

function length_variance(
    design_length,
    actual_length
)=

actual_length
-
design_length;

function variance_percent(
    design_length,
    actual_length
)=

design_length == 0

?

0

:

(
(actual_length-design_length)
/
design_length
)
*
100;

//
// VALIDATION
//

MAX_LENGTH_VARIANCE_PERCENT = 5.0;

function length_pass(
    design_length,
    actual_length
)=

abs(
variance_percent(
design_length,
actual_length
)
)

<=

MAX_LENGTH_VARIANCE_PERCENT;

//
// CONNECTOR VALIDATION
//

function connector_installed(id)=

len(
[
for(c=AS_BUILT_CONNECTORS)

if(
c[1] == id
&&
c[5] == STATUS_PASS
)

c
]
)

>

0;

//
// HARNESS VALIDATION
//

function harness_complete(id)=

len(
[
for(h=AS_BUILT_HARNESSES)

if(
h[1] == id
&&
h[5] == STATUS_PASS
)

h
]
)

>

0;

//
// REPORTS
//

module report_as_built_summary()
{
    echo(
        "====== AS-BUILT SUMMARY ======"
    );

    echo(
        str(
            "Installed Circuits: ",
            len(AS_BUILT_CIRCUITS)
        )
    );

    echo(
        str(
            "Installed Connectors: ",
            len(AS_BUILT_CONNECTORS)
        )
    );

    echo(
        str(
            "Installed Harnesses: ",
            len(AS_BUILT_HARNESSES)
        )
    );

    echo(
        str(
            "QC Records: ",
            len(AS_BUILT_QC)
        )
    );

    echo(
        str(
            "ECNs: ",
            len(ECN_DATABASE)
        )
    );
}

module report_open_ecns()
{
    echo(
        "====== ECNs ======"
    );

    for(e=ECN_DATABASE)
    {
        echo(
            str(
                e[0],
                " : ",
                e[1]
            )
        );
    }
}

module report_qc_results()
{
    echo(
        "====== QC RESULTS ======"
    );

    for(q=AS_BUILT_QC)
    {
        echo(
            str(
                q[0],
                " : ",
                q[1],
                " : ",
                q[2]
            )
        );
    }
}