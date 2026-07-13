# Panduan untuk Claude Code — Template Buku Pedia

Repo ini adalah template buku standar UNESCO PT. Penerbit Buku Pedia versi LaTeX.
**README.md adalah sumber kebenaran** untuk seluruh spesifikasi format, keputusan
desain, dan alasannya — baca bagian "Spesifikasi Format" dan "Keputusan Desain"
sebelum mengubah apa pun yang berkaitan dengan tampilan.

## Arsitektur

- `bukupedia.cls` — SEMUA aturan format (ukuran 15,5x23 cm, margin 2/2/1,5/1,5 cm,
  Carlito 11pt spasi 1, gaya judul bab/section, tabel, caption, kode, glosarium,
  indeks, penomoran halaman). Naskah tidak boleh mengulang/menimpa aturan ini.
- `main.tex` — hanya metadata + isi naskah. Metadata: `\judul`, `\subjudul`,
  `\penulis`, `\penulisredaksi`, `\isbn`, `\editor`, `\penyunting`, `\desainsampul`,
  `\tahun` (bawaan: tahun kompilasi), `\logopenerbit` (bawaan: `images/image6.png`,
  dipakai halaman judul — berkas ini wajib ada; varian logo resmi lain di `logo/`).
- Perintah halaman dari kelas: `\coverdepan`, `\halamanjudul`, `\halamanredaksi`,
  `\daftarisi`, `\babtambahan{JUDUL}` (bab tak bernomor + entri TOC yang benar),
  `\daftarpustaka{reference}`, `\cetakindeks`, `\coverbelakang`. Jangan merakit
  `\chapter*` + `\addcontentsline` manual — pakai perintah-perintah ini.
- Lingkungan/perintah isi: `kodeprogram` (kode dalam kotak, tak terpotong halaman;
  bahasa bawaan Python, per blok bisa `[Java]` dll.), `isisubsek` (isi sub bab
  sejajar judulnya), `\glosletter`/`\glosentry` (glosarium; pemakaian `\glosletter`
  pertama otomatis tanpa garis pemisah), `\index{...}` (indeks), `\cite{kunci}`
  (sitasi dari `reference.bib`).
- Kelas memperingatkan metadata kosong/placeholder dan berkas cover/logo hilang;
  properti Title/Author/Subject PDF terisi otomatis dari metadata.
- Cover dimuat dari `cover/depan.pdf|png` dan `cover/belakang.pdf|png` (15,5x23 cm) —
  untuk ganti cover cukup timpa berkasnya, jangan menggambar cover di main.tex.

## Menulis naskah baru dari template ini

1. Ganti metadata di `main.tex`.
2. Ganti isi bab (`\chapter{...}` + `\section{...}` A-H sesuai struktur penerbit:
   Pendahuluan, Tujuan Instruksional, Uraian Materi, Latihan, Rangkuman, Pustaka).
3. Tambah referensi di `reference.bib`, sitasi dengan `\cite{...}` — daftar pustaka
   tersusun otomatis gaya APA, hanya memuat yang disitasi.
4. Timpa `cover/depan.pdf` dan `cover/belakang.pdf`.
5. Kode program: tampilkan potongan pendek dalam `kodeprogram` dengan penjelasan per
   baris; kode lengkap dirujuk ke repo GitHub (ketentuan penerbit — lihat README).

## Kelayakan ISBN

Naskah yang dibangun dari template ini pada akhirnya diajukan ISBN. Saat mereview
atau menyusun naskah, audit terhadap rubrik resmi
<https://naskah.bukupedia.co.id/llmreview/isbn/>: minimal 60 halaman isi (di luar
halaman romawi), untuk masyarakat luas, bukan modul/diktat internal (hindari judul
bagian TIU/TIK, "Uraian Materi", "Latihan" — pakai padanan bergaya buku umum),
bukan laporan penelitian mentah/tugas kuliah, tanpa placeholder tersisa.

## Kompilasi dan standar mutu

- Kompilasi: `latexmk -pdf main` (lintas OS, konfigurasi di `.latexmkrc`) atau `make`.
- **Log wajib bersih**: 0 error, 0 Overfull, 0 Underfull, 0 warning. Cek setelah
  setiap perubahan:
  ```
  grep -cE '^!' main.log ; grep -c 'Overfull' main.log ; grep -c 'Underfull' main.log
  grep -iE 'warning' main.log | grep -viE 'infwarerr|Package: '
  ```
  Jangan commit bila log kotor. CI menolak build yang tidak bersih.

## Jangan "memperbaiki" hal-hal ini (disengaja — detail di README)

- Font Carlito (bukan Calibri — tidak tersedia di TeX; Carlito kembaran metriknya).
- Tahun otomatis `\the\year` (ganti via `\tahun{...}` bila perlu tetap).
- Daftar isi & indeks dibuat otomatis (docx aslinya berisi entri dummy).
- Daftar pustaka hanya memuat pustaka yang disitasi; 4 entri contoh lain di
  `reference.bib` memang sengaja tidak disitasi.
- Jumlah halaman PDF ≠ docx (docx punya halaman kosong artefak Word).
- `xurl` dimuat setelah hyperref; `\LettrineTextFont` tegak; `bahasa.apc` lokal —
  semuanya penjaga log bersih.
