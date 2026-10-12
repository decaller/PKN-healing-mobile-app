# Spesifikasi Desain & Arsitektur: Teman Curhat AI v1 (Earth-Tree)

> **Dokumen Spesifikasi Desain & Panduan Implementasi**  
> **Dasar Template:** `prototype/v2/design` (`teman_curhat_ai_mode_pra_chat_template`, `teman_curhat_ai_mode_walkie_talkie_voice`, `teman_curhat_ai_sesi_chat_generator_dokumen`)  
> **Tema Visual:** Earth-Tree Design System (`prototype/v2/design/earth_tree/DESIGN.md`)  
> **Prinsip Utama:** *100% On-Device Privacy (Zero Cloud Leak)*, *Fitrah-First*, *Tazkiyatun Nafs*, *Tactile Warmth*.

---

## 1. Filosofi & Karakteristik Desain

Fitur **Teman Curhat AI** dirancang sebagai ruang jeda dan penenteram batin (*Sanctuary*) bagi orang tua dan pendidik dalam menavigasi dinamika pengasuhan anak secara Islami (Tarbiyah Nabawiyah).

1. **Organic Tactility:** Elemen antarmuka menyerupai batu kali halus (*river pebble roundness*), serat kayu alami, dan kertas hangat (*warm parchment*), menjauhkan kesan dingin teknologi modern.
2. **Serene Editorial Modernism:** Tipografi ganda elegan:
   - **Merriweather (Serif):** Digunakan untuk heading utama, kutipan ayat suci Al-Qur'an, dan matan Hadits nabawiyah (termasuk rendering teks Arab bersahaja).
   - **Plus Jakarta Sans:** Digunakan untuk elemen antarmuka, input form, label status, dan body teks yang mudah dibaca.
3. **Privasi Amanah (Zero Cloud Leak):** Menjamin bahwa setiap keluh kesah dan data pengasuhan tidak bocor ke cloud. Ditenagai oleh Edge LLM lokal (*Gemma 3 / Gemma 4 / LiteRT*) yang berjalan langsung di perangkat (*on-device*).

---

## 2. Palet Token Warna Earth-Tree

| Token Nama | Nilai Hex | Peran Antarmuka |
|---|---|---|
| `surface` | `#FDF9F0` | Latar belakang kanvas utama (Sand-Ecru alami) |
| `surface-container-low` | `#F7F3EA` | Kartu latar berjenjang rendah |
| `surface-container` | `#F1EDE5` | Wadah kartu sekunder dan input pill |
| `surface-container-high` | `#ECE8DF` | Kartu kutipan dalil dan panel sasis walkie-talkie |
| `surface-container-highest` | `#E6E2DA` | Pemisah dan border halus |
| `surface-container-lowest` | `#FFFFFF` | Latar putih bersih untuk gelembung chat & dokumen |
| `primary` | `#006194` | Aksen Celestial Sky (tombol kirim, status aktif) |
| `primary-container` | `#007BB9` | Wadah aksen biru langit |
| `primary-fixed` | `#CCE5FF` | Badge dan ikon sorotan lembut |
| `secondary` | `#006D30` | Meadow Canopy Green (status amanah, privasi, kedamaian) |
| `secondary-fixed` | `#95F8A7` | Aksen hijau muda segar |
| `tertiary` | `#7E5223` | Warm Earth Clay (kategori hadits, adab, refleksi kalbu) |
| `on-surface` | `#1C1C17` | Basalt Mineral (teks utama berkontras tinggi lembut) |
| `on-surface-variant` | `#3F4850` | Slate Grey (subteks keterangan dan timestamp) |
| `outline-variant` | `#BFC7D2` | Garis pemisah halus (1px) |

---

## 3. Tiga Template Layar dari `prototype/v2/design`

### A. Template 1: Mode Pra-Chat & Pijakan Permulaan (`teman_curhat_ai_mode_pra_chat_template`)
- **Mode Switcher Pill:** Pilihan cepat antara *"Teks & Dokumen"* dan *"Mode Walkie-Talkie"*.
- **Grounding Welcome Banner:** Sapaan hangat *"Ahlan wa Sahlan, Abu Hafi"* dengan penegasan *"Privasi Amanah 100% On-Device • Zero Cloud Leak"*.
- **Input Chamber Luas:** Textarea responsif dengan tombol utilitas (Rekam Suara, Lampiran Dokumen, Hadits & Salaf, dan Kirim).
- **3 Guidance Stones (Pijakan Permulaan):**
  1. *Ide Aktivitas:* Stimulasi fitrah bermain anak sesuai tahapan usia.
  2. *Ide RPP Rumah:* Perencanaan kurikulum keluarga thoyyib pekanan.
  3. *Refleksi Diri:* Muhasabah amarah dan penataan ruang batin orang tua.
