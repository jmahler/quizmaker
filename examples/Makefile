
PDFS := firmware-test-engineer-interview.pdf linux-admin.pdf

all: $(PDFS)

%.tex: %.test test.template
	qzm -t test.template -c $< > $@

%.pdf: %.tex
	pdflatex $<

clean:
	-rm -f $(PDFS)
	-rm -f $(PDFS:.pdf=.log)
	-rm -f $(PDFS:.pdf=.aux)
