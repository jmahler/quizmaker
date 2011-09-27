
all: MATH-40-p01.pdf MATH-40-p01-ans.pdf

%-ans.tex: %.test
	qzm-view_test --printanswers $< > $@

%.tex: %.test
	qzm-view_test $< > $@

%.pdf: %.tex
	rubber --pdf $<

clean:
	-rm -f *.log *.aux *.dvi *.pdf