- **FAQ Quick Inquiries (4 Pilihan Sekali Klik):**
  - "Anak 8 tahun menolak shalat Maghrib karena asyik bermain gadget..."
  - "Bagaimana menenangkan dada yang bergemuruh saat anak membantah..."
  - "Cara membedakan bakat kritis (Al-Fathanah) dengan sifat membangkang..."
  - "SOP 10 detik saat anak tantrum histeris di supermarket depan umum..."

### B. Template 2: Walkie-Talkie Ruang Qalbu (`teman_curhat_ai_mode_walkie_talkie_voice`)
- **Visual Sasis Analog:** Kotak instrumen transmisi dengan dial frekuensi *"Resonansi Qalbu • 142.4 MHz"* dan kisi-kisi speaker hangat.
- **Animated Audio Waveform Visualizer:** Batang frekuensi multi-warna (*meadow green* & *celestial sky*) yang bergerak dinamis merespons getaran suara.
- **Large Tactile Push-To-Talk (PTT) Button:** Tombol lingkar 96px dengan label *"TAHAN"*, dilengkapi animasi gelombang cincin (*pulsating halo ripples*) saat ditekan.
- **Micro-Toggles:** Pengalihan Loudspeaker/Earpiece dan saklar *Noise Filter Fitrah On*.
- **Live Stream Transcription:** Transkrip dialog suara langsung dua arah.

### C. Template 3: Sesi Chat & Generator Dokumen RPP (`teman_curhat_ai_sesi_chat_generator_dokumen`)
- **Enkripsi Header:** *"Ruang Konsultasi Fitrah • Enkripsi Berkelanjutan • Model PKN Edge"*.
- **Gelembung Dialog Asimetris:** Pesan orang tua bersudut tajam di sisi pengirim dengan status *"Tersampaikan amanah"*; balasan AI berpenanda *"Tazkiyah Guide"*.
- **Matan Hadits / Dalil Callout Card:** Kartu khusus bersudut melengkung dengan tipografi Arab bersahaja (font Merriweather) berarah RTL, terjemahan, dan rujukan sanad hadits.
- **Embedded Document Card (RPP Adab Fitrah Terapan):**
  - Kartu dokumen A4 / PDF siap cetak terintegrasi langsung di dalam thread chat.
  - Komponen: Judul spesifik anak dan fase usia (contoh: *Ananda Zaid - 8 Thn, Tamyiz*), jadwal transisi senja, kalimat afirmasi nabawiyah, dan checklist adab harian.
  - Aksi interaktif: Pratinjau, Salin Teks, dan Unduh / Cetak Dokumen.

---

## 4. Ekosistem Edge LLM & Pipeline Benchmark

1. **Model Edge yang Didukung:**
   - **Gemma 3 270M (Ultra-Lite Edge):** Model berukuran 291 MB yang dirancang untuk perangkat berdaya rendah, menawarkan kecepatan inferensi $>100$ token/detik.
   - **Gemma 3 1B (Balanced Mobile Edge):** Model berukuran 815 MB yang seimbang antara pemahaman semantik bahasa Indonesia dan efisiensi memori RAM ($<1$ GB).
   - **Gemma 4 E2B (Deep Reasoning Edge):** Model 4.6 GB dengan kemampuan *Chain-of-Thought (Thinking Process)* untuk sintesis dokumen kurikulum dan konsultasi manhaj mendalam.
   - **LiteRT Audio8 Engine (TFLite Runtime):** Model audio autoregresif dan neural codec untuk sintesis suara Walkie-Talkie lokal dengan latensi langkah $<10$ ms.
2. **Indikator Benchmark Empiris:**
   - **TTFT (Time to First Token):** Kecepatan respon mula-mula sejak tombol kirim ditekan (satuan: milidetik).
   - **Generation Throughput:** Kecepatan token yang dihasilkan saat streaming (satuan: token/detik).
   - **Prompt Evaluation Speed:** Waktu parsing konteks dan guardrail sistem (satuan: token/detik).
   - **Memory Footprint:** Estimasi alokasi RAM per model saat aktif.
   - **Manhaj & Guardrail Compliance:** Kepatuhan pada batasan syar'i (tanpa diagnosis medis, tanpa sanksi fisik balita, penyertaan disclosure AI).
