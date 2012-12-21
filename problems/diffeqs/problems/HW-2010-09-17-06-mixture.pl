
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('math', 'class:MATH-40', 'mixture', 'linear ODE');

$par_time = '00:15:00';

$short_desc = "A tank initially contains 300 gal of brine ...";

$question = <<'HERE';
A tank initially contains 300 gal of brine in which 20 lb of salt is dissolved.
Starting at t = 0, brine containing 3 lb of salt per gallon flows in to the tank
at the rate of 3 gal/min.  The mixture is kept uniform by stirring, and the
well-stirred mixture leaves the tank at the rate of 5 gal/min.  How much salt
is in the tank at the end of 15 minutes?
HERE

$worklines = 20;

# TODO - more detailed answer
$answer = <<'HERE';
Substitute and solve the differential equation. 
\begin{align*}
    \frac{dQ}{dt} &= r_{in} \cdot c_{in} - r_{out} \cdot \frac{Q}{v_o - (r_{out} - r_{in}) t} \\
    Q(t) &= Q_0
\end{align*}

(steps not shown)

\begin{align*}
    Q = 134 \;\; \mbox{lbs}
\end{align*}

HERE

$uuid = "[jmm] Tue, 21 Sep 2010 21:18:41 -0700";

$ref = 'Homework problem #10 from sheet handed out on 9/17/10 in the
class MATH-40 taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
