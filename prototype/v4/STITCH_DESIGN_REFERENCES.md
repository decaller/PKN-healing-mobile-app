# Katalog Desain Google Stitch & Pemetaan Referensi Prototipe v4

> **Dokumen Audit & Pemetaan Referensi Desain**  
> **Sumber Aset:** `design/stitch_pkn_healing_mobile_app(2)/stitch_pkn_healing_mobile_app/` (77 Layar Eksplorasi)  
> **Kurasi Matang (32 Layar Earth-Tree):** [`prototype/v2/design/`](../v2/design/) & [`prototype/v2/KATALOG_DAN_ARSITEKTUR_32_LAYAR.md`](../v2/KATALOG_DAN_ARSITEKTUR_32_LAYAR.md)  
> **Target Implementasi:** `prototype/v4/` (Baseline Rilis) & `prototype/v5/` (Feature Testbed: Charts, Relations, Daily Tasks)

---

## 1. Ringkasan Eksekutif Hasil Google Stitch

Direktori `design/stitch_pkn_healing_mobile_app(2)` memuat seluruh artefak desain hasil eksplorasi **Google Stitch** yang komprehensif. Koleksi ini terdiri dari:

1. **3 Dokumen Fondasi Produk & Arsitektur:**
   - 📄 [`prd_pkn_healing_mobile_app.md`](file:///home/abuhafi/Project/PKN-healing-mobile-app/design/stitch_pkn_healing_mobile_app(2)/stitch_pkn_healing_mobile_app/prd_pkn_healing_mobile_app.md): Spesifikasi produk lengkap (5 Modul Inti, Persona Abu Zaid/Ummu Zaid, Fase Tamyiz 7–10 thn, kepatuhan manhaj, zero cloud leak).
   - 📄 [`skill_panduan_contextual_anti_slop_redesign.md`](file:///home/abuhafi/Project/PKN-healing-mobile-app/design/stitch_pkn_healing_mobile_app(2)/stitch_pkn_healing_mobile_app/skill_panduan_contextual_anti_slop_redesign.md): Standar Anti-Slop (kejujuran data, no-streak shaming, no fake countdowns, WCAG 2.2 AAA, touch targets 48dp).
   - 📄 [`panduan_layout_out_of_the_box_non_card_redesign.md`](file:///home/abuhafi/Project/PKN-healing-mobile-app/design/stitch_pkn_healing_mobile_app(2)/stitch_pkn_healing_mobile_app/panduan_layout_out_of_the_box_non_card_redesign.md): Panduan layout *Out-of-the-Box* non-kartu (Editorial Terbuka, Action Spine, Indeks Bertingkat, Kanvas 3-Zona).

2. **77 Direktori Layar Desain (HTML Tailwind + PNG Pratinjau):**
   Mencakup seluruh spektrum alur pengguna dari beranda, darurat krisis 10 detik, konseling batin AI, simulasi karakter RPG beradab, instrumen bakat TB-40, hingga tiket daurah offline.

---

## 2. Taksonomi 77 Layar Berdasarkan Modul Produk

```
                                 [ PKN Healing App ]
                                          │
    ┌───────────────┬────────────────┬────┴───────────┬───────────────┬───────────────┐
    │               │                │                │               │               │
[Beranda]       [P3K Krisis]    [Curhat AI]      [Kisah RPG]     [Instrumen]     [Khazanah &]
(Home Hub)      (Guidance-First)(Sanctuary)      (Rehearsal)     (TB-40 & Mizan) [Event E-Pass]
```

### A. Modul 1: Beranda & Varian Hub (14 Layar)
* **Model Earth-Tree (Kanonikal v4):**
  - `home_screen_light_mode_earth_tree/` & `home_screen_dark_mode_earth_tree/` *(Sudah diimplementasikan di v4)*
  - `home_screen_light_mode_multi_serial_carousel/` & `home_screen_dark_mode_multi_serial_carousel/`
  - `home_screen_light_mode_serial_milestone/` & `home_screen_dark_mode_serial_milestone/`
* **Model Eksplorasi Alternatif:**
  - `beranda_pkn_flutter_m3/` (Model M3 awal)
  - `pkn_healing_beranda_eksekutif/`, `pkn_healing_beranda_serial_hub/`, `pkn_healing_beranda_terra/`
  - `beranda_model_a_social_stories_feed/` (Model linimasa cerita)
  - `beranda_model_b_streaming_audio_hub/` (Model pemutar kajian/audio)
  - `beranda_model_c_bento_box_mindful_sanctuary/` (Model bento mindful)
  - `beranda_model_d_interactive_card_deck/` (Model tumpukan kartu swipe)
  - Super-app benchmarks: `model_1_gojek_wechat_super_app_hub/`, `model_2_tokopedia_shopee_marketplace/`, `model_3_halodoc_alodokter_klinik_jiwa/`

---

### B. Modul 2: P3K & Protokol Krisis Lapangan (2 Layar)
* **`resep_krisis_10_detik_tantrum_publik/`** ⭐ *(Prioritas Utama)*
  - Struktur: *Action Spine* (TL;DR Lead box 10-detik, Batasan Hukum Syar'i perlindungan anak, 3 langkah SOP bertahap, tombol cepat bagikan & cetak).
* **`telaah_dalil_kedisiplinan_usia_10_thn/`**
  - Telaah matan hadits dan fiqih tarbiyah fase Tamyiz menuju Murahaqah.

---

### C. Modul 3: Teman Curhat AI & Sanctuary (7 Layar)
* **`ruang_curhat_ai_sanctuary/`** ⭐ *(Prioritas Utama)*
  - Indikator 100% On-Device / Zero Cloud Leak.
  - Barometer Nafs Al-Insan 3 Tingkatan (*Ammarah* $\rightarrow$ *Lawwamah* $\rightarrow$ *Muthma’innah*).
  - Mikrofon audio visualizer berdenyut (*pulsating concentric rings*).
  - Resep Doa Penenteram Hati (QS. Thaha: 25-26 berharakat lengkap) + tombol salin/simpan.
* `teman_curhat_ai_barometer_nafs/` & `teman_curhat_ai_pkn_flutter_m3/` & `teman_curhat_ai_terra/`
* `kabinet_muhasabah_tb_40_mobile/` & `kabinet_muhasabah_tb_40_full_screen/` (Thought cabinet untuk menyimpan wawasan jiwa).
* `rive_showcase_kabinet_muhasabah_nafs_mandala/` (Visualisasi mandala nafs).

---

### D. Modul 4: Kisah & Living Rehearsal RPG (15 Layar)
* **`detail_serial_pemilihan_episode/`** ⭐ *(Prioritas Utama)*
  - Banner hero dramatis suasana meja makan temaram.
  - Ringkasan adab & meta bakat (*Syajaa'ah & Rifq*, Fase Tamyiz 9 Thn).
  - Manajemen Save Slot (Slot 1: Ayah Lembut vs Save Baru).
  - Daftar episode interaktif serial Zaid.
* **`living_rehearsal_rpg_mobile/`** & `mode_2_living_rehearsal_rpg_full_screen/` ⭐
  - Mini-game HUD: Thuma'ninah meter, Sakinah hati meter, penanda waktu 18:35 WIB.
  - Kanvas isometrik atmosferik dengan interactive orbs (*Firaasah*, *Syajaa'ah*, *Anaah*).
  - Dialog bercabang dengan konsekuensi psikis anak tanpa *Game Over*.
* `mode_2_lemparan_dadu_adab_islah/` & `pemeriksaan_dadu_adab_2d6_mobile/` & `pemeriksaan_dadu_adab_2d6_full_screen/` (Pemeriksaan dadu 2d6 resolusi ishlah).
* `mode_2_simulasi_dialog_batin_tb_40/` & `pita_dialog_6_suara_batin_tb_40/` (Pita dialog 6 suara batin).
* `mode_1_sinematik_sirah_mobile/`, `mode_1_pemutar_animasi_sirah/`, `mode_1_sinematik_sirah_theater_mode/` (Mode pemutar sinematik sirah).
* `rive_state_machine_karakter_reaktif_zaid/` & `rive_reaktif_rekonsiliasi_islah_zaid/` (State machine animasi karakter anak).
* `modal_manajemen_save_slot/` & `laporan_pertumbuhan_adab/` (Rubrik BT/MT/BK/MM).

---

### E. Modul 5: Instrumen Bakat Syakilah TB-40 & Mizan Fitrah (6 Layar)
* **`matriks_syakilah_tb_40_mobile/`** & `matriks_syakilah_6_rumpun_bakat_tb_40/` & `matriks_syakilah_tb_40_full_screen/`
  - Visualisasi 6 rumpun bakat tarbiyah berbasis taksonomi TB-40.
* **`timbangan_resonansi_jiwa_mizan_fitrah/`** & `timbangan_resonansi_fitrah_mizan_6_rumpun/`
  - Kalkulator timbangan keselarasan fitrah (Mizan).
* `rive_dynamic_physics_timbangan_mizan_fitrah/` & `first_principles_parenting_simulator/`

---

### F. Modul 6: Khazanah Wiki, Glosarium & Brankas Luring (9 Layar)
* **`peta_induk_khazanah_fitrah_moc/`** & `khazanah_wiki_flutter_m3/` (Peta Induk 6 Pilar Fitrah).
* `glosarium_istilah_syakilah/` (Kamus definisi istilah syar'i).
* `pencarian_khazanah_anak_membantah/` (Hasil pencarian kontekstual krisis).
* `halaman_utama_koleksi_brankas_luring/` & `layar_baca_luring_catatan_pribadi/` & `modal_buat_folder_koleksi_tematik/` (Sistem brankas offline personal).
* `fitrah_learning_path_bite_sized_player/` & `pemutar_audio_bedtime_driving/` (Audio player nada rendah).

---

### G. Modul 7: Agenda Event & E-Pass Majelis (6 Layar)
* **`agenda_event_daurah_flutter_m3/`**
  - Jadwal daurah tatap muka dan webinar online.
* **`detail_event_kuota_syar_i_pkn/`**
  - Transparansi alokasi kursi ikhwan/akhwat tanpa manipulasi FOMO.
* **`detail_event_digital_e_pass/`** ⭐
  - E-Pass tiket digital luring dengan QR Code siap scan panitia.
* `pilih_tiket_checkout_peserta/`, `pembayaran_bsi_bukti_transfer/`, `e_ticket_dinamis_scanner_panitia/`.

---

### H. Modul Onboarding (1 Layar)
* `onboarding_diagnostik_amanah/`: Alur diagnostik peran orang tua dan penetapan fase anak binaan.

---

## 3. Rekomendasi Roadmap Halaman Referensi untuk Prototipe v4

Dari 77 layar di atas, berikut adalah **5 Layar Prioritas Utama** yang paling relevan untuk diimplementasikan ke dalam [`prototype/v4`](./) sebagai kelanjutan dari Beranda yang sudah aktif:

| Prioritas | Nama Layar Referensi Stitch | Rute / Konteks di v4 | Manfaat & Nilai Produk |
|---|---|---|---|
| 🥇 **1** | `resep_krisis_10_detik_tantrum_publik/` | **P3K Tantrum Screen** (via Bento & P3K Grid) | Memberikan pertolongan pertama 10 detik saat orang tua panik menghadapi anak tantrum di ruang umum. Memenuhi janji utama produk (*Guidance-First*). |
| 🥈 **2** | `ruang_curhat_ai_sanctuary/` | **Curhat AI Screen** (via Tab Navigasi #3 & Tombol PTT) | Tempat orang tua menumpahkan rasa bersalah/emosi secara privat. Menghadirkan Barometer Nafs (Ammarah-Lawwamah-Muthma'innah) & Doa Penenteram Hati. |
| 🥉 **3** | `detail_serial_pemilihan_episode/` | **Detail Serial Screen** (via Kartu Cerita Beranda) | Menghubungkan kartu cerita Zaid di Beranda dengan daftar episode lengkap, manajemen save slot, dan sinopsis adab. |
| 4 | `detail_event_digital_e_pass/` | **Event E-Pass Screen** (via Highlights Carousel & Tab #2) | Menampilkan tiket daurah offline dengan nomor kursi syar'i dan QR code yang dapat dibuka tanpa internet. |
| 5 | `matriks_syakilah_tb_40_mobile/` | **Matriks TB-40 Screen** (via P3K Grid Instrumen) | Menampilkan eksplorasi 40 bakat anak dan kalkulator keselarasan fitrah. |

---

## 4. Panduan Konversi Desain Stitch ke Flutter v4 (Earth-Tree)

Saat mentranslasikan layar referensi Stitch ke basis kode `prototype/v4`:
1. **Gunakan Forui + Iconoir:** Ganti seluruh class HTML Material Symbols dengan widget `iconoir_flutter`.
2. **Gunakan Token Warna `context.earthTree`:** Ganti palet Tailwind `#101419` / `#14b8a6` dengan token semantik Earth-Tree (`surfaceContainerLowest`, `celestialSky`, `meadowCanopy`, `tactileBorder`).
3. **Patuhi Anti-Slop Layout:** Pertahankan struktur *Action Spine* (tindakan utama di atas, rujukan dalil di bawah) dan hindari pembungkusan berulang kartu di dalam kartu (*nested card slop*).
4. **Offline-Ready:** Sediakan fallback data luring untuk teks doa, dalil, dan SOP krisis.
