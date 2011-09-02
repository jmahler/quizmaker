
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('ODE', 'separable ODE', 'class:MATH-40', 'difficulty:medium', 'trig');

$par_time = '00:03:00';

$short_desc = "Solve the ODE: sin(x)*sin(y) dx + cos(x)*cos(y) dy = 0";

$question = <<'HERE';
Solve the ODE:
\begin{align*}
    \sin(x) \sin(y) \; dx + \cos(x) \cdot \cos(y) \; dy &= 0
\end{align*}
HERE

$worklines = 6;

$answer = <<'HERE';
Separate and integrate.
\begin{align*}
    \int \frac{-\sin(x)}{\cos(x)} \; dx &= \int \frac{ \cos(y) }{ \sin(y) } \; dy \\
    \ln|\cos(x)| &= \ln|\sin(y)| + C \\
    \cos(x) &= \sin(y) \cdot C \\
    \sin(y) &= C \cdot \cos(x)
\end{align*}

Other slight variations involving $C$ in the answer are also acceptable.
HERE

$uuid = "[jmm] Wed, 22 Sep 2010 16:13:49 -0700";

$ref = 'Homework problem 3 from the sheet handed out on 8/25/10 in the class (MATH-40) taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
