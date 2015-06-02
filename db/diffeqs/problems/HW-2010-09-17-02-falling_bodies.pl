
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('math', 'class:MATH-40', 'falling bodies');

$par_time = '00:04:00';

$short_desc = "4 lbs thrown down 2000 ft ...";

$question = <<'HERE';
An object weighting 4 lb is thrown vertically downward toward the earth
from a height of 2000 ft with an initial velocity of 2 ft/sec.  As it falls
it is acted upon by air resistance that is numerically equal to $v/2$ (in pounds),
where $v$ is the velocity (in feet per second).\\
\\
(a)  What is the velocity and distance fallen at the end of 1 second? \\
(b)  With what velocity does the object strike the earth?
HERE

$worklines = 20;

# TODO - a more detailed answer
$answer = <<'HERE';

Use the equation for the falling bodies and find $k$.
Then substitute to find the answer.
\begin{align*}
    \frac{dv}{dt} &= g - \frac{g}{m} \cdot k \cdot v \\
    \frac{dv}{dt} &= 32 - \frac{32}{4} \cdot \frac{1}{2} \cdot v \\
    \frac{dv}{dt} &= 32 - 4 \cdot v \\
    \frac{dv}{32 - 4 \cdot v} &= dt \\
    \frac{dv}{8 - v} &= 4 \cdot dt \\
    \frac{dv}{v - 8} &= -4 \cdot dt \\
    \int \frac{dv}{v - 8} &= \int -4 \cdot dt \\
    \ln |v - 8| &= -4 \cdot t + C \\
    v - 8 &= e^{-4 \cdot t} e^{C} \\
    v &= e^{-4 \cdot t} e^{C} + 8 \\
    2 &= e^{C} + 8 & (v(0) = 2) \\
    K &= -6 \\
    v &= 8 - g \cdot e^{-4 \cdot t}
\end{align*}

Velocity at 1 second: 7.89 ft/s

Because the terminal velocity is 8.00 ft/s and it reaches this
speed well before 2000 ft the velocity at impact will
also be the terminal velocity (8.00 ft/s).
HERE

$uuid = "[jmm] Tue, 21 Sep 2010 20:20:12 -0700";

$ref = 'Homework problem #3 from sheet handed out on 9/17/10 in the
class MATH-40 taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
