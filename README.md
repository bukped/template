# Template Buku Pedia (LaTeX)

Template buku standar UNESCO **PT. Penerbit Buku Pedia**. Seluruh aturan format
dikemas dalam kelas dokumen [`bukupedia.cls`](./bukupedia.cls) — penulis cukup mengisi
metadata dan naskah di [`main.tex`](./main.tex). Hasil jadi: [main.pdf](./main.pdf).

* Repositori: <https://github.com/bukped/template>
* Dokumentasi (GitHub Pages): <https://universitas.bukupedia.co.id/template/>
* Rilis + PDF terbangun otomatis: <https://github.com/bukped/template/releases>
* Kelas dokumen via CDN: <https://cdn.jsdelivr.net/gh/bukped/template@latest/bukupedia.cls>

## Penulis memakai Claude/AI? Tempelkan SKILL.md

Penulis yang memakai **Claude Code** (atau asisten AI lain) cukup menempelkan URL ini
ke sesinya, lalu meminta "sesuaikan naskah saya dengan template ini":

```
https://universitas.bukupedia.co.id/template/SKILL
```

(Alternatif markdown mentah: `https://raw.githubusercontent.com/bukped/template/main/SKILL.md`)

[SKILL.md](./SKILL.md) berisi instruksi lengkap yang bisa dieksekusi AI: mengunduh
kelas `bukupedia.cls` ke folder proyek penulis, menyusun `main.tex` dari naskah yang
sudah ada (struktur bab, prakata, referensi BibTeX, indeks, glosarium, cover), sampai
kompilasi dengan log bersih.

**Pengguna Claude Desktop / claude.ai** memasang skill lewat unggahan zip:

1. Unduh paket skill: <https://universitas.bukupedia.co.id/template/template-bukupedia-skill.zip>
2. Buka **Settings → Capabilities → Skills → Upload skill**, pilih zip tersebut.
3. Di percakapan, minta: *"pakai skill template-bukupedia, sesuaikan naskah saya"*.

Zip berisi `SKILL.md` beserta berkas inti template (`bukupedia.cls`, contoh naskah,
cover bawaan, dll.) sehingga Claude punya salinan lokal tanpa perlu mengunduh.
Regenerasi paket: `make skill`.

