//
// GW_ENGINE_VALIDATION_OVERLAY.scad
//
// REV5
//
// Engineering validation visualization
//

SHOW_VALIDATION_OVERLAY = true;

//
// PASS MARKER
//

module validation_pass(pos)
{
    translate(pos)

    color("lime")

    sphere(
        d = 0.75,
        $fn = 24
    );
}

//
// WARNING MARKER
//

module validation_warning(pos)
{
    translate(pos)

    color("yellow")

    sphere(
        d = 1.0,
        $fn = 24
    );
}

//
// FAIL MARKER
//

module validation_fail(pos)
{
    translate(pos)

    color("red")

    sphere(
        d = 1.25,
        $fn = 24
    );
}

//
// CLEARANCE VOLUME
//

module clearance_volume(
    pos,
    dims
)
{
    color(
        [1,0,0,0.15]
    )

    translate(pos)

    cube(
        dims,
        center=true
    );
}

//
// FAILURE LABEL
//

module failure_label(
    txt,
    pos
)
{
    translate(
    [
        pos[0],
        pos[1],
        pos[2] + 3
    ])

    color("red")

    linear_extrude(0.15)

    text(
        txt,
        size = 1.0
    );
}

//
// INTERFERENCE MARKER
//

module interference_pair(
    p1,
    p2
)
{
    color("red")

    hull()
    {
        translate(p1)
        sphere(d=0.25);

        translate(p2)
        sphere(d=0.25);
    }
}

//
// DASHBOARD
//

module validation_dashboard(
    passes = 0,
    warnings = 0,
    failures = 0
)
{
    translate(
    [
        210,
        0,
        80
    ])

    color("white")

    linear_extrude(0.20)

    text(
        str(
            "PASS: ",passes,"\n",
            "WARN: ",warnings,"\n",
            "FAIL: ",failures
        ),
        size = 3
    );
}

//
// MASTER VALIDATION LAYER
//

module render_validation_overlay()
{
    if(SHOW_VALIDATION_OVERLAY)
    {
        //
        // Future engines feed data here
        //

        validation_dashboard(
            0,
            0,
            0
        );
    }
}