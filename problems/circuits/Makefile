
#all: simple-circuits.pdf simple-circuits-ans.pdf
all:	 EECE311-test1-01.pdf EECE311-test1-01-ans.pdf

%-ans.tex: %.test
	qzm -a -t $< > $@

%.tex: %.test
	qzm -t $< > $@

%.pdf: %.tex
	rubber --pdf $<

clean:
	-rm -f *.log *.aux *.dvi *.pdf

