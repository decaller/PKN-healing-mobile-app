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
- [x] **Task 1.2:** Implementasi Riverpod state architecture di `lib/features/`.
- [x] **Task 1.3:** Validasi deserialisasi JSON schema untuk polymorphic lesson cards.
- [x] **Task 1.4:** Pengujian unit test `LessonPlayerNotifier` (13/13 test passing).

### Phase 2: Design Tokens & Theme Foundation *(Completed)*
- [x] **Task 2.1:** Implementasi token warna kanonikal (`AppColors`) & tipografi Inter modern.
- [x] **Task 2.2:** Reusable components: `SegmentedProgressBar`, `AdabBadge`, `ArabicDalilCard`, `MocPilarChip`.
- [x] **Task 2.3:** Spesifikasi token visual dan preview Figma 53 layar di `design/`.

### Phase 3: Onboarding & JTBD Diagnostic Flow *(Completed)*
- [x] **Task 3.1:** Kuesioner diagnostik 4 langkah di `lib/features/onboarding/`.
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

---

### Phase 7: Fondasi Engine Simulasi, Dependensi & Skema Database Isar *(UPCOMING / READY FOR EXECUTION)*
- [ ] **Task 7.1:** Tambahkan dependensi engine ke `pubspec.yaml` (`flame: ^1.18.0`, `bonfire: ^3.11.1`, `rive: ^0.13.0`, `flame_rive: ^1.10.0`, `isar: ^3.1.0+1`, `isar_flutter_libs: ^3.1.0+1`, `workmanager: ^0.5.2`).
- [ ] **Task 7.2:** Definisikan entitas database lokal Isar di `lib/features/simulation/data/models/`:
  - `CharacterEntity`: id, uuid, name, gender, agePhase (Thufulah..Syaikh), exactAgeYears, loveTankLevel (0–100), nafsState (0–2), currentVenueId, lastStateCalculatedAt, masteredAdabKeys, talentScores.
  - `LedgerEventEntity`: id, characterUuid, eventTimestamp, venueId, category, title, narrativeText, isPendingDilemma, dilemmaScenarioId, isResolved, chosenResolutionKey, loveTankImpact, nafsImpact.
  - `RealToVirtualMissionEntity`: id, missionKey, title, realWorldActionDescription, suggestedDurationMinutes, targetAgePhase, loveTankReward, virtualGardenSeedReward, isCompletedToday, lastCompletedAt.
  - `ScenarioProgressEntity`: id, scenarioId, currentActiveNodeId, chosenChoiceHistory, isCompleted, lastPlayedAt, triggeredIslahPathway, acquiredSkillPoints.
- [ ] **Task 7.3:** Bangun arsitektur jembatan Riverpod State Provider $\leftrightarrow$ Bonfire GameController (`SimulationController`, `LedgerNotifier`, `ScenarioPlayerNotifier`).
- [ ] **Task 7.4:** Parser & Graph Loader luring untuk skrip skenario JSON di `assets/data/scenarios/`.
- [ ] **Task 7.5:** Unit test untuk skema entitas Isar, Riverpod state bridge, dan logika prerequisite choice gating.

