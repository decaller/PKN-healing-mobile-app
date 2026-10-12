# Master Indeks & Peta Arsitektur Seluruh Prototipe (PKN Healing Mobile App)

> **Dokumentasi Konsolidasi & Evaluasi 12 Prototipe**  
> Tanggal Pembaruan: 12 Oktober 2026  
> Basis Desain: **Earth-Tree Design System** (`prototype/v2/design/earth_tree/DESIGN.md`)  
> Target Rilis: **Unified Modular Flutter Application** (Android & iOS)

---

## 1. Peta Ekosistem Seluruh Prototipe

Repositori ini telah mengeksplorasi dan memvalidasi seluruh pilar aplikasi melalui **12 sub-prototipe mandiri** di folder `prototype/`:

```
prototype/
├── v0/                     # [Flutter] Fondasi awal state machine Riverpod & Lesson Player
├── v1/                     # [Flutter Web] Sandbox pratinjau browser dengan device_preview
├── v2/                     # [Design & Specs] Arsip kanonikal 32 Layar Earth-Tree, evaluasi UX & data Wiki
├── v3/                     # [Flutter] Uji coba adopsi Forui UI library (^0.11.1)
├── v4/                     # [Flutter] Baseline native kanonikal (Beranda, Highlights, Bento, P3K Tantrum)
├── v5/                     # [Flutter] Testbed chart data jiwa (fl_chart, Mizan physics), Relasi & Daily Task
├── AI v1/                  # [Flutter] Teman Curhat AI, Edge LLM/LiteRT, Walkie-Talkie PTT, PDF Generator
├── Event v1/               # [Flutter] Agenda & Majelis Akbar Parenting Nabawiyah (Web & Mobile runner)
├── wiki v1/                # [Web HTML/JS] Prototipe penjelajah khazanah Wiki PKN (Directory & Article view)
├── scene generator v1/     # [OpenPencil/CLI] Evaluasi & otomasi Scene Graph living RPG / skenario adab
├── backend v1/             # [Node/Python] Server eksperimen scraping WordPress & Git Wiki mirror
└── backend v2/             # [Full Engine] Dual-Database, Directus, Alexandrie, LibSQL Vector, MCP Server
```

---

## 2. Matriks Rincian & Analisis Setiap Prototipe

| Folder Prototipe | Stack Teknologi | Fokus Fitur & Tanggung Jawab Utama | Aset / Hasil Kunci | Status Kesiapan |
| :--- | :--- | :--- | :--- | :--- |
| **[`v0`](./v0/)** | Flutter 3.29, Riverpod | Fondasi arsitektur micro-learning (Google Primer model), kuis skenario, dan rubrik kualitatif adab. | 13/13 passing tests, model polimorfik kartu modul. | **Teruji (Fondasi)** |
| **[`v1`](./v1/)** | Flutter Web | Uji coba responsivitas layout mobile di browser dengan simulator iPhone/Android frame. | Port web runner, layout emulator browser. | **Arsip Eksperimen** |
| **[`v2`](./v2/)** | HTML Tailwind, SVG, MD | Master konsep visual 32 layar lengkap, dokumen evaluasi Flutter, dan teks korpus ekstraksi Wiki PKN. | [`KATALOG_DAN_ARSITEKTUR_32_LAYAR.md`](./v2/KATALOG_DAN_ARSITEKTUR_32_LAYAR.md), [`FLUTTER_ANALISIS_DAN_REKOMENDASI.md`](./v2/FLUTTER_ANALISIS_DAN_REKOMENDASI.md), 32 desain HTML/PNG. | **Master Rujukan Desain** |
| **[`v3`](./v3/)** | Flutter, Forui UI | Eksplorasi adaptasi tema Earth-Tree pada komponen Forui (`forui.yaml`, skinning token warna). | Setup Forui pertama, token warna Earth-Tree dasar. | **Arsip Eksperimen** |
| **[`v4`](./v4/)** | Flutter, Forui, Iconoir | Implementasi kanonikal beranda mobile native: Header salam, Dynamic Search Ticker, Highlights Carousel, Daily Activity, Bento Grid, P3K Krisis 10 Detik. | 12/12 passing tests, 0 lint issues, floating acrylic frosted dock. | **Kanonikal Stabil (UI Core)** |
| **[`v5`](./v5/)** | Flutter, Forui, fl_chart | Testbed visualisasi data jiwa (Stacked Bar sepekan, Radar TB-40, Mizan physics), Layar Relasi Qalbiyah, dan Daily Task amalan adab + Modal Review. | 23/23 passing tests, `CustomPainter` Mizan Balance, cross-feature wiring ke Daily Task. | **Kanonikal Stabil (Fitur Harian & Relasi)** |
| **[`AI v1`](./AI%20v1/)** | Flutter, LiteRT, Audio | Layar Teman Curhat AI, Mode Pra-chat (Pijakan Permulaan), Mode Walkie-Talkie Ruang Qalbu (PTT living waveform), Generator Dokumen RPP Adab (PDF A4), Benchmark Suite Edge LLM. | Hasil benchmark Gemma 3 (270M, 1B) & Gemma 4 (E2B), audio visualizer, template RPP keluarga. | **Siap Digabung (Modul AI)** |
| **[`Event v1`](./Event%20v1/)** | Flutter Web/Mobile, HTTP | Agenda daurah & majelis akbar, filter kategori dinamis dari sumber resmi, poster landscape, pembatasan URL eksternal aman, polling 30s. | Model event transaksional, poster caching CORS, web launcher port 3011. | **Siap Digabung (Modul Event)** |
| **[`wiki v1`](./wiki%20v1/)** | HTML5, Tailwind, JS | Prototipe antarmuka direktori katalog fitrah dan pembaca artikel dengan breadcrumb, daftar isi (TOC), dan status sinkronisasi. | Pola navigasi direktori artikel dan pembaca Markdown interaktif. | **Rujukan Modul Wiki** |
| **[`scene generator v1`](./scene%20generator%20v1/)** | OpenPencil CLI 0.15.1 | Evaluasi editor open-source pengganti Figma untuk otomasi dan manipulasi SceneGraph 166 frame serta naskah simulasi living RPG. | [`README.md`](./scene%20generator%20v1/README.md) panduan teknis OpenPencil, evaluasi CLI export JSX/PNG. | **Rujukan Desain Scene** |
| **[`backend v1`](./backend%20v1/)** | Node.js, Python, Flask | Server backend awal untuk scraping situs `karakternabawiyah.com` dan sinkronisasi berkas Git Wiki Markdown. | Parser WordPress awal, pemetaan data JSON dasar. | **Arsip (Digantikan v2)** |
| **[`backend v2`](./backend%20v2/)** | Python, SQLite LibSQL, Directus | Arsitektur Dual-Database lengkap: Wiki-AI + Alexandrie Non-AI, compiler OTA Zstandard (`v4.0.0`, 7.69 MB), LibSQL Vector Search 384-dim (`F32_BLOB(384)`), MCP Server 6 tools, Drift Outbox sync. | 7/7 passing acceptance tests, `knowledge_build.db`, `test_backend_v2.py`, service client Flutter Dart. | **Produksi Terverifikasi (Master Backend)** |

---

## 3. Cetak Biru Kompilasi Modular (*Unified Modular Flutter App*)

Tujuan fase selanjutnya adalah menyatukan seluruh kemampuan dari sub-prototipe di atas ke dalam satu aplikasi Flutter kanonikal di folder kompilasi (misal `prototype/compile/` atau `lib/` root) dengan prinsip **Modular Feature Architecture & Zero Runtime Breakage**.

```
┌────────────────────────────────────────────────────────────────────────┐
│                   UNIFIED MODULAR FLUTTER CONTAINER                    │
├────────────────────────────────────────────────────────────────────────┤
│  CORE SHELL: Earth-Tree Theme + Forui + Iconoir + 5-Tab Frosted Dock   │
│  FEATURE FLAG SYSTEM: Fitur dapat dihidup/matikan via Config Runtime   │
├────────────────────────────────────────────────────────────────────────┤
│  [Module 1: Home Core]         <- dari prototype/v4                    │
│  [Module 2: Daily & Relasi]    <- dari prototype/v5                    │
│  [Module 3: Teman Curhat AI]   <- dari prototype/AI v1                 │
│  [Module 4: Event & Majelis]   <- dari prototype/Event v1              │
│  [Module 5: Knowledge & Vector]<- dari prototype/backend v2 (client)  │
│  [Module 6: Narrative Adab]    <- dari prototype/v0 & v2 Living RPG    │
└────────────────────────────────────────────────────────────────────────┘
```

### A. Sistem Feature Flags (`FeatureFlagsConfig`)
Setiap modul fitur dibungkus oleh antarmuka konfigurasi independen:

```dart
class FeatureFlagsConfig {
  final bool enableHome;            // Modul Beranda & Highlights
  final bool enableDailyTask;       // Modul Amanah Harian & Modal Review
  final bool enableRelations;       // Modul Relasi Qalbiyah & Visualisasi Chart
  final bool enableCurhatAi;        // Modul Teman Curhat AI & Walkie-Talkie
  final bool enableEvents;          // Modul Agenda Daurah & Majelis Akbar
  final bool enableKnowledgeWiki;   // Modul Khazanah Wiki & LibSQL Vector Search
  final bool enableNarrativeRpg;    // Modul Living Story & Skenario Adab

  const FeatureFlagsConfig({
    this.enableHome = true,
    this.enableDailyTask = true,
    this.enableRelations = true,
    this.enableCurhatAi = true,
    this.enableEvents = true,
    this.enableKnowledgeWiki = true,
    this.enableNarrativeRpg = true,
  });
}
```

### B. Graceful Degradation & Dynamic Navigation Dock
1. **Dynamic Shell Dock:** Jika `enableCurhatAi = false`, tab Curhat di dock navigasi otomatis disembunyikan tanpa merusak tata letak tab lainnya.
2. **Dynamic Bento & Card Grid:** Jika `enableEvents = false`, kartu highlights agenda di beranda otomatis beralih menampilkan pesan mutiara hikmah atau kuis harian.
3. **Penyedia Layanan Terisolasi (Decoupled Services):** Setiap fitur berkomunikasi melalui Provider / Interface abstrak. Fitur Amanah Harian tetap dapat berjalan mandiri meskipun backend sinkronisasi atau model AI offline.

---

## 4. Rangkuman Panduan Pengujian

Untuk memverifikasi setiap prototipe yang siap diuji:

```bash
# 1. Uji Fitur Chart & Relasi (v5)
cd prototype/v5 && flutter test

# 2. Uji Beranda & UI Kanonikal (v4)
cd prototype/v4 && flutter test

# 3. Uji Backend v2 & LibSQL Vector Search (7 acceptance tests)
cd "prototype/backend v2" && python3 test_backend_v2.py -v

# 4. Uji Layar Event (Event v1)
cd "prototype/Event v1" && flutter test
```
