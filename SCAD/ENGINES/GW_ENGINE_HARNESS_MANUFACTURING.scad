//
// GW_ENGINE_HARNESS_MANUFACTURING.scad
//
// REV5
//
// Harness manufacturing metrics.
//

include <GW_ENGINE_HARNESS_GEOMETRY.scad>;
include <GW_ENGINE_WIRE_LENGTH.scad>;

//
// HARNESS METRICS
//

function harness_circuit_count(h) =
    len(h);

function harness_total_length(h) =
    harness_length(h);

function harness_total_length_ft(h) =
    harness_length(h) / 12.0;

function harness_clamp_estimate(h) =
    ceil(
        harness_length(h)
        /
        18
    );

//
// HARNESS REPORT
//

module report_manufacturing_harness(
    name,
    harness
)
{
    echo(
        "=============================="
    );

    echo(
        str(
            "HARNESS: ",
            name
        )
    );

    echo(
        str(
            "CIRCUITS: ",
            harness_circuit_count(
                harness
            )
        )
    );

    echo(
        str(
            "LENGTH (IN): ",
            harness_total_length(
                harness
            )
        )
    );

    echo(
        str(
            "LENGTH (FT): ",
            harness_total_length_ft(
                harness
            )
        )
    );

    echo(
        str(
            "BUNDLE DIA: ",
            harness_bundle_diameter(
                harness
            )
        )
    );

    echo(
        str(
            "CLAMPS: ",
            harness_clamp_estimate(
                harness
            )
        )
    );
}

//
// COMPLETE REPORT
//

module report_harness_manufacturing()
{
    echo(
        "===== HARNESS MANUFACTURING ====="
    );

    report_manufacturing_harness(
        "HB001_ENGINE",
        HB001_ENGINE
    );

    report_manufacturing_harness(
        "HB002_DASH",
        HB002_DASH
    );

    report_manufacturing_harness(
        "HB003_AUDIO",
        HB003_AUDIO
    );

    report_manufacturing_harness(
        "HB004_REAR",
        HB004_REAR
    );
}

//
// TOTALS
//

function total_harness_length() =

    harness_total_length(HB001_ENGINE)

    +

    harness_total_length(HB002_DASH)

    +

    harness_total_length(HB003_AUDIO)

    +

    harness_total_length(HB004_REAR);

function total_harness_length_ft() =

    total_harness_length()
    /
    12.0;

function total_harness_circuits() =

    harness_circuit_count(HB001_ENGINE)

    +

    harness_circuit_count(HB002_DASH)

    +

    harness_circuit_count(HB003_AUDIO)

    +

    harness_circuit_count(HB004_REAR);

function total_harness_clamps() =

    harness_clamp_estimate(HB001_ENGINE)

    +

    harness_clamp_estimate(HB002_DASH)

    +

    harness_clamp_estimate(HB003_AUDIO)

    +

    harness_clamp_estimate(HB004_REAR);

//
// MANUFACTURING SUMMARY
//

module report_manufacturing_summary()
{
    echo(
        "===== MANUFACTURING SUMMARY ====="
    );

    echo(
        str(
            "TOTAL CIRCUITS: ",
            total_harness_circuits()
        )
    );

    echo(
        str(
            "TOTAL LENGTH (IN): ",
            total_harness_length()
        )
    );

    echo(
        str(
            "TOTAL LENGTH (FT): ",
            total_harness_length_ft()
        )
    );

    echo(
        str(
            "TOTAL CLAMPS: ",
            total_harness_clamps()
        )
    );
}

//
// VALIDATION
//

module validate_harness_manufacturing()
{
    echo(
        "===== HARNESS MANUFACTURING VALIDATION ====="
    );

    if(
        total_harness_circuits()
        <=
        0
    )
    {
        echo(
            "NO HARNESS CIRCUITS DEFINED"
        );
    }

    if(
        total_harness_length()
        <=
        0
    )
    {
        echo(
            "NO HARNESS LENGTH CALCULATED"
        );
    }
}

//
// MASTER ENTRY
//

module generate_harness_manufacturing_data()
{
    report_harness_manufacturing();

    report_manufacturing_summary();

    validate_harness_manufacturing();
}