# AI v1 — Teman Curhat AI, Simulasi Edge LLM, & Benchmark Suite

Prototype Flutter mandiri (`ai_v1`) untuk **Teman Curhat AI: Tazkiyatun Nafs & Pendampingan Fitrah** dengan inferensi on-device (Edge LLM & LiteRT). 

Desain dan alur interaksi mengimplementasikan secara presisi spesifikasi dari `prototype/v2/design`:
1. `teman_curhat_ai_mode_pra_chat_template` (Pijakan Permulaan, Prompt Stones & FAQ)
2. `teman_curhat_ai_mode_walkie_talkie_voice` (Transmiter Walkie-Talkie Ruang Qalbu, Living Waveform, Tombol PTT Tactile)
3. `teman_curhat_ai_sesi_chat_generator_dokumen` (Sesi Dialog Fitrah, Matan Hadits Kalbu RTL, Generator Dokumen RPP Adab Harian A4/PDF)

Sistem visual mematuhi **Earth-Tree Design System** (`prototype/v2/design/earth_tree/DESIGN.md`): palet warna Sand-Ecru, Basalt Mineral, Meadow Canopy Green, tipografi ganda (Merriweather Serif & Plus Jakarta Sans), serta ikon vektor Iconoir.

---

## 1. Fitur Utama Prototipe

### A. Mode Pra-Chat & Pijakan Permulaan
- **Banner Ahlan wa Sahlan:** Sapaan hangat dengan penegasan *"Privasi Amanah 100% On-Device • Zero Cloud Leak"*.
- **Input Chamber:** Kotak input luas dengan tombol rekam suara, lampiran catatan lokal, selector hadits/salaf, dan tombol kirim responsif.
- **3 Guidance Stones (Pijakan Permulaan):**
  - *Ide Aktivitas:* Stimulasi bermain sesuai usia tamyiz.
  - *Ide RPP Rumah:* Perencanaan kurikulum keluarga thoyyib pekanan.
  - *Refleksi Diri:* Muhasabah amarah dan penataan ruang batin orang tua.
- **4 FAQ Prompt Cepat Sekali Klik:** Mengisi pertanyaan kontekstual langsung ke kolom curhat.

### B. Konsultasi Sesi Chat & Generator Dokumen RPP
- **Streaming Token On-Device:** Alur respon token-per-token dengan metrik langsung (TTFT ms & tokens/s).
- **Matan Hadits / Dalil Callout Card:** Kartu kutipan dalil nabawiyah bersahaja (font Merriweather Serif, teks Arab RTL, terjemahan, dan penjelasan adab).
- **Embedded Document Card (RPP Adab Fitrah Terapan):**
  - Pembuatan dokumen terstruktur untuk Ananda Zaid (8 Thn, Tamyiz Awal).
  - Memuat: Jadwal transisi senja (17:15 - 18:20), kalimat afirmasi nabawiyah, dan 5 butir ceklis adab harian.
  - Tombol aksi: *Salin Teks* dan *Cetak PDF* (siap cetak format A4).

### C. Mode Walkie-Talkie Ruang Qalbu
- **Sasis Analog Monolit:** Dial frekuensi *"Resonansi Qalbu • 142.4 MHz"* dan kisi-kisi speaker hangat.
- **Living Audio Waveform Visualizer:** Visualisasi gelombang audio dinamis yang merespons getaran suara.
- **Large Tactile Push-To-Talk (PTT) Button:** Tombol lingkaran 96px dengan label *"TAHAN" / "BICARA"* dan animasi ripple halo cincin saat ditekan.
- **Micro-Toggles:** Pengalihan Loudspeaker/Earpiece dan saklar *Noise Filter Fitrah*.
- **Transkripsi Real-Time:** Transkrip dialog suara dua arah.

### D. Edge LLM & LiteRT Benchmark Console
- **Interactive Console di Flutter:** Menjalankan pengujian performa langsung dari aplikasi.
- **Metrik Evaluasi Empiris:**
  - **TTFT (Time to First Token):** Latensi respon awal (ms).
  - **Generation Throughput:** Kecepatan token (tokens/detik).
  - **Prompt Evaluation Speed:** Kecepatan pembacaan konteks (tokens/detik).
  - **Total Latensi:** Waktu komputasi total (ms).
  - **Memory Footprint:** Estimasi RAM per model.
