
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('math', 'partial fractions', 'integration', 'class:MATH-31');

$par_time = '00:03:00';

$short_desc = "Integrate: (x^2 - 1)/(x*(x^2 + 1))";

$question = <<'HERE';
Integrate:
\begin{align*}
    \int \frac{x^2 - 1}{x (x^2 + 1)}
\end{align*}
HERE

$worklines = 10;

$answer = <<'HERE';
In its current form it cannot be integrated easily.
Noticing that the degree of the denominator is greater than the
numerator it can likely be reduced using partial fractions.

\begin{align*}
    \frac{x^2 - 1}{x (x^2 + 1)} &= \frac{A}{x} + \frac{B x + C}{x^2 + 1} \\
    x^2 - 1 &= A \cdot (x^2 + 1) + x \cdot (B x + C) \\
    \ldots \\
    \frac{x^2 - 1}{x (x^2 + 1)} &= \frac{-1}{x} + \frac{2 x + 0}{x^2 + 1}
\end{align*}

Now it is in a form that can be integrated easily.
\begin{align*}
    \int \Big( \frac{-1}{x} + \frac{2 x + 0}{x^2 + 1} \Big) \; dx
      &= \frac{1}{x^2} + \ln|x^2 + 1| + C
\end{align*}
HERE

$uuid = "[jmm] 2010-09-19 01";

$ref = 'An example made up by the author on 19 Sep 2010.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
