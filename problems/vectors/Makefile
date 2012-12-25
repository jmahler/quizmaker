
.PHONY: clean

all: all_probs.pdf all_probs-ans.pdf

all_probs.tex: all_probs.test
	qzm-view_test $< > $@

all_probs-ans.tex: all_probs.test
	qzm-view_test --printanswers $< > $@

all_probs.pdf: all_probs.tex
	rubber --pdf $<

all_probs-ans.pdf: all_probs-ans.tex
	rubber --pdf $<

clean:
	-rm -f *.log *.aux *.dvi *.pdf *.tex

