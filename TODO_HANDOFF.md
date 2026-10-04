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

### Phase 7: Baitul Fitrah Virtual Simulation Module (Flame + Bonfire + Rive) *(UPCOMING / READY FOR EXECUTION)*
- [ ] **Task 7.1:** Tambahkan dependensi engine ke `pubspec.yaml`:
  ```yaml
  flame: ^1.18.0
  bonfire: ^3.11.1
  rive: ^0.13.0
  flame_rive: ^1.10.0
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.4
  workmanager: ^0.5.2
  ```
- [ ] **Task 7.2:** Definisikan entitas database lokal Isar di `lib/features/simulation/data/models/`:
  - `CharacterEntity`: id, name, agePhase, loveTank (0–100), nafsState, adabScores.
  - `LedgerEventEntity`: timestamp, venueId, title, description, isPendingDilemma, resolution.
- [ ] **Task 7.3:** Implementasi `DeltaTimeSimulationService`:
  - Menghitung waktu shalat dan siklus adab saat aplikasi dibuka kembali setelah AFK.
  - Menghasilkan daftar log naratif untuk *The Welcome Back Ledger*.
- [ ] **Task 7.4:** Buat prototipe kanvas 2D isometrik ruangan *Baitul Fitrah* (Ruang Keluarga & Kamar Tidur):
  - Menggunakan Bonfire GameWidget dengan kamera isometrik.
  - Penataan furnitur syar'i (meja makan adab, pemisahan tempat tidur usia 10 tahun).
- [ ] **Task 7.5:** Integrasikan avatar Rive (`.riv`) ke dalam Bonfire:
  - Tautkan parameter *Tangki Cinta* ke input State Machine (senyum vs menangis).
  - Tautkan status shalat ke siklus gerakan wudhu & shalat.
- [ ] **Task 7.6:** Buat layar UI Flutter `WelcomeBackLedgerScreen`:
  - Menampilkan gulungan peristiwa saat login kembali (< 100 ms).
  - Modal skenario pilihan respons *Bahasa Hati* untuk menyelesaikan krisis tertunda.
- [ ] **Task 7.7:** Integrasikan tab navigasi ke-3 di `app_router.dart` bertajuk `"Kampung Fitrah"`.

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
* **Web UI:** `http://100.118.34.69:8095/138b4a85-4714-404a-a520-a4eb47c6c777/apps/a51414a1-fbcf-4946-8a05-b98eff0fa61e`
* **CLI:** `superplane apps active`
* **Canvas File:** `superplane/canvas.yaml`

---

## 5. Indeks Dokumen Desain & Konsep

1. 🗺️ **Peta User Journey 17 Persona**: [`docs/USER_JOURNEYS.md`](docs/USER_JOURNEYS.md)
2. 👥 **17 Profil Persona Otentik**: [`docs/personas/`](docs/personas/)
3. 🎮 **Konsep Game Baitul Fitrah & Madinah Virtual**: [`docs/GAME_CONCEPT_VIRTUAL_FITRAH.md`](docs/GAME_CONCEPT_VIRTUAL_FITRAH.md)
4. ⚙️ **Analisis Kebutuhan Stack Teknis 2D/3D Game**: [`docs/TECH_STACK_GAME_ANALYSIS.md`](docs/TECH_STACK_GAME_ANALYSIS.md)
5. 🎨 **Audit & Saran Pengembangan Desain Figma**: [`design/ANALISIS_DAN_PENGEMBANGAN.md`](design/ANALISIS_DAN_PENGEMBANGAN.md)
6. 📐 **Spesifikasi Token Desain**: [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md)
