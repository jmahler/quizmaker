
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('math', 'class:MATH-40', 'ODE', 'exact ODE');

$par_time = '00:04:00';

$short_desc = "Solve the ODE: (xy - 1)dx + (x^2 - xy) dy = 0";

$question = <<'HERE';
Solve the ODE:
\begin{align*}
    (x \cdot y - 1) \; dx + (x^2 - x \cdot y) \; dy = 0
\end{align*}
HERE

$worklines = 15;

$answer = <<'HERE';
It is not separable and it is not exact (see below) but it is close.
\begin{align*}
    \frac{\partial{M}}{\partial{y}} &= x \ne \frac{\partial{N}}{\partial{x}}
        = 2x - y
\end{align*}

Try to find a function in terms of $x$ only.
\begin{align*}
    \frac{ \frac{\partial{M}}{\partial{y}} - \frac{\partial{N}}{\partial{x}} }
        {N}
        &= \frac{x - 2x + y}{x^2 - xy} \\
        &= -\frac{1}{x}
\end{align*}
A function in terms of $x$ only was found so this can be used to build an
integrating factor.

\begin{align*}
    \mu &= e^{\int -1/x \; dx} \\
        &= x^{-1}
\end{align*}

Multiply the integrating factor by the original equation and then
check to make sure it is now exact.
\begin{align*}
    \frac{(xy - 1)}{x} \; dx + \frac{ (x^2 - xy)}{x} \; dy &= 0 \\
    y - \frac{1}{x} \; dx + (x - y) \; dy &= 0 \\
    \frac{\partial{M}}{\partial{y}} = 1 &= \frac{\partial{N}}{\partial{x}}
\end{align*}
The modified equation is exact so now it can be solved normally.

Integrate each term seperately and then combine unique terms.
\begin{align*}
    \int \Big( y - \frac{1}{x} \Big) \; dx &= x y - \ln|x| \\
    \int \Big( x - y \Big) \; dy &= x y - \frac{y^2}{2} \\
    -\frac{y^2}{2} + x y - \ln|x| &= C
\end{align*}
HERE

$uuid = "[jmm] Tue, 21 Sep 2010 22:26:02 -0700";

$ref = 'An example given on 9/13/10 in the class MATH-40 taught
by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
