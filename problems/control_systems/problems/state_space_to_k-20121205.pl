
@tags = ('control systems', 's-domain', 'state space',
	'2nd order', 'K1, K2', 'pole placement',
	'teacher:Dr. Ghandakly',
	'school:CSU Chico',
	'class:EECE482');

# The amount of time it should take for the average person
# to complete this problem.
$par_time = '00:25:00';  # 25 minutes
# HH:MM:SS  (hours, minutes, seconds)

# A short description of the problem, used in summaries.
$short_desc = 'From state space find K1 and K2';

# reference (where did this problem come from?)
$ref = 'Problem given in EECE 482 taught by '.
'Dr. Ghandakly at CSU Chico during the Fall of 2012';

#
# QUOTING STRINGS:
#
# The recommended way to quote large strings is by using a Here document
# with single quotes.
#
# $var = <<'HERE';
#   place your text here
# HERE
#
# Single quotes ('') may also be used but they will escape '\\'
# which can cause problems with LaTeX code.
#
 
# The question to be answered, in LaTeX format
$question = <<'QUESTION';
Find the constants, $K_1$ and $K_2$ for the given state
space values and the second order system parameters.

\begin{align*}
A &=
\begin{bmatrix}
	-10 & 1 \\
	-0.02 & -2
\end{bmatrix} \\
B &=
\begin{bmatrix}
	0 \\
	2
\end{bmatrix}
\end{align*}
\begin{align*}
	\zeta &= 0.5 \\
	\omega_n &= 3
\end{align*}
QUESTION

# amount of space (\vspace) for working the problem
$workspace = '0in';  # student provides their own paper

$answer = <<'ANSWER';
First, recall the denominator of the second order equation.
\begin{align*}
s^2 + 2 \zeta \omega_n s + \omega_n^2 \\
s^2 + 3 s + 9
\end{align*}

Next, arrange the state space equation.

\begin{align*}
	\dot{x} &= Ax + Bu \\
	y &= C x + D u
\end{align*}

Let
\begin{align*}
	u = -K \cdot x
\end{align*}

Arrange, recallaing the Laplace of $\dot{x}$ is $s X$.

\begin{align*}
	\dot{x} &= Ax - B K x \\
	s I x &= (A - BK) x \\
	s I x -A + BK &= 0
\end{align*}

\begin{align*}
\begin{bmatrix}
	s & 0 \\
	0 & s
\end{bmatrix}
-
\begin{bmatrix}
	-10 & 1 \\
	-0.02 & -2 
\end{bmatrix}
+
\begin{bmatrix}
	0 \\
	2
\end{bmatrix}
\begin{bmatrix}
	K_1 & K_2
\end{bmatrix}
&= 0 \\
\begin{bmatrix}
	s + 10 & -1 \\
	0.02 + 2 K_1 & s + 2 + 2 K_2
\end{bmatrix}
&= 0
\end{align*}

Calculate the determinant.

\begin{align*}
	(s + 10)(s + 2 + 2 K_2) + (0.02 + 2 K_1) \\
	s^2 + (12 + 2 K_2) s + (20.02 + 2 K_1 + 20 K_2)
\end{align*}

Using pole placement, set this equal to the system found previously.

\begin{align*}
	s^2 + (12 + 2 K_2) s + (20.02 + 2 K_1 + 20 K_2)
	&= s^2 + 3 s + 9
\end{align*}

\begin{align*}
	12 + 2 K_2 &= 3 \\
	K_2 &= -\frac{9}{2}
\end{align*}

\begin{align*}
	20.02 + 2 K_1 + 20 K_2 &= 9 \\
	20.02 + 2 K_1 - 90 &= 9 \\
	2 K_1 &= 99 - 20.02 \\
	K_1 &= 39.49
\end{align*}

To summarize, the answers for $K$ are:
\begin{align*}
	K_2 &= -\frac{9}{2} \\
	K_1 &= 39.49
\end{align*}
ANSWER

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

1;
