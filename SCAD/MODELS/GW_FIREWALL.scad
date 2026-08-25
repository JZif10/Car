//
// GW_FIREWALL.scad
//
// 1989 Jeep Grand Wagoneer (SJ)
// REV5
//
// Master firewall geometry and
// electrical integration points.
//
 
//
// FIREWALL PARAMETERS
//
 
FIREWALL_WIDTH = 60.0;
FIREWALL_HEIGHT = 40.0;
FIREWALL_THICKNESS = 0.125;
 
FIREWALL_Z_CENTER = 24.0;
 
//
// CN001 BULKHEAD CONNECTOR
//
 
CN001_WIDTH = 5.50;
CN001_HEIGHT = 3.75;
 
CN001_Y = 12.0;
CN001_Z = 36.0;
 
//
// MAIN HARNESS GROMMET
//
 
MAIN_GROMMET_Y = 16.0;
MAIN_GROMMET_Z = 30.0;
MAIN_GROMMET_DIA = 2.00;
 
//
// HVAC PENETRATIONS
//
 
AC_PASS_Y = -10.0;
AC_PASS_Z = 28.0;
AC_PASS_DIA = 3.00;
 
HEATER_PASS_Y = -14.0;
HEATER_PASS_Z = 24.0;
HEATER_PASS_DIA = 2.50;
 
//
// RTMR MOUNT
//
 
RTMR_Y = 20.0;
RTMR_Z = 30.0;
 
//
// ECU MOUNT
//
 
ECU_Y = 8.0;
ECU_Z = 34.0;
 
//
// G100 GROUND LOCATION
//
 
G100_Y = 22.0;
G100_Z = 10.0;
 
//
// FIREWALL PANEL
//
 
module firewall_panel()
{
difference()
{
cube(
[
FIREWALL_THICKNESS,
FIREWALL_WIDTH,
FIREWALL_HEIGHT
],
center=true);
 
//
// CN001 BULKHEAD OPENING
//
 
translate(
[
0,
CN001_Y,
CN001_Z - FIREWALL_Z_CENTER
])
 
cube(
[
1.0,
CN001_WIDTH,
CN001_HEIGHT
],
center=true);
 
//
// MAIN HARNESS GROMMET
//
 
translate(
[
0,
MAIN_GROMMET_Y,
MAIN_GROMMET_Z - FIREWALL_Z_CENTER
])
 
rotate([0,90,0])
 
cylinder(
d=MAIN_GROMMET_DIA,
h=1.0,
center=true,
$fn=48
);
 
//
// HVAC OPENING
//
 
translate(
[
0,
AC_PASS_Y,
AC_PASS_Z - FIREWALL_Z_CENTER
])
 
rotate([0,90,0])
 
cylinder(
d=AC_PASS_DIA,
h=1.0,
center=true,
$fn=64
);
 
//
// HEATER CORE OPENING
//
 
translate(
[
0,
HEATER_PASS_Y,
HEATER_PASS_Z - FIREWALL_Z_CENTER
])
 
rotate([0,90,0])
 
cylinder(
d=HEATER_PASS_DIA,
h=1.0,
center=true,
$fn=48
);
}
}
 
//
// CN001 REFERENCE BLOCK
//
 
module cn001_reference()
{
translate(
[
0,
CN001_Y,
CN001_Z - FIREWALL_Z_CENTER
])
 
color("orange")
 
cube(
[
4.50,
2.00,
3.00
],
center=true);
}
 
//
// G100 GROUND STUD
//
 
module g100_ground()
{
translate(
[
1.0,
G100_Y,
G100_Z - FIREWALL_Z_CENTER
])
 
color("green")
 
rotate([0,90,0])
 
cylinder(
d=0.50,
h=1.50,
center=true,
$fn=32
);
}
 
//
// SNIPER ECU MOUNTING PLATE
//
 
module sniper_ecu_plate()
{
translate(
[
2.0,
ECU_Y,
ECU_Z - FIREWALL_Z_CENTER
])
 
color("lightgray")
 
cube(
[
0.125,
10.0,
8.0
],
center=true);
}
 
//
// RTMR MOUNTING ZONE
//
 
module rtmr_mount_zone()
{
translate(
[
3.0,
RTMR_Y,
RTMR_Z - FIREWALL_Z_CENTER
])
 
color([0,0,1,0.35])
 
cube(
[
8.0,
8.0,
4.0
],
center=true);
}
 
//
// FIREWALL REFERENCE AXES
//
 
module firewall_reference_axes()
{
color("red")
cube([0.25,60,0.10],center=true);
 
color("blue")
cube([0.25,0.10,40],center=true);
}
 
//
// MASTER FIREWALL ASSEMBLY
//
 
module firewall()
{
color("gray")
firewall_panel();
 
cn001_reference();
 
g100_ground();
 
sniper_ecu_plate();
 
rtmr_mount_zone();
}
