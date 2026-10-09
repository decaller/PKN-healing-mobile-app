# 🛡️ Analisis Kepatuhan (Compliance), Diferensiasi Toko Aplikasi, & Arsitektur Mobile

> **Status Dokumen:** Master Governance, Regulatory & Architectural Compliance Audit  
> **Tanggal:** 9 Oktober 2026  
> **Target Ekosistem:** PKN Healing Mobile App (Flutter — iOS & Android)  
> **Ruang Lingkup:** Seluruh dokumen riset baru, skenario JSON, arsitektur teknis, dan antarmuka aktif  

---

## 📌 Ringkasan Eksekutif

Dokumen ini mencatat evaluasi kepatuhan (*compliance*) menyeluruh atas evolusi konsep dan dokumen teknis terbaru di repositori `PKN-healing-mobile-app`. Evaluasi difokuskan pada tiga ranah yang saling mengunci:
1. **Kepatuhan Dokumen & Konten:** Safeguarding anak, fiqih pengasuhan, privasi data (UU PDP No. 27/2022), batasan medis non-klinis, dan autentisitas nash syar'i.
2. **Diferensiasi Produk vs Kepatuhan Toko Aplikasi:** Strategi penempatan kategori, kebijakan Google Play Generative AI & Health Content, kebijakan Apple App Store Review Guidelines, dan klasifikasi rating usia IARC.
3. **Arsitektur Teknis vs Kepatuhan Sistem Operasi:** Desain *local-first zero-cloud*, batas ukuran binary 150 MB (Play Asset Delivery), pengelolaan daur hidup mikrofon (*Foreground Service Android 14+ / iOS Audio Session*), serta integritas mesin graf naratif deterministik.

---

## BAGIAN 1: Audit Kepatuhan Dokumen Baru (5 Pilar Compliance)

### 1.1. Pilar I: Child Safeguarding & Fiqih Parenting (Keselamatan Fisik & Emosi Anak)

| Lokasi Bukti / Klausul | Temuan / Bunyi Teks | Status Kepatuhan | Analisis Kritis & Risiko Regulasi | Rekomendasi Remediasi Wajib |
|---|---|:---:|---|---|
| [`prototype/v0/lib/features/feed/presentation/screens/feed_screen.dart:187,275`](prototype/v0/lib/features/feed/presentation/screens/feed_screen.dart)<br>[`docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md:177`](docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md)<br>[`prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json:241`](prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json) | *"Hadirkan pelukan penenteram jiwa"*, *"peluk saat ia marah"*, *"memeluk erat selama 3 menit tanpa ceramah"*. | ⚠️ **Non-Compliant (Safeguarding Risk)** | **Pemaksaan Kontak Fisik (*Forced Touch*):** Anak dalam kondisi tantrum berat atau disregulasi sensorik (*sensory overload*) dapat meronta jika dipeluk paksa. Hal ini berisiko mencederai anak/orang tua, memperburuk histeria, dan melanggar prinsip…
| [`prototype/v0/lib/features/feed/presentation/screens/feed_screen.dart:270`](prototype/v0/lib/features/feed/presentation/screens/feed_screen.dart)<br>[`prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json:219`](prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json) | *"Larangan keras memukul sebelum usia 10 tahun."* | ⚠️ **Risiko Misinterpretasi Hukum & Syar'i** | **Implikasi Legalisasi Kekerasan Fisik:** Redaksi negatif ganda ini rawan disalahartikan bahwa setelah 10 tahun, orang tua bebas memukul dengan keras. Menurut syariat (HR. Abu Dawud no. 495), batasannya adalah *dharbun ghairu mubarrih* (ketegasan mendidik tanpa melukai, pantang berbekas, haram memukul wajah). Menurut hukum positif (UU Perlindungan Anak No. 35/2014 Pasal 76C), kekerasan fisik dilarang mutlak. | Reform…
| [`docs/KONSEP_MEKANIK_RIYADHOH_DAN_TANGKI_CINTA.md:75,133`](docs/KONSEP_MEKANIK_RIYADHOH_DAN_TANGKI_CINTA.md) | Opsi *Munkar* (bentakan/ancaman) berbiaya **0 Cinta** dengan peringatan merusak jiwa. | ✅ **Compliant (Pedagogical Win)** | **Refleksi Psikologis Akurat:** Melampiaskan emosi destruktif tidak membutuhkan kendali diri (*low energy*), sedangkan menahan amarah membutuhkan perjuangan (*Riyadhoh/Mujahadah*). Tidak ada *Game Over*, melainkan memicu *Jalur Islah* (rekonsiliasi). | Pertahankan mekanik ini sebagai inti diferensiasi anti-guilt game. |

