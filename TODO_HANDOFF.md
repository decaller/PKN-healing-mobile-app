# PKN Healing Mobile App — Roadmap, Tech Decisions & Developer Handoff Document

> **Status:** Architecture Scaffolding, Design Previews & Persona Framework Complete  
> **Last Updated:** 4 Oktober 2026  
> **Target Platform:** Flutter (iOS & Android Unified Single Binary)  
> **Active Tech Decision:** **Flutter + Flame Engine + Bonfire + Rive** (Lightweight Virtual Human & AFK Simulation)

---

## 1. Project Overview & Architectural Vision

**PKN Healing Mobile App** adalah aplikasi mobile terpadu yang memadukan dua pilar utama:
1. **Modul Edukasi & Microlearning Manhaj Nabawiyah (PKN)**:
   - Kurasi gagasan berbasis kartu (*Deepstash model*) dengan **Lead TL;DR < 10 detik**.
   - Taksonomi 6 Pilar MOC (*Maps of Content*: P1 s.d. P6).
   - Modul belajar interaktif 5 langkah (*Google Primer model*) dengan kuis skenario, tindakan verbal, dan doa muhasabah.
   - Pemutar audio sirah & tazkiyatun nafs di latar belakang (*hands-free*).
   - Pemantauan adab kualitatif non-gamifikasi (**BT - MT - BK - MM**) melalui *Fast-Tap Rubric 19 Butir Adab*.
