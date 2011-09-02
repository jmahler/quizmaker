
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('ODE', 'separable IVP', 'class:MATH-40', 'difficulty:easy');

$par_time = '00:02:00';

$short_desc = "Solve the IVP: y' = -x/y; y(0) = 1";

$question = <<'HERE';
Solve the ODE:
\begin{align*}
    \frac{dy}{dx} &= \frac{-x}{y} ; \;\;\; y(0) = 1
\end{align*}
HERE

$worklines = 10;

$answer = <<'HERE';

First solve the ODE (separate and integrate).

\begin{align*}
    \int y \; dy &= - \int x \; dx \\
    \frac{y^2}{2} &= -\frac{x^2}{2} + C \\
    y^2 &= -x^2 + C \\
    y &= \pm \sqrt{C - x^2}
\end{align*}

Substitute the values of the initial condition ($y(0) = 1$) to find
the value of $C$.

\begin{align*}
    y(0) &= 1 \\
    1 &= \pm \sqrt{C - 0^2} \\
    1 &= \pm \sqrt{C} & \mbox{(cannot be negative)} \\
    y &= \sqrt{1 - x^2}
\end{align*}
HERE

$uuid = "[jmm] Tue, 08 Aug 2010 00:00:02 -0700";

$ref = 'An example given in class (MATH-40) taught by Mr Bigler at '.
'Butte Community College on 2010-Aug-24.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
