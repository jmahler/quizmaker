
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('math', 'class:MATH-40', 'newtons law of cooling');

$par_time = '00:05:00';

$short_desc = "A pan of hot water is removed ...";

$question = <<'HERE';
A pan of hot water is removed from the stove and placed nearby to cool.
At this instant the temperature of the water was 200 degrees Farenheight,
and five minutes later it was 190 degrees Farenheight.
Assuming Newton's Law of Cooling applies and that the temperature
surrounding the pan of cooling water is 60 degrees Farenheight, what
will be the temperature of the water 20 minutes after it was set down to cool?
HERE

$worklines = 10;

$answer = <<'HERE';
First find $k$
\begin{align*}
    | T_f - A | &= (T_0 - A) \cdot e^{k \cdot t} \\
    | 190 - 60 | &= (200 - 60) \cdot e^{k \cdot 5} \\
    \frac{130}{140} &= e^{k \cdot 5} \\
    k &= \frac{ \ln(130/140) }{5}
\end{align*}

Now substitute for $t$ using the new $k$ and solve for $T_f$.
\begin{align*}
    | T_f - 60 | &= (200 - 60) \cdot e^{ \frac{ \ln(130/140) }{5} \cdot 20} \\
    T_f &= 200 \cdot e^{ 4 \cdot \ln(130/140) } \\
    &= 149 \;\; \mbox{degrees F}
\end{align*}
HERE

$uuid = "[jmm] Tue, 21 Sep 2010 20:53:36 -0700";

$ref = 'Homework problem #8 from sheet handed out on 9/17/10 in the
class MATH-40 taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
