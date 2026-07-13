.PHONY: all clean

all: main.pdf

main.pdf: main.tex reference.bib main.ist
	pdflatex -interaction=nonstopmode main
	bibtex main
	makeindex -s main.ist main
	pdflatex -interaction=nonstopmode main
	pdflatex -interaction=nonstopmode main

clean:
	rm -f main.aux main.log main.toc main.lof main.lot main.out \
	      main.bbl main.blg main.idx main.ilg main.ind main.pdf