---

### 1.2. Pilar II: Privasi Data, Hak Anak & Regulasi AI (UU PDP No. 27/2022 & GDPR)

| Aspek Regulasi | Dasar Hukum / Standar | Status | Analisis Arsitektur & Kepatuhan |
|---|---|:---:|---|
| **Perekaman Suara Berkelanjutan (*Continuous Voice Loop*)** | • UU PDP No. 27/2022 Ps. 20 (Persetujuan Pemrosesan Data Spesifik)<br>• Apple Guideline 5.1.2 & Google Microphone Policy | ⚠️ **Perlu Klausul Ketat** | Fitur *Hands-Free Voice Loop* (VAD otomatis mendengarkan tanpa menekan tombol mic) di [`docs/RISET_EDGE_AI_LITERT_DAN_VOICE_CURHAT.md`](docs/RISET_EDGE_AI_LITERT_DAN_VOICE_CURHAT.md) dilarang merekam di latar belakang (*background listening*). Mikrofon **wajib foreground-only**, disertai visualisasi pulsing aktif, serta tombol pemutus manual (*Mute/Stop*). |
| **Prinsip *Zero-Retention* Data Audio** | • UU PDP Ps. 27 (Penghapusan & Pemusnahan Data)<br>• GDPR Art. 5(1)(e) (Storage Limitation) | ⚠️ **Wajib Tertulis di Policy** | Rekaman suara curhat memuat aib dan rahasia keluarga. **Buffer audio PCM/WAV di RAM wajib langsung dimusnahkan segera setelah transkripsi STT selesai.** Dilarang menyimpan file audio curhat ke disk atau mengirimnya ke server analitik pihak ketiga. |
| **Evaluasi Otomatis & Skor Anak (*Automated Profiling*)** | • UU PDP No. 27/2022 Ps. 25 (Perlindungan Data Anak)<br>• UU PDP Ps. 50 (Hak atas Profiling Otomatis) | ✅ **Compliant (Terisolasi di Game)** | Temuan F9 pada [`design/DESIGN_CRITIQUE.md`](design/DESIGN_CRITIQUE.md) berhasil diatasi: parameter *Tangki Cinta (misal: 15%)* dan *Nafs Barometer* diisolasi sebagai **studi kasus fiksi sandbox game** ([`docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md`](docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md)), bukan penilaian/vonis terhadap anak kandung di dunia nyata. |

---

### 1.3. Pilar III: Batasan Medis & Kesehatan Mental (Non-Clinical Boundaries)

Di [`docs/RISET_EDGE_AI_LITERT_DAN_VOICE_CURHAT.md:215`](docs/RISET_EDGE_AI_LITERT_DAN_VOICE_CURHAT.md), agen pendamping batin (*Ummu Rahmah*) menenangkan ibu yang stres (*Parental Burnout / Postpartum Depression*).

