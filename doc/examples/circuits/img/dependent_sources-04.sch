v 20110115 2
C 49500 46000 1 0 1 vdc-1.sym
{
T 48800 46650 5 10 1 1 0 6 1
refdes=V1
T 48800 46850 5 10 0 0 0 6 1
device=VOLTAGE_SOURCE
T 48800 47050 5 10 0 0 0 6 1
footprint=none
T 48800 46450 5 10 1 1 0 6 1
value=DC 20V
}
C 50300 48200 1 0 0 resistor-1.sym
{
T 50600 48600 5 10 0 0 0 0 1
device=RESISTOR
T 50500 48500 5 10 1 1 0 0 1
refdes=R2
T 50900 48500 5 10 1 1 0 0 1
value=2k
}
C 49400 49700 1 0 0 arrow-j01.sym
C 52600 50300 1 180 0 xccs-j01.sym
C 49100 49400 1 270 1 resistor-1.sym
{
T 49500 49700 5 10 0 0 90 2 1
device=RESISTOR
T 48700 50100 5 10 1 1 180 6 1
refdes=R1
T 49000 49700 5 10 1 1 0 6 1
value=1k
}
C 52400 46100 1 90 0 resistor-1.sym
{
T 52000 46400 5 10 0 0 90 0 1
device=RESISTOR
T 52100 46800 5 10 1 1 180 0 1
refdes=R3
T 51900 46400 5 10 1 1 0 0 1
value=3k
}
C 54200 47700 1 90 0 resistor-1.sym
{
T 53800 48000 5 10 0 0 90 0 1
device=RESISTOR
T 54600 48400 5 10 1 1 180 0 1
refdes=R4
T 54300 48000 5 10 1 1 0 0 1
value=4k
}
C 50500 48100 1 270 0 arrow-j01.sym
C 51700 46800 1 180 0 arrow-j01.sym
C 53900 48400 1 180 0 arrow-j01.sym
C 49700 46400 1 0 0 arrow-j01.sym
N 52300 49300 52300 47000 4
N 51200 48300 52300 48300 4
N 49200 47200 49200 49400 4
N 50300 48300 49200 48300 4
N 49200 46000 49200 45600 4
N 49200 45600 54100 45600 4
N 52300 45600 52300 46100 4
N 54100 45600 54100 47700 4
N 49200 50300 49200 50800 4
N 49200 50800 54100 50800 4
N 54100 50800 54100 48600 4
N 52300 50300 52300 50800 4
T 52700 49800 5 10 1 0 0 0 1
1.5 v_x
T 52600 46500 5 10 1 0 0 0 1
v_x
T 52500 47000 9 10 1 0 0 0 1
+
T 52600 46000 9 10 1 0 0 0 1
-
T 51200 46500 5 10 1 0 0 0 1
i_e
T 50600 47700 5 10 1 0 0 0 1
i_d
T 50000 46500 5 10 1 0 0 0 1
i_a
T 49700 49800 5 10 1 0 0 0 1
i_b
T 53400 48100 5 10 1 0 0 0 1
i_c