Versi LaTeX ini adalah konversi setia dari template asli penerbit
([TEMPLATEUNESCOBUKUPEDIA.docx](./TEMPLATEUNESCOBUKUPEDIA.docx)): setiap halaman sudah
diverifikasi berdampingan dengan render docx, dan ukuran font diambil langsung dari XML
di dalam docx. Bagian [Spesifikasi Format](#spesifikasi-format) mendokumentasikan
semuanya — tidak perlu membongkar ulang docx.

---

## Mulai Cepat

```latex
\documentclass{bukupedia}

% ---------- Metadata buku ----------
\judul{JUDUL BUKU}
\subjudul{Sub Judul Buku}
\penulis{Penulis Satu\\ Penulis Dua}        % urutan pada halaman judul
\penulisredaksi{Penulis Dua\\ Penulis Satu} % opsional, bila urutan di redaksi berbeda
\isbn{}                  % diisi begitu nomor ISBN terbit
\editor{Nama Editor}
\penyunting{Nama Penyunting}
\desainsampul{Nama Desainer}
% \tahun{2023}           % bawaan: tahun saat kompilasi
% \penerbit{...} \alamatredaksi{...} \distributor{...} % sudah ber-default Bukupedia

\begin{document}
\coverdepan              % dari berkas cover/depan.pdf|png
\halamanjudul            % dibangun otomatis dari metadata
\halamanredaksi          % dibangun otomatis dari metadata

\frontmatter
\babtambahan{PRAKATA}    % bab tak bernomor + entri daftar isi yang benar
% paragraf pembuka pakai drop cap:
% \lettrine[lines=3, findent=2pt, nindent=0pt]{M}{embuat} ...
\daftarisi               % daftar isi + entri TOC di halaman awalnya

\mainmatter
\chapter{JUDUL BAB}
\section{Pendahuluan}
% ... sitasi dengan \cite{kunci} dari reference.bib ...

\backmatter
\daftarpustaka{reference}   % DAFTAR PUSTAKA gaya APA dari reference.bib
\babtambahan{GLOSARIUM}
% ... \glosletter{A}, \glosentry{Istilah}{Definisi} ...
\babtambahan{KREDIT GAMBAR}
\cetakindeks             % INDEKS + entri TOC di halaman awalnya
\babtambahan{TENTANG PENULIS}
\coverbelakang           % dari berkas cover/belakang.pdf|png
\end{document}
```

Perintah lain dari kelas: lingkungan `kodeprogram` (kotak kode yang tidak terpotong
halaman; bahasa bawaan Python, ganti per blok dengan `\begin{kodeprogram}[Java]`),
`isisubsek` (isi sub bab sejajar judulnya), dan
`\glosletter{A}` / `\glosentry{Istilah}{Definisi}` untuk glosarium (pemakaian
`\glosletter` pertama otomatis tanpa garis pemisah; `\glosletterfirst` lama tetap
dikenali).

Kemudahan bawaan kelas: metadata penting yang masih kosong/placeholder dan berkas
cover/logo yang hilang dilaporkan sebagai peringatan/error dengan pesan yang jelas,
dan properti Title/Author/Subject pada PDF terisi otomatis dari metadata buku.

---

## Kelayakan ISBN

Sebelum naskah diajukan, audit terhadap rubrik resmi:
<https://naskah.bukupedia.co.id/llmreview/isbn/>. Ringkasnya: minimal **60 halaman
isi** (di luar halaman romawi), ditujukan bagi masyarakat luas, bukan modul/diktat
internal maupun laporan penelitian mentah/tugas kuliah — hindari judul bagian
bergaya modul (TIU/TIK, "Uraian Materi", "Latihan"); gunakan padanan bergaya buku
umum. Pastikan juga tidak ada placeholder tersisa (biografi penulis, sinopsis
cover belakang, dsb.).

---

## Instalasi LaTeX (TinyTeX)

Mengikuti panduan resmi: <https://universitas.bukupedia.co.id/latex/>.
TinyTeX ringan dan berjalan di **Windows, macOS, dan Linux**.

1. **Install R** dari <https://cran.r-project.org/> (TinyTeX dipasang lewat R).
2. **Install TinyTeX** — jalankan di R Console:

   ```r
   install.packages('tinytex')
   tinytex::install_tinytex()
   ```

3. **Verifikasi:**

   ```r
   tinytex::tinytex_root()
   tinytex::tlmgr("--version")
   ```

4. **Install paket yang dibutuhkan template ini** — jalankan di terminal
   (Command Prompt/PowerShell/Terminal):

   ```
   tlmgr install carlito babel-indonesian geometry setspace booktabs enumitem listings xcolor colortbl pgf lettrine tocloft caption hyperref xurl apacite titlesec fontaxes psnfss cm-super makeindex bibtex latexmk
   ```

Alternatif tanpa R: install **TeX Live** penuh (Linux/macOS) atau **MiKTeX**
(Windows, paket terunduh otomatis saat kompilasi pertama).

Editor yang disarankan panduan: Antigravity/VS Code dengan ekstensi *vscode-pdf*
(atau LaTeX Workshop).

---

## Kompilasi (semua OS)

**Cara termudah — `latexmk`** (Windows/macOS/Linux, konfigurasi sudah disediakan di
[`.latexmkrc`](./.latexmkrc)):

```
latexmk -pdf main
```

Satu perintah itu otomatis menjalankan pdflatex + bibtex + makeindex (dengan gaya
indeks `main.ist`) sebanyak yang diperlukan, menghasilkan `main.pdf`.

**Manual** (bila tidak ada latexmk; jalan di Command Prompt/PowerShell/Terminal):

```
pdflatex main
bibtex main
makeindex -s main.ist main
pdflatex main
pdflatex main
```

**Dengan make** (Linux/macOS): `make` untuk kompilasi, `make clean` untuk bersih-bersih,
`make cover` untuk regenerasi desain cover bawaan (butuh `pdfseparate` dari
poppler-utils; di Windows cukup timpa langsung berkas cover — lihat di bawah).

### Standar kualitas kompilasi

Log kompilasi (`main.log`) **wajib bersih**: 0 error, 0 overfull, 0 underfull, dan
0 warning. Standar ini dijaga otomatis oleh CI (lihat bawah) dan bisa dicek lokal:

```bash
grep -cE '^!' main.log            # harus 0 (error)
grep -c 'Overfull' main.log       # harus 0
grep -c 'Underfull' main.log      # harus 0
grep -iE 'warning' main.log | grep -viE 'infwarerr|Package: '  # harus kosong
```

Penunjang kebersihan log yang sudah terpasang di kelas: `xurl` + `\emergencystretch`
(URL/baris tidak melebihi margin), `\hbadness`/`\vbadness` 3000 (baris agak renggang
yang tak kasat mata tidak dilaporkan), `\LettrineTextFont` tegak (Carlito tidak punya
small caps), dan `bahasa.apc` lokal (apacite tidak menyertakan definisi bahasa
Indonesia).

### Rilis otomatis, git tag, dan CDN jsDelivr

Setiap push ke `main`, GitHub Actions ([`.github/workflows/release.yml`](./.github/workflows/release.yml)):

1. mengompilasi PDF di container TeX Live,
2. menegakkan standar kualitas di atas (build **gagal** bila log tidak bersih),
3. membuat git tag `v<versi-kelas>.<n>` dan **GitHub Release** berisi `main.pdf`,
   `bukupedia.cls`, dan `template-bukupedia-skill.zip`, lengkap dengan tautan CDN
   jsDelivr yang terpaku pada versi tersebut.

**Versi diambil otomatis** dari baris `\ProvidesClass` di `bukupedia.cls`
(mis. `v1.1` → tag `v1.1.12`). Menaikkan versi template = mengubah angka versi
di baris itu saja; workflow tidak perlu disentuh.

Berkas rilis bisa diambil via jsDelivr tanpa clone:

```
https://cdn.jsdelivr.net/gh/bukped/template@latest/bukupedia.cls    (rilis terbaru)
https://cdn.jsdelivr.net/gh/bukped/template@v1.1.12/bukupedia.cls   (terpaku versi)
https://cdn.jsdelivr.net/gh/bukped/template@latest/main.pdf
```

---

## Struktur Berkas

| Berkas/Folder | Isi |
|---|---|
| `bukupedia.cls` | Kelas dokumen: **seluruh aturan format** template |
| `main.tex` | Naskah contoh: metadata buku + isi |
| `reference.bib` | Daftar pustaka terpisah (BibTeX); sitasi dengan `\cite{kunci}` |
| `main.ist` | Gaya makeindex (kepala huruf bold, nomor halaman tanpa koma) |
| `bahasa.apc` | Definisi bahasa apacite untuk babel `bahasa` (menghilangkan warning) |
| `.latexmkrc` | Konfigurasi latexmk (kompilasi satu perintah, lintas OS) |
| `Makefile` | Alur kompilasi untuk pengguna make |
| `.github/workflows/release.yml` | CI: build + quality gate + auto tag & release |
| `cover/` | `depan.pdf` + `belakang.pdf` (cover), `desain.tex` (sumber desain bawaan) |
| `images/` | Gambar naskah contoh; `image6.png` = logo penerbit yang dipakai halaman judul (**wajib ada**, path bisa diganti via `\logopenerbit{...}`) |
| `logo/` | Aset logo resmi Bukupedia untuk cover/halaman judul atau kebutuhan lain, dipakai via `\logopenerbit{logo/berkas.png}`: `logobukped.png` (utama), `logobukped-removebg-preview.png` (utama, latar transparan), `bukpedpanjang.png`/`bukpedpanjangweb.png` (banner memanjang), `hitamputih.png` (monokrom), `putih.png` (putih — untuk latar gelap, mis. cover belakang), `dobelitem.png`, `favicon*` (ikon web, bukan untuk cetak) |

## Mengganti Cover

Cover **tidak** digambar di `main.tex` — dimuat dari berkas gambar (tanpa ekstensi,
menerima `.pdf`/`.png`/`.jpg`). Cukup timpa dengan desain berukuran **15,5 x 23 cm**:

* `cover/depan.pdf` (atau hapus lalu taruh `depan.png`)
* `cover/belakang.pdf` (atau `belakang.png`)

Desain bawaan bersumber dari `cover/desain.tex`; regenerasi dengan `make cover`
(kompilasi 2x pass — wajib, karena `remember picture` — lalu halaman 1 menjadi
`depan.pdf` dan halaman 2 menjadi `belakang.pdf`).

---

## Spesifikasi Format

Semua sudah diimplementasikan di `bukupedia.cls`. Angka bersumber dari XML docx asli.

### Kertas, margin, font

| Pengaturan | Nilai |
|---|---|
| Ukuran kertas (UNESCO) | **15,5 x 23 cm** |
| Margin atas dan bawah | **2 cm** |
| Margin kiri dan kanan | **1,5 cm** |
| Gutter | **0 cm** (kelas memakai `oneside`: margin simetris, tanpa halaman kosong sisipan) |
| Font | **Carlito 11pt**, spasi 1 — kembaran metrik Calibri (Calibri tidak tersedia di TeX) |
| Indentasi paragraf | semua paragraf menjorok, **termasuk paragraf pertama setelah judul** (`indentfirst`) |

### Penomoran halaman

| Bagian | Nomor |
|---|---|
| Cover, halaman judul, halaman redaksi | tanpa nomor |
| Prakata s.d. daftar isi (`\frontmatter`) | romawi i, ii, ... |
| BAB 1 s.d. tentang penulis | arab 1, 2, ... |
| Posisi | bawah-tengah (gaya `plain`), tanpa running header |

### Halaman depan

| Elemen | Spesifikasi |
|---|---|
| **Halaman judul** | judul **22pt bold** menempel margin atas; sub judul **12pt**; nama penulis **16pt bold** (±9 cm dari atas); logo penerbit 5 cm + "PT. Penerbit Buku Pedia / tahun" **biru (RGB 31,78,121) bold 10pt** di bawah |
| **Halaman redaksi** | judul **16pt bold** + sub judul **10pt** menempel atas; blok info **8pt spasi 1** menempel bawah; label *bold italic*; antar kelompok satu baris kosong; baris kosong di bawah `ISBN:` untuk diisi nanti; 4 baris penutup rapat. Label `Font:` dan `Distributor:` tidak dicetak (distributor Bukupedia banyak; `\fontbuku`/`\distributor` tetap dikenali demi kompatibilitas). (Tabel 1.1 docx menyebut "Book Antiqua", tetapi docx-nya sendiri memakai Calibri 8pt — praktik docx yang diikuti) |
| **Prakata** | judul 16pt bold tengah; paragraf pembuka ber-**drop cap 3 baris** |
| **Daftar isi** | tanpa dot leader, nomor rata kanan, entri bab "BAB 1 ...", huruf section "A." bertitik, kedalaman sampai section saja, entri utama bold |

### Isi buku

| Elemen | Spesifikasi |
|---|---|
| **Judul bab bernomor** | "BAB 1" + judul, **24pt bold rata kanan**, garis **biru muda (RGB 155,194,230)** 1.2pt di bawahnya |
| **Judul bab tak bernomor** (PRAKATA dll.) | **16pt bold tengah** |
| **Section** | "A. JUDUL" **12pt bold** kapital; jarak 8pt di atas, **2pt (tipis) ke konten** |
| **Sub section** | "a) Judul" **11pt tidak bold**, menjorok sejajar indentasi paragraf; label berlebar tetap 1.5em; isi via lingkungan `isisubsek` sehingga **huruf pertama judul dan isi segaris vertikal** |
| **Poin a) b) c)** dalam teks | label menjorok sejajar indentasi paragraf, isi sejajar teks label, **tanpa jarak** dari paragraf di atas maupun antar poin |
| **Kode program** | lingkungan `kodeprogram`: monospace kecil, kotak 0.4pt latar abu 4%, **tidak terpotong halaman**, tanpa pewarnaan sintaks |
| **Tabel** | isi **8pt**, grid penuh **0.6pt**, header **shading abu muda** (gray 0.92) bold; sel **rata tengah vertikal** (kolom `X` → `m{}`); header dua baris dibuat sebagai dua baris `\multicolumn` agar tingginya pas |
| **Caption** | **8pt tengah**; tabel "Tabel 1.1. ..." (titik, di atas); gambar "Gambar 1.1 ..." (spasi, di bawah); jarak caption-objek 3pt; float rapat (`\intextsep` 4pt, `\textfloatsep` 8pt) |
| **URL panjang** | tidak melebihi margin (`xurl` setelah hyperref + penalti rendah + `\emergencystretch`) |

