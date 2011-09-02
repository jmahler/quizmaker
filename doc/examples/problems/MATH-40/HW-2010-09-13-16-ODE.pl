
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('math', 'class:MATH-40', 'ODE', 'difficulty:hard',
            'clever substitution', 'ultimate method');

$par_time = '00:10:00';

$short_desc = "Solve the ODE: (x + y) dy = y dx";

$question = <<'HERE';
Solve the ODE
\begin{align*}
    (x + y) \; dy &= y \; dx
\end{align*}
HERE

$worklines = 10;

# TODO - a more detailed answer
$answer = <<'HERE';
This problem can be solved using the ultimate method or the clever
substitution ($v = y/x$).
\begin{align*}
\frac{ \frac{\partial M}{\partial y} - \frac{\partial N}{\partial x} }
    { - M } &= -\frac{2}{y}
\end{align*}

(intermediate steps not shown)

\begin{align*}
    \frac{x}{y} - \ln|y| = C
\end{align*}
HERE

$uuid = "[jmm] Thu, 23 Sep 2010 17:23:52 -0700";

$ref = 'Homework problem #16 from sheet handed out on 9/13/10 in the
class MATH-40 taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
