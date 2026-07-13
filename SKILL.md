---
name: template-bukupedia
description: Menyesuaikan naskah buku dengan template LaTeX standar UNESCO PT. Penerbit Buku Pedia — mengunduh kelas bukupedia.cls ke folder proyek penulis, menyusun main.tex dari naskah yang sudah ada, dan mengompilasinya sampai log bersih. Gunakan ketika penulis ingin memformat naskah bukunya sesuai template Bukupedia.
---

# Skill: Menyesuaikan Naskah dengan Template Buku Pedia

Instruksi ini untuk **Claude** yang bekerja di folder proyek seorang **penulis buku
Bukupedia**. Tugasmu: memformat naskah penulis (apapun bentuknya — .docx, .md, .txt,
.tex) menjadi buku LaTeX yang memenuhi template standar UNESCO PT. Penerbit Buku Pedia,
lalu mengompilasinya sampai bersih.

Sumber resmi:

* Repositori template: <https://github.com/bukped/template>
* Dokumentasi lengkap (spesifikasi format + keputusan desain): <https://universitas.bukupedia.co.id/template/>
* Rilis (PDF contoh + berkas): <https://github.com/bukped/template/releases>
* Kriteria kelayakan ISBN (rubrik review naskah): <https://naskah.bukupedia.co.id/llmreview/isbn/>

## Langkah 1 — Unduh berkas template ke folder proyek

> **Catatan (Claude Desktop / skill dari zip):** bila skill ini terpasang dari paket
> zip, berkas template (`bukupedia.cls`, `main.ist`, `latexmkrc`→`.latexmkrc`,
> `bahasa.apc`, `indonesian.apc`, `Makefile`, `contoh-main.tex`,
> `contoh-reference.bib`, `cover/`) **sudah tersedia di folder skill ini** — salin
> langsung ke folder proyek penulis, tidak perlu mengunduh.

Jalankan di root folder proyek penulis (jangan menimpa naskah mereka):

```bash
BASE=https://cdn.jsdelivr.net/gh/bukped/template@latest
# fallback bila CDN bermasalah: BASE=https://raw.githubusercontent.com/bukped/template/main
curl -fLO $BASE/bukupedia.cls
curl -fLO $BASE/main.ist
curl -fLO $BASE/bahasa.apc
curl -fLO $BASE/indonesian.apc
curl -fLO $BASE/.latexmkrc
curl -fLO $BASE/Makefile
curl -fL  -o contoh-main.tex $BASE/main.tex        # contoh naskah, sebagai acuan struktur
curl -fL  -o contoh-reference.bib $BASE/reference.bib
curl -fL --create-dirs -o cover/depan.pdf    $BASE/cover/depan.pdf
curl -fL --create-dirs -o cover/belakang.pdf $BASE/cover/belakang.pdf
curl -fL --create-dirs -o images/image6.png  $BASE/images/image6.png  # logo penerbit (dipakai \halamanjudul)
```

