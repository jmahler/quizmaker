
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('IVP', 'ODE', 'linear', 'class:MATH-40', 'difficulty:hard', 'trig');

$par_time = '00:10:00';

$short_desc = "Solve the IVP: y' = (cot x)*y + sin(x); y(pi/2) = 0";

$question = <<'HERE';
Solve the IVP:
\begin{align*}
    y' &= (\cot x) y + \sin x \;\; ; \; y(\pi/2) = 0
\end{align*}
HERE

$worklines = 10;

$answer = <<'HERE';
It is not seperable but it does fit in to the linear form ($y' + P(x) y = Q(x)$).
\begin{align*}
    y' - (\cot x) y &= \sin x
\end{align*}

Build the integrating factor.
\begin{align*}
    \mu &= e^{\int -\cot x \; dx} \\
        &= e^{- \ln|\sin x|} \\
        &= \frac{1}{\sin x}
\end{align*}

Multiply $\mu$ by the equation.
\begin{align*}
    y' \cdot \frac{1}{\sin x} - \frac{\cot x}{\sin x} y &= 1
\end{align*}

Check the derivative and integrate.
\begin{align*}
    \int \frac{d}{dx} \Big[ \frac{1}{\sin x} y \Big] &= \int 1 \; dx \\
    \frac{1}{\sin x} y &= x + C
\end{align*}

Substitute the initial conditon to find $C$.
\begin{align*}
    \frac{1}{\sin(\pi/2)} \cdot 0 &= \frac{\pi}{2} + C \\
    C &= -\frac{\pi}{2}
\end{align*}

\begin{align*}
    y &= \sin(x) \Big( x - \frac{\pi}{2} \Big)
\end{align*}
HERE

$uuid = "[jmm] Thu, 23 Sep 2010 09:15:47 -0700";

$ref = 'Homework problem 7 from the problems on Pg. 71 of Ordinary Differential Equations by Charles E. Roberts.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
