
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = (
         'ODE',
         'difficulty:moderate',
         'class:MATH-40',
         'reduction of order',
         'reduction of order - one solution to find another',
         'test',
     );

$par_time = '00:05:00';

$short_desc = "Solve: (x^2 + 1)y'' - 2xy' + 2y = 0.";

$question = <<'HERE';
Solve the ODE
\begin{align*}
(x^2 + 1) y'' - 2 x y' + 2 y &= 0
\end{align*}
knowing that one solution is $y = x$.
HERE

$worklines = 15;

$answer = <<'HERE';
Because we are given one of the solution it is most likely
a Reduction of Order problem.
But it needs to be in the form
\begin{align*}
    y'' + P(x) y' + Q(x) y &= 0
\end{align*}
before it can be solved.

\begin{align*}
    y'' - \frac{2 x}{x^2 + 1} y' + \frac{2}{x^2 + 1} y &= 0
\end{align*}

To find a second answer, $y_2$, we must solve $y_2 = v \cdot y_1$ where
\begin{align*}
    v &= \int \frac{e^{-\int P(x) \; dx}}{(y_1)^2}
\end{align*}

Plugging in the values and solving results in the value:
\begin{align*}
    v &= x - \frac{1}{x}
\end{align*}

\begin{align*}
    y_2 &= v \cdot y_1 \\
        &= (x - \frac{1}{x}) x \\
        &= x^2 - 1
\end{align*}

Checking the second answer by deriving and plugging back in to the original
equation will confirm that it is indeed a valid solution.

Combine both the solutions in to a single general solution for the
final answer.

\begin{align*}
    y_g &= C_1 x + C_2 x^2 - 1
\end{align*}

HERE

$uuid = "[jmm] Tue, 26 Oct 2010 18:41:12 -0700";

$ref = 'This was a test question given on 10/20/10 in MATH-40 taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