### Bagian belakang

| Elemen | Spesifikasi |
|---|---|
| **Daftar pustaka** | `\daftarpustaka{reference}` — gaya **APA** (`apacite`), hanya pustaka yang disitasi |
| **Glosarium** | huruf kepala **polos**, antar kelompok huruf dipisah **garis horizontal tipis** |
| **Indeks** | otomatis dari `\index{...}`; kepala huruf **bold**, nomor halaman dipisah **spasi tanpa koma** |
| **Tentang penulis** | foto kiri ±25% lebar, teks mengalir di sampingnya; nama **tidak bold** |

### Cover bawaan (meniru docx)

* **Depan**: dasar hitam; gambar blockchain diregangkan selebar halaman di 76% bagian
  bawah; logo Bukupedia **putih** kanan-atas; kolom hitam kiri berisi logo JS besar dan
  Solana; judul 26pt bold putih dengan angka **"3" merah**; sub judul 12pt; nama penulis
  **serif (Palatino) bold 15pt** bawah-tengah.
* **Belakang**: pita hitam atas (JS kiri, Solana kanan); sinopsis putih 11pt justify;
  logo Bukupedia putih kiri-bawah. Tanpa kotak ISBN/alamat (docx tidak memilikinya).

---

## Keputusan Desain (perbedaan yang disengaja terhadap docx)

