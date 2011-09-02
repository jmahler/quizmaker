
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('math', 'class:MATH-40', 'exponential growth');

$par_time = '00:05:00';

$short_desc = "A mold grows at a rate ...";

$question = <<'HERE';
A mold grows at a rate that is proportional to the amount present.
In 24 hours the amount of it has grown from 2 grams to 3 grams.
How many grams of it are present at the end of 24 more hours?
HERE

$worklines = 10;

$answer = <<'HERE';
The rate of change is proportional to the amount present.
\begin{align*}
    & \frac{dA}{dt} \propto k \cdot A
\end{align*}

Use the initial conditions to find $k$.
\begin{align*}
    A &= A_0 \cdot e^{k \cdot t} \\
    3 &= 2 \cdot e^{k \cdot 24} \\
    \ln(\frac{3}{2}) &= k \cdot 24 \\
    k &= \frac{ \ln(\frac{3}{2}) }{24}
\end{align*}

Substitute for time ($t$) and solve for the amount ($A$).
\begin{align*}
    A &= A_0 e^{ \frac{ \ln(\frac{3}{2}) }{24} \cdot t } \\
      &= A_0 e^{ \frac{ \ln(\frac{3}{2}) }{24} \cdot 48 } \\
      &= 2 \cdot e^{2 \ln(\frac{3}{2}) } \\
      &= 4.5 \;\; \mbox{grams}
\end{align*}
HERE

$uuid = "[jmm] Tue, 21 Sep 2010 20:42:10 -0700";

$ref = 'Homework problem #6 from sheet handed out on 9/17/10 in the
class MATH-40 taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
