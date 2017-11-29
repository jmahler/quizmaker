TESTS_IN = $(shell ls *.test)
TESTS = $(TESTS_IN:.test=.pdf)
TESTS_ANS = $(TESTS_IN:.test=-ans.pdf)

PROBLEMS = $(shell ls *.prb)

all: $(TESTS) $(TESTS_ANS)

# tests
%-ans.tex: %.test $(PROBLEMS)
	qzm -a -t $< > $@

%.tex: %.test $(PROBLEMS)
	qzm -t $< > $@

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

clean:
	-rm -f *.log *.aux *.dvi *.pdf
	-rm -f *.tex
