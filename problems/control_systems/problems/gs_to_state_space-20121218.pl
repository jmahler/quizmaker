
@tags = ('control systems', 's-domain', 'state space',
	'teacher:Dr. Ghandakly',
	'school:CSU Chico',
	'class:EECE482');

# The amount of time it should take for the average person
# to complete this problem.
$par_time = '00:20:00';  # 20 minutes
# HH:MM:SS  (hours, minutes, seconds)

# A short description of the problem, used in summaries.
$short_desc = 'G(s) to state space, 20/(s^2 + 7s + 10)';

# reference (where did this problem come from?)
$ref = 'Problem two from the final exam of EECE 482 taught by '.
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
Convert the following system in to state space form.
\begin{align*}
	G(s) &= \frac{20}{s^2 + 7s + 10}
\end{align*}
QUESTION

# amount of space (\vspace) for working the problem
$workspace = '0in';  # student provides their own paper

$answer = <<'ANSWER';
\begin{align*}
	G(s) &= \frac{20}{(s+2)(s+5)}
\end{align*}

Perform the partial fraction expansion.
\begin{align*}
	\frac{20}{(s+2)(s+5)} &= \frac{A}{(s+2)} + \frac{B}{(s+5)} \\
	A &= 6.66 \\
	B &= -6.66
\end{align*}

Recall what we are trying to find, $y$, $u$, $x$
\begin{align*}
	\dot{x} &= A x + B u \\
	y &= C x + D u
\end{align*}

Re-arrange the equations to find these variables.
\begin{align*}
	G(s) &= \frac{y(s)}{u(s)} \\
		 &= \frac{6.66}{(s+2)} - \frac{6.66}{(s+5)} \\
	y(s) &= u \; \frac{6.66}{(s+2)} - u \; \frac{6.66}{(s+5)}
\end{align*}

Let
\begin{align*}
	x_1 &= u \frac{6.66}{(s+2)} \\
	x_2 &= - u \frac{6.66}{(s+5)}
\end{align*}

Now arrange to find $x$ and $u$.

\begin{align*}
	x_1 (s+2) &= u \; 6.66 \\
	s \; x_1 + 2 \; x_1 &= u \; 6.66 \\
	s \; x_1 &= - 2 \; x_1 + u \; 6.66
\end{align*}

\begin{align*}
	x_2 (s+5) &= -u \; 6.66 \\
	s \; x_2 + 5 \; x_2 &= -u \; 6.66 \\
	s \; x_2 &= - x_2 \; 5 + -u \; 6.66
\end{align*}

Recall that the inverse Laplace transform of $s \cdot X$ is $\dot{x}$.

\begin{align*}
	\dot{x_1} &= -2 x_1 + 6.66 \cdot u \\
	\dot{x_2} &= -5 x_2 - 6.66 \cdot u \\
\end{align*}

Recal that there are many possible state space solutions to
for the system.
The simplest arrangement is to place $x_1$ and $x_2$ in each
position.
And then set $C$ to all ones to include both $x_1$ and $x_2$.

\[
\begin{bmatrix}
	\dot{x_1} \\
	\dot{x_2}
\end{bmatrix}
=
\begin{bmatrix}
	-2 & 0 \\
	0 & -5
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2
\end{bmatrix}
+
\begin{bmatrix}
6.66 \\
-6.66
\end{bmatrix}
u \\
\]

\[
y =
\begin{bmatrix}
1 & 1
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2
\end{bmatrix}
\]

ANSWER

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

1;
