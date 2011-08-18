
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

Show below is a sample session used to create a test.

    jeri@bishop tests$ pwd
    /home/jeri/quizmaker/doc/examples/tests
    jeri@bishop tests$ ls
    Makefile  skel.test
    jeri@bishop tests$ qzm-view_test skel.test > skel.tex
    jeri@bishop tests$ ls
    Makefile  skel.test  skel.tex
    jeri@bishop tests$ rubber skel.tex
    compiling skel.tex...
    compiling skel.tex...
    jeri@bishop tests$ ls
    Makefile  skel.aux  skel.dvi  skel.log  skel.test  skel.tex
    jeri@bishop tests$ kdvi skel.dvi

The file `skel.test` is the test definition.
Here 'skel' is shorthand for 'skeleton' since this file is used as an
example from which to build other test definitions.
`qzm-view_test` is used to convert the test definition in `skel.test`
to LaTeX format.
The [`rubber`][rubber] command is used to process the LaTeX code in to dvi or other
output types (ps, pdf).

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

