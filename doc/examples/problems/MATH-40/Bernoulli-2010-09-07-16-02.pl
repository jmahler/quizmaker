
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('ODE', 'nonlinear ODE', 'Bernoulli ODE', 'class:MATH-40',);

$par_time = '00:07:00';  # 5 minutes

$short_desc = "Solve the ODE: y' - 2y/x = -x^2 * y^2";

$question = <<'HERE';
Solve the ODE:
\begin{align*}
    y' - \frac{2 y}{x} = -x^2 \cdot y^2
\end{align*}
HERE

$worklines = 45;

$answer = <<'HERE';
Notice that the equation is nonlinear because of $y^2$, therefore
it might be solved as a Bernoulli Differential Equation.

Follow the steps for solving a Bernoulli Differential Equation.

Multiply by $y^{-2}$ to eliminate $y^2$.

\begin{align*}
    y' \cdot y^{-2} - \frac{2}{x} \cdot y^{-1} &= -x^2
\end{align*}

Let $z = y^{1 - n} = y^{1 - 2} = y^{-1}$.
\begin{align*}
    z &= y^{-1} \\
    z' &= -y^{-2} \cdot y'
\end{align*}

Substitute $z$ in to the original equation:
\begin{align*}
    -z' - \frac{2}{x} \cdot z = -x^2 \\
    z' + \frac{2}{x} \cdot z = x^2
\end{align*}

Now it can be solved as a linear ODE.

\begin{align*}
    y' + P(x) \cdot y &= Q(x) \\
    z' + \frac{2}{x} \cdot z &= x^2
\end{align*}

\begin{align*}
    \mu &= e^{\int P(x) dx} \\
    &= e^{\int \frac{2}{x} dx} \\
    &= e^{2 \ln |x|} \\
    &= x^2
\end{align*}

Multiply $\mu$ by the linear equation, find the derivative (and check).
\begin{align*}
    x^2 \cdot z' - 2 \cdot x \cdot z &= x^4 \\
    \frac{d}{dx} \Big[ x^2 \cdot z \Big] &= x^4  & \mbox{(checked OK)}
\end{align*}

Integrate.
\begin{align*}
    \int \frac{d}{dx} \Big[ x^2 \cdot z \Big] &= x^4 \\
    x^2 \cdot z &= \frac{x^5}{5} + C
\end{align*}

Substitute for $z$ the original equation ($z = y^{-1}$).
\begin{align*}
    \frac{x^2}{y} &= \frac{x^5}{5} + C \\
    \frac{1}{y} &= \frac{x^3}{5} + \frac{C}{x^2} \\
    \frac{1}{y} &= \frac{x^5 + 5 \cdot C}{5 x^2} \\
    y &= \frac{5 x^2}{x^5 + 5 C} \\
    y &= \frac{x^2}{\frac{x^5}{5} + C}
\end{align*}

The final answer is:
\begin{align*}
    y &= \frac{x^2}{\frac{x^5}{5} + C}
\end{align*}
HERE

$uuid = "Tue, 07 Sep 2010 16:44:14 -0700";

$ref = 'An example taken from Wikipedia [http://en.wikipedia.org/wiki/Bernoulli_differential_equation] on 2010-Sep-07';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
