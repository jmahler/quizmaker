
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('ODE', 'separable ODE', 'class:MATH-40', 'difficulty:easy');

$par_time = '00:02:00';

$short_desc = "Solve the ODE: y' = 1 + y^2";

$question = <<'HERE';
Solve the ODE:
\begin{align*}
    y' = 1 + y^2
\end{align*}
HERE

$worklines = 8;

$answer = <<'HERE';
Seperate and integrate.

\begin{align*}
    \frac{dy}{dx} &= 1 + y^2 \\
    dy &= (1 + y^2) \; dx \\
    \frac{dy}{1 + y^2} &= dx \\
    \int \frac{dy}{1 + y^2} &= \int dx \\
    \arctan(y) &= x + C \\
    y &= \tan(x + C) & \mbox{(explicit, one parameter, family of solutions)} \\
    x &= 0, C = 0 \rightarrow y = 0 \\
    y &= \tan(x) & \mbox{(particular solution)}
\end{align*}
HERE

$uuid = "[jmm] Tue, 08 Aug 2010 00:00:01 -0700";

$ref = 'An example given in class (MATH-40) taught by Mr Bigler at '.
'Butte Community College on 2010-Aug-24.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
