# Katalog Kanonikal 32 Layar Prototipe Earth-Tree & Pemetaan Arsitektur Flutter

> **Dokumen Master Spesifikasi Layar & Arsitektur Visual**  
> **Lokasi Aset Sumber:** `prototype/v2/design/`  
> **Design System:** Earth-Tree Specification (`prototype/v2/design/earth_tree/DESIGN.md`)  
> **Target Implementasi:** Flutter Native (`prototype/v4/` dan `prototype/v5/`)

---

## 1. Ringkasan Eksekutif

Direktori `prototype/v2/design/` memuat seluruh aset pratinjau antarmuka beresolusi tinggi hasil eksplorasi desain **Earth-Tree**:
* **32 Layar HTML Tailwind Interaktif**: Mewakili seluruh alur operasional aplikasi PKN Healing.
* **1 Berkas Design Tokens Master**: `earth_tree/DESIGN.md` (Palet warna membumi: Sand-Ecru `#fdf9f0`, Pine Green `#006d30`, Ocean Blue `#006194`, Terracotta `#7e5223`, dan Slate Basalt `#1c1c17`).
* **1 Korpus Pengetahuan Otoritatif**: `extracted_text_from_https_wikipkn.insanmustaqbal.or.id.md` (106 KB ekstraksi Wiki PKN: 40 Bakat TB-40, dalil fase usia, rukun 3A, dan panduan pengasuhan).

---

## 2. Taksonomi 32 Layar Berdasarkan 10 Kluster Produk

```
                                  [ PKN Healing App (Earth-Tree) ]
                                                 │
     ┌───────────────┬───────────────────────────┼───────────────────────────┬───────────────┐
     │               │                           │                           │               │
[Onboarding &]  [Beranda &]                 [Pendampingan &]            [Khazanah &]    [Ekosistem &]
[Diagnostik]    [Amanah Harian]             [P3K Krisis AI]             [Bakat TB-40]   [Kemitraan]
```

### Kluster 1: Onboarding & Diagnostik Relasi Jiwa
| Direktori Layar | Judul Antarmuka | Komponen Kunci UI | Pemetaan Widget Flutter |
|---|---|---|---|
| `onboarding_pemilihan_peran_personalisasi_fitrah/` | Pemilihan Peran Amanah | 4 kartu peran (Ayah, Bunda, Guru, Pemuda) | `FCard` + `Iconoir.User` + seleksi Riverpod |
| `onboarding_relasi_diagnostik_amanah/` | Diagnostik Relasi Jiwa | Kartu anggota keluarga (Zaid 8 th, Maryam 4 th, Ummu Zaid) | `FCard` + status fase usia (Tamyiz, Thufulah) |