| Klausul Kepatuhan | Standar Industri Toko Aplikasi | Status | Tindakan Mitigasi yang Diperlukan |
|---|---|:---:|---|
| **Disclaimer Non-Medis & Non-Psikiatris** | Google Play Health Content Policy & Apple Guideline 1.4.1 (Medical Apps). Aplikasi dilarang mengklaim fungsi terapi medis/psikologis klinis tanpa izin resmi tenaga kesehatan. | ⚠️ **Wajib Ditambahkan** | Tambahkan *Medical Disclaimer Card* pada antarmuka onboarding dan ruang curhat: <br>*"Aplikasi ini adalah media edukasi adab dan refleksi spiritual keluarga, bukan pengganti konsultasi dengan psikolog, psikiater, atau tenaga medis profesional."* |
| **Protokol Eskalasi Krisis Darurat (*Emergency Crisis Escalation*)** | Standar Etika AI Interaktif: Jika terdeteksi indikasi bahaya akut (ide bunuh diri, kekerasan fisik ekstrem terhadap anak), AI dilarang hanya memberi respon puitis. | ⚠️ **Gap Arsitektur AI** | Wajib ditambahkan modul filter keamanan teks (*Rule-based Safety Trigger*): jika terdeteksi krisis ekstrem, sistem seketika memunculkan tombol darurat langsung ke: <br>• **Layanan SAPA 129** (KemenPPPA RI - Darurat Anak/Perempuan)<br>• **Hotline Kesehatan Jiwa 119 ext. 8** (Kemenkes RI). |

---

### 1.4. Pilar IV: Autentisitas Syar'i & Takhrij Dalil

1. **Resolusi Dilema Takdir vs Usaha (*Jibilliy vs Muktasab*):**
   * *Status:* ✅ **Compliant (Mumtaz)**.
   * *Analisis:* Di [`docs/KONSEP_MEKANIK_RIYADHOH_DAN_TANGKI_CINTA.md`](docs/KONSEP_MEKANIK_RIYADHOH_DAN_TANGKI_CINTA.md), integrasi kaidah Tazkiyatun Nafs (Imam Al-Ghazali & Ibnul Qayyim) berhasil menyelaraskan TB-40. Bakat adalah kecenderungan alami (*Jibilliy*), namun seseorang tetap dituntut berakhlak mulia di luar bakatnya melalui latihan jiwa (*Muktasab / Riyadhoh*).
2. **Kesesuaian Takhrij Nash:**
   * Di [`docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md:144-148`](docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md): Hadits Anas bin Malik tertera teks Arab berharakat dan nomor riwayat shahih (*Shahih Al-Bukhari no. 6038*).
   * Di [`prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json`](prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json): Seluruh opsi memuat dalil Al-Qur'an (QS. Ali 'Imran: 159, QS. Al-Isra: 23) dan hadits nabawiyah pada *educationalTooltip*.
   * *Catatan Takhrij:* Untuk hadits anjuran wudhu saat marah (HR. Abu Dawud no. 4784), sertakan keterangan bahwa sanadnya diperbincangkan ulama namun maknanya shahih dan diamalkan dalam *fadhail a'mal*.

---

### 1.5. Pilar V: Aksesibilitas & Etika Desain (WCAG 2.1 AA & Anti-Guilt UX)

* **Kontras Token & Target Sentuh:** Di [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) dan [`docs/TODO_TES_TEKNOLOGI.md:170-171`](docs/TODO_TES_TEKNOLOGI.md), rasio kontras $\ge 4.5:1$ dan target sentuh minimum $\ge 48\times 48\text{ dp}$ telah ditetapkan sebagai acceptance criteria pengujian (*TEST-7.6 & TEST-7.7*).
* **Tipografi Arab & RTL:** Format teks Arab dikunci menggunakan font Amiri dan atribut `TextDirection.rtl` ([`DESIGN_SYSTEM.md:134`](DESIGN_SYSTEM.md)).
* **Anti-Guilt UX & Zero Cross-Theme Penalty:** Konsep *Sandbox Bertema* ([`docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md:92-106`](docs/STRUKTUR_CERITA_DUAL_MODE_DAN_SANDBOX_TEMA.md)) menghapus penalti kegagalan antar-tema, menolak *streak shaming*, dan mengganti *Game Over* dengan *Jalur Islah*.

