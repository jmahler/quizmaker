
PROBLEMS := $(shell ls *.prb)
PDFS := linux.pdf

all: $(PDFS)

%.pdf: %.tex
	pdflatex $<

linux.tex: linux.test $(PROBLEMS)
	qzm -t ../test.template -c $< > $@

clean:
	-rm -f $(PDFS)
	-rm -f $(PDFS:.pdf=.log)
	-rm -f $(PDFS:.pdf=.aux)
