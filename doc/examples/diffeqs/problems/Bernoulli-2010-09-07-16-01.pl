
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('ODE', 'nonlinear ODE', 'Bernoulli ODE',
            'teacher:Mr. Bigler', 'class:MATH-40',
            'in class example');

$par_time = '00:03:00';  # 3 minutes

$short_desc = "Solve the ODE: y' + y = x*y^3";

$question = <<'HERE';
Solve the ODE:
\begin{align*}
    y' + y &= x \cdot y^3
\end{align*}
HERE

$worklines = 45;

$answer = <<'HERE';
Notice that the equation is nonlinear because of $y^3$ therefore
it might be solved as a Bernoulli Differential Equation.

Follow the steps for solving a Bernoulli Differential Equation.

Multiply by $y^{-3}$ to eliminate $y^3$.

\begin{align*}
    y' \cdot y^{-3} + y^{-2} &= x
\end{align*}

Let $z = y^{1 - n} = y^{1 - 3} = y^{-2}$.
\begin{align*}
    z &= y^{-2} \\
    z' &= -2 \cdot y^{-3} \cdot y'
\end{align*}

Substitute $z$ in to the original equation:
\begin{align*}
    -\frac{1}{2} \cdot z' + z &= x
\end{align*}

Now it can be solved as a linear ODE.

\begin{align*}
    y' + P(x) \cdot y &= Q(x) \\
    z' - 2 \cdot z &= -2 \cdot x
\end{align*}

\begin{align*}
    \mu &= e^{\int P(x) dx} \\
    &= e^{\int -2 dx} \\
    &= e^{-2 x}
\end{align*}

Multiply $\mu$ by the linear equation, find the derivative (and check).
\begin{align*}
    e^{-2 x} \cdot z' - e^{-2 x} \cdot 2 z &= -e^{-2 x} \cdot 2 x \\
    \frac{d}{dx} \Big[ e^{-2 x} z \Big] &= -e^{-2 x} 2 x  & \mbox{(checked OK)}
\end{align*}

Integrate (hint: use the table method).
\begin{align*}
    \int \frac{d}{dx} \Big[ e^{-2 x} z \Big] &= \int -e^{-2 x} 2 x \\
    e^{-2 x} z  &= x e^{-2 x} + \frac{1}{2} e^{-2 x} + C \\
    z &= x + \frac{1}{2} + C e^{2 x}
\end{align*}

Substitute for $z$ the original equation ($z = y^{-2}$).
\begin{align*}
    y^{-2} &= x + \frac{1}{2} + C e^{2 x} \\
    \frac{1}{y^{2}} &= \frac{2 x + 1 + C e^{2 x} 2}{2} \\
    y^2 &= \frac{2}{2 x + 1 + 2 C e^{2 x}} \\
    y^2 &= \frac{4}{4 x + 2 + 4 C e^{2 x}} \\
    y &= \frac{2}{\sqrt{4 x + 2 + 4 C e^{2 x}}}
\end{align*}

The final answer is:
\begin{align*}
    y &= \frac{2}{\sqrt{4 x + 2 + 4 C e^{2 x}}}
\end{align*}

An alternative solution could have combined all the components related
to $C$.
\begin{align*}
    y &= \frac{2}{\sqrt{4 x + 2 + C}}
\end{align*}
HERE

$uuid = "Tue, 07 Sep 2010 16:29:03 -0700";

$ref = 'An example given in class (MATH-40) taught by Mr Bigler at '.
'Butte Community College on 2010-Sep-01.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
