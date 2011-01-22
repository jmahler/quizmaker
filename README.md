
NAME
----

QuizMaker - Build tests of math problems.

INTRODUCTON
-----------

A student studying math, physics or engineering will accumulate many
problems during the course of a class.
But if these problems are recorded on paper they can be difficult and
cumbersome to study from because it is hard to search for problems.
The QuizMaker system aims to ease this situation by organizing problems into a
databse so that they can be quickly recalled and grouped together to build tests.

QuizMaker also aims to make studying for a test closer to the reality of taking
a test.
When studying from notes the student might find a problem, work the problem and then
check their answer.  And this is repeated until they feel confident in their
abilities.
But this process is drastically different from a test where a set of problems
is given with no answers and no notes and there is only a finite time to complete
them.
QuizMaker can bring studying closer to testing by generating a set of problems
without answers for the student to perform.

INSTALL
-------

Once the basic packages have been installed (see REQUIREMENTS) a
database schema should be loaded (see the directory sql/).
The schema can be loaded without data or with data.
The schema with data includes a basic set of problems
which is good for learning how the problems can be formatted.

REQUIREMENTS
------------

This system is completely web based and built using the [Zend Framework][zend].
In addition to Zend you will also need those packages that it depends on such
as [Apache][apache] and [Php][php].
These packages should be straightforward to install on most [Linux][linux]
distributions ([Debian][deb], [Ubuntu][ubu], [RedHat][red]).

It is also necessary to have [Mathtex][mathtex] for previewing the equations.
Currently the location of this cgi-script is defined in

    application/views/helpers/FormatProblem.php

      $host = "http://qzm.local/cgi-bin/mathtex.cgi?"

 [zend]: http://framework.zend.com
 [apache]: http://www.apache.org
 [php]: http://www.php.net
 [linux]: http://www.kernel.org
 [deb]: http://www.debian.org
 [ubu]: http://www.ubuntu.com
 [red]: http://www.redhat.com
 [mathtex]: http://www.ctan.org/tex-archive/support/mathtex/

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