Didokumentasikan supaya sesi/kontributor berikutnya **tidak "memperbaiki"** hal-hal ini:

1. **Carlito, bukan Calibri** — Calibri milik Microsoft, tak tersedia di TeX; Carlito
   kembaran metriknya. Book Antiqua pada cover diganti Palatino dengan alasan sama.
2. **Tahun otomatis** — `\tahunterbit` mengikuti tahun kompilasi; ganti dengan
   `\tahun{2023}` bila perlu tetap. Docx menulis 2023 statis.
3. **Daftar isi otomatis** dengan nomor halaman sungguhan. Daftar isi docx berisi entri
   dummy statis (KATA PENGANTAR dan BAB 2 fiktif) — tidak direplikasi.
4. **Indeks otomatis** dari `\index{}` pada istilah yang benar-benar ada di naskah.
   Entri indeks docx adalah dummy dari buku lain; yang direplikasi **formatnya**.
5. **Daftar pustaka hanya memuat yang disitasi** (4 entri, sama seperti docx). Empat
   contoh APA di bagian H ditampilkan sebagai teks kutipan dan tetap tersedia di
   `reference.bib` tanpa disitasi. Judul entri mengikuti kaidah APA yang benar
   (sentence case, nama jurnal miring) — docx-nya sendiri tidak konsisten.
