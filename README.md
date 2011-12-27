
NAME
----

QuizMaker - Build tests of math problems.

INTRODUCTON
-----------

A student studying math, physics or engineering will accumulate many
problems during the course of a class.
But if these problems are recorded on paper they can be difficult
to study from because it is hard to search for problems.
The QuizMaker system aims to ease this situation by organizing problems into a
database so that they can be quickly recalled and grouped together to build tests.

SYNOPSIS
--------

The system consists of command line utilities which are used
to query problems and build tests.

Shown below is an example of how to query the problems.

    jeri@bishop diffeqs$ qzm-query -listtags problems/*.pl
    TAGS:
     test
     mixture
     trig
     polynomial long division
     reduction of order
     Newton
     exact ODE
     math
    ...
    jeri@bishop diffeqs$ qzm-query -findtags -tags math "exact ODE" -files problems/*.pl 
    FILES:
      problems/exact-ODE-2010-09-13-01.pl
      problems/exact-ODE-2010-09-13-02.pl
    jeri@bishop diffeqs$


Show below is a sample session used to create a test.
To compile the [LaTeX][latex] code [Rubber][rubber] is used but other
equivalent utilities can be used as well.
These commands are also provided in the Makefile.

    jeri@bishop diffeqs$ qzm-view_test MATH-40-p01.test > MATH-40-p01.tex
    jeri@bishop diffeqs$ rubber --pdf MATH-40-p01.tex 
    compiling MATH-40-p01.tex...
    compiling MATH-40-p01.tex...
    jeri@bishop diffeqs$ ls
    Makefile         MATH-40-p01.log  MATH-40-p01.test  problems
    MATH-40-p01.aux  MATH-40-p01.pdf  MATH-40-p01.tex
    jeri@bishop diffeqs$
    
 [rubber]: https://launchpad.net/rubber

REQUIREMENTS
------------

To run these programs it is necessary to have a recent version
of [Perl][perl] and a [LaTeX][latex] processor.

 [perl]: http://www.perl.org
 [latex]: http://www.latex-project.org

INSTALLATON
-----------

To run the programs they need to be accessible on a users
$PATH and the libraries must be found by Perl ($PERL5LIB).

One solution which is well suited for development
is to unpack the package in to the users directory such as
~/user and then to link to the needed parts inside.

If the user has the directory ~/bin which is searchable in
the environment variable $PATH then links can be added to
the programs in the bin directory of this package.

Similarly if the user has the directory ~/lib/perl5/ which is
searchable in the environment variable $PERL5LIB then links can
be added to the libraries in the lib/perl5 directory of this package.

One these links are added it is simple to retrieve upstream updates
using [Git][quizmaker].

 [quizmaker]: https://github.com/jmahler/quizmaker

AUTHOR
------

Jeremiah Mahler <jmmahler@gmail.com><br>
<http://www.google.com/profiles/jmmahler#about>

COPYRIGHT
---------

Copyright &copy; 2011, Jeremiah Mahler.  All Rights Reserved.<br>
This project is free software and released under
the [GNU General Public License][gpl].

 [gpl]: http://www.gnu.org/licenses/gpl.html

