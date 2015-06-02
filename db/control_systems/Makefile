
.PHONY: clean

all: EECE482-final.pdf EECE482-final-ans.pdf

EECE482-final.tex: EECE482-final.test
	qzm-view_test $< > $@

EECE482-final-ans.tex: EECE482-final.test
	qzm-view_test --printanswers $< > $@

EECE482-final.pdf: EECE482-final.tex
	rubber --pdf $<

EECE482-final-ans.pdf: EECE482-final-ans.tex
	rubber --pdf $<

clean:
	-rm -f *.log *.aux *.dvi *.pdf *.tex

