
NAME
====

QuizMaker - Build tests of math problems formatted with [LaTeX][latex]

INTRODUCTION
============

A student studying math, physics or engineering will accumulate many
problems during the course of a class.
But if these problems are recorded on paper they can be difficult
to study from because it is hard to search for problems.
The goal of the QuizMaker system is to simplify this situation by
organizing a database of problems using tags so that tests can
be easily created which focus on specific facets of a subject.

SYNOPSIS
========

The system consists of command line utilities which are used
to query problems and build tests.

Shown below is an example of how to query the problems.

    diffeqs$ qzm-query -listtags problems/*.pl
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
    diffeqs$ qzm-query -findtags -tags math "exact ODE" -files problems/*.pl 
    FILES:
      problems/exact-ODE-2010-09-13-01.pl
      problems/exact-ODE-2010-09-13-02.pl
    diffeqs$


Shown below is a sample session used to create a test.
To compile the [LaTeX][latex] code [Rubber][rubber] is used but other
equivalent utilities should work as well.
These commands are also provided in the Makefile.

    diffeqs$ qzm-view_test MATH-40-p01.test > MATH-40-p01.tex
    diffeqs$ rubber --pdf MATH-40-p01.tex 
    compiling MATH-40-p01.tex...
    compiling MATH-40-p01.tex...
    diffeqs$ ls
    Makefile         MATH-40-p01.log  MATH-40-p01.test  problems
    MATH-40-p01.aux  MATH-40-p01.pdf  MATH-40-p01.tex
    diffeqs$
    
 [rubber]: https://launchpad.net/rubber

REQUIREMENTS
============

To run these programs it is necessary to have a recent version
of [Perl][perl] and a [LaTeX][latex] processor.

 [perl]: http://www.perl.org
 [latex]: http://www.latex-project.org

INSTALLATION
============

To run the programs they need to be accessible on a users
$PATH and the libraries must be found by Perl ($PERL5LIB).

One solution, which is well suited for development,
is to unpack the package in to the users directory such as
~/quizmaker/ and then to link to the needed parts inside.

If the user has the directory ~/bin, which is searchable in
the environment variable $PATH, then links can be added to
the programs in the bin directory of this package.

    ~$ cd ~/bin
    ~/bin$ ln -s ~/quizmaker/bin/* .

Similarly, if the user has the directory ~/lib/perl5/ which is
searchable in the environment variable $PERL5LIB then links can
be added to the libraries in the lib/perl5 directory of this package.

    ~$ cd ~/lib/perl5/
    ~/lib/perl5$ ln -s ~/quizmaker/lib/perl5/* .

Once these links are added it is simple to retrieve upstream updates
using the usual git pull.

 [quizmaker]: https://github.com/jmahler/quizmaker

AUTHOR
======

Jeremiah Mahler <jmmahler@gmail.com><br>
<https://github.com/jmahler/>

COPYRIGHT
=========

Copyright &copy; 2015, Jeremiah Mahler.  All Rights Reserved.<br>
This project is free software and released under
the [GNU General Public License][gpl].

 [gpl]: http://www.gnu.org/licenses/gpl.html

