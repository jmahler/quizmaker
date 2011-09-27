
all:

# If an error occured about images, make sure
# the img director can be found and link to
# it as needed.
image-example.pdf: image-example.test
	qzm-view_test image-example.test > image-example.tex
	rubber --pdf image-example.tex

clean:
	-rm -f *.log *.aux *.dvi *.pdf