2. **Modul Gamifikasi & Simulasi Kehidupan ("Baitul Fitrah & Madinah Virtual")**:
   - Simulasi manusia virtual (anak, orang tua, santri) dengan parameter fitrah: **Tangki Cinta (Love Tank)** dan **Tiga Lapisan Jiwa (Nafs Barometer)**.
   - Peta 7 lokasi komunitas islami (*Rumah Baitul Fitrah, Sekolah Kuttab, Masjid Jami', Taman Alam, Pasar Niaga, Asrama, Tetangga*).
   - Mekanik **Idle / AFK** (*Away From Keyboard*) di mana kehidupan virtual terus berdenyut mandiri di latar belakang, dan rekap kejadian disajikan saat login kembali melalui **"The Welcome Back Ledger"**.
   - Mekanik **"Real-to-Virtual Bridge"**: Aksi nyata di rumah asli (misal memeluk anak tanpa HP) mengisi energi virtual, bukan membuat pengguna kecanduan layar.

---

## 2. Architecture Decision Record (ADR): Framework Simulasi Virtual

### Keputusan: Menggunakan **Flutter + Flame Engine + Bonfire + Rive**

| Komponen Arsitektur | Teknologi Terpilih | Peran & Justifikasi Teknis |
| :--- | :--- | :--- |
| **Host Application** | **Flutter (Dart 3.5+)** | Satu basis kode tunggal (*single binary*) untuk Android dan iOS sekaligus. Startup instan (< 1 detik). |
| **Core Game Engine** | **Flame Engine (`flame: ^1.18.0`)** | Game loop 2D isometrik murni Dart. Tambahan ukuran APK hanya **+3–5 MB** (total aplikasi $< 40\text{ MB}$), RAM 35–50 MB, 60–120 FPS stabil. |
| **Simulasi RPG & Komunitas** | **Bonfire (`bonfire: ^3.11.1`)** | Framework di atas Flame yang menyediakan *pathfinding* pergerakan karakter otomatis, tabrakan dinding/pintu, balon dialog *Bahasa Hati*, dan pencahayaan waktu shalat. |
| **Virtual Human & Animasi** | **Rive (`rive: ^0.13.0` & `flame_rive`)** | Vektor animasi interaktif dengan *State Machine*. Satu file karakter hanya **~200 KB**, mampu mengekspresikan tangisan tantrum, senyuman haru, dan gerakan shalat secara anatomis presisi. |
| **Database Luring Cepat** | **Isar Database (`isar: ^3.1.0+1`)** | Database NoSQL lokal ultra-cepat untuk menyimpan ratusan log kejadian *The Welcome Back Ledger* secara luring. |
| **Simulasi Latar (AFK)** | **WorkManager & Delta-Time Engine** | Menggunakan algoritma *Timestamp Delta* matematika murni tanpa loop render background; bebas boros baterai. |

### Alternatif yang Dipertimbangkan & Ditolak:
* **Unity Embedded (`flutter_unity_widget`)**: Ditolak karena membengkakkan ukuran APK sebesar **+70 s.d. 120 MB**, memakan RAM **250–400 MB**, membuat HP cepat panas, dan jembatan native bridge rawan crash.
* **Godot Embedded**: Ditolak karena pustaka jembatan Flutter komunitas belum berstatus stabil dan berisiko tinggi saat update Flutter OS.
* **Murni Game Engine Tanpa Flutter**: Ditolak karena kenyamanan membaca artikel edukasi PKN, form rubrik guru, dan audio player latar menjadi sangat buruk di dalam game engine.

---

## 3. Prioritized Implementation Roadmap (TODO List)

### Phase 1: Local Tooling & State Machine Verification *(Completed)*
- [x] **Task 1.1:** Setup `flutter pub get` dan verifikasi integritas dependensi.
- [x] **Task 1.2:** Implementasi Riverpod state architecture di `prototype/v0/lib/features/`.
- [x] **Task 1.3:** Validasi deserialisasi JSON schema untuk polymorphic lesson cards.
- [x] **Task 1.4:** Pengujian unit test `LessonPlayerNotifier` (13/13 test passing).

### Phase 2: Design Tokens & Theme Foundation *(Completed)*
- [x] **Task 2.1:** Implementasi token warna kanonikal (`AppColors`) & tipografi Inter modern.
- [x] **Task 2.2:** Reusable components: `SegmentedProgressBar`, `AdabBadge`, `ArabicDalilCard`, `MocPilarChip`.
- [x] **Task 2.3:** Spesifikasi token visual dan preview Figma 53 layar di `design/`.

### Phase 3: Onboarding & JTBD Diagnostic Flow *(Completed)*
- [x] **Task 3.1:** Kuesioner diagnostik 4 langkah di `prototype/v0/lib/features/onboarding/`.
- [x] **Task 3.2:** Algoritma komputasi arketipe persona (Ayah, Bunda, Guru, Pengelola, Santri, Mandiri).
- [x] **Task 3.3:** Layar `ActivationalInsightScreen` dengan rute rekomendasi pilar MOC otomatis.
- [x] **Task 3.4:** Persistensi flag onboarding ke `SharedPreferences`.

### Phase 4: Google Primer-Style Lesson Player *(Completed)*
- [x] **Task 4.1:** Step renderer: `TextStepView`, `MultipleChoiceStepView`, `SwipePollStepView`, `FillInBlankStepView`.
- [x] **Task 4.2:** Segmented progress bar & feedback penjelasan syar'i animasi.
- [x] **Task 4.3:** Laporan pertumbuhan adab kualitatif `AdabGrowthReportScreen` (BT-MT-BK-MM).

### Phase 5: Deepstash-Style Discovery Feed *(Completed)*
- [x] **Task 5.1:** Feed penjelajahan kartu gagasan dengan Lead TL;DR < 10 detik.
- [x] **Task 5.2:** Filter interaktif 6 Pilar MOC (`P1` s.d. `P6`).
- [x] **Task 5.3:** Offline bookmarking via `BookmarksProvider`.
- [x] **Task 5.4:** Pencarian kata kunci judul dan tesis gagasan tarbiyah.

---

### Phase 6: Persona & User Journeys Integration *(Completed)*
- [x] **Task 6.1:** Salin 17 berkas persona autentik dari `wiki-pkn` ke `docs/personas/`.
- [x] **Task 6.2:** Buat peta perjalanan komprehensif 17 persona di `docs/USER_JOURNEYS.md`.
- [x] **Task 6.3:** Sinkronkan kode onboarding (`jtbd_data.dart` & `onboarding_state.dart`) untuk mencakup seluruh 6 kluster peran.
- [x] **Task 6.4:** Perbarui `README.md` dengan konsep aplikasi, pilar manhaj, dan 7 flowchart representatif persona.
- [x] **Task 6.5:** Buat laporan audit dan analisis desain Figma di `design/ANALISIS_DAN_PENGEMBANGAN.md`.

### Phase 6.5: Interactive Web Prototype & Device Preview (`prototype/v1`) *(Completed)*
- [x] **Task 6.5.1:** Setup scaffold Flutter Web dengan integrasi `device_preview` di `prototype/v1/`.
- [x] **Task 6.5.2:** Sambungkan seluruh state machine Riverpod, GoRouter, dan SharedPreferences (localStorage) ke kanvas web.
- [x] **Task 6.5.3:** Validasi visual rendering pratinjau mobile (iPhone 13, iPad, Android) di browser (`http://localhost:8181`).
- [x] **Task 6.5.4:** Verifikasi integritas analisis statis (0 issues) dan pengujian otomatis (13/13 passing tests).

---

### Phase 7: Evaluasi Kritis & Transformasi Arsitektur Dual-Core *(Completed)*
- [x] **Task 7.1:** De-scoping game engine 2D berat (Flame/Bonfire/Unity) setelah audit desain [`design/DESIGN_CRITIQUE.md`](design/DESIGN_CRITIQUE.md) dan [`design/IDEA_REFINEMENT.md`](design/IDEA_REFINEMENT.md).
- [x] **Task 7.2:** Penetapan Arsitektur Baru: Dual-Core PKN Mobile ([`docs/RISET_DUAL_CORE_WIKI_DAN_NARRATIVE_RPG.md`](docs/RISET_DUAL_CORE_WIKI_DAN_NARRATIVE_RPG.md)) — Pilar 1: Wiki-Tools Hub, Pilar 2: Narrative RPG Rehearsal.
- [x] **Task 7.3:** Audit Master Governance & Toko Aplikasi ([`COMPLIANCE_AND_ARCHITECTURE.md`](COMPLIANCE_AND_ARCHITECTURE.md)): Safeguarding anak, fiqih pengasuhan, privasi suara zero-retention, dan pemisahan non-klinis.

### Phase 8: Riset Mekanik TB-40 & Validasi Empiris Gemma AI *(Completed)*
- [x] **Task 8.1:** Transformasi 24 skill Disco Elysium menjadi 40 Bakat Syakilah TB-40 ([`docs/RISET_MEKANIK_SKILL_DISCO_ELYSIUM_TB40.md`](docs/RISET_MEKANIK_SKILL_DISCO_ELYSIUM_TB40.md)).
- [x] **Task 8.2:** Benchmark lokal model LLM Google Gemma 3 (1B) dan Gemma 4 (E2B) ([`docs/LAPORAN_PENGUJIAN_GEMMA3_TB40.md`](docs/LAPORAN_PENGUJIAN_GEMMA3_TB40.md)) untuk simulasi suara batin fitrah.
- [x] **Task 8.3:** Ekstraksi korpus dalil & taksonomi lengkap Wiki PKN ([`prototype/v2/design/extracted_text_from_https_wikipkn.insanmustaqbal.or.id.md`](prototype/v2/design/extracted_text_from_https_wikipkn.insanmustaqbal.or.id.md)).

### Phase 9: Desain Kanonikal Earth-Tree & Flutter Forui v3/v4 *(Completed)*
- [x] **Task 9.1:** Adopsi sistem desain *Earth-Tree* (sand ecru, mineral basalt, meadow pine green, Merriweather, Plus Jakarta Sans, Amiri).
- [x] **Task 9.2:** Evaluasi kelayakan Flutter di [`prototype/v2/FLUTTER_ANALISIS_DAN_REKOMENDASI.md`](prototype/v2/FLUTTER_ANALISIS_DAN_REKOMENDASI.md) (100% layak dengan Forui + Iconoir).
- [x] **Task 9.3:** Scaffolding `prototype/v3` (eksplorasi Forui) dan pembangunan basis kode native kanonikal di `prototype/v4` (Ronde 1 & 2: Beranda Earth-Tree, P3K Tantrum 10 Detik, Ruang Curhat AI Sanctuary, Detail Dalil, Serial Zaid).
- [x] **Task 9.4:** Pengujian widget test & theme contrast WCAG 2.2 di `prototype/v4` (12/12 passing tests, 0 lint issues).

### Phase 10: Backend v2 Dual-Database Engine, LibSQL Vector & MCP Pipeline *(Completed)*
- [x] **Task 10.1:** Docker Compose stack terpadu (PostgreSQL, Directus CMS port 8055, Alexandrie Hub port 8201) di `prototype/backend v2/compose.yaml`.
- [x] **Task 10.2:** Compiler database offline `build_knowledge_db.py`: menghasilkan `knowledge_build.db` (FTS5 search + LibSQL 384-dim `F32_BLOB(384)` + DiskANN index `libsql_vector_idx`).
- [x] **Task 10.3:** Kompresi Zstandard level 19: menghasilkan rilis semantik `v4.0.0` (`knowledge_v4.db.zst`, 7.69 MB dari 59.1 MB uncompressed) siap unduh OTA.
- [x] **Task 10.4:** Arsitektur sinkronisasi outbox Drift SQLite lokal ke API server python dengan deteksi konflik timestamp (`stale_mutation` 409).
- [x] **Task 10.5:** MCP Server stdio dengan 6 tools (`search_knowledge` [lexical/semantic/hybrid], `get_article`, `get_doa_penenang`, `get_skenario_adab`, `get_agenda_event`, `get_similar_articles`).
- [x] **Task 10.6:** Acceptance test suite `test_backend_v2.py` (7/7 tests passing 100%).

### Phase 11: Prototype v5 Feature Testbed (Charts, Relations, Daily Tasks & 32 Screens) *(Completed)*
- [x] **Task 11.1:** Setup `prototype/v5` dari fondasi bersih v4 dengan penambahan dependensi `fl_chart: ^1.1.0`.
- [x] **Task 11.2:** Verifikasi integritas analisis statis (0 issues) dan pengujian otomatis (23/23 passing tests).
- [x] **Task 11.3:** Uji coba kemampuan chart di Flutter untuk kasus PKN:
  - Stacked Bar Activity Chart Sepekan (Senin–Ahad: Diri, Hati, Ilmu via `fl_chart`).
  - TB-40 Radar / Spider Chart (6 Rumpun Bakat via `fl_chart`).
  - Mizan Fitrah Dynamic Balance Scale (Interaktif physics tilt via `CustomPainter`).
  - Multi-segment Horizon Progress Bar (Segmented pill native).
- [x] **Task 11.4:** Implementasi Fitur Relasi Qalbiyah (`RelationsProgressScreen`):
  - Laporan Neraca Jiwa & Relasi (Filter: Pekan Ini, Bulan Ini, Sepanjang Masa).
  - Kartu Profil Relasi Multi-Persona (Ananda Zaid, Ananda Maryam, Ummu Zaid).
  - Tadabbur Asisten AI dan Rekomendasi Hikmah Esok Hari yang dapat langsung disematkan ke Daily Task.
- [x] **Task 11.5:** Implementasi Fitur Daily Task Amanah Harian (`DailyTaskScreen`):
  - Daftar tugas terkelompok (Todo Relasi, Mujahadah Diri, Target Belajar).
  - Integrasi **Modal Review Kualitas Amalan Adab** (Bottom sheet muhasabah non-gamified: Muthma'innah, Lawwamah, Ammarah).
  - Sinkronisasi status selesai ke neraca pencapaian secara reaktif via Riverpod.
- [x] **Task 11.6:** Pembuatan Feature Showcase Hub & Shell Dock 5-Tab di `prototype/v5` (`Beranda`, `Amanah Harian`, `Curhat AI`, `Lab Chart`, `Relasi Jiwa`).

### Phase 12: Integrasi Komprehensif Data Offline OTA & On-Device AI *(Completed)*
- [x] **Task 12.1:** Implementasi client service Flutter LibSQL Vector & Hybrid Search RRF (`prototype/backend v2/client_examples/libsql_vector_search_service.dart`).
- [x] **Task 12.2:** Panduan & Service On-Device Embedding ONNX INT8 di background isolate Flutter (`prototype/backend v2/client_examples/on_device_embedder_service.dart`).
- [x] **Task 12.3:** Verifikasi 12 sub-prototipe dan pembuatan master indeks [`prototype/README.md`](prototype/README.md).

### Phase 13: Modular Unified Flutter Prototype Compilation *(Completed)*
- [x] **Task 13.1:** Bangun wadah kompilasi modular (`prototype/compile/`): satukan core UI (v4), relasi/daily task (v5), Teman Curhat (AI v1), Agenda (Event v1), Micro-learning (v0), dan Khazanah LibSQL (backend v2).
- [x] **Task 13.2:** Implementasi `FeatureFlagsConfig`: setiap fitur dapat diaktifkan/dinonaktifkan secara independen tanpa merusak navigasi atau modul lain, dilengkapi control panel interaktif dan dock adaptif.
- [x] **Task 13.3:** Verifikasi pengujian otomatis dan analisa statis (0 errors, 0 warnings, 14/14 tests passing) pada prototipe modular `prototype/compile/`.

### Phase 14: Local Multi-Platform Execution, Web Release Server & Tailscale Validation *(Completed)*
- [x] **Task 14.1:** Peluncuran versi Web lokal (`http://localhost:3010`) dan Android Studio terpadu (`DISPLAY=:1` Wayland) di lingkungan pengembang lokal.
- [x] **Task 14.2:** Investigasi dan perbaikan kendala chunk loading RequireJS (`image_cache.dart script error`) pada penjelajahan remote Tailscale.
- [x] **Task 14.3:** Kompilasi bundle produksi teroptimasi (`flutter build web --release`, single `main.dart.js` 3.2 MB) untuk mengeliminasi ketergantungan RequireJS dinamis.
- [x] **Task 14.4:** Implementasi web server mandiri berkinerja tinggi [`prototype/compile/serve_web.py`](prototype/compile/serve_web.py) dengan dukungan MIME type WebAssembly/JS, CORS, header COEP/COOP, dan SPA fallback routing.
- [x] **Task 14.5:** Validasi akses lintas perangkat via Tailscale VPN (`http://100.118.34.69:3010` & `http://cachyos-5600gt.tail0faa6b.ts.net:3010`), verifikasi respons HTTP 200 OK di semua endpoint aset.
- [x] **Task 14.6:** Penyusunan master checklist modularitas OMP ([`prototype/compile/MODULAR_CHECKLIST_OMP.md`](prototype/compile/MODULAR_CHECKLIST_OMP.md)) dengan status 15/15 terverifikasi.

---

## 4. Developer Quick Reference & Commands

### Flutter Commands
```bash
# From the repository root
cd prototype/v0

# Install dependencies
flutter pub get

# Run static analyzer (wajib 0 issues)
flutter analyze

# Run all automated tests (wajib 13/13 passing)
flutter test

# Run app on connected device / emulator
flutter run
```

### Git & Remote Repository
* **Remote Repository:** [`https://github.com/decaller/PKN-healing-mobile-app`](https://github.com/decaller/PKN-healing-mobile-app)
* **Active Branch:** `main`

---

## 5. Indeks Dokumen Desain & Konsep

1. 🗺️ **Peta User Journey 17 Persona**: [`docs/USER_JOURNEYS.md`](docs/USER_JOURNEYS.md)
2. 👥 **17 Profil Persona Otentik**: [`docs/personas/`](docs/personas/)
3. 🎮 **Konsep Game Baitul Fitrah & Madinah Virtual**: [`docs/GAME_CONCEPT_VIRTUAL_FITRAH.md`](docs/GAME_CONCEPT_VIRTUAL_FITRAH.md)
4. ⚙️ **Analisis Kebutuhan Stack Teknis 2D/3D Game**: [`docs/TECH_STACK_GAME_ANALYSIS.md`](docs/TECH_STACK_GAME_ANALYSIS.md)
5. 📋 **Inventaris & Preparasi Elemen Simulasi**: [`docs/PREPARASI_ELEMEN_SIMULASI.md`](docs/PREPARASI_ELEMEN_SIMULASI.md)
6. 🎨 **Audit & Saran Pengembangan Desain Figma**: [`design/ANALISIS_DAN_PENGEMBANGAN.md`](design/ANALISIS_DAN_PENGEMBANGAN.md)
7. 📐 **Spesifikasi Token Desain**: [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md)
8. 📄 **Dokumentasi Komprehensif Master PDF**: [`docs/PKN_Mobile_Documentation.pdf`](docs/PKN_Mobile_Documentation.pdf)
9. 💎 **Referensi Desain Modern UI/UX**:
   - [Oiloil UI](https://ui.oiloil.org/en/) (*Calm tech, minimalis, kontemplatif, zero visual noise*)
   - [21st.dev](https://21st.dev/) (*Micro-interactions, design engineering, tactile learning tooltips & HUDs*)
10. 📑 **Dokumentasi Komprehensif Temuan Riset & Arah Baru**: [`docs/DOKUMENTASI_TEMUAN_DAN_ARAH_BARU.md`](docs/DOKUMENTASI_TEMUAN_DAN_ARAH_BARU.md)
11. 🧭 **Cetak Biru Simplifikasi Dual-Core (Wiki-Tools × RPG)**: [`docs/RISET_DUAL_CORE_WIKI_DAN_NARRATIVE_RPG.md`](docs/RISET_DUAL_CORE_WIKI_DAN_NARRATIVE_RPG.md)
12. 🧠 **Riset Mekanik TB-40 Ala Disco Elysium**: [`docs/RISET_MEKANIK_SKILL_DISCO_ELYSIUM_TB40.md`](docs/RISET_MEKANIK_SKILL_DISCO_ELYSIUM_TB40.md)
13. 📊 **Laporan Pengujian Empiris Google Gemma 3 (TB-40)**: [`docs/LAPORAN_PENGUJIAN_GEMMA3_TB40.md`](docs/LAPORAN_PENGUJIAN_GEMMA3_TB40.md)
14. 🔍 **Kritik Desain & Evaluasi Lean Product**: [`design/DESIGN_CRITIQUE.md`](design/DESIGN_CRITIQUE.md) & [`design/IDEA_REFINEMENT.md`](design/IDEA_REFINEMENT.md)
15. 🎭 **Data Skenario JSON Graf Multi-Karakter**: [`prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json`](prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json)
16. 💖 **Konsep Mekanik Riyadhoh & Dinamika Tangki Cinta**: [`docs/KONSEP_MEKANIK_RIYADHOH_DAN_TANGKI_CINTA.md`](docs/KONSEP_MEKANIK_RIYADHOH_DAN_TANGKI_CINTA.md)
17. 🎙️ **Riset Edge AI LiteRT, Voice Dialectics (TTS) & Teman Curhat**: [`docs/RISET_EDGE_AI_LITERT_DAN_VOICE_CURHAT.md`](docs/RISET_EDGE_AI_LITERT_DAN_VOICE_CURHAT.md)
18. 📖 **Spesifikasi Struktur Cerita Dual-Mode & Sandbox Bertema**: [`docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md`](docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md)
19. 🧪 **Dokumen Master TODO Tes Teknologi**: [`docs/TODO_TES_TEKNOLOGI.md`](docs/TODO_TES_TEKNOLOGI.md)
20. 🛡️ **Master Audit Kepatuhan, Store Differentiation & Arsitektur**: [`COMPLIANCE_AND_ARCHITECTURE.md`](COMPLIANCE_AND_ARCHITECTURE.md)