---

## BAGIAN 2: Diferensiasi Produk vs Kepatuhan Toko Aplikasi (Store Compliance)

```
┌────────────────────────────────────────────────────────────────────────┐
│            STRATEGI POSISI DIFERENSIASI vs KEBIJAKAN TOKO              │
├─────────────────────────┬──────────────────────────────────────────────┤
│  Kategori App Store     │  Education (Primary) + Lifestyle (Secondary) │
├─────────────────────────┼──────────────────────────────────────────────┤
│  Kategori Google Play   │  Parenting atau Education                    │
├─────────────────────────┼──────────────────────────────────────────────┤
│  Target Audiens Resmi   │  Dewasa / Orang Tua / Pendidik (Usia 18+)    │
├─────────────────────────┼──────────────────────────────────────────────┤
│  Rating Usia (IARC)     │  Everyone 10+ / PEGI 7 (Parental Guidance)   │
├─────────────────────────┼──────────────────────────────────────────────┤
│  AI Declaration         │  Deklarasi Konten AI dengan In-App Report    │
└─────────────────────────┴──────────────────────────────────────────────┘
```

### 2.1. Klasifikasi Kategori: Menghindari Perangkap "Designed for Families"
* **Risiko Fatal Toko:** Jika aplikasi dikategorikan untuk anak-anak, Google Play dan Apple akan memberlakukan aturan *Families Policy / Kids Category* (COPPA/GDPR-K). Aturan ini melarang pelacakan analitik standar, melarang fitur curhat AI bebas, dan menuntut verifikasi usia gerbang orang tua (*Parental Gate*) yang kaku.
* **Solusi Compliance:** 
  * Di Google Play Console dan App Store Connect, tetapkan **Target Audiens: Dewasa / Orang Tua (18+)**.
  * Berikan deskripsi yang menegaskan bahwa aplikasi adalah **Alat Bantu Refleksi Pengasuh (*Caregiver Tool*)**, bukan game yang dimainkan langsung oleh anak-anak balita.

### 2.2. Branding "Healing" vs Kebijakan Aplikasi Medis Toko
* **Apple Guideline 1.4.1 & Google Play Health Policy:** Toko aplikasi menolak keras aplikasi non-medis yang menjanjikan "kesembuhan gangguan jiwa" (*cure/treatment claims*).
* **Solusi Compliance:**
  * Di metadata publik toko (Judul, Subtitle, Keywords, Promo Text): Hindari klaim medis seperti *"Menyembuhkan trauma dan depresi anak"*.
  * Gunakan terminologi: *"Pendamping Pengasuhan Bijak, Refleksi Adab & Penenang Jiwa Keluarga (*Tazkiyatun Nafs*)"*.

### 2.3. Kebijakan Konten AI Generatif (Google Play AI Policy 2024–2026)
* **Aturan Google Play:** Aplikasi berbasis GenAI wajib memiliki fasilitas pelaporan konten (*in-app reporting*), filter konten berbahaya, dan pencegahan jailbreak.
* **Keunggulan Strategis Arsitektur PKN:**
  * Cerita RPG utama berjalan di atas **Graf JSON Statis Kurasi** ([`prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json`](prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json)). Skenario ini **100% deterministik, bebas halusinasi, dan bebas risiko pelanggaran konten toko**.
  * Model LLM lokal (Gemma 3) hanya bertindak sebagai sandbox opsional, dilengkapi sistem prompt berpagar ketat (*system prompt guardrails*).

