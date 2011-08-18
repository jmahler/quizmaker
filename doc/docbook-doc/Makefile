
#
# XXX - The default database name is 'quizmaker',
#   if your database is named something else this will need
#   to be changed in order to work.
DBNAME=quizmaker


DEPS=intro.xml design.xml usage.xml install.xml devel.xml fdl.xml
#DEPS=intro.xml design.xml user.xml install.xml devel.xml quizmaker.xml fdl.xml


all: html/index.html

main.txt: main.xml $(DEPS)
	xmlto txt $<

main.dvi: main.xml $(DEPS)
	#dblatex -t dvi $<
	#dblatex -T db2latex -t dvi $<  # db2latex output style
	xmlto --with-dblatex dvi $<

html/index.html: index.xml $(DEPS)
	xmlto -o html html $<

main.pdf: main.xml $(DEPS)
	xmlto --with-dblatex pdf $<
	#dblatex $<
	#dblatex -T db2latex $<  # db2latex output style
#	docbook2pdf $<

main.ps: main.xml $(DEPS)
	xmlto --with-dblatex pdf $<
	#dblatex -t ps $<
	#dblatex -T db2latex -t ps $<  # db2latex output style
	#docbook2ps $<

html:
	mkdir html

html/quizmaker.html: html
	postgresql_autodoc -t html -d $(DBNAME) -f html/quizmaker

#
# The output produced by postgresql_autodoc cannot be integrated
# directly because it includes a <book> and <chapter> section.
# This patch removes these additions.
#
# Here is how the patch is created and used.
#
# First the raw file is generated and then copied (for editing):
#
#   make quizmaker_raw.xml
#   cp quizmaker_raw.xml quizmaker.xml
#
# Edit quizmaker.xml to include the necessary changes.
#
#   diff -u quizmaker_raw.xml quizmaker.xml > quizmaker.xml.patch
#
# Now the next time quizmaker_raw.xml is generated it can be patched.
#
#   mv quizmaker_raw.xml quizmaker.xml
#   patch -p0 <quizmaker.xml.patch
#

#quizmaker.xml: quizmaker_raw.xml quizmaker.xml.patch
#	mv $< $@
#	patch -p0 <quizmaker.xml.patch

# postgresql_autodoc automaticall generates documentation
#  from the database based on COMMENT's.
#
#   psql> \h COMMENT
#
#quizmaker_raw.xml:
#	postgresql_autodoc -t xml -d $(DBNAME) -f quizmaker_raw

#user.xml: user.xml.php ../examples/problems/skel.pl html/skel-problem.png
usage.xml: usage.xml.php ../examples/problems/skel.pl
	chmod +w $@  # try to prevent editing of generated file
	php $< > $@
	chmod -w $@  # try to prevent editing of generated file

# the preview takes up an entire page,
# how to scale down for a figure?
#html/skel-problem.png: skel-problem1.png
#	mv $< $@
#
#skel-problem1.png: skel-problem.dvi
#	dvipng $<
#
#skel-problem.dvi: ../examples/problems/skel.pl
#	qzm-view_problem.pl $< | rubber-pipe > $@

clean:
	-rm -f main.pdf
	-rm -f main.ps
	-rm -f main.log
	-rm -fr html
	-rm -f main.dvi
	-rm -f main.txt
	-rm -f quizmaker.xml quizmaker_raw.xml
	-rm -f skel-problem.dvi

