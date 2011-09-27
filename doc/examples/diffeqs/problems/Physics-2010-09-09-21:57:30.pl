
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('physics', 'math', 'ODE', 'Newton', 'class:PHYS-41', 'class:MATH-40');

$par_time = '00:05:00';  # 5 minutes

$short_desc = "Derive the kinematic equation for position.";

$question = <<'HERE';
Knowing that acceleration, position, and velocity are related as
\begin{align*}
    a &= \frac{dv}{dt} \;\;\; [m/s^2] \\
    v &= \frac{dx}{dt} \;\;\; [m/s]
\end{align*}
derive the kinematic equation that describes the position ($x(x_0, v_0, t, a) \;\; [m]$).
HERE

$worklines = 30;

$answer = <<'HERE';
\begin{align*}
    a &= \frac{dv}{dt} \;\;\; [m/s^2]
\end{align*}

Separate the variables and integrate.

\begin{align*}
    \int a \; dt &= \int dv \\
    a \cdot t &= v + C
\end{align*}

To determine what $C$ should be check the units.
In this case the units are $[m/s]$ which means $C$ represents velocity,
specifically the initial velocity.

\begin{align*}
    a \cdot t &= v + v_0 \;\;\; [m/s]
\end{align*}

Substitute for velocity ($v$) with $\frac{dx}{dt}$ then separate
and integrate.

\begin{align*}
    \frac{dx}{dt} &= a \cdot t + v_0 \\
    \int dx &= \int (a \cdot t + v_0) dt \\
    x &= \frac{1}{2} \cdot a \cdot t^2 + v_0 \cdot t + C
\end{align*}

Determine what $C$ should be just like before by checking the units.

\begin{align*}
    x_f &= \frac{1}{2} \cdot a \cdot t^2 + v_0 \cdot t + x_0 \;\;\; [m]
\end{align*}

This final equation determines the position based on acceleration, velocity,
etc.
HERE

$uuid = "[jmm] Thu, 09 Sep 2010 22:03:06 -0700";

$ref = 'A common example that is relevant to both a Physics class and
a class in Differential Equations.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
