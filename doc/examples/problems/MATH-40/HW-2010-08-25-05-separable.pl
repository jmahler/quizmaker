
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('ODE', 'separable ODE', 'class:MATH-40', 'difficulty:hard',
        'polynomial long division', 'partial fractions');

$par_time = '00:10:00';

$short_desc = "Solve the ODE: (xy + x)dx - (x^2*y^2 + x^2 + y^2 + 1)dy = 0";

$question = <<'HERE';
Solve the ODE:
\begin{align*}
    (xy + x) \; dx - (x^2 y^2 + x^2 + y^2 + 1) \; dy &= 0
\end{align*}
HERE

$worklines = 10;

$answer = <<'HERE';
Separate.
\begin{align*}
    (xy + x) \; dx - (x^2 y^2 + x^2 + y^2 + 1) \; dy &= 0 \\
    x (y + 1) \; dx &= x^2 (y^2 + 1) + (y^2 + 1) \; dy \\
    \frac{(y+1)}{x} \; dx &= (y^2 + 1) (x^2 + 1) \; dy \\
    \frac{dx}{x(x^2 + 1)} &= \frac{y^2 + 1}{y + 1} \; dy
\end{align*}

In it's current form it is difficult to integrate.
The left hand side ($dx$) can be reduced using partial fractions.
And the right hand side can be reduced using polynomial long division.
The steps are not shown, just the result below.
\begin{align*}
    \Big( \frac{1}{x} - \frac{x}{x^2 + 1} \Big) \; dx &= \Big( y - 1 + \frac{2}{y+1} \Big) \; dy \\
    \ln|x| - \frac{1}{2} \cdot \ln|x^2 + 1| &= \frac{y^2}{2} - y + 2 \cdot \ln|y + 1| + C \\
    2 \ln|x| - \ln|x^2 + 1| &= y^2 - 2 y + 4 \cdot \ln|y + 1| + C
\end{align*}
HERE

$uuid = "[jmm] Wed, 22 Sep 2010 18:01:09 -0700";

$ref = 'Homework problem 5 from the sheet handed out on 8/25/10 in the class (MATH-40) taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
