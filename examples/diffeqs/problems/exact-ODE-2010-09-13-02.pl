
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('math', 'class:MATH-40', 'ODE', 'exact ODE');

$par_time = '00:04:00';

$short_desc = "Solve the ODE: y dx + (x^2 y - x) dy = 0";

$question = <<'HERE';
Solve the ODE:
\begin{align*}
    y \; dx + (x^2 y - x ) \; dy = 0
\end{align*}
HERE

$worklines = 15;

$answer = <<'HERE';
It is not separable and it is not exact (see below) but it is close.
\begin{align*}
    \frac{\partial{M}}{\partial{y}} &= 1 \ne \frac{\partial{N}}{\partial{x}}
        = 2 x y - 1
\end{align*}

Try to find a function in terms of $x$ only.
\begin{align*}
    \frac{ \frac{\partial{M}}{\partial{y}} - \frac{\partial{N}}{\partial{x}} }
        {N}
        &= \frac{2 - 2 x y}{x^2 y - x} \\
        &= -\frac{2}{x}
\end{align*}
A function in terms of $x$ only was found so this can be used to build an
integrating factor.

\begin{align*}
    \mu &= e^{\int -2/x \; dx} \\
        &= x^{-2}
\end{align*}

Multiply the integrating factor by the original equation and then
check to make sure it is now exact.
\begin{align*}
    \frac{y}{x^2} \; dx + \frac{ (x^2 y - x)}{x^2} \; dy &= 0 \\
    \frac{\partial{M}}{\partial{y}} = \frac{1}{x^2} &= \frac{\partial{N}}{\partial{x}}
\end{align*}
The modified equation is exact so now it can be solved normally.

Integrate each term seperately and then combine unique terms.
\begin{align*}
    \int \frac{y}{x^2} \; dx &= -\frac{y}{x} \\
    \int \Big( y - \frac{1}{x} \Big) \; dy &= \frac{y^2}{2} - \frac{y}{x} \\
    \frac{y^2}{2} - \frac{y}{x} &= C
\end{align*}
HERE

$uuid = "[jmm] Tue, 21 Sep 2010 22:57:59 -0700";

$ref = 'An example given on 9/13/10 in the class MATH-40 taught
by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
