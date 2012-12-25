
@tags = ('vector', 'ellipse', 'trigonometry',
	'book:Div, Grad, Curl and All That. Schey.');

# The amount of time it should take for the average person
# to complete this problem.
$par_time = '00:05:00';  # 5 minutes
# HH:MM:SS  (hours, minutes, seconds)

# A short description of the problem, used in summaries.
$short_desc = 'Position vector equivalent to ellipse function.';

# reference (where did this problem come from?)
$ref = 'This problem was taken from the book "Div, Grad, Curl and All That
by H.M. Schey.  4th Edition 2007.  Problem I-4 (c) on Page 9.';

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
Show that the function for position vector 
\begin{align*}
\vec{r(t)} &= \hat{i} \; a \; \cos(\omega t) + \hat{j} \; b \; \sin(\omega t)
\end{align*}
represents the position function of an ellipse.
\begin{align*}
\left( \frac{x}{a} \right)^2
+
\left( \frac{y}{b} \right)^2
&= 1
\end{align*}
QUESTION

# amount of space (\vspace) for working the problem
$workspace = '6in';

$answer = <<'ANSWER';
First, extract the $x$ and $y$ components of $\hat{i}$ and $\hat{j}$
respectively.
\begin{align*}
	x &= a \; \cos(\omega t) \\
	y &= b \; \sin(\omega t) \\
\end{align*}

Arrange to isolate the trigonometric functions.
\begin{align*}
	\frac{x}{a} &= \cos(\omega t) \\
	\frac{y}{b} &= \sin(\omega t) \\
\end{align*}

Recall the trigonometric identity: 
\begin{align*}
	\sin^2(\theta) + \cos^2(\theta) &= 1
\end{align*}

Substitute for the final answer.
\begin{align*}
	\left( \frac{y}{b} \right)^2 + \left( \frac{x}{a} \right)^2 &= 1
\end{align*}

ANSWER

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

1;
