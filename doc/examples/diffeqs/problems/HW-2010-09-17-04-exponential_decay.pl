
#
# see doc/examples/problems/skel.pl for a detailed
# definition of the settings in this file
#

@tags = ('math', 'class:MATH-40', 'exponential decay');

$par_time = '00:05:00';

$short_desc = "... radioactive nuclei decay is proportional ...";

$question = <<'HERE';
Assume that the rate at which radioactive nuclei decay is proporitonal to the
number of such nuclei that are present in a given sample.  In a certain sample
one-fourth of the original number of radioactive nuclei have undergone
disintegration in a period of 500 years. \\
\\
(a)  What fraction of the original radioactive nuclei will remain after 1000
years? \\
(b)  In how many years will one-half of the original number remain?
HERE

$worklines = 10;

$answer = <<'HERE';
\begin{align*}
    \frac{dA}{dt} &= k \cdot A \\
    A &= A_0 \cdot e^{k \cdot t} \\
    \frac{3}{4} A_0 &= A_0 \cdot e^{k \cdot 500} \\
    k &= \frac{\ln(3/4)}{500} \\
    A &= A_0 \cdot e^{ \frac{\ln(3/4)}{500} \cdot t}
\end{align*}

a)
\begin{align*}
    t &= 1000 \;\; \mbox{years} \\
    z \cdot A_0 &= A_0 \cdot e^{ \frac{\ln(3/4)}{500} \cdot 1000} \\
    z &= 9/16
\end{align*}

b)
\begin{align*}
    z &= 1/2 \\
    t &= ? \\
    \frac{1}{2} &= e^{ \frac{\ln(3/4)}{500} \cdot t} \\
    t &= \frac{ \ln(1/2) \cdot 500 }{ \ln(3/4) } \\
      &= 1205 \;\; \mbox{years}
\end{align*}
HERE

$uuid = "[jmm] Tue, 21 Sep 2010 20:53:36 -0700";

$ref = 'Homework problem #7 from sheet handed out on 9/17/10 in the
class MATH-40 taught by Mr Bigler at Butte College.';

$author = 
'Jeremiah Mahler <jmmahler@gmail.com>
http://www.google.com/profiles/jmmahler#about';

# vim:syntax=perl

1;
