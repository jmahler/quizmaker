
#all: simple-circuits.pdf simple-circuits-ans.pdf
all:	 EECE311-test1-01.pdf EECE311-test1-01-ans.pdf

%-ans.tex: %.test
	qzm-view_test --printanswers $< > $@

%.tex: %.test
	qzm-view_test $< > $@

%.pdf: %.tex
	rubber --pdf $<

clean:
	-rm -f *.log *.aux *.dvi *.pdf

