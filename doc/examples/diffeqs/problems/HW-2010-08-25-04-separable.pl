
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('ODE', 'separable ODE', 'class:MATH-40', 'difficulty:medium',
        'trig', 'partial fractions');

$par_time = '00:05:00';

$short_desc = "Solve the ODE: dP/dt = a*P - b*P^2";

$question = <<'HERE';
Solve the ODE:
\begin{align*}
    \frac{dP}{dt} &= a \cdot P - b \cdot P^2
\end{align*}
HERE

$worklines = 10;

$answer = <<'HERE';
Separate and integrate.
\begin{align*}
    \frac{dP}{a \cdot P - b \cdot P^2} &= dt
\end{align*}

Use partial fractions (not shown) to reduce the equation to
an integratable form.
\begin{align*}
    \int dt &= \int \Big( \frac{1/a}{P} + \frac{b/a}{a - b \cdot P} \Big) \; dP
\end{align*}

\begin{align*}
    t &= \frac{1}{a} \ln|P| - \frac{1}{a} \ln|a - b \cdot P| + C \\
    t \cdot a + C &= \ln|P| - \ln|a - b \cdot P| \\
    t \cdot a + C &= \ln \Big( \frac{|P|}{|a - b \cdot p|} \Big) \\
    K \cdot e^{t \cdot a} &= \frac{|P|}{|a - b \cdot P|}
\end{align*}
HERE

$uuid = "[jmm] Wed, 22 Sep 2010 16:41:13 -0700";

$ref = 'Homework problem 4 from the sheet handed out on 8/25/10 in the class (MATH-40) taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
