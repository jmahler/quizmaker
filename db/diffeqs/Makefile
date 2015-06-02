
.PHONY: clean

all: MATH-40-p01.pdf MATH-40-p01-ans.pdf

MATH-40-p01.tex: MATH-40-p01.test
	qzm-view_test $< > $@

MATH-40-p01-ans.tex: MATH-40-p01.test
	qzm-view_test --printanswers $< > $@

MATH-40-p01.pdf: MATH-40-p01.tex
	rubber --pdf $<

MATH-40-p01-ans.pdf: MATH-40-p01-ans.tex
	rubber --pdf $<

clean:
	-rm -f *.log *.aux *.dvi *.pdf *.tex

