//
// GW_ENGINE_INTERFERENCE_DETECTION.scad
//
// REV5 REV3
//
// Installation validation engine.
//
// Provides:
//
// Component-to-Component checks
// Seat interference checks
// Cargo fitment checks
// Service clearance visualization
//

include <../DATABASES/GW_COMPONENTS.scad>;
include <../DATABASES/GW_ANCHORS.scad>;
include <../DATABASES/GW_CLEARANCE_DATABASE.scad>;

//
// BODY REFERENCE VOLUMES
//

PASSENGER_SEAT_POS = [50,15,12];
PASSENGER_SEAT_DIM = [22,22,24];

DRIVER_SEAT_POS = [50,-15,12];
DRIVER_SEAT_DIM = [22,22,24];

CARGO_LEFT_POS = [145,-25,18];
CARGO_LEFT_DIM = [20,8,18];

CARGO_RIGHT_POS = [145,25,18];
CARGO_RIGHT_DIM = [20,8,18];

//
// COMPONENT DIMENSIONS
//
// Temporary hardcoded table.
//
// Future revision should move
// dimensions into GW_COMPONENTS.scad.
//

function component_dims(id)=

id=="BAT001"      ? [13,7,8] :
id=="LITH001"     ? [15,9,10] :
id=="INV001"      ? [20,10,5] :
id=="RTMR001"     ? [10,8,4] :
id=="HALO11"      ? [8,6,2] :
id=="CAN001"      ? [4,3,1] :
id=="OBD001"      ? [2,1,1] :
id=="ECU001"      ? [8,6,2] :
id=="AMP001"      ? [14,10,2] :
id=="SW_MAIN"     ? [6,4,1.5] :
id=="SW_REAR"     ? [6,4,1.5] :
id=="BMS001"      ? [5,4,1.5] :
id=="CAM_REAR_01" ? [1.25,1.25,1] :
[2,2,2];

//
// POSITION LOOKUP
//

function component_position(id)=

anchor_position(
    component_anchor(id)
);

//
// BOUNDING BOX HELPERS
//

function bbox_min(pos,dims)=
[
    pos[0]-dims[0]/2,
    pos[1]-dims[1]/2,
    pos[2]-dims[2]/2
];

function bbox_max(pos,dims)=
[
    pos[0]+dims[0]/2,
    pos[1]+dims[1]/2,
    pos[2]+dims[2]/2
];

//
// BOX OVERLAP
//

function bbox_overlap(
    amin,
    amax,
    bmin,
    bmax
)=

!(
    amax[0] < bmin[0] ||
    amin[0] > bmax[0] ||

    amax[1] < bmin[1] ||
    amin[1] > bmax[1] ||

    amax[2] < bmin[2] ||
    amin[2] > bmax[2]
);

//
// DISTANCE
//

function point_distance(a,b)=

sqrt(
    pow(b[0]-a[0],2)+
    pow(b[1]-a[1],2)+
    pow(b[2]-a[2],2)
);

//
// GENERIC VOLUME COLLISION
//

function volume_collision(
    pos_a,
    dim_a,
    pos_b,
    dim_b
)=

bbox_overlap(
    bbox_min(pos_a,dim_a),
    bbox_max(pos_a,dim_a),
    bbox_min(pos_b,dim_b),
    bbox_max(pos_b,dim_b)
);

//
// CLEARANCE LOOKUP
//

function required_clearance(id)=
service_clearance(id);

//
// VISUAL MARKERS
//

module clearance_pass(pos)
{
    color("lime")

    translate(pos)

    sphere(
        d=0.60,
        $fn=20
    );
}

module clearance_fail(pos)
{
    color("red")

    translate(pos)

    sphere(
        d=1.00,
        $fn=20
    );
}

//
// CLEARANCE VOLUMES
//

module clearance_zone(
    pos,
    dims,
    clr=[1,0,0,0.08]
)
{
    color(clr)

    translate(pos)

    cube(
        dims,
        center=true
    );
}

