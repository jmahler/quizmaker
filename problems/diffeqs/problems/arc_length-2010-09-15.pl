
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('ODE', 'separable ODE', 'class:MATH-31', 'difficulty:moderate', 'proof',
    'pythagorean theorem', 'arc length');

$par_time = '00:05:00';

$short_desc = "Derive formula for the arc length using the Pythagorean Theorem.";

$question = <<'HERE';
Use the pythagorean theorem ($a^2 + b^2 = c^2$) to derive the
formula for calculating the arc length.
HERE

$worklines = 8;

$answer = <<'HERE';
The goal is sum up all the lengths of the hypotenuses as either
x (or y) gets infinitely small. In this answer it will be over $x$.
\begin{align*}
    a^2 + b^2 &= c^2 \\
    dS^2 &= dx^2 + dy^2 \\
    \sqrt{\frac{dL^2}{dx^2}} &= \sqrt{1 + \frac{dy^2}{dx^2}} \\
    \frac{dL}{dx} &= \sqrt{1 + \frac{dy^2}{dx^2}} \\
    dL &= \sqrt{1 + \frac{dy^2}{dx^2}} \;\; dx \\
    \int dL &= \int_{a}^{b} \sqrt{1 + \Big( \frac{dy}{dx} \Big)^2} \;\; dx \\
    L &= \int_{a}^{b} \sqrt{1 + \Big( \frac{dy}{dx}\Big)^2} \;\; dx
\end{align*}
HERE

$uuid = "[jmm] Wed, 15 Sep 2010 21:17:42 -0700";

$ref = 'This example is commonly given in a Calculus 2 (MATH-31) class.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