6. **Tanpa halaman kosong sisa luapan** — docx punya halaman hampir kosong (artefak
   Word); tidak direplikasi, sehingga total halaman PDF (19) ≠ docx (21) dan nomor
   halaman bagian belakang bergeser sedikit.
7. **Kode program monospace dalam kotak** agar indentasi terjaga dan blok kode
   proporsional (di docx kodenya Calibri polos dan indentasinya hilang).

## Cara Memverifikasi Kesesuaian dengan Docx

```bash
# render docx pembanding
libreoffice --headless --convert-to pdf TEMPLATEUNESCOBUKUPEDIA.docx
# render kedua PDF per halaman lalu sandingkan
pdftoppm -png -r 60 main.pdf halaman-latex
pdftoppm -png -r 60 TEMPLATEUNESCOBUKUPEDIA.pdf halaman-docx
# ukuran font pasti dibaca dari XML docx (w:sz = setengah-poin; 44 = 22pt):
unzip -p TEMPLATEUNESCOBUKUPEDIA.docx word/document.xml | grep -o '<w:sz w:val="[0-9]*"'
```

Ukuran kertas dan margin `main.pdf` sudah diverifikasi empiris: 439.37 x 651.97 pt =
tepat 15,5 x 23 cm; posisi tinta teks konsisten dengan margin 2/2/1,5/1,5 cm (nomor
halaman di area footer ±1 cm dari tepi bawah, sama seperti docx).

---

## Ketentuan Naskah dari Penerbit (ringkas)

* **Minimal 50 halaman isi** (di luar cover, daftar isi, lampiran, dll.).
* **Nama penulis tanpa gelar dan tanpa tanda baca**; judul tanpa tanda baca. Nama dan
  urutan penulis **konsisten** antara sampul, halaman judul, dan halaman redaksi.
* **Prakata** dibuka dengan data faktual (statistik) terpercaya; memuat tujuan
  penulisan, pembaca sasaran, keunggulan buku, dan cara membaca buku. **Dilarang**
  menulis tempat/tanggal/nama penulis di akhir prakata, dan ucapan terima
  kasih/persembahan.
* **Naskah topik pemrograman**: wajib melampirkan link repositori GitHub yang sudah
  ditransfer ke organisasi [bukped](https://github.com/bukped); satu folder per bab;
  link ditulis di prakata. Kode program **tidak boleh** ditampilkan setengah-satu
  halaman penuh — jelaskan per baris/fungsi diselingi penjelasan, sisanya dirujuk ke
  GitHub. Dilarang memasukkan dokumen naskah ke repo. Repo berisi `README.md`
  (judul, sinopsis, link katalog, profil penulis), `coverbuku.jpg`, `fotopenulis.jpg`.
  Contoh: <https://github.com/bukped/FluPy>.
* Jika gambar bukan karya penulis, cantumkan referensinya di halaman **kredit gambar**.
* Naskah yang tidak memenuhi ketentuan biasanya ditolak Perpusnas karena dianggap
  membukukan laporan penelitian/skripsi/tesis/disertasi.

Template docx asli beserta ketentuan lengkap bergambar: [TEMPLATEUNESCOBUKUPEDIA.docx](./TEMPLATEUNESCOBUKUPEDIA.docx).
