
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('ODE', 'nonlinear ODE', 'IVP', 'Bernoulli ODE', 'class:MATH-40',);

$par_time = '00:05:00';  # 5 minutes

$short_desc = "Solve the IVP: y' - y/2x = x * y^-3; y(1) = 2";

$question = <<'HERE';
Solve the IVP:
\begin{align*}
    y' - \frac{y}{2 x} = x \cdot y^{-3} \; ; \;\;\; y(1) = 2
\end{align*}
HERE

$worklines = 45;

$answer = <<'HERE';
Notice that the equation is nonlinear because of $y^{-3}$, therefore
it might be solved as a Bernoulli Differential Equation.

Follow the steps for solving a Bernoulli Differential Equation.

Multiply by $y^{3}$ to eliminate $y^{-3}$.

\begin{align*}
    y' \cdot y^{3} - \frac{1}{2 x} \cdot y^{4} &= x
\end{align*}

Let $z = y^{1 - n} = y^{1 - (-3)} = y^{4}$.
\begin{align*}
    z &= y^{4} \\
    z' &= 4 \cdot y^{3} \cdot y'
\end{align*}

Substitute $z$ in to the original equation:
\begin{align*}
    \frac{1}{4} \cdot z' - \frac{1}{2x} \cdot z = x
\end{align*}

Now it can be solved as a linear ODE.

\begin{align*}
    y' + P(x) \cdot y &= Q(x) \\
    z' - \frac{2}{x} \cdot z &= 4 \cdot x
\end{align*}

Find the integrating factor ($\mu$).
\begin{align*}
    \mu &= e^{\int P(x) dx} \\
    &= e^{\int -\frac{2}{x} dx} \\
    &= e^{-2 \ln |x|} \\
    &= x^{-2}
\end{align*}

Multiply $\mu$ by the linear equation and find the derivative.
\begin{align*}
    z' \cdot x^{-2} + 2 \cdot x^{-3} \cdot z &= 4 x^{-1} \\
    \frac{d}{dx} \Big[ x^{-2} \cdot z \Big] &= 4 \cdot x^{-1}
\end{align*}

Integrate.
\begin{align*}
    \frac{d}{dx} \Big[ x^{-2} \cdot z \Big] &= 4 \cdot x^{-1} \\
    z \cdot x^{-2} &= 4 \ln|x| + C
\end{align*}

Substitute for $z$ the original equation ($z = y^{4}$).
\begin{align*}
    y^4 \cdot x^{-2} &= 4 \ln|x| + C
\end{align*}

At this point the ODE is solved implicitly.
But $C$ needs to be found using the initial condition $y(1) = 2$.
Substitute the values and solve for $C$.
\begin{align*}
    2^4 &= 1^2 \cdot 4 \ln|1| + C \\
    C &= 16 \\
    y^4 \cdot x^{-2} &= 4 \ln|x| + 16
\end{align*}

The final answer in implicit form is:
\begin{align*}
    y^4 &= x^2 \cdot 4 \ln|x| + 16 x^2
\end{align*}
HERE

$uuid = "Tue, 07 Sep 2010 20:38:37 -0700";

$ref = 'An example given in class (MATH-40) taught by Mr Bigler at '.
'Butte Community College on 2010-Sep-01.';;

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