Logo penerbit `images/image6.png` **wajib ada** — halaman judul memuatnya. Bila ingin
memakai varian logo lain, aset resmi tersedia di folder
[`logo/`](https://github.com/bukped/template/tree/main/logo) repo template; atur
lokasinya dengan `\logopenerbit{path/berkas.png}` di preamble. Varian yang tersedia:
`logobukped.png` (utama), `logobukped-removebg-preview.png` (latar transparan),
`bukpedpanjang.png` (banner memanjang), `hitamputih.png` (monokrom), `putih.png`
(putih — untuk latar gelap seperti cover belakang).

Jika penulis belum punya TeX: install TinyTeX (panduan di
<https://universitas.bukupedia.co.id/latex/>) lalu
`tlmgr install carlito babel-indonesian geometry setspace booktabs enumitem listings xcolor colortbl pgf lettrine tocloft caption hyperref xurl apacite titlesec fontaxes psnfss cm-super makeindex bibtex latexmk`.

## Langkah 2 — Pahami aturannya (jangan dilanggar)

* `bukupedia.cls` memuat SEMUA aturan format (15,5 x 23 cm; margin 2/2/1,5/1,5 cm;
  Carlito 11pt spasi 1; gaya judul; tabel; dll.). **Jangan mengubah kelas dan jangan
  menimpa aturannya** dari naskah (tanpa `\usepackage{geometry}` ulang, tanpa
  `\titleformat` sendiri, dst.).
* Keputusan desain yang disengaja (font Carlito bukan Calibri, tahun otomatis, daftar
  isi & indeks otomatis, dll.) terdokumentasi di README repo — jangan "diperbaiki".

## Langkah 3 — Susun main.tex dari naskah penulis

Buat `main.tex` baru mengikuti kerangka `contoh-main.tex`:

1. **Metadata**: `\judul{...}`, `\subjudul{...}`, `\penulis{Nama Satu\\ Nama Dua}`,
   `\isbn{}` (kosong dulu), `\editor{...}`, `\penyunting{...}`, `\desainsampul{...}`.
   Nama penulis **tanpa gelar dan tanpa tanda baca**; judul tanpa tanda baca.
2. **Halaman wajib berurutan**: `\coverdepan`, `\halamanjudul`, `\halamanredaksi`,
   `\frontmatter`, `\babtambahan{PRAKATA}`, `\daftarisi`, `\mainmatter`, bab-bab isi,
   `\backmatter`, `\daftarpustaka{reference}`, `\babtambahan{GLOSARIUM}`,
   `\babtambahan{KREDIT GAMBAR}`, `\cetakindeks`, `\babtambahan{TENTANG PENULIS}`,
   `\coverbelakang`. (Jangan merakit `\chapter*` + `\addcontentsline` manual —
   perintah kelas di atas sudah mengurus entri daftar isinya dengan benar.)
3. **Prakata**: dibuka data faktual/statistik terpercaya; memuat tujuan penulisan,
   pembaca sasaran, keunggulan buku, cara membaca; sertakan link repo GitHub kode
   program. **Dilarang**: tempat/tanggal/nama penulis di akhir, ucapan terima kasih,
   persembahan. Paragraf pertama boleh drop cap:
   `\lettrine[lines=3, findent=2pt, nindent=0pt]{H}{uruf}...`
4. **Struktur bab**: tiap `\chapter` berisi `\section` (otomatis berhuruf A., B.,
   C. ...). Hindari judul bagian bergaya modul/diktat (mis. "Tujuan Instruksional",
   "TIU/TIK", "Uraian Materi", "Latihan") — rubrik kelayakan ISBN menolak naskah yang
   terbaca sebagai diktat internal. Gunakan padanan bergaya buku umum: "Apa yang Akan
   Anda Pelajari", langsung judul topik per section, "Refleksi dan Penerapan",
   "Intisari Bab", "Sumber dan Bacaan Lanjutan".
5. **Kode program**: hanya potongan pendek di lingkungan `kodeprogram`, dijelaskan per
   baris/fungsi; kode lengkap dirujuk ke repo GitHub penulis (yang nanti ditransfer ke
   organisasi `bukped`). Kode tidak boleh memakan setengah-satu halaman penuh.
6. **Referensi**: pindahkan semua pustaka penulis ke `reference.bib` (format BibTeX),
   sitasi di naskah dengan `\cite{kunci}` — daftar pustaka tersusun otomatis gaya APA.
7. **Istilah penting** diberi `\index{Istilah}` agar indeks terisi — **konsisten
   kapitalisasinya** agar entri tidak terpecah; glosarium dengan `\glosletter{A}` /
   `\glosentry{Istilah}{Definisi}` (pemakaian `\glosletter` pertama otomatis tanpa
   garis pemisah).
8. **Gambar**: `figure` biasa dengan `\caption` (caption otomatis 8pt, "Gambar 1.1"
   di bawah gambar). Gambar bukan karya penulis wajib dicatat di halaman KREDIT GAMBAR.
9. **Cover**: minta desain penulis berukuran **15,5 x 23 cm**, timpa `cover/depan.pdf`
   dan `cover/belakang.pdf` (boleh `.png` — hapus `.pdf`-nya).

## Langkah 4 — Kompilasi sampai bersih

```bash
latexmk -pdf main    # atau: make
```

**Standar mutu (wajib)** — log `main.log` harus:

```bash
grep -cE '^!' main.log            # 0 error
grep -c 'Overfull' main.log       # 0
grep -c 'Underfull' main.log      # 0
grep -iE 'warning' main.log | grep -viE 'infwarerr|Package: '  # kosong
```

Bila ada pelanggaran, perbaiki naskah (bukan kelasnya) dan kompilasi ulang.

## Langkah 5 — Verifikasi akhir

* `pdfinfo main.pdf` → ukuran halaman harus 439.37 x 651.97 pts (= 15,5 x 23 cm).
* Penomoran: cover/judul/redaksi tanpa nomor; prakata mulai romawi `i`; BAB 1 mulai `1`.
* Nama & urutan penulis konsisten di cover, halaman judul, dan halaman redaksi.
* **Kelayakan ISBN**: audit naskah terhadap rubrik
  <https://naskah.bukupedia.co.id/llmreview/isbn/> — minimal **60 halaman isi**
  (di luar halaman romawi), ditujukan untuk masyarakat luas, bukan modul/diktat
  internal, bukan laporan penelitian mentah atau tugas kuliah, dan tidak ada
  placeholder tersisa (biografi, sinopsis cover belakang, dsb.).
