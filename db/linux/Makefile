
PROBLEMS := $(shell ls *.prb)

linux.pdf: linux.tex
	pdflatex $<

linux.tex: linux.test $(PROBLEMS)
	qzm -a -t $< > $@