//
// COMPONENT INTERFERENCE
//

module analyze_component_interference()
{
    for(i=[0:len(COMPONENTS)-1])
    {
        for(j=[i+1:len(COMPONENTS)-1])
        {
            compA = COMPONENTS[i][0];
            compB = COMPONENTS[j][0];

            posA =
                component_position(compA);

            posB =
                component_position(compB);

            dimsA =
                component_dims(compA);

            dimsB =
                component_dims(compB);

            amin =
                bbox_min(posA,dimsA);

            amax =
                bbox_max(posA,dimsA);

            bmin =
                bbox_min(posB,dimsB);

            bmax =
                bbox_max(posB,dimsB);

            if(
                bbox_overlap(
                    amin,
                    amax,
                    bmin,
                    bmax
                )
            )
            {
                echo(
                    str(
                        "INTERFERENCE: ",
                        compA,
                        " <-> ",
                        compB
                    )
                );

                clearance_fail(posA);
                clearance_fail(posB);
            }
        }
    }
}

//
// SEAT INTERFERENCE
//

module analyze_seat_interference()
{
    for(c=COMPONENTS)
    {
        id = c[0];

        pos =
            component_position(id);

        dims =
            component_dims(id);

        if(
            volume_collision(
                pos,
                dims,
                PASSENGER_SEAT_POS,
                PASSENGER_SEAT_DIM
            )
        )
        {
            echo(
                str(
                    "PASSENGER SEAT INTERFERENCE: ",
                    id
                )
            );

            clearance_fail(pos);
        }

        if(
            volume_collision(
                pos,
                dims,
                DRIVER_SEAT_POS,
                DRIVER_SEAT_DIM
            )
        )
        {
            echo(
                str(
                    "DRIVER SEAT INTERFERENCE: ",
                    id
                )
            );

            clearance_fail(pos);
        }
    }
}

//
// CARGO FITMENT
//

module analyze_cargo_fitment()
{
    cargo_components =
    [
        "LITH001",
        "INV001",
        "BMS001"
    ];

    for(id=cargo_components)
    {
        pos =
            component_position(id);

        dims =
            component_dims(id);

        left_ok =
            volume_collision(
                pos,
                dims,
                CARGO_LEFT_POS,
                CARGO_LEFT_DIM
            );

        right_ok =
            volume_collision(
                pos,
                dims,
                CARGO_RIGHT_POS,
                CARGO_RIGHT_DIM
            );

        if(
            !(left_ok || right_ok)
        )
        {
            echo(
                str(
                    "CARGO FITMENT FAIL: ",
                    id
                )
            );

            clearance_fail(pos);
        }
    }
}

//
// SERVICE CLEARANCE VOLUMES
//

module render_service_clearance()
{
    for(c=COMPONENTS)
    {
        id = c[0];

        pos =
            component_position(id);

        dims =
            component_dims(id);

        svc =
            required_clearance(id);

        expanded =
        [
            dims[0] + svc,
            dims[1] + svc,
            dims[2] + svc
        ];

        clearance_zone(
            pos,
            expanded
        );
    }
}

//
// MASTER ANALYSIS
//

module analyze_installation()
{
    analyze_component_interference();

    analyze_seat_interference();

    analyze_cargo_fitment();
}

//
// REPORTING
//

module report_interference()
{
    echo(
        "===== INTERFERENCE REPORT ====="
    );

    for(i=[0:len(COMPONENTS)-1])
    {
        for(j=[i+1:len(COMPONENTS)-1])
        {
            compA = COMPONENTS[i][0];
            compB = COMPONENTS[j][0];

            echo(
                str(
                    compA,
                    " -> ",
                    compB,
                    " distance=",
                    point_distance(
                        component_position(compA),
                        component_position(compB)
                    )
                )
            );
        }
    }
}