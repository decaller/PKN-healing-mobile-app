# Scene Generator v1 — Catatan Penggunaan OpenPencil

Tanggal analisis: 11 Oktober 2026. Sumber: dokumentasi resmi `open-pencil/open-pencil` dan artefak desain lokal. CLI yang dijalankan untuk verifikasi: **0.15.1**. Dokumen ini adalah panduan penggunaan; tidak memasang editor desktop atau membangun generator baru.

## 1. Kesimpulan

[OpenPencil](https://github.com/open-pencil/open-pencil) adalah editor desain open source berlisensi MIT, alternatif Figma untuk membuat dan mengedit layer, frame, komponen, serta auto layout. Tersedia aplikasi web, desktop, CLI, MCP, dan SDK Vue.

Untuk proyek PKN, mulai dari **master desain yang sudah ada**, bukan membuat salinan generator. Gunakan editor untuk pemeriksaan visual, CLI untuk membaca atau menjalankan generator lokal, lalu prototype HTML untuk interaksi. Desain scene Virtual Fitrah tidak sama dengan runtime game produksi.

OpenPencil masih dalam pengembangan aktif. Kemampuan membaca `.fig` tidak menjamin kesetaraan visual atau semua fitur Figma. Jangan menganggap ekspor JSX sebagai aplikasi siap produksi.

## 2. Temuan folder lain

Penelusuran folder prototype lain tidak menemukan catatan atau generator OpenPencil yang relevan di `prototype/`. Referensi operasional berada di `design/`, dengan konteks tambahan pada `README.md` dan `DESIGN_SYSTEM.md`.

| Artefak lokal | Kegunaan |
|---|---|
| [`../../design/README.md`](../../design/README.md) | Panduan regenerasi, token, key layar, batas prototype dan scene |
| [`../../design/ANALISIS_DAN_PENGEMBANGAN.md`](../../design/ANALISIS_DAN_PENGEMBANGAN.md) | Catatan analisis dan pengembangan sebelumnya |
| [`../../design/PKN_Healing_App_Design.fig`](../../design/PKN_Healing_App_Design.fig) | Master desain editable yang dibuat dengan OpenPencil |
| [`../../design/generate-journeys.js`](../../design/generate-journeys.js) | Generator journey aplikasi utama |
| [`../../design/generate-virtual-fitrah.js`](../../design/generate-virtual-fitrah.js) | Generator layar dan scene Virtual Fitrah |
| [`../../design/generate-prototype.mjs`](../../design/generate-prototype.mjs) | Membuat prototype browser dari metadata desain |
| [`../../design/sync-tokens.mjs`](../../design/sync-tokens.mjs) | Sinkronisasi token ke keluaran aplikasi |
| [`../../design/resize-viewport.js`](../../design/resize-viewport.js) | Helper resize viewport eksplisit |
| [`../../design/prototype.html`](../../design/prototype.html) | Prototype interaktif browser, bukan native prototype Figma |
| [`../../DESIGN_SYSTEM.md`](../../DESIGN_SYSTEM.md) | Konteks desain sistem proyek |

Pembacaan master melalui CLI pada sesi ini berhasil: **7 halaman, 7.747 node**, dengan font **Amiri** dan **Inter**. Halamannya meliputi Design System & Tokens, Layar Aplikasi PKN, Parcours, Komponen & Peta Journey, serta tiga halaman Virtual Fitrah.

Menurut `design/README.md`, master mempunyai 166 frame berkunci `screenKey`: 111 viewport utama dan 55 game. Itu adalah catatan artefak sebelumnya, bukan penghitungan ulang `screenKey` pada sesi ini. Jumlah seluruh node bertipe FRAME dari CLI bukan jumlah layar; container internal juga berupa FRAME.

**Konvensi penting:**

- Gunakan `screenKey` sebagai identitas layar; node ID dapat berubah setelah serialisasi atau regenerasi.
- Generator memiliki halaman/aset tertentu dan dapat membangun ulang isinya. Simpan salinan sebelum menjalankan mutasi.
- Data `pknPrototype` dan `pknGamePrototype` dipakai generator browser; jangan menganggapnya native reactions Figma.
- Metadata constraint tidak cukup untuk membuktikan resize responsif. Helper lokal menghitung posisi dan ukuran secara eksplisit.
- Token dan tipografi aktual mengikuti kontrak pada `design/README.md`; jangan mengambil skala lama tanpa membandingkannya.

## 3. Mulai menggunakan editor

### Pilihan termudah: web

1. Buka [app.openpencil.dev](https://app.openpencil.dev), atau [demo](https://app.openpencil.dev/demo) untuk mencoba.
2. Gunakan menu **File → Open** atau `Ctrl + O` dan pilih `design/PKN_Healing_App_Design.fig`.
3. Pilih halaman di panel kiri, lalu pilih frame/layer.
4. Ubah ukuran, posisi, warna, tipografi, dan layout melalui panel properti kanan.
5. Simpan salinan melalui **Save As** / `Ctrl + Shift + S`. Periksa lokasi file hasilnya; browser dapat memakai File System Access API atau fallback unduhan.

Gunakan Chrome/Edge terbaru untuk mengurangi perbedaan dukungan file dan font. README resmi menyebut minimum Chrome 111, Edge 111, Firefox 128, atau Safari 16.4. Izinkan akses font lokal jika diminta dan diperlukan. Pastikan Inter dan Amiri tersedia sebelum menilai tampilan teks.

### Pilihan desktop

Unduh paket dari [rilis resmi](https://github.com/open-pencil/open-pencil/releases/latest). Dokumentasi menyebut Linux x64 `.AppImage` / `.deb`, Windows `.msi` / `.exe`, dan macOS `.dmg`. Untuk Linux non-Debian, pilih AppImage jika tersedia; jangan menjalankan instruksi `apt` sebagai instruksi universal.

Desktop Linux membutuhkan WebKitGTK 2.40+ menurut README resmi. Integrasi coding agent lokal dan MCP live-app lebih sesuai dijalankan dengan editor desktop.

### Menjalankan source secara terpisah

Opsional untuk pengembangan OpenPencil, bukan syarat menggunakan master PKN. Jalankan di direktori kerja terpisah agar source upstream tidak bercampur dengan prototype aplikasi:

```bash
git clone https://github.com/open-pencil/open-pencil.git
cd open-pencil
bun install
bun run dev
```

Menurut [Getting Started](https://openpencil.dev/getting-started.md), editor pengembangan tersedia di `http://localhost:1420`. Desktop source memerlukan Rust dan prasyarat Tauri; `bun run tauri dev` bukan langkah instalasi web.

## 4. Alur desain manual

1. Pilih **Frame** (`F`), gambar container layar, lalu isi width/height pada panel kanan. Ukuran mobile dasar proyek yang didokumentasikan adalah 390×844; Android 412×915 dan tablet 768×1024.
2. Beri nama frame dan layer secara bermakna. Nama tidak menggantikan plugin data `screenKey` yang dipakai generator lokal.
3. Tambahkan teks (`T`), rectangle (`R`), ellipse (`O`), atau pen (`P`). Gunakan `V` untuk kembali ke seleksi.
4. Pilih frame atau kumpulan node, tekan `Shift + A` untuk auto layout. Atur arah vertical/horizontal, gap, padding, dan alignment di bagian **Layout**.
5. Gunakan **Fixed** untuk ukuran eksplisit, **Fill** untuk memenuhi ruang parent, dan **Hug** untuk mengikuti konten. Untuk scene isometrik, posisi bebas dapat lebih sesuai daripada auto layout untuk objek di dalam scene.
6. Buat elemen berulang sebagai komponen dengan `Ctrl + Alt + K`. Masukkan instance dari tab **Assets** atau context menu **Create instance**. Edit master untuk perubahan bersama; override instance dapat mempertahankan nilai lokal.
7. Untuk varian, pilih beberapa komponen lalu `Ctrl + Shift + K`. Atur dimensi seperti `State` atau `Theme` pada properti komponen.
8. Periksa teks panjang, clipping, posisi dock, dan konsistensi tema. Simpan `.fig`, ekspor frame untuk review, lalu buka kembali file simpanan untuk memeriksa persistensi.

Shortcut berikut untuk Windows/Linux; gunakan Cmd sebagai pengganti Ctrl pada macOS bila sesuai dokumentasi.

| Aksi | Shortcut |
|---|---|
| Geser canvas | Tombol mouse tengah + drag, atau tool `H` |
| Zoom | `Ctrl + scroll` |
| Fit seluruh konten | `Shift + 1` |
| Fit pilihan | `Shift + 2` |
| Duplikasi | `Ctrl + D` atau `Alt + drag` |
| Undo / redo | `Ctrl + Z` / `Ctrl + Shift + Z` |
| Buka / simpan | `Ctrl + O` / `Ctrl + S` |
| Simpan sebagai | `Ctrl + Shift + S` |
| Ekspor pilihan | `Ctrl + Shift + E` |
| AI chat | `Ctrl + J` |

Jika browser mengambil alih shortcut, gunakan menu aplikasi. Referensi: [Drawing Shapes](https://openpencil.dev/user-guide/drawing-shapes.md), [Auto Layout](https://openpencil.dev/user-guide/auto-layout.md), [Components](https://openpencil.dev/user-guide/components.md), dan [Keyboard Shortcuts](https://openpencil.dev/reference/keyboard-shortcuts.md).

## 5. Simpan, impor, dan ekspor

- **Master editable:** simpan sebagai `.fig`.
- **Migrasi dari Figma:** unduh salinan lokal `.fig`, buka di OpenPencil, lalu bandingkan frame penting. Clipboard node antaraplikasi juga didokumentasikan, tetapi belum diuji pada sesi ini.
- **`.pen`:** CLI 0.15.1 melaporkan dukungan **read-only**; jangan mengasumsikan format ini dapat disimpan kembali. Konversi ke `.fig` bila perlu.
- **Review gambar:** pilih frame, buka bagian **Export**, pilih PNG/JPG/WEBP/SVG dan scale. PNG/WEBP mendukung transparansi; JPG memakai latar putih.
- **Handoff kode:** JSX/Tailwind atau HTML adalah keluaran desain; logic, routing, state, backend, dan perilaku game tetap harus diimplementasikan.

Instalasi CLI bersifat terpisah dari desktop:

```bash
npm install -g @open-pencil/cli@0.15.1
openpencil --help
openpencil formats
```

Pin versi di atas untuk mengikuti hasil verifikasi catatan ini. Periksa `--help` setelah upgrade; README upstream `master` dapat lebih baru daripada paket npm.

Contoh dari root repo:

```bash
openpencil info design/PKN_Healing_App_Design.fig
openpencil tree design/PKN_Healing_App_Design.fig
openpencil find design/PKN_Healing_App_Design.fig --type TEXT
openpencil fonts design/PKN_Healing_App_Design.fig
```

Untuk ekspor, tentukan frame terlebih dahulu. Jangan menggunakan ID lama tanpa lookup pada berkas terkini:

```bash
openpencil eval design/PKN_Healing_App_Design.fig -c 'return figma.root.findAll(n=>n.type==="FRAME"&&n.getPluginData("screenKey")).map(n=>({key:n.getPluginData("screenKey"),id:n.id,name:n.name}));' --json
```

Setelah mendapatkan ID, ganti `ID_FRAME` pada contoh berikut dengan hasil lookup:

```bash
openpencil export design/PKN_Healing_App_Design.fig --node ID_FRAME -f png -s 2 -o /tmp/pkn-frame.png --font-policy strict
openpencil export design/PKN_Healing_App_Design.fig --node ID_FRAME -f jsx --style tailwind -o /tmp/pkn-frame.jsx
```

CLI 0.15.1 memakai `-f jsx --style tailwind`, **bukan `-f tailwind-jsx`** yang muncul pada README upstream saat analisis. `--font-policy strict` menghentikan ekspor raster/PDF jika font tidak dapat disiapkan dengan setia; ini bukan pemeriksaan kesetaraan visual lengkap.

Untuk impor HTML/CSS sederhana:

```bash
openpencil import /tmp/card.html --css /tmp/card.css -o /tmp/card.fig
```

Ini tidak menjalankan aplikasi Flutter atau mengonversi seluruh website beserta interaksinya. [DOM/CSS mapping](https://openpencil.dev/reference/dom-css-mapping.md) menyebut konversi headless sebagai aproksimasi; image URL eksternal tidak otomatis diunduh. Periksa hasil secara visual.

Referensi: [File Operations & Export](https://openpencil.dev/user-guide/exporting.md) dan [CLI Exporting](https://openpencil.dev/programmable/cli/exporting.md).

## 6. Menggunakan generator PKN yang sudah ada

**Perintah berikut mengubah artefak.** Jangan menjalankannya hanya untuk membuka desain. Salin master ke backup terlebih dahulu; regenerasi dapat menimpa edit manual pada halaman yang dimiliki generator. Script prototype dan token juga dapat menulis keluaran proyek.

Dari root repo, alur yang sudah didokumentasikan di `design/README.md`:

```bash
openpencil eval design/PKN_Healing_App_Design.fig --stdin -w < design/generate-journeys.js
openpencil eval design/PKN_Healing_App_Design.fig --stdin -w < design/generate-virtual-fitrah.js
node design/generate-prototype.mjs
node design/sync-tokens.mjs
node design/sync-tokens.mjs --check
```

`-w` menulis perubahan eval ke file. Tanpa `-w`, perubahan eval tidak disimpan ke master. Sesi analisis ini **tidak menjalankan regenerasi atau sinkronisasi token**, karena permintaan hanya folder dan catatan.

Untuk mencoba prototype browser yang sudah ada, jalankan server statis tanpa mengubah source:

```bash
npx --yes http-server design -a 127.0.0.1 -p 8080
```

Buka `http://127.0.0.1:8080/prototype.html`; hentikan server dengan `Ctrl + C`. Prototype lokal menyediakan interaksi/simulasi, bukan backend produksi. Catatan lama menyebut state bookmark, pilihan, dan tulisan hanya bertahan selama halaman terbuka.

## 7. Membuat scene dengan AI

1. Buka AI chat dengan `Ctrl + J`.
2. Buka pengaturan chat, tambah konfigurasi provider, model ID, dan API key.
3. Simpan model dan tetapkan sebagai **Design agent**.
4. Pilih frame target dan pin selection sebagai konteks bila tersedia.
5. Minta perubahan terarah, lalu periksa canvas dan ekspor hasilnya.

Contoh prompt untuk percobaan di dokumen salinan:

```text
Pada frame yang dipilih, buat scene isometrik taman keluarga dengan layer
native editable. Gunakan jalur pejalan kaki, dua pohon, bangku, dan area
berkebun. Jangan mengubah halaman lain. Beri nama layer secara jelas,
pertahankan ukuran frame, dan ekspor PNG untuk pemeriksaan visual.
```

AI mendukung pembuatan node, layout, komponen, dan perubahan style. Tool yang tersedia tergantung **Settings → Tool access**. Jika fitur tidak muncul, periksa pengaturan tool, jangan langsung menganggap model gagal.

**Keamanan dan biaya:** API key tidak boleh disimpan dalam repo atau dokumen ini. Permintaan AI dikirim langsung ke provider, sehingga prompt, konteks desain, atau gambar yang dilampirkan dapat keluar dari mesin. Gunakan data sintetis, bukan data pribadi anak atau catatan kesehatan. Biaya provider tetap berlaku walaupun editor open source. CORS browser dan dukungan tool calling berbeda antarmodel; gunakan desktop atau provider yang kompatibel bila diperlukan. Tool toggles bukan sandbox: script tool dapat menjalankan operasi yang lebih luas.

Referensi: [AI Chat](https://openpencil.dev/programmable/ai-chat.md) dan [BYOK Compatibility](https://openpencil.dev/programmable/byok-provider-compatibility.md).

## 8. Otomasi melalui MCP dan pilihan SDK

### MCP live-app

Untuk agent eksternal, buka editor desktop dengan dokumen dimuat, lalu instal MCP:

```bash
npm install -g @open-pencil/mcp@0.15.1
claude mcp add --scope user open-pencil -- openpencil-mcp
claude mcp list
```

Konfigurasi generik untuk client lain:

```json
{
  "mcpServers": {
    "open-pencil": {
      "command": "openpencil-mcp"
    }
  }
}
```

Mulai dari inspeksi dokumen dan halaman, kemudian buat/modifikasi node, ekspor untuk review, dan simpan. Pada workflow multi-document, gunakan `document_id` dan `page_id` eksplisit agar perubahan tidak masuk ke tab yang salah.

Jangan otomatis menyetujui semua tool. Pertahankan konfirmasi mutasi sampai target dokumen jelas. Jika memakai server HTTP, batasi file melalui `OPENPENCIL_MCP_ROOT`; pertahankan autentikasi dan bind loopback. Server localhost bukan layanan publik untuk diekspos tanpa pengamanan.

Dokumentasi upstream terbaru dan README juga menjelaskan penggunaan headless. Catatan ini memilih desktop/live-app untuk instruksi MCP karena alur tersebut dinyatakan eksplisit pada [MCP Server](https://openpencil.dev/programmable/mcp-server.md). Integrasi MCP belum dijalankan pada sesi ini.

### SDK untuk editor khusus

Jika nanti diperlukan editor scene dengan UI khusus, OpenPencil menyediakan engine framework-agnostic dan SDK `@open-pencil/vue` yang headless. SDK bukan generator scene siap pakai; aplikasi masih perlu menyediakan toolbar, panel, routing, dan file flow. Untuk kebutuhan saat ini, gunakan CLI/generator lokal dahulu daripada menambah editor kedua.

Referensi: [SDK Getting Started](https://openpencil.dev/programmable/sdk/getting-started.md). Tidak ada integrasi SDK yang dibuat dalam folder ini.

## 9. Kolaborasi dan batas alternatif Figma

Kolaborasi resmi memakai WebRTC P2P: klik tombol share, bagikan link room, lalu peserta dapat melihat cursor, selection, dan edit bersama. Ada follow viewport dan voice call. Simpan `.fig` sebagai backup; link kolaborasi bukan pengganti version history. Kolaborasi belum diuji pada sesi ini.

[Figma Feature Matrix](https://openpencil.dev/reference/figma-compatibility.md) masih mencantumkan tanggal pembaruan 7 Maret 2026 dan memiliki bagian yang tertinggal dari dokumentasi fitur terbaru. Jangan memakai jumlah coverage atau status semua baris sebagai bukti versi saat ini. Contohnya, matrix menyebut PDF belum tersedia, sedangkan CLI 0.15.1 yang dijalankan sudah mencantumkan PDF.

Untuk proyek ini, batas yang tetap harus dijaga berdasarkan catatan lokal:

- Interaksi yang berjalan berada di prototype browser; native reactions/cloud Figma belum dibuktikan.
- Scene tujuh venue adalah desain dan simulasi, bukan engine game, AI hidup, ekonomi nyata, atau validasi psikometrik.
- Keberhasilan ekspor tidak membuktikan aksesibilitas, responsivitas semua ukuran, atau bebas overlap pada semua layar.
- Migrasi ke Figma, integrasi font Arab/RTL, dan handoff ke Flutter memerlukan pemeriksaan surface masing-masing.

## 10. Masalah umum

| Masalah | Tindakan |
|---|---|
| `openpencil: command not found` | Instal CLI terpisah atau gunakan `npx --yes @open-pencil/cli@0.15.1 --help` untuk mencoba tanpa instalasi global |
| Font atau tinggi teks berbeda | Pastikan Inter/Amiri tersedia, periksa `openpencil fonts`, dan gunakan font policy strict pada ekspor final |
| Ekspor menampilkan banyak layar | Tentukan `--node` dari lookup terkini, bukan mengekspor seluruh halaman/dokumen |
| Node ID lama tidak cocok | Cari ulang `screenKey` setelah reopen atau regenerasi |
| Edit manual hilang setelah generator | Pulihkan backup; perubahan generator perlu dilakukan pada sumber generator, bukan hanya output miliknya |
| AI tidak dapat memakai tool | Periksa provider/model, API key, CORS, dan Tool access; jangan bagikan key untuk debugging |
| MCP tidak terhubung | Pastikan desktop dan dokumen terbuka, periksa `claude mcp list`, lalu restart server/client setelah perubahan tool settings |
| Prototype tidak merespons seperti native Figma | Gunakan `design/prototype.html`; jangan menganggap metadata browser sebagai native connections |

## 11. Bukti verifikasi dan rujukan

Dijalankan pada sesi ini tanpa mutasi master:

- `npx --yes @open-pencil/cli@0.15.1 --help`: berhasil, CLI melaporkan v0.15.1.
- `npx --yes @open-pencil/cli@0.15.1 formats`: berhasil, `.fig` read/write dan `.pen` read-only; format gambar, PDF, PPTX, dan JSX tercantum.
- `npx --yes @open-pencil/cli@0.15.1 export --help`: berhasil, opsi `-f jsx --style tailwind`, `--node`, dan `--font-policy` tersedia.
- `npx --yes @open-pencil/cli@0.15.1 import --help`: berhasil, input HTML dan opsi CSS/output tersedia.
- `npx --yes @open-pencil/cli@0.15.1 info design/PKN_Healing_App_Design.fig`: berhasil membaca 7 halaman, 7.747 node, font Amiri dan Inter.

Editor web/desktop, AI provider, MCP, regenerasi, ekspor gambar, dan prototype browser **belum diuji secara interaktif pada sesi ini**. Instruksi untuk bagian tersebut bersumber dari dokumentasi resmi dan catatan lokal, bukan klaim keberhasilan runtime.

Sumber utama:

- [Repository dan README upstream](https://github.com/open-pencil/open-pencil)
- [Getting Started](https://openpencil.dev/getting-started.md)
- [CLI Reference](https://openpencil.dev/reference/cli.md)
- [Indeks dokumentasi untuk agent](https://openpencil.dev/llms.txt)
- [Metadata npm CLI yang diperiksa](https://registry.npmjs.org/@open-pencil/cli/latest)
- [`design/README.md`](../../design/README.md)

### Riwayat catatan

- 11 Oktober 2026: membuat folder Scene Generator v1 dan catatan awal dari analisis sumber resmi serta desain lokal; belum menambahkan implementasi generator.
