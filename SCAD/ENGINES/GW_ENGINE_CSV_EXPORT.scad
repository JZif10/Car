//
// GW_ENGINE_CSV_EXPORT.scad
//
// REV5
//
// Manufacturing export engine.
//

include <../DATABASES/GW_CIRCUITS.scad>;
include <../DATABASES/GW_PIN_DATABASE.scad>;
include <../DATABASES/GW_CONNECTORS.scad>;
include <../DATABASES/GW_COMPONENTS.scad>;
include <../DATABASES/GW_SPLICE_DATABASE.scad>;

include <GW_ENGINE_WIRE_LENGTH.scad>;

//
// BOM EXPORT
//

module export_bom_csv()
{
    echo(
        "BOM,BEGIN"
    );

    for(c=CIRCUITS)
    {
        echo(
            str(
                "WIRE,",
                c[3], ",",
                c[4]
            )
        );
    }

    echo(
        "BOM,END"
    );
}

//
// CUTSHEET EXPORT
//

module export_cutsheet_csv()
{
    echo(
        "CUTSHEET,BEGIN"
    );

    for(c=CIRCUITS)
    {
        echo(
            str(
                c[0], ",",
                c[3], ",",
                c[4], ",",
                wire_length(c[0])
            )
        );
    }

    echo(
        "CUTSHEET,END"
    );
}

//
// LABEL EXPORT
//

module export_labels_csv()
{
    echo(
        "LABELS,BEGIN"
    );

    for(c=CIRCUITS)
    {
        echo(
            str(
                c[0], ",",
                source_connector(c[0])
            )
        );
    }

    echo(
        "LABELS,END"
    );
}

//
// CONNECTOR EXPORT
//

module export_connectors_csv()
{
    echo(
        "CONNECTORS,BEGIN"
    );

    for(c=CONNECTORS)
    {
        echo(
            str(
                c[0], ",",
                c[1], ",",
                c[2]
            )
        );
    }

    echo(
        "CONNECTORS,END"
    );
}

//
// SPLICE EXPORT
//

module export_splices_csv()
{
    echo(
        "SPLICES,BEGIN"
    );

    for(s=SPLICES)
    {
        echo(
            str(
                s[0], ",",
                s[1]
            )
        );
    }

    echo(
        "SPLICES,END"
    );
}

//
// MASTER EXPORT
//

module export_all_csv()
{
    export_bom_csv();

    export_cutsheet_csv();

    export_labels_csv();

    export_connectors_csv();

    export_splices_csv();
}