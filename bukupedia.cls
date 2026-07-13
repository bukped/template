% ============================================================
% bukupedia.cls
% Kelas dokumen buku standar UNESCO - PT. Penerbit Buku Pedia
%
% Pemakaian minimal (lihat main.tex untuk contoh lengkap):
%
%   \documentclass{bukupedia}
%   \judul{JUDUL BUKU}
%   \subjudul{Sub Judul Buku}
%   \penulis{Penulis Satu\\ Penulis Dua}
%   \begin{document}
%   \coverdepan
%   \halamanjudul
%   \halamanredaksi
%   \frontmatter
%   ... prakata, \tableofcontents ...
%   \mainmatter
%   ... isi bab ...
%   \daftarpustaka{reference}
%   \backmatter
%   ... glosarium, indeks, dst ...
%   \coverbelakang
%   \end{document}
%
% Spesifikasi yang sudah diatur kelas ini:
%   - Ukuran buku 15,5 x 23 cm (standar UNESCO)
%   - Margin atas-bawah 2 cm, kiri-kanan 1,5 cm, gutter 0 cm
%   - Font Carlito 11pt (kembaran metrik Calibri), spasi 1
%   - Judul bab 24pt kanan bergaris; section A. 12pt; dst.
%   - Referensi BibTeX gaya APA (apacite)
% ============================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bukupedia}[2026/07/13 v1.0 Template buku UNESCO PT. Penerbit Buku Pedia]

% Opsi lain diteruskan ke kelas book
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[11pt,oneside]{book}

% ---------- Ukuran kertas dan margin ----------
\RequirePackage[paperwidth=15.5cm, paperheight=23cm,
            top=2cm, bottom=2cm,
            left=1.5cm, right=1.5cm,
            bindingoffset=0cm]{geometry}

% ---------- Font Carlito (pengganti Calibri) ----------
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[sfdefault,lf]{carlito}

% ---------- Bahasa ----------
\RequirePackage[bahasa]{babel}

% ---------- Spasi 1 ----------
\RequirePackage{setspace}
\singlespacing

% ---------- Paket umum ----------
\RequirePackage{graphicx}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{enumitem}
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{colortbl} % shading sel/baris tabel
\definecolor{kepalatabel}{gray}{0.92} % abu muda header tabel (seperti docx)
% Isi sel tabel rata tengah vertikal (bukan rata atas), seperti docx
\renewcommand\tabularxcolumn[1]{m{#1}}
% Garis tabel sedikit lebih tebal agar border (termasuk garis atas
% header yang berimpit dengan shading) terlihat jelas
\setlength{\arrayrulewidth}{0.6pt}
\RequirePackage{tikz}
\RequirePackage{lettrine} % drop cap pada paragraf pembuka prakata
% Teks setelah huruf drop cap dibiarkan tegak biasa (bawaan lettrine
% adalah small caps yang tidak dimiliki Carlito dan memicu warning font)
\renewcommand{\LettrineTextFont}{\upshape}
\RequirePackage{indentfirst} % paragraf pertama setelah judul ikut menjorok
\RequirePackage{makeidx}
\RequirePackage[titles]{tocloft}
\RequirePackage{caption}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{xurl} % dimuat setelah hyperref: \url boleh patah baris di titik mana pun
\setlength{\Urlmuskip}{0mu plus 1mu} % beri kelenturan antar karakter URL
\renewcommand\UrlBreakPenalty{100}   % izinkan patah URL dengan penalti rendah
\renewcommand\UrlBigBreakPenalty{100}
\emergencystretch=1.5em % cadangan kelenturan agar baris tidak melebihi margin
% Hanya laporkan boks yang benar-benar buruk; baris agak renggang
% (badness kecil) tidak perlu memenuhi log
\hbadness=3000
\vbadness=3000

% ---------- Format caption (mengikuti docx: 8pt, tengah) ----------
% Tabel: "Tabel 1.1. ..." (titik) di atas tabel.
% Gambar: "Gambar 1.1 ..." (spasi) di bawah gambar.
\DeclareCaptionFont{delapan}{\fontsize{8}{10}\selectfont}
\captionsetup{font=delapan, justification=centering, skip=3pt}
\captionsetup[table]{labelsep=period}
\captionsetup[figure]{labelsep=space}
% Di docx tabel/gambar menyatu rapat dengan teks di sekitarnya;
% jarak float dirapatkan agar serupa
\setlength{\intextsep}{4pt}
\setlength{\textfloatsep}{8pt}

% ---------- Format daftar isi (mengikuti docx) ----------
% Tanpa titik-titik penghubung, nomor halaman rata kanan,
% entri bab berawalan "BAB ", kedalaman sampai section (A-H).
\setcounter{tocdepth}{1}
\renewcommand{\cftdotsep}{\cftnodots}
\renewcommand{\cftchappresnum}{BAB }
\setlength{\cftchapnumwidth}{3.4em}
\renewcommand{\cftsecaftersnum}{.}

% ---------- Referensi APA dengan BibTeX ----------
\RequirePackage{apacite}

% ---------- Indeks ----------
\makeindex

% ---------- Penomoran section gaya A. B. C. ----------
\renewcommand{\thesection}{\Alph{section}}
\renewcommand{\thesubsection}{\alph{subsection})}

% ---------- Format judul bab dan section (mengikuti docx) ----------
% Bab bernomor : "BAB 1" + judul, 24pt bold, rata kanan,
%                dengan garis horizontal di bawahnya.
% Bab tak bernomor (PRAKATA dll.): 16pt bold, tengah.
% Section      : 12pt bold, "A. JUDUL SECTION".
\RequirePackage{titlesec}
\definecolor{garisbab}{RGB}{155,194,230}
\titleformat{\chapter}[display]
  {\raggedleft\bfseries}
  {\fontsize{24}{29}\selectfont BAB \thechapter}
  {6pt}
  {\fontsize{24}{29}\selectfont\MakeUppercase}
  [{\color{garisbab}\titlerule[1.2pt]}]
\titleformat{name=\chapter, numberless}[display]
  {\centering\bfseries}
  {}
  {0pt}
  {\fontsize{16}{19}\selectfont\MakeUppercase}
\titlespacing*{\chapter}{0pt}{-20pt}{20pt}
\titleformat{\section}
  {\bfseries\fontsize{12}{14}\selectfont}
  {\thesection.}{0.5em}{\MakeUppercase}
% Jarak judul section: renggang secukupnya dari teks sebelumnya,
% tipis ke konten di bawahnya (seperti docx)
\titlespacing*{\section}{0pt}{8pt}{2pt}
% Sub section "a) ..." : tidak bold, menjorok sejajar indentasi
% paragraf. Label diberi lebar tetap 1.5em supaya teks judul dan
% isi di bawahnya (lingkungan isisubsek) mulai di posisi x yang
% sama persis.
\titleformat{\subsection}
  {\fontsize{11}{13}\selectfont}
  {\makebox[1.5em][l]{\thesubsection}}{0em}{}
\titlespacing*{\subsection}{\parindent}{6pt}{3pt}
% Isi sub section: blok menjorok sejajar teks judul sub section
\newenvironment{isisubsek}
  {\list{}{\setlength{\leftmargin}{\dimexpr\parindent+1.5em\relax}%
           \setlength{\rightmargin}{0pt}}\item\relax}
  {\endlist}

% ---------- Format kode program ----------
% Kode program disajikan dalam kotak berbingkai tipis dengan
% latar abu muda agar batasnya jelas dan proporsional, memakai
% huruf monospace agar indentasi kode terjaga.
\lstset{
  language=Python,
  basicstyle=\ttfamily\small,
  showstringspaces=false,
  breaklines=true,
  frame=single,
  framerule=0.4pt,
  rulecolor=\color{black!60},
  backgroundcolor=\color{black!4},
  xleftmargin=3pt,
  xrightmargin=3pt,
  aboveskip=1em,
  belowskip=1em
}
% Lingkungan kode yang tidak terpotong pindah halaman
\lstnewenvironment{kodeprogram}
  {\noindent\minipage{\linewidth}}
  {\endminipage}

% ---------- Entri glosarium ----------
% \glosletterfirst{A} untuk huruf pertama, \glosletter{B} dst.
% (dengan garis pemisah), \glosentry{istilah}{definisi}.
\newcommand{\glosentry}[2]{\noindent #1: #2\par\medskip}
\newcommand{\glosletterfirst}[1]{\noindent #1\par\medskip}
\newcommand{\glosletter}[1]{\par\smallskip\noindent\rule{\textwidth}{0.4pt}\par\medskip\noindent #1\par\medskip}

% ============================================================
% METADATA BUKU
% Diisi di preamble dokumen dengan perintah-perintah berikut.
% ============================================================
\newcommand{\bkp@judul}{JUDUL BUKU}
\newcommand{\bkp@subjudul}{}
\newcommand{\bkp@penulis}{Nama Penulis}
\newcommand{\bkp@penulisredaksi}{\bkp@penulis}
\newcommand{\bkp@isbn}{}
\newcommand{\bkp@editor}{}
\newcommand{\bkp@penyunting}{}
\newcommand{\bkp@desainsampul}{}
\newcommand{\bkp@fontbuku}{Calibri}
\newcommand{\bkp@penerbit}{PT. Penerbit Buku Pedia}
\newcommand{\bkp@alamatredaksi}{Athena Residence Blok. E No. 1, Desa Ciwaruga,\\
Kec. Parongpong, Kab. Bandung Barat 40559\\
Tel. 628-775-2000-300\\
Email : penerbit@bukupedia.co.id}
\newcommand{\bkp@distributor}{Informatics Research Center\\
Jl. Sariasih No. 54\\
Bandung 40151\\
Email : irc@ulbi.ac.id}

\newcommand{\judul}[1]{\renewcommand{\bkp@judul}{#1}}
\newcommand{\subjudul}[1]{\renewcommand{\bkp@subjudul}{#1}}
% Nama penulis pada halaman judul (pisahkan dengan \\)
\newcommand{\penulis}[1]{\renewcommand{\bkp@penulis}{#1}}
% Urutan penulis di halaman redaksi bila berbeda dari halaman judul
\newcommand{\penulisredaksi}[1]{\renewcommand{\bkp@penulisredaksi}{#1}}
\newcommand{\isbn}[1]{\renewcommand{\bkp@isbn}{#1}}
\newcommand{\editor}[1]{\renewcommand{\bkp@editor}{#1}}
\newcommand{\penyunting}[1]{\renewcommand{\bkp@penyunting}{#1}}
\newcommand{\desainsampul}[1]{\renewcommand{\bkp@desainsampul}{#1}}
\newcommand{\fontbuku}[1]{\renewcommand{\bkp@fontbuku}{#1}}
\newcommand{\penerbit}[1]{\renewcommand{\bkp@penerbit}{#1}}
\newcommand{\alamatredaksi}[1]{\renewcommand{\bkp@alamatredaksi}{#1}}
\newcommand{\distributor}[1]{\renewcommand{\bkp@distributor}{#1}}
% Tahun terbit: otomatis mengikuti tahun saat kompilasi.
% Ganti dengan \tahun{2023} bila perlu tahun tetap.
\newcommand{\tahunterbit}{\the\year}
\newcommand{\tahun}[1]{\renewcommand{\tahunterbit}{#1}}
% Kompatibilitas: \judulbuku dan \subjudulbuku tetap tersedia
\newcommand{\judulbuku}{\bkp@judul}
\newcommand{\subjudulbuku}{\bkp@subjudul}

\definecolor{penerbitblue}{RGB}{31,78,121}

% Nomor halaman di bawah-tengah, tanpa running header (sesuai docx)
\AtBeginDocument{\pagestyle{plain}}

% ============================================================
% \coverdepan / \coverbelakang
% Memuat berkas gambar cover/depan dan cover/belakang
% (pdf/png/jpg, ditulis tanpa ekstensi agar fleksibel).
% Ganti cover cukup dengan menimpa berkas tersebut dengan
% desain berukuran 15,5 x 23 cm. Desain bawaan bersumber dari
% cover/desain.tex (regenerasi: "make cover").
% Halaman cover tidak diberi nomor dan tidak ikut penomoran
% (penomoran "Alph" tersembunyi agar tidak bentrok dg hyperref).
% ============================================================
\newcommand{\coverdepan}{%
  \pagenumbering{Alph}%
  \thispagestyle{empty}%
  \begin{tikzpicture}[remember picture, overlay]
    \node[inner sep=0pt] at (current page.center)
      {\includegraphics[width=\paperwidth, height=\paperheight]{cover/depan}};
  \end{tikzpicture}%
  \clearpage}

\newcommand{\coverbelakang}{%
  \clearpage
  \thispagestyle{empty}%
  \begin{tikzpicture}[remember picture, overlay]
    \node[inner sep=0pt] at (current page.center)
      {\includegraphics[width=\paperwidth, height=\paperheight]{cover/belakang}};
  \end{tikzpicture}}

% ============================================================
% \halamanjudul
% Halaman judul: judul 22pt bold melekat margin atas, sub judul
% 12pt, nama penulis 16pt bold, logo + nama penerbit (biru) di
% bagian bawah. Tanpa nomor halaman, tanpa logo di atas.
% ============================================================
\newcommand{\halamanjudul}{%
  \thispagestyle{empty}%
  {\centering
    {\fontsize{22}{26}\selectfont\bfseries \bkp@judul\par}
    \vspace{0.5em}
    {\fontsize{12}{15}\selectfont \bkp@subjudul\par}
    \vspace{5cm}
    {\fontsize{16}{19}\selectfont\bfseries \bkp@penulis\par}
    \vfill
    \begin{tabular}{@{}c@{\hspace{1em}}l@{}}
      \raisebox{-0.45\height}{\includegraphics[width=5cm]{images/image6.png}} &
      \begin{tabular}[c]{@{}l@{}}
        \textcolor{penerbitblue}{\fontsize{10}{12}\selectfont\bfseries \bkp@penerbit}\\[2pt]
        \textcolor{penerbitblue}{\fontsize{10}{12}\selectfont\bfseries \tahunterbit}
      \end{tabular}
    \end{tabular}\par
  }%
  \clearpage}

% ============================================================
% \halamanredaksi
% Halaman redaksi: judul 16pt/sub judul 10pt melekat di atas,
% info redaksi 8pt spasi 1 melekat di bawah. Tanpa nomor halaman.
% Baris kosong di bawah ISBN diisi lewat \isbn{...} begitu
% nomor ISBN terbit.
% ============================================================
\newcommand{\halamanredaksi}{%
  \thispagestyle{empty}%
  \noindent{\fontsize{16}{19}\selectfont\bfseries \bkp@judul}\\[2pt]
  {\fontsize{10}{12}\selectfont \bkp@subjudul}

  \vfill

  {\fontsize{8}{10}\selectfont % Calibri (Carlito) 8pt, spasi 1

  \noindent\textbf{\textit{Penulis:}}\\
  \bkp@penulisredaksi

  \bigskip
  \noindent\textbf{\textit{ISBN}}:\\
  \bkp@isbn\mbox{}

  \bigskip
  \noindent\textbf{\textit{Editor:}}\\
  \bkp@editor

  \bigskip
  \noindent\textbf{\textit{Penyunting:}}\\
  \bkp@penyunting

  \bigskip
  \noindent\textbf{\textit{Desain sampul dan Tata letak:}}\\
  \bkp@desainsampul

  \bigskip
  \noindent\textbf{\textit{Font:}}\\
  \bkp@fontbuku

  \bigskip
  \noindent\textbf{\textit{Penerbit:}}\\
  \bkp@penerbit

  \bigskip
  \noindent\textbf{\textit{Redaksi:}}\\
  \bkp@alamatredaksi

  \bigskip
  \noindent\textbf{\textit{Distributor:}}\\
  \bkp@distributor

  \bigskip
  \noindent Cetakan Pertama, \tahunterbit\\
  Hak cipta dilindungi undang-undang\\
  Dilarang memperbanyak karya tulis ini dalam bentuk dan\\
  dengan cara apa pun tanpa ijin tertulis dari penerbit\par
  }%
  \clearpage}

% ============================================================
% \daftarpustaka{berkas-bib}
% Mencetak DAFTAR PUSTAKA gaya APA dari berkas .bib
% ============================================================
\newcommand{\daftarpustaka}[1]{%
  \renewcommand{\bibname}{DAFTAR PUSTAKA}%
  \bibliographystyle{apacite}%
  \bibliography{#1}}

\endinput
