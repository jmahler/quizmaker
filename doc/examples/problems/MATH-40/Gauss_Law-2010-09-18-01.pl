
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('physics', 'math', 'E&M', 'class:PHYS-42');

$par_time = '00:05:00';  # 5 minutes

$short_desc = "Show that Gauss's Law is true by calculating the integral.";

$question = <<'HERE';
To find the flux using Gauss's Law it is often not necessary
to calculate the E field and the area because $q/\epsilon_0$ can be used.
\begin{align*}
    \Phi &= \oint \vec{E} \cdot \vec{dA} = \frac{q}{\epsilon_0}
\end{align*}

Using any surface you choose, complete the integral and show that it
does in fact equal $q/\epsilon_0$.
HERE

$worklines = 20;

$answer = <<'HERE';
The simplest surface to use is a sphere so that is what will be used here.

The equation for calculating the electric field using Coulomb's Law.
\begin{align*}
    E = \frac{k \cdot Q}{r^2}
\end{align*}

The surface area of a sphere.
\begin{align*}
    A = 4 \cdot \pi \cdot r^2
\end{align*}

\begin{align*}
    \Phi &= \oint E \cdot dA \\
    &= E \cdot A \\
    &= \frac{k \cdot Q \cdot 4 \pi r^2}{r^2} \\
    &= k \cdot Q \cdot 4 \pi
\end{align*}

Substitute for $k$.
\begin{align*}
    k &= \frac{1}{4 \pi \epsilon_0}
\end{align*}

\begin{align*}
    \Phi &= k \cdot Q \cdot 4 \pi \\
    &= \frac{Q \cdot 4 \pi}{4 \pi \epsilon_0} \\
    &= \frac{Q}{\epsilon_0} \\
    &= \frac{q}{\epsilon_0}
\end{align*}

This results proves that integrating produces the same result as expected.
HERE

$uuid = "[jmm] Thu, 18 Sep 2010 23:35:43 -0700";

$ref = 'A common problem in a Physisc Electricity and Magnetism class.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
