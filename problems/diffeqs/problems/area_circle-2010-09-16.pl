
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('math', 'class:MATH-31', 'difficulty:easy', 'proof', 'polar');

$par_time = '00:05:00';

$short_desc = "Devise the formula for the area of a circle.";

$question = <<'HERE';
Devise the formula for the area of a circle.
(HINT: use polar coordinates)
HERE

$worklines = 6;

$answer = <<'HERE';
Using a double integral and polar coordinates sum the area from the
radius from $0$ to $r$ and then sum this over all the angles $0$ to $\theta$.
\begin{align*}
    A &= \int_0^{2 \pi} \int_0^r r \; dr \; d\theta \\
      &= \int_0^{2 \pi} \frac{r^2}{2} \; d\theta \\
      &= \int_0^{2 \pi} \frac{2 \pi r^2}{2} \\
    A &= \pi \cdot r^2
\end{align*}

An alternative is to integrate over half the angle and then double it.
\begin{align*}
    A &= 2 \cdot \int_0^{\pi} \int_0^r r \; dr \; d\theta \\
      &= 2 \cdot \int_0^{\pi} \Big[ \frac{r^2}{2} \Big]_0^r \; d\theta \\
      &= 2 \cdot \int_0^{\pi} \frac{r^2}{2} \; d\theta \\
      &= 2 \cdot \int_0^{\pi} \frac{r^2}{2} \cdot \pi \\
    A &= \pi \cdot r^2
\end{align*}
HERE

$uuid = "[jmm] Thu, 16 Sep 2010 08:59:22 -0700";

$ref = 'This example is commonly given in a Calculus 2 (MATH-31) class.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
