.PHONY: all cover clean

all: main.pdf

main.pdf: main.tex reference.bib main.ist
	pdflatex -interaction=nonstopmode main
	bibtex main
	makeindex -s main.ist main
	pdflatex -interaction=nonstopmode main
	pdflatex -interaction=nonstopmode main

# Regenerasi cover bawaan (cover/depan.pdf & cover/belakang.pdf)
# dari sumber desain tikz di cover/desain.tex.
# Untuk cover kustom, cukup timpa cover/depan.pdf|png dan
# cover/belakang.pdf|png tanpa perlu target ini.
cover: cover/desain.tex
	cd cover && pdflatex -interaction=nonstopmode desain
	cd cover && pdflatex -interaction=nonstopmode desain
	cd cover && pdfseparate desain.pdf halaman-%d.pdf \
	  && mv halaman-1.pdf depan.pdf \
	  && mv halaman-2.pdf belakang.pdf \
	  && rm -f desain.aux desain.log desain.pdf

clean:
	rm -f main.aux main.log main.toc main.lof main.lot main.out \
	      main.bbl main.blg main.idx main.ilg main.ind main.pdf \
	      cover/desain.aux cover/desain.log cover/desain.pdf
