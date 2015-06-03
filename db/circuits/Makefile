
DIAGRAMS = dependent_source-02-diagram.pdf voltage-resistor-diagram.pdf

all: simple-circuits.pdf simple-circuits-ans.pdf

%-ans.tex: %.test *.prb
	qzm -a -t $< > $@

%.tex: %.test *.prb
	qzm -t $< > $@

%.eps: %.ps
	ps2epsi $< $@

%.pdf: %.eps
	epspdf $<

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

simple-circuits.pdf: simple-circuits.tex $(DIAGRAMS)

simple-circuits-ans.pdf: simple-circuits-ans.tex $(DIAGRAMS)

clean:
	-rm -f *.log *.aux *.dvi *.pdf
	-rm -f *.tex
