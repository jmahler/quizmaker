
@tags = ('control systems', 's-domain', 'state space',
	'teacher:Dr. Ghandakly',
	'school:CSU Chico',
	'class:EECE482');

# The amount of time it should take for the average person
# to complete this problem.
$par_time = '00:20:00';  # 20 minutes
# HH:MM:SS  (hours, minutes, seconds)

# A short description of the problem, used in summaries.
$short_desc = 'Convert state space s-domain';

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
Convert the following state space equation to a transfer
function in the s-domain.
\[
\begin{bmatrix}
	\dot{x_1} \\
	\dot{x_2}
\end{bmatrix}
=
\begin{bmatrix}
	-10 & 1 \\
	-0.02 & -2
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2
\end{bmatrix}
+
\begin{bmatrix}
0 \\
2
\end{bmatrix}
u \\
\]

\[
y =
\begin{bmatrix}
1 & 0
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2
\end{bmatrix}
\]

QUESTION

# amount of space (\vspace) for working the problem
$workspace = '0in';  # student provides their own paper

$answer = <<'ANSWER';

The diagram of what we are solving may help.
\begin{center}
\includegraphics[scale=0.5]{img/Gs_y_u}
\end{center}

First, arrange matrix equations according to what we
are trying to find ($G(s) = y/u$).

\begin{align*}
	s \; X &= A X + B U \\
	s \; I \; X - A X &= B U \\
	(s \; I \; X - A) X &= B U \\
	X &= (s \; I - A)^{-1} B U
\end{align*}

\begin{align*}
	y &= C X \\
	y &= C \left[ (s \; I - A)^{-1} B u \right] \\
	\frac{y}{u} &= C \left[ (s \; I - A)^{-1} B \right]
\end{align*}

Substituting the given values.

\begin{align*}
\frac{y}{u} &= 
	\begin{bmatrix}
	1 & 0
	\end{bmatrix}
	\left(
		\begin{bmatrix}
			s & 0 \\
			0 & s
		\end{bmatrix}
		-
		\begin{bmatrix}
			-10 & 1 \\
			-0.02 & -2 
		\end{bmatrix}
	\right)^{-1}
	\begin{bmatrix}
		0 \\ 2
	\end{bmatrix} \\
	&=
	\begin{bmatrix}
	1 & 0
	\end{bmatrix}
	\begin{bmatrix}
		s + 10 & -1 \\
		0.02 & s + 2
	\end{bmatrix}
	^{-1}
	\begin{bmatrix}
		0 \\ 2
	\end{bmatrix}
\end{align*}

Next invert the matrix by using the determinant and swapping values
and signs.

\begin{align*}
\text{det} &= (s + 10)(s + 2) + 0.02 \\
		  &= s^2 + 12 s + 20.02
\end{align*}

\begin{align*}
\frac{y}{u}
	&=
	\frac{
		\begin{bmatrix}
		1 & 0
		\end{bmatrix}
		\begin{bmatrix}
		s + 2 & 1 \\
		-0.02 & s + 10
		\end{bmatrix}
		\begin{bmatrix}
		0 \\ 2
		\end{bmatrix}
		}{s^2 + 12 s + 20.02} \\
	&=
	\frac{
		\begin{bmatrix}
		1 & 0
		\end{bmatrix}
		\begin{bmatrix}
		2 \\
		2 s + 20	
		\end{bmatrix}
		}{s^2 + 12 s + 20.02}
\end{align*}

Finally, the answer is:

\begin{align*}
	G(s) &= \frac{2}{s^2 + 12 s + 20.02}
\end{align*}
ANSWER

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

1;
