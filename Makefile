.PHONY: all cover skill clean

all: main.pdf

main.pdf: main.tex bukupedia.cls reference.bib main.ist
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

# Paket skill untuk pengguna Claude Desktop/claude.ai:
# zip berisi folder template-bukupedia/ (SKILL.md + berkas inti
# template) yang tinggal diunggah di Settings -> Capabilities ->
# Skills. Jalankan ulang target ini setiap SKILL.md/kelas berubah.
skill:
	rm -rf template-bukupedia template-bukupedia-skill.zip
	mkdir -p template-bukupedia/cover template-bukupedia/images
	cp SKILL.md bukupedia.cls main.ist bahasa.apc indonesian.apc \
	   Makefile template-bukupedia/
	cp .latexmkrc template-bukupedia/latexmkrc
	cp main.tex template-bukupedia/contoh-main.tex
	cp reference.bib template-bukupedia/contoh-reference.bib
	cp cover/depan.pdf cover/belakang.pdf template-bukupedia/cover/
	cp images/image6.png template-bukupedia/images/
	zip -qr template-bukupedia-skill.zip template-bukupedia
	rm -rf template-bukupedia

clean:
	rm -f main.aux main.log main.toc main.lof main.lot main.out \
	      main.bbl main.blg main.idx main.ilg main.ind main.pdf \
	      cover/desain.aux cover/desain.log cover/desain.pdf
