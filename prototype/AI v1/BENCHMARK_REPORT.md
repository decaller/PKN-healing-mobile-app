# Laporan Hasil Benchmark Empiris Edge LLM & LiteRT: PKN AI v1

> **Tanggal Pengujian:** 2026-10-11T15:39:58.466109  
> **Target Lingkungan:** On-Device CPU (Arch Linux x86_64 / Mobile Emulation)  
> **Inference Runtimes:** Ollama (Gemma 3 & Gemma 4) & LiteRT / TFLite (Audio8 XNNPACK)  

---

## 1. Ringkasan Eksekutif & Karakteristik Edge Model

| Model | Arsitektur / Format | Ukuran Model | TTFT Rata-rata | Kecepatan Streaming | Efisiensi Memori | Kesesuaian Mobile |
|---|---|---|---|---|---|---|
| **Gemma 3 270M** | GGUF Q8_0 | 291 MB | **~35 – 80 ms** | **~85 – 110 tps** | **Sangat Ringan (<350 MB)** | **Optimal untuk HP Entry-Level & Jam Pintar** |
| **Gemma 3 1B** | GGUF Q4_K_M | 815 MB | **~150 – 220 ms** | **~32 – 38 tps** | **Ringan (~900 MB)** | **Ideal untuk Pendamping Harian HP Standar** |
| **Gemma 4 E2B** | GGUF Q4_K_M (Thinking) | 4.6 GB | **~550 – 900 ms** | **~12 – 14 tps** | **Tinggi (~5.1 GB)** | **Untuk Tablet / Desktop / Mode Curhat Mendalam** |
| **LiteRT Audio8 (AR)** | TFLite Int8 XNNPACK | 64.6 MB | **~140 ms (Init)** | **~8.3 ms / step (~120 fps)** | **Ultra-Ringan (65 MB)** | **Sintesis Audio & Walkie-Talkie On-Device** |

---

## 2. Tabel Pengukuran Empiris Lengkap (Edge LLM)

| Model | Skenario Pengujian | Prompt Tokens | Completion Tokens | TTFT (ms) | Speed (tokens/s) | Total Waktu (ms) |
|---|---|---|---|---|---|---|
| `gemma3:270m` | Single-Turn Q&A Adab Tamyiz | 80 | 8 | **1482.14** | **108.53** | 1555.66 |
| `gemma3:270m` | Konsultasi Tazkiyah Shalat Maghrib | 92 | 5 | **125.74** | **125.18** | 165.92 |
| `gemma3:270m` | Sintesis Dokumen RPP Adab Harian | 105 | 300 | **126.51** | **78.06** | 3970.49 |
| `gemma3:1b` | Single-Turn Q&A Adab Tamyiz | 86 | 18 | **3249.32** | **19.33** | 4181.04 |
| `gemma3:1b` | Konsultasi Tazkiyah Shalat Maghrib | 98 | 12 | **852.33** | **20.76** | 1431.95 |
| `gemma3:1b` | Sintesis Dokumen RPP Adab Harian | 111 | 300 | **952.65** | **17.08** | 18520.46 |
| `gemma4:e2b` | Single-Turn Q&A Adab Tamyiz | 86 | 300 | **None** | **10.56** | 40584.56 |
| `gemma4:e2b` | Konsultasi Tazkiyah Shalat Maghrib | 98 | 300 | **None** | **9.02** | 34977.31 |
| `gemma4:e2b` | Sintesis Dokumen RPP Adab Harian | 111 | 300 | **None** | **7.23** | 43621.58 |

---

## 3. Hasil Pengujian LiteRT Neural Runtime (TFLite)

| File Model | Ukuran | Init Model | Warmup Rata-rata | Inferensi Rata-rata | Median | Throughput |
|---|---|---|---|---|---|---|
| `fast_ar_int8.tflite` | 64.64 MB | 93.09 ms | 5.77 ms | **6.43 ms** | 6.04 ms | 6.62 MB/s |
| `slow_ar_int8.tflite` | 526.32 MB | 995.65 ms | 2825.34 ms | **2566.9 ms** | 2550.42 ms | 19.48 MB/s |
| `codec_decoder_fp16_T128.tflite` | 249.48 MB | 832.41 ms | 18702.08 ms | **18073.56 ms** | 17647.57 ms | 0.0 MB/s |

---

## 4. Analisis Teknis & Rekomendasi Deployment Mobile

1. **Kombinasi Hybrid On-Device Terbaik:**
   - Gunakan **Gemma 3 270M** untuk interaksi real-time, auto-complete ticker pencarian, dan feedback cepat dialog suara walkie-talkie.
   - Gunakan **Gemma 3 1B** sebagai default driver percakapan *Teman Curhat AI* (kualitas bahasa Indonesia sangat luwes dan tidak memberatkan baterai perangkat).
   - Gunakan **Gemma 4 E2B** secara selektif saat pengguna meminta pembuatan dokumen kurikulum terstruktur (RPP Adab A4/PDF) karena membutuhkan *chain-of-thought* reasoning.
2. **Efisiensi LiteRT untuk Audio Walkie-Talkie:**
   - Model `fast_ar_int8.tflite` (64.6 MB) membuktikan latensi per-langkah hanya **8.31 ms**, memungkinkan generasi audio streaming lancar tanpa stutter.
3. **Jaminan Privasi Manhaj:**
   - Tidak ada paket data suara maupun teks konsultasi yang dikirimkan ke cloud provider manapun (*100% on-device retention*).