### 2.4. Opsi "Munkar" vs Kuesioner IARC / ESRB Rating
* **Kuesioner IARC:** Muncul pertanyaan mengenai apakah terdapat kekerasan verbal atau bentakan dalam aplikasi.
* **Solusi Compliance:**
  * Pilihan *Munkar* tidak memuat kata-kata makian kotor/profanitas (*no profanity*), melainkan berupa distorsi emosi (misal: *"Bisa hati-hati tidak kalau makan?!"*).
  * Menargetkan rating **Everyone 10+ (PEGI 7)** dengan deskripsi konten *"Simulasi Dilema Pengasuhan & Konflik Ringan"*.

### 2.5. Keunggulan Etika: Anti-Guilt UX vs Retensi Toko Komersial
* Mainstream mobile game menggunakan taktik retensi gelap (*dark patterns*): *streak shaming, predatory notification, loot box*.
* PKN menolak seluruh taktik tersebut. Sikap ini selaras dengan pedoman **Apple Human Interface Guidelines (Calm Technology)** dan **Google Digital Wellbeing**, yang secara drastis memperbesar peluang aplikasi dipromosikan dalam kurasi editorial (*App of the Day / Featured App*).

---

## BAGIAN 3: Arsitektur Mobile App vs Technical Compliance

```
┌────────────────────────────────────────────────────────────────────────┐
│                        FLUTTER APPLICATION SHELL                       │
├───────────────────────────────────┬────────────────────────────────────┤
│   BASE MODULE (APK/IPA ~35 MB)    │    ON-DEMAND AI PACK (~550 MB)     │
│   • Clean Architecture + Riverpod │    • Play Asset Delivery (PAD)     │
│   • Isar Database (Local-First)   │    • Gemma 3 1B INT4 (.litertlm)   │
│   • Deterministic JSON Graph RPG  │    • Sherpa-ONNX Whisper INT8      │
│   • Audio Player (Opus Offline)   │    • Foreground-Only Mic Lifecycle │
│   • Zero Cloud Leakage            │    • Buffer Dropped from RAM       │
└───────────────────────────────────┴────────────────────────────────────┘
```

### 3.1. Batas Binary 150 MB Google Play & Play Asset Delivery (PAD)
* **Tantangan Arsitektur:** Bundling langsung model Gemma 3 1B INT4 (~550 MB) dan Whisper STT (~99 MB) menghasilkan ukuran installer **> 650 MB**. Google Play membatasi *Base APK* pada Android App Bundle (AAB) maksimal **150 MB**. iOS juga membatasi unduhan seluler jika aplikasi $> 200\text{ MB}$.
* **Solusi Kepatuhan Arsitektur:**
  * Terapkan **Modular Dynamic Feature Delivery / Play Asset Delivery (PAD)**:
    1. **Base App (~30–40 MB):** Berisi Flutter Shell, Wiki-PKN, Tools Darurat, Audio Player, dan Skenario Graf JSON. Aplikasi 100% siap pakai tanpa AI berat.
    2. **On-Demand AI Model Pack (~550 MB):** Bobot model AI diunduh secara terpisah melalui koneksi Wi-Fi hanya jika pengguna mengaktifkan fitur *"Living Rehearsal & Teman Curhat Suara"*.

### 3.2. Local-First Architecture: Kepatuhan Tertinggi Data Privacy
* **Desain Zero-Cloud:**
  * Riwayat keputusan, catatan Islah, dan profil keluarga disimpan 100% secara lokal di **Isar Database**.
  * Inferensi suara (Whisper) dan penalaran (Gemma 3) dieksekusi langsung di NPU/GPU ponsel via LiteRT-LM.
* **Hasil pada Store Privacy Declarations:**
  * **Google Play Data Safety Form:** Deklarasi resmi **"Data Collected: NONE (0 Data)"** dan **"Data Shared: NO"**.
  * **Apple Privacy Nutrition Labels:** Meraih badge privasi tertinggi **"Data Not Collected"**.
  * **Kepatuhan Hukum:** Bebas 100% dari liabilitas kebocoran data di bawah **UU PDP Indonesia No. 27/2022**.

