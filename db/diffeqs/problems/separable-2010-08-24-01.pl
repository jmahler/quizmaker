
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('ODE', 'separable ODE', 'class:MATH-40', 'difficulty:easy');

$par_time = '00:02:00';

$short_desc = "Solve the ODE: y' = 2*x";

$question = <<'HERE';
Solve the ODE:
\begin{align*}
    y' = 2 x
\end{align*}
HERE

$worklines = 6;

$answer = <<'HERE';
Separate and integrate.

\begin{align*}
    \frac{dy}{dx} &= 2 x \\
    dy &= 2 x \; dx \\
    \int dy &= \int 2 x \; dx \\
    y &= x^2
\end{align*}

The answer can be verified by deriving it and verifying that
it is the same as the original equation.

\begin{align*}
    y &= x^2 \\
    y' &= 2 x
\end{align*}
HERE

$uuid = "[jmm] Tue, 08 Aug 2010 00:00:00 -0700";

$ref = 'An example given in class (MATH-40) taught by Mr Bigler at '.
'Butte Community College on 2010-Aug-24.';;

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
