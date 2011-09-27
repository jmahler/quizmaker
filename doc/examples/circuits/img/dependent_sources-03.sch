v 20110115 2
C 46100 46300 1 0 1 vdc-1.sym
{
T 45400 46950 5 10 1 1 0 6 1
refdes=V1
T 45400 47150 5 10 0 0 0 6 1
device=VOLTAGE_SOURCE
T 45400 47350 5 10 0 0 0 6 1
footprint=none
T 45400 46750 5 10 1 1 0 6 1
value=DC 20V
}
C 46200 48100 1 0 0 resistor-1.sym
{
T 46500 48500 5 10 0 0 0 0 1
device=RESISTOR
T 46400 48400 5 10 1 1 0 0 1
refdes=R1
T 46500 47900 5 10 1 1 0 0 1
value=1k
}
C 49900 48100 1 0 0 resistor-1.sym
{
T 50200 48500 5 10 0 0 0 0 1
device=RESISTOR
T 50100 48400 5 10 1 1 0 0 1
refdes=R5
T 50200 47900 5 10 1 1 0 0 1
value=5k
}
C 47600 47100 1 270 0 resistor-1.sym
{
T 48000 46800 5 10 0 0 270 0 1
device=RESISTOR
T 47200 46600 5 10 1 1 0 0 1
refdes=R2
T 47900 46600 5 10 1 1 0 0 1
value=2k
}
C 49400 47400 1 90 1 resistor-1.sym
{
T 49000 47100 5 10 0 0 270 2 1
device=RESISTOR
T 49100 46900 5 10 1 1 0 6 1
refdes=R4
T 49500 46900 5 10 1 1 0 0 1
value=4k
}
C 51300 47400 1 90 1 resistor-1.sym
{
T 50900 47100 5 10 0 0 270 2 1
device=RESISTOR
T 51000 46900 5 10 1 1 0 6 1
refdes=R6
T 51400 46900 5 10 1 1 0 0 1
value=6k
}
C 48100 48100 1 0 0 resistor-1.sym
{
T 48400 48500 5 10 0 0 0 0 1
device=RESISTOR
T 48300 48400 5 10 1 1 0 0 1
refdes=R3
T 48400 47900 5 10 1 1 0 0 1
value=3k
}
N 49000 48200 49900 48200 4
N 49300 47400 49300 48200 4
N 47100 48200 48100 48200 4
N 45800 47500 45800 48200 4
N 45800 48200 46200 48200 4
N 45800 46300 45800 45800 4
N 45800 45800 52000 45800 4
N 51200 45800 51200 46500 4
N 49300 46500 49300 45800 4
N 50800 48200 52000 48200 4
N 51200 48200 51200 47400 4
N 47700 46200 47700 45800 4
T 45800 48300 5 10 1 0 0 0 1
1
T 47500 48300 5 10 1 0 0 0 1
2
T 49400 48300 5 10 1 0 0 0 1
3
T 51400 48300 5 10 1 0 0 0 1
4
C 50200 45500 1 0 0 gnd-1.sym
T 52200 48200 9 10 1 0 0 0 1
a
T 52200 45800 9 10 1 0 0 0 1
b
T 52500 50200 0 10 1 0 0 0 1
.
N 47700 47100 47700 48200 4
C 50800 49000 1 90 0 xccs-j01.sym
N 49300 48200 49300 49300 4
N 49300 49300 49800 49300 4
N 51200 48200 51200 49300 4
N 51200 49300 50800 49300 4
T 50100 49700 5 10 1 0 0 0 1
3.0 i_1
C 48000 47800 1 180 0 arrow-j01.sym
{
T 48000 47600 5 10 1 1 0 0 1
netname=i_1
}
