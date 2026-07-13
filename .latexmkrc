# Konfigurasi latexmk — kompilasi lintas-OS satu perintah:
#   latexmk -pdf main
# Otomatis menjalankan pdflatex + bibtex + makeindex (dengan gaya
# indeks main.ist) sebanyak yang diperlukan.
$pdf_mode = 1;
$bibtex_use = 2;
$makeindex = 'makeindex -s main.ist %O -o %D %S';