### Kluster 2: Beranda Hub & Amanah Harian (Non-Gamified)
| Direktori Layar | Judul Antarmuka | Komponen Kunci UI | Pemetaan Widget Flutter |
|---|---|---|---|
| `home_screen_light_mode_multi_serial_carousel/` | Beranda Kanonikal Terang | Header salam, Dynamic search ticker, Highlights carousel, Bento grid, Serial carousel | `HomeScreen` (aktif di v4 & v5) |
| `home_screen_dark_mode_multi_serial_carousel/` | Beranda Kanonikal Gelap | Varian tema malam kontemplatif | `HomeScreen` dengan `Brightness.dark` |
| `home_screen_daily_task_collapsible/` | Beranda Daily Task Collapsible | Panel tugas harian yang dapat dilipat (*low cognitive noise*) | `ExpansionTile` berbalut `FCard` |
| `daily_task_amanah_harian_relasi/` | Amanah Harian Abu Hafi | Kategori tugas (Relasi Hati, Diri, Belajar), filter chips | `ListView` + kategori chip + checkbox memicu modal review |
| `modal_review_kualitas_keberhasilan_todo/` | Modal Review Kualitas Adab | Muhasabah sejenak (Muthma'innah, Lawwamah, Ammarah), respon anak | `showModalBottomSheet` dengan tactile indicator |
| `my_progress_relasi_pengasuhan/` | Neraca Jiwa & Relasi | Filter waktu (Pekan Ini/Bulan Ini), Stacked Bar Chart mingguan, kartu profil relasi | `fl_chart.BarChart` + Kartu Persona Relasi |

### Kluster 3: Kurikulum Modul Harian & Serial Pengasuhan
| Direktori Layar | Judul Antarmuka | Komponen Kunci UI | Pemetaan Widget Flutter |
|---|---|---|---|
| `modul_harian_pengasuhan/` | Modul Harian Pengasuhan | Kurikulum 30 hari adab rumah tangga | `ListView` vertikal milestone |
| `detail_modul_thuma_ninah_meja_makan/` | Detail Modul Hari ke-14 | Pijakan Ruhaniyah, Capaian Adab, Langkah Praktik | Card editorial terbuka bertahap |
| `detail_serial_thuma_ninah_meja_makan/` | Serial Meja Makan | Hub serial, premis masalah, milestone serial | Banner 16:9 + slot progres |

### Kluster 4: P3K Krisis Lapangan & Doa Penenang
| Direktori Layar | Judul Antarmuka | Komponen Kunci UI | Pemetaan Widget Flutter |
|---|---|---|---|
| `tips_cepat_resep_krisis_10_detik/` | SOP Resep Krisis 10 Detik | Action Spine, 3 langkah SOP, dalil larangan kekerasan | `P3kCrisisScreen` (aktif di v4 & v5) |
| `doa_penenang_munajat_jiwa/` | Doa Penenang & Munajat Jiwa | Player audio doa nabawi, matan Arab Amiri, terjemah | Audio visualizer + kartu doa tersimpan |

### Kluster 5: Teman Curhat AI & Tazkiyatun Nafs
| Direktori Layar | Judul Antarmuka | Komponen Kunci UI | Pemetaan Widget Flutter |
|---|---|---|---|
| `teman_curhat_ai_mode_pra_chat_template/` | Pra-Chat Konseling Jiwa | Kategori curhat fitrah, pertanyaan umum | Filter chip prompt terarah |
| `teman_curhat_ai_mode_walkie_talkie_voice/` | Walkie-Talkie Ruang Qalbu | PTT (Push-To-Talk), Living waveform visualizer, frekuensi qalbu | PTT gesture button + stream bubble |
| `teman_curhat_ai_sesi_chat_generator_dokumen/` | Generator RPP Rumah Tangga | Kompilasi dialog curhat menjadi dokumen A4 PDF siap cetak | Embedded Document Card + PDF exporter |

### Kluster 6: Skenario Cerita Adab Interaktif (Living Rehearsal)
| Direktori Layar | Judul Antarmuka | Komponen Kunci UI | Pemetaan Widget Flutter |
|---|---|---|---|
| `cerita_interaktif_skenario_adab/` | Katalog Skenario Adab | Serial Zaid: Menghadapi Kemarahan Menjelang Maghrib | Narrative choices card deck |

### Kluster 7: Bakat Syakilah TB-40 & Pangkalan Data
| Direktori Layar | Judul Antarmuka | Komponen Kunci UI | Pemetaan Widget Flutter |
|---|---|---|---|
| `wiki_direktori_taksonomi_40_bakat_tb_40/` | Pangkalan Data TB-40 | Rukun 3A (*Al-Fithrah*, *Al-Aadaab*, *Al-Amal*), 6 rumpun bakat | `fl_chart.RadarChart` + direktori |
| `katalog_bakat_syakilah_tb_40/` | Katalog 40 Bakat Syakilah | Indeks 40 bakat alfabetis & rumpun | Grid kartu bakat bertanda |
| `detail_bakat_ash_shidq_tb_40/` | Detail Bakat Ash-Shidq | Pesona alami anak, manifestasi perilaku, dalil syar'i | Editorial layout mendalam |

### Kluster 8: Tools & Instrumen Praktis Lapangan
| Direktori Layar | Judul Antarmuka | Komponen Kunci UI | Pemetaan Widget Flutter |
|---|---|---|---|
| `tools_instrumen_praktis/` | Hub Tools Pengasuhan | Timbangan Resonansi Jiwa, Kalkulator Usia Fitrah, Dadu 2D6 | Grid 3-kolom instrumen praktis |
| `detail_instrumen_timbangan_resonansi_jiwa/` | Mizan Fitrah & Resonansi | 3 spektrum frekuensi jiwa, SOP 3 langkah kalibrasi | CustomPainter Mizan Balance Scale |
| `katalog_instrumen_praktis_kerjasama_lembaga/` | Katalog Lembaga & Template | Template A4 siap cetak, program kemitraan madrasah | Download card + proposal info |
| `detail_kerjasama_visitasi_lapangan/` | Visitasi Lapangan Tarbiyah | Audit tata kelola adab harian (*Bi al-Qudwah*) | Form instrumen observasi |

### Kluster 9: Khazanah Wiki PKN & Korpus Dalil
| Direktori Layar | Judul Antarmuka | Komponen Kunci UI | Pemetaan Widget Flutter |
|---|---|---|---|
| `wiki_pkn_beranda_peta_khazanah/` | Beranda Wiki PKN | Peta 3 jalur belajar, 4 tahapan praktik, korpus dalil | Pencarian instan + index peta |
| `wiki_artikel_perintah_shalat_pentahapan_usia/` | Artikel Shalat 7 & 10 Thn | Takhrij hadits, pencegahan kekerasan fisik | Reader view + font Amiri |
| `wiki_artikel_tiga_bahasa_pengasuhan_nabawiyah/` | Artikel Tiga Bahasa Mendidik | Bahasa Hati, Bahasa Lisan, Bahasa Tangan | Reader view + studi kasus SOTAB |

### Kluster 10: Agenda Majelis, Toko Buku & Profil
| Direktori Layar | Judul Antarmuka | Komponen Kunci UI | Pemetaan Widget Flutter |
|---|---|---|---|
| `agenda_seluruh_event/` | Kalender Agenda & Majelis | Daurah akbar, halaqah ayah, webinar online | Timeline agenda + tiket |
| `detail_majelis_daurah_akbar_parenting_nabawiyah/` | Detail Majelis Daurah | Asatidz, silabus, rundown, form registrasi | Event detail hero view |
| `toko_buku_pustaka_pkn/` | Toko Buku & Pustaka PKN | Literatur resmi tarbiyah nabawiyah | E-commerce pustaka syar'i |
| `detail_buku_menempa_adab_usia_tamyiz/` | Detail Buku Menempa Adab | Format cetak/digital, kaidah pokok, sinopsis | Book detail view + purchase action |
| `profil_pengguna_aktivitas_bookmark/` | Profil & Pengaturan Abu Hafi | Aktivitas berjalan, bookmark, akun keluarga | Akun setting & bookmark vault |