- **Ekspor Laporan Markdown:** Salin ringkasan hasil pengujian dalam format tabel Markdown.

---

## 2. Model Edge yang Didukung & Hasil Pengujian

| Model | Format / Runtime | Ukuran | TTFT (ms) | Speed (tps) | Karakteristik Utama |
|---|---|---|---|---|---|
| **Gemma 3 270M** | GGUF (Ollama Edge) | 291 MB | **~125 ms** | **~108 – 125 tps** | Ultra-ringan, respon instan, ideal untuk mobile hemat daya |
| **Gemma 3 1B** | GGUF (Ollama Edge) | 815 MB | **~850 ms** | **~20 – 35 tps** | Keseimbangan terbaik antara pemahaman bahasa dan memori |
| **Gemma 4 E2B** | GGUF (Ollama Edge) | 4.6 GB | **~570 – 900 ms** | **~13 – 15 tps** | Penalaran mendalam dengan *thinking process* untuk RPP |
| **LiteRT Audio8 (AR)** | TFLite XNNPACK | 64.6 MB | **~140 ms (Init)** | **~8.3 ms / step** | Model neural audio on-device untuk suara Walkie-Talkie |

Laporan empiris lengkap tersedia di [`BENCHMARK_REPORT.md`](BENCHMARK_REPORT.md).

---

## 3. Menjalankan Web

Prasyarat: Flutter 3.29+ / Dart 3.7+ dan Ollama aktif di latar belakang (opsional, aplikasi otomatis beralih ke simulasi on-device jika luring).

```bash
cd "prototype/AI v1"
./run_web.sh
```

Buka `http://localhost:3012` pada browser.

Konfigurasi opsional alamat endpoint Ollama:
```bash
PORT=3012 HOST=0.0.0.0 OLLAMA_URL=http://localhost:11434 ./run_web.sh
```

---

## 4. Menjalankan Skrip Benchmark Mandiri

Untuk mengeksekusi benchmark otomatis lintas model Edge LLM dan LiteRT runtime:

```bash
cd "prototype/AI v1"
python benchmark/benchmark_runner.py
```

Skrip akan menjalankan suite pengujian, mencatat latensi streaming, mengevaluasi file `.tflite` via `litert-benchmark`, dan memperbarui `BENCHMARK_REPORT.md` serta `benchmark/benchmark_results.json`.

---

## 5. Struktur Berkas

```
prototype/AI v1/
├── assets/
│   └── fonts/                    # Merriweather & Plus Jakarta Sans
├── benchmark/
│   ├── benchmark_runner.py       # Skrip otomatisasi benchmark LLM & LiteRT
│   └── benchmark_results.json    # Data mentah metrik empiris
├── design/
│   ├── DESIGN.md                 # Dokumen spesifikasi desain Earth-Tree
│   ├── teman_curhat_ai_mode_pra_chat_template/
│   ├── teman_curhat_ai_mode_walkie_talkie_voice/
│   └── teman_curhat_ai_sesi_chat_generator_dokumen/
├── lib/
│   ├── core/
│   │   ├── models/ai_models.dart
│   │   ├── services/edge_llm_service.dart
│   │   ├── services/benchmark_service.dart
│   │   └── theme/earth_tree_theme.dart
│   ├── ui/
│   │   ├── home_page.dart
│   │   └── views/
│   │       ├── pre_chat_view.dart
│   │       ├── chat_session_view.dart
│   │       ├── walkie_talkie_view.dart
│   │       └── benchmark_view.dart
│   └── main.dart
├── test/
│   └── widget_test.dart
├── run_web.sh                    # Launcher web port 3012
├── pubspec.yaml
├── BENCHMARK_REPORT.md           # Laporan benchmark empiris resmi
└── README.md
```

---

## 6. Verifikasi

```bash
flutter pub get
flutter analyze   # 0 issues found!
flutter test      # All tests passed!
```