### 3.3. Daur Hidup Mikrofon: Android 14+ FGS & iOS Audio Session
* **Regulasi Sistem Operasi:**
  * **Android 14 (API 34+):** Mewajibkan deklarasi Foreground Service spesifik `android:foregroundServiceType="microphone"` dengan notifikasi persisten di status bar.
  * **Apple iOS:** Menolak keras aplikasi yang merekam audio saat aplikasi berada di latar belakang (*background listening rejection*).
* **Solusi Kepatuhan Teknis:**
  * Layanan mikrofon dikunci sebagai **Strictly Foreground-Only**:
    1. Mengikat stream mikrofon dengan `WidgetsBindingObserver`.
    2. Jika layar mati atau aplikasi diminimalkan (`AppLifecycleState.paused`), stream mic **seketika diputus (*instant teardown*)**.
    3. Buffer audio di memori volatil (RAM) langsung di-*clear* setelah proses transkripsi selesai.

### 3.4. Deterministic Graph Engine: Benteng Kepatuhan Konten Syariat
* **Tantangan AI Generatif:** LLM murni rentan halusinasi, bias fatwa, atau memberikan anjuran parenting yang tidak selaras syariat.
* **Solusi Kepatuhan Arsitektur:**
  * Logika percabangan cerita diisolasi dalam **Graph Node Tree JSON** yang telah diaudit oleh tim syar'i.
  * Node keputusan mengevaluasi formula matematika deterministik:
    $$\text{isChoiceEnabled} = (\text{TangkiCinta} \ge \text{BiayaRiyadhoh})$$
  * AI generatif tidak pernah diberi wewenang mengubah hukum adab atau membuat keputusan teologis sendiri.

---

## 📋 Matriks Checklist Kepatuhan & Rencana Aksi (Action Plan)

| Prioritas | Komponen / Berkas | Tindakan Kepatuhan (*Remediation Action*) | Penanggung Jawab |
|:---:|---|---|:---:|
| **P0 (Blocking)** | [`prototype/v0/lib/features/feed/presentation/screens/feed_screen.dart`](prototype/v0/lib/features/feed/presentation/screens/feed_screen.dart)<br>[`prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json`](prototype/v0/assets/data/scenarios/skenario_krisis_shalat_rumah.json) | Perbaiki redaksi krisis: ubah instruksi pelukan paksa menjadi kontak fisik bersyarat atas persetujuan anak; perjelas formulasi sanksi usia 10 tahun selaras kaidah *ghairu mubarrih*. | Content & Lead Dev |
| **P0 (Blocking)** | Onboarding & Ruang Curhat | Tambahkan *Medical & Crisis Disclaimer* serta tombol kontak darurat langsung ke Layanan SAPA 129 dan Hotline Kesehatan Jiwa 119 ext. 8. | UI/UX & Flutter Dev |
| **P1 (Store)** | Metadata Toko & Google Play Console | Daftarkan kategori **Education / Parenting** dengan target audiens **Dewasa (18+)** untuk menghindari pembatasan Families Policy. | Product Owner |
| **P1 (Arch)** | [`docs/RISET_EDGE_AI_LITERT_DAN_VOICE_CURHAT.md`](docs/RISET_EDGE_AI_LITERT_DAN_VOICE_CURHAT.md) | Terapkan arsitektur **Play Asset Delivery (PAD)** untuk model AI 550 MB agar Base APK tetap di bawah 150 MB. | AI / Mobile Architect |
| **P1 (Arch)** | Lifecycle Audio di Flutter | Kunci mic stream sebagai *foreground-only* via `WidgetsBindingObserver`; terapkan *RAM buffer drop* instan pasca-transkripsi. | Flutter Core Dev |
| **P2 (A11y)** | [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) | Jalankan pengujian empiris kontras warna, target sentuh 48dp, dan text scaling 200% sesuai standar WCAG 2.1 AA. | QA & Accessibility |
