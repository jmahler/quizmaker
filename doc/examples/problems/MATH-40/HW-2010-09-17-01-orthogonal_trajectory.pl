
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('math', 'class:MATH-40', 'orthogonal trajectories',
            'polynomial long division');

$par_time = '00:04:00';

$short_desc = "Find the orthogonal trajectory of: y = c*(x + 1/x)";

$question = <<'HERE';
Find the orthogonal trajectories of the family of curves
\begin{align*}
    y &= c \Big( x + \frac{1}{x} \Big)
\end{align*}
HERE

$worklines = 10;

# TODO - a more detailed answer
$answer = <<'HERE';
\begin{align*}
    y^2 &= -x^2 -2 \cdot \ln|x^2 - 1| + C
\end{align*}
HERE

$uuid = "[jmm] Tue, 21 Sep 2010 20:13:23 -0700";

$ref = 'Homework problem #1 from sheet handed out on 9/17/10 in the
class MATH-40 taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
