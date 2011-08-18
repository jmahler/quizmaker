
#
# doc/examples/problems/skel.pl
#   - An example QuizMaker problem definition in Perl
#
# To preview this run the command:
#
#  qzm-preview.pl skel.pl | rubber-pipe > tmp.dvi 
#
# Then open the file tmp.dvi with a viewer such as kdvi.
#
#  kdvi tmp.dvi
#

@tags = ('algebra', 'solve for x', 'teacher:Mr. Bob', 'class:MATH-120');

# The amount of time it should take for the average person
# to complete this problem.
$par_time = '00:00:30';  # 30 seconds
# HH:MM:SS  (hours, minutes, seconds)

# A short description of the problem, used in summaries.
$short_desc = 'Find x (in x^2 = 4)';

# reference (where did this problem come from?)
$ref = 'An example given in class (MATH-40) taught by Mr Bigler at '.
'Butte Community College on 9/1/10.';;

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
 
# The question to be answered
$question = <<'QUESTION';
'Find the value of $x$:
\begin{align*}
    x^2 &= 4 \\
    \sqrt{x^2} &= \sqrt{4} \\
    x &= 2
\end{align*}';
QUESTION

# number of lines for working the problem
$worklines = 5;

$answer =
'$x = 2$';

#
# A unique identifier must be provided to help prevent this
# problem from unintentionally being added to the database more
# than once.
#
# A good unique identifier is the current time with seconds.
#
#   date +"%F %T"
#     2010-08-28 19:33:28
#
$uuid = "2010-08-28 19:33:28";

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# Describe where this question was referenced from.
$ref = 'An example given in class (MATH-120) taught by Mr Somebody at '.
'Some College on 2010-Sep-01.';;

#
# If a variable is defined that is not understood during loading an
#  error similar to below will be produced.
#
# $bad_variable = 89;
#
#  Use of uninitialized value in concatenation (.) or string at /home/jeri/lib/perl5/QuizMaker.pm line 87, <IN_FILE> line 59.
#

# vim:syntax=perl

1;