### Phase 8: Pipeline Aset Vektor Rive & Rigging Manusia Virtual
- [ ] **Task 8.1:** Integrasikan file vektor Rive (`.riv`) untuk 6 arketipe fitrah (Thufulah Boy/Girl, Tamyiz, Murahaqah, Baligh, Syabab, Syaikh).
- [ ] **Task 8.2:** Implementasi State Machine Inputs standar (`loveTankLevel`, `nafsState`, `triggerCry`, `triggerHug`, `triggerShalat`, `triggerAdabMakan`, `triggerSleep`).
- [ ] **Task 8.3:** Sinkronisasi ekspresi mikro wajah (mata, alis, tetesan air mata saat krisis) dan gesture tangan kanan secara anatomis.
- [ ] **Task 8.4:** Rancang widget HUD Flutter dinamis: *Tangki Cinta Gauge* & *Nafs Barometer* (Ammarah, Lawwamah, Muthma'innah).

### Phase 9: Lingkungan 2D Isometrik & Navigasi Bonfire (Baitul Fitrah & 7 Venue)
- [ ] **Task 9.1:** Konversi dan integrasikan peta Tiled JSON untuk *Baitul Fitrah* (Ruang Tamu, Ruang Keluarga, Musholla Rumah, Dapur Barakah, Kamar Tidur Bersekat Usia 10 thn).
- [ ] **Task 9.2:** Implementasi collision layers (`CollisionArea`), zona interaksi furnitur, dan pathfinding otonom Bonfire.
- [ ] **Task 9.3:** Buat sistem pencahayaan siklus waktu 24 jam alami (Fajar, Siang Cerah, Lembayung Senja, Malam Temaram).
- [ ] **Task 9.4:** Hubungkan navigasi ke 6 venue komunitas lainnya (*Kuttab*, *Masjid Jami'*, *Taman Fitrah*, *Pasar Barakah*, *Asrama Santri*, *Ruang Kerja Ayah*).

### Phase 10: Delta-Time AFK Simulation Engine & The Welcome Back Ledger
- [ ] **Task 10.1:** Implementasi algoritma matematika luruh Tangki Cinta offline ($\Delta t = t_{\text{resume}} - t_{\text{last\_exit}}$ dengan koefisien $\lambda_{\text{fase}}$ usia).
- [ ] **Task 10.2:** Evaluasi siklus waktu shalat astronomis & generator otomatis log kejadian background (zero battery consumption).
- [ ] **Task 10.3:** Buat layar UI Flutter `WelcomeBackLedgerScreen` (animasi gulungan perkamen digital, render instan $< 100\text{ ms}$).
- [ ] **Task 10.4:** Modal penyelesaian krisis emosional / dilema adab tertunda dengan pilihan respons *Bahasa Hati*.

### Phase 11: Skenario Dilema Adab, Gating Prasyarat & Multi-Character POV Relay
- [ ] **Task 11.1:** Susun katalog 50+ skenario interaktif berbasis format JSON Graph Node Tree di `assets/data/scenarios/` untuk 6 fase usia (Thufulah s.d. Syaikh).
- [ ] **Task 11.2:** Terapkan arsitektur kendali bergantian (POV Relay mode): pemain mengendalikan anak, orang tua, dan sesepuh/guru secara berestafet dalam satu krisis.
- [ ] **Task 11.3:** Implementasikan widget UI pilihan berjenjang (Mumtaz s.d. Munkar) dengan *Prerequisite Gating* (dinonaktifkan jika syarat bakat TB-40, level adab BT-MM, atau nafs belum terpenuhi).
- [ ] **Task 11.4:** Bangun modal interaktif *Educational Learning Tooltip*: membedah teks dalil syar'i dan analisis gap fitrah saat pemain mengetuk pilihan terkunci.
- [ ] **Task 11.5:** Terapkan percabangan *Jalur Islah & Rekonsiliasi* (No Game Over): kesalahan respon memicu konsekuensi alami dan membuka jalur pemulihan tazkiyah.
- [ ] **Task 11.6:** Bangun katalog misi dunia nyata *Real-to-Virtual Bridge* (peluk anak 3 menit, shalat berjamaah, sirah tidur) dan integrasikan tautan instan ke modul MOC/Dalil.


### Phase 12: Integrasi Komunitas Multi-Persona, Audio Soundscape & Polish Beta
- [ ] **Task 12.1:** Integrasikan soundscape alami (kicau burung fajar, gemericik air wudhu, desau angin) & SFX adab nabawiyah yang menenangkan jiwa.
- [ ] **Task 12.2:** Terapkan prinsip *Anti-Guilt UX* (tanpa penalti jika lama tidak buka aplikasi, sambutan welas asih saat kembali).
- [ ] **Task 12.3:** Profiling performa memori (RAM $< 50\text{ MB}$, startup $< 1\text{ detik}$, 60–120 FPS di perangkat Android/iOS entry-level).
- [ ] **Task 12.4:** Registrasikan rute navigasi tab *"Kampung Fitrah"* di `app_router.dart` dan jalankan pengujian integrasi E2E.

---

## 4. Developer Quick Reference & Commands

### Flutter Commands
```bash
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

### SuperPlane Control Plane (Local Docker)
* **Web UI:** `http://localhost:8095/<ORGANIZATION_ID>/apps/<APP_ID>`
* **CLI:** `superplane apps active`
* **Canvas File:** `superplane/canvas.yaml`

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
15. 🎭 **Data Skenario JSON Graf Multi-Karakter**: [`assets/data/scenarios/skenario_krisis_shalat_rumah.json`](assets/data/scenarios/skenario_krisis_shalat_rumah.json)
16. 💖 **Konsep Mekanik Riyadhoh & Dinamika Tangki Cinta**: [`docs/KONSEP_MEKANIK_RIYADHOH_DAN_TANGKI_CINTA.md`](docs/KONSEP_MEKANIK_RIYADHOH_DAN_TANGKI_CINTA.md)
17. 🎙️ **Riset Edge AI LiteRT, Voice Dialectics (TTS) & Teman Curhat**: [`docs/RISET_EDGE_AI_LITERT_DAN_VOICE_CURHAT.md`](docs/RISET_EDGE_AI_LITERT_DAN_VOICE_CURHAT.md)
18. 📖 **Spesifikasi Struktur Cerita Dual-Mode & Sandbox Bertema**: [`docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md`](docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md)
19. 🧪 **Dokumen Master TODO Tes Teknologi**: [`docs/TODO_TES_TEKNOLOGI.md`](docs/TODO_TES_TEKNOLOGI.md)

