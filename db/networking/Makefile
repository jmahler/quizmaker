DIAGRAMS_IN = $(shell ls *.ps)
DIAGRAMS = $(DIAGRAMS_IN:.ps=.pdf)

TESTS_IN = $(shell ls *.test)
TESTS = $(TESTS_IN:.test=.pdf)
TESTS_ANS = $(TESTS_IN:.test=-ans.pdf)

PROBLEMS = $(shell ls *.prb)

all: $(DIAGRAMS) $(TESTS) $(TESTS_ANS)

# xcircuit diagrams
%.pdf: %.ps
	ps2epsi $< $@
	epspdf $<

# tests
%-ans.tex: %.test $(PROBLEMS) $(DIAGRAMS)
	qzm -a -t $< > $@

%.tex: %.test $(PROBLEMS) $(DIAGRAMS)
	qzm -t $< > $@

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

clean:
	-rm -f *.log *.aux *.dvi *.pdf
	-rm -f *.tex
