
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('IVP', 'ODE', 'separable IVP', 'class:MATH-40', 'difficulty:hard',
        'trig', 'table method of integration');

$par_time = '00:10:00';

$short_desc = "Solve the IVP: x*sin(x)*e^(-y) dx - y dy = 0";

$question = <<'HERE';
Solve the IVP:
\begin{align*}
    x \cdot \sin(x) \cdot e^{-y} \; dx - y \; dy &= 0 \;\; ; \; y(0) = 1
\end{align*}
HERE

$worklines = 10;

$answer = <<'HERE';
Separate.
\begin{align*}
    \int x \cdot \sin(x) \cdot e^{-y} \; dx &= \int y \; dy
\end{align*}

Use the table method of integration to integrate each side.
\begin{align*}
    -x \cdot \cos(x) + \sin(x) &= y e^y - e^y + C
\end{align*}

Substitute the initial conditon to find $C$.
\begin{align*}
    0 + 0 &= 1 \cdot e^1 - e^1 + C \\
    C &= 0
\end{align*}

\begin{align*}
    -x \cdot \cos(x) + \sin(x) &= y e^y - e^y
\end{align*}
HERE

$uuid = "[jmm] Wed, 22 Sep 2010 23:28:25 -0700";

$ref = 'Homework problem 10 from the sheet handed out on 8/25/10 in the class (MATH-40) taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
