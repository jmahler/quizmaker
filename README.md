
NAME
====

QuizMaker - Build tests of math problems formatted with [LaTeX][latex]

DESCRIPTION
===========

A student studying math, physics or engineering will accumulate many
problems during the course of a class.  If these problems are recorded
on paper they can be difficult to search through and study from.

QuizMaker is used to easily build tests of these problems.

The test template and the problems themselves use [LaTeX][latex] so
it is simple to format equations, tables, etc.

USAGE
=====

Given a test.template and a .test, such as the following

    ~/quizmaker/examples$ cat linux-admin.test 

    title: Linux Admin Test
    
    problem_files:
        - linux/linux_abc.prb
        - networking/osi-levels-01.prb
        - networking/osi-levels-02.prb
        - networking/network-address-01.prb
        - math/estimate224.prb
        - operating_systems/operation-speed.prb
        - system_design/count.prb
    
    author: Jeremiah Mahler <jmmahler@gmail.com>
    
    # vim:syntax=yaml

along with problems such as

    ~/quizmaker/examples$ cat operating_systems/operation-speed.prb 
    tags:
        - interview
        - linux
        - operating systems
    
    time: 1 minute
    
    short_desc: speed of operations
    
    question: |
        Rank the following operations from fastest to slowest:
        \begin{enumerate}
        \item Read from CPU register.
        \item Disc seek.
        \item Context switch.
        \item Read from main memory.
        \end{enumerate}
    
        \vspace*{0.5in}
    
    answer: |
        From fastest to slowest is: 1, 4, 3, 2.
    
    author: Jeremiah Mahler <jmmahler@gmail.com>
    
    # vim:syntax=yaml

the [LaTeX][latex] output is generated by simply running qzm

    ~/quizmaker/examples$ qzm -t test.template -c linux-admin.test > linux-admin.tex

Then [LaTeX][latex] can be processed using the usual tools

    ~/quizmaker/examples$ pdflatex linux-admin.tex

For more examples see the examples/ directory.

 [latex]: http://www.latex-project.org

AUTHOR
======

Jeremiah Mahler <jmmahler@gmail.com><br>
<https://github.com/jmahler/>

COPYRIGHT
=========

Copyright &copy; 2017, Jeremiah Mahler.  All Rights Reserved.<br>
This project is free software and released under
the [GNU General Public License][gpl].

 [gpl]: http://www.gnu.org/licenses/gpl.html
