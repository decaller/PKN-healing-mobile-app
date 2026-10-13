# Evaluasi Kritis UX, Ergonomi Kognitif & Redesain Navigasi Berbasis Tujuan (Goal-Directed UX)

> **Status:** Dokumen Keputusan Desain Antarmuka & Interaksi Pengguna (*UX Architecture Decision Record*)  
> **Metodologi Evaluasi:** Sintesis Hasil Audit OMP (*UI/UX Pro Max*, *Calm Technology Designer*, *Security Architect*) dan Teori Kognitif Perilaku Pengguna (*Paradox of the Active User*, *Information Foraging Theory*, *Jakob’s Law*).  
> **Berkas Terkait:** [`KRITIK_DAN_EVALUASI_SISTEM.md`](KRITIK_DAN_EVALUASI_SISTEM.md), [`README.md`](README.md), [`PHASED_IMPLEMENTATION_ROADMAP.md`](PHASED_IMPLEMENTATION_ROADMAP.md).

---

## 1. Landasan Teoretis: Mengapa Pengguna Bukan Penjelajah Penasaran (*Not Curious Explorers*)

Desain antarmuka PKN Mobile v2 wajib berpijak pada realitas perilaku manusia di dunia nyata, bukan asumsi idealis desainer:

### A. The Paradox of the Active User (Carroll & Rosson)
- Pengguna tidak pernah meluangkan waktu untuk mempelajari antarmuka, membaca panduan, atau menjelajahi menu demi rasa ingin tahu.
- Pengguna langsung berusaha menyelesaikan tugas nyata (*Job-To-Be-Done*) sejak detik pertama aplikasi dibuka. Mengharapkan pengguna baru untuk mengetuk tab bawah yang abstrak (seperti "Ruang Batin" atau "Hub") hanya untuk melihat isinya adalah asumsi yang keliru.

### B. Information Foraging Theory & Satisficing (Pirolli, Card & Herbert Simon)
- Pengguna bergerak seperti pemburu informasi yang menghemat energi kognitif: mereka hanya mengikuti **aroma informasi (*information scent*)** yang paling kuat, jelas, dan tidak ambigu.
- Pengguna memilih opsi pertama yang dirasa "cukup baik" (*satisficing*) untuk menyelesaikan tujuannya saat itu. Label yang puitis atau metaforis memiliki aroma informasi yang sangat lemah sehingga akan diabaikan total.

### C. Hukum Jakob (*Jakob’s Law*) & Memori Otot Pengguna Rutin
- Pengguna menghabiskan 90% waktu hidup digitalnya di aplikasi lain. Mereka menuntut kontrol navigasi bekerja persis seperti aplikasi standar yang telah membentuk kebiasaan mereka.
- **Distribusi 80/20 Navigasi:** 85%–95% sesi pengguna terpusat pada **1 hingga 2 tab dominan (terutama Beranda)**. Menyingkirkan fitur penting ke tab sekunder dengan harapan pengguna akan mencarinya ke sana justru akan mematikan adopsi fitur tersebut.

---

## 2. Temuan Kritis Audit 2 (Calm Technology & Ergonomi Aksesibilitas)

| Area Evaluasi | Temuan Kritis Cetak Biru Awal | Keputusan Desain Terverifikasi |
| :--- | :--- | :--- |
| **Paradoks Anti-Guilt UX** | Wireframe memuat persentase numerik `Zaid (95%)` dan label nafsu otomatis (`Ammarah/Lawwamah`) yang memicu *spiritual guilt* dan kesan diagnosis batin sepihak. | **Hapus seluruh angka persentase pada Tangki Cinta.** Ganti dengan status kualitatif reflektif (*"Penuh Kehangatan"*, *"Butuh Waktu Bersama"*). Review nafsu dijadikan muhasabah pribadi opsional. |
| **Beban Kognitif Beranda** | Menumpuk 6 widget berat sekaligus (*Top Header, Running Ticker, Highlights Carousel, Collapsible Ceklist, Bento Grid 2x2, Carousel Serial Zaid*) menciptakan *visual cacophony*. | **Redesain Beranda menjadi Goal-Directed Launchpad:** Disusun berdasarkan 3 tujuan utama pengguna, bukan daftar pameran 12 modul. |
| **Aksesibilitas Font Arab** | Teks dalil Al-Qur'an dan Hadits (*Amiri Arabic*) rawan terpotong harakatnya jika line-height disetel statis. | **Dynamic Line-Height & TextScaler 200%:** Memastikan harakat tidak terpotong dan lulus uji pembesaran font sistem tanpa merusak layout. |
| **Kontras Warna Earth-Tree** | Kombinasi warna *Sand Ecru* dan *Basalt* belum teruji secara numerik. | **Standarisasi Token WCAG 2.2 AA:** Rasio kontras teks normal wajib ≥ 4.5:1 dan teks besar ≥ 3.0:1 pada tema terang dan gelap. |
| **Interaksi Audio PTT** | Mode rekam hanya mengandalkan *press-and-hold* yang melelahkan jari saat curhat panjang. | **Dual-Mode Audio PTT:** Mendukung mode *tahan-bicara* dan mode *ketuk-mulai/ketuk-selesai*, dilengkapi tombol pembatalan yang jelas. |

---

## 3. Redesain Bottom Navigation Bar (Patuh pada Jakob's Law)

Navigasi bilah bawah dipertahankan menggunakan **5 menu standar dengan label konvensional** agar pengguna langsung paham fungsinya tanpa beban kognitif:

```
┌────────────────────────────────────────────────────────────────────────┐
│  ┌──────────────────────────────────────────────────────────────────┐  │
│  │        FLOATING FROSTED DOCK (5 TAB STANDAR & FAMILIAR)          │  │
│  │ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ │  │
│  │ │    🏠    │ │    📅    │ │    📖    │ │    🤍    │ │    👤    │ │  │
│  │ │ Beranda  │ │  Event   │ │  Materi  │ │  Curhat  │ │  Profil  │ │  │
│  │ └──────────┘ └──────────┘ └──────────┘ └──────────┘ └──────────┘ │  │
│  └──────────────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────────────┘
```

### Pemetaan Fasilitas 12 Modul ke dalam 5 Tab Tetap:

1. **Tab 1 — 🏠 Beranda (Pusat Tujuan Harian - 85% Waktu Pengguna):**
   - Jalur cepat ke P3K Tantrum < 10 Detik.
   - Amalan Adab Hari Ini (Ceklist harian aktif).
   - Bilah pencarian khazanah terpadu (FTS5).
   - Rekomendasi hikmah & agenda terdekat hari ini.
2. **Tab 2 — 📅 Event (Agenda Majelis & Daurah):**
   - Kalender kajian, daurah parenting, dan temu lembaga mitra.
   - Pendaftaran acara dan integrasi lencana keikutsertaan.
3. **Tab 3 — 📖 Materi (Pustaka & Khazanah Ilmu / Wiki):**
   - Artikel, rekaman audio kajian, slide presentasi, dan modul kurikulum PKN.
   - Katalog Buku resmi karya asatidzah (Pustaka Nabawiyah).
   - Direktori Tokoh Rujukan (Ust. Abdul Kholiq, Ust. Bayu, Prof. Iman, Ummu Khusna).
4. **Tab 4 — 🤍 Curhat (Pendampingan Batin & Ruang Qalbu):**
   - Pintu masuk langsung dialog hati tanpa penghakiman.
   - PTT Audio Ephemeral (rekaman suara dihapus seketika setelah transkripsi).
   - Doa penenang hati dan ekspor RPP Adab Keluarga pribadi.
5. **Tab 5 — 👤 Profil (Identitas, Keluarga & Pengaturan):**
   - Identitas diri & peranan keluarga/lembaga (mendukung status *Guest*).
   - Lingkaran Relasi Keluarga & Teman Dekat.
   - Asesmen Bakat Fitrah (Tafsir Bakat 40 / TB-40).
   - Koleksi Lencana Event & Kemitraan Lembaga.
   - Manajemen Kunci Pemulihan Enkripsi E2EE (*Zero-Knowledge Directus*).

---

## 4. Komposisi Beranda Baru: "Goal-Directed Launchpad + Discovery Hub"

Beranda memadukan ketegasan **Goal-Directed Actions** (untuk kebutuhan mendesak & habit harian) dengan **Discovery Hub Terpadu** (kombinasi Carousel & Grid untuk modul pelengkap, serta Highlight Promosi Event Terdekat):

```
┌────────────────────────────────────────────────────────────────────────┐
│ 👤 Ahlan wa Sahlan, Abu Zaid           [🌙/☀️ Theme] [⚙️ Pengaturan]   │
│ 🌿 "Koneksi Sebelum Koreksi — Tautkan Hati Sebelum Meluruskan"         │
├────────────────────────────────────────────────────────────────────────┤
│ 🔍 [ Cari dalil, materi adab, panduan pengasuhan...         ] [🎙️ Mic] │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│ 🎯 GOAL 1: PERTOLONGAN CEPAT (EMERGENCY & IMMEDIATE VALUE)             │
│ [Aroma Informasi Sangat Tajam: Solusi Situasi Nyata < 10 Detik]       │
│ ┌──────────────────────────────────┬─────────────────────────────────┐ │
│ │ 🚑 P3K SOP Tantrum < 10 Detik    │ 🤍 Ruang Qalbu (Curhat AI)      │ │
│ │ Panduan redam amarah seketika    │ Luapkan beban hati tanpa dihakimi│ │
│ └──────────────────────────────────┴─────────────────────────────────┘ │
│                                                                        │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│ 🎯 GOAL 2: TUGAS & AMALAN HARI INI (DAILY HABIT & CADENCE)             │
│ [Pembentuk Habit Loop Harian: Fokus pada 3 Tindakan Terpenting]        │
│ 📋 AMALAN ADAB HARI INI                            [Buka Semua 3 ➔]    │
│ • [✓] Dekap Ananda Zaid 3 menit (Bahasa Hati)                          │
│ • [ ] Tahan amarah & puasa lisan saat lelah                            │
│ • [ ] Dzikir petang 100x & doa kelembutan hati                         │
│                                                                        │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│ 📢 HIGHLIGHT PROMOSI EVENT TERDEKAT (HIGH-VISIBILITY BANNER)          │
│ ┌────────────────────────────────────────────────────────────────────┐ │
│ │ 📅 H-3 DAURAH PARENTING NABAWIYAH (MAJELIS AKBAR NASIONAL)         │ │
│ │ "Menumbuhkan Fitrah Keimanan Sebelum Usia Baligh" bersama Asatidzah│ │
│ │ 📍 Masjid SKIS / Live Zoom • 500 Peserta Terdaftar  [Daftar ➔]     │ │
│ └────────────────────────────────────────────────────────────────────┘ │
│                                                                        │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│ 🎨 DISCOVERY HUB: MODUL PELENGKAP (KOMBINASI CAROUSEL & GRID)          │
│                                                                        │
│ 1. HORIZONTAL CAROUSEL (KONTEN NARASI & PUSTAKA VISUAL)                │
│ [Geser Horizontal ➔]                                                   │
│ ┌──────────────────────────────┐ ┌──────────────────────────────────┐  │
│ │ 🎬 SERIAL ZAID: Episode 4    │ │ 📚 BUKU PILIHAN BULAN INI        │  │
│ │ "Ketika Anak Menolak Shalat" │ │ "Seni Berbicara Nabawiyah"       │  │
│ │ [Latih Respon Adab ➔]        │ │ [Lihat Sinopsis & Pesan ➔]       │  │
│ └──────────────────────────────┘ └──────────────────────────────────┘  │
│                                                                        │
│ 2. GRID 2x2 ACTION TILES (UTILITAS & EKSPLORASI EKOSISTEM)             │
│ ┌──────────────────────────────┬────────────────────────────────────┐  │
│ │ 🎯 Tafsir Bakat 40 (TB-40)   │ 🏛️ Kemitraan Lembaga              │  │
│ │ Cermin bakat fitrah ciptaan  │ Visitasi, coaching, & kurikulum    │  │
│ ├──────────────────────────────┼────────────────────────────────────┤  │
│ │ 👥 Direktori Tokoh Pakar     │ 🏫 Jaringan Lembaga Mitra          │  │
│ │ Ust. Abdul Kholiq, Ust. Bayu │ SKIS, SOTAB, Darul Atsar, HU, YBIT │  │
│ └──────────────────────────────┴────────────────────────────────────┘  │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 5. Matriks Perbandingan: Sebelum vs. Sesudah Redesain

| Aspek Desain | Desain Awal (Cetak Biru v2) | Desain Baru (Goal-Directed + Discovery Hub) | Dampak Positif bagi Pengguna |
| :--- | :--- | :--- | :--- |
| **Fokus Homescreen** | Menampilkan 12 modul dalam 6 widget berbeda tanpa prioritas yang jelas. | **Hirarki Terpadu:** Goal Cepat ➔ Amalan Harian ➔ Highlight Event ➔ Carousel Narasi ➔ Grid Utilitas. | Menghilangkan kebingungan visual seraya tetap memberi panggung proporsional bagi seluruh 12 modul. |
| **Promosi Event** | Tercecer sebagai kartu biasa di antara bento grid. | **Dedicated Highlight Banner:** Kartu H-countdown dengan visibilitas tinggi di tengah Beranda. | Konversi pendaftaran daurah dan kehadiran majelis meningkat drastis. |
| **Modul Pelengkap** | Menumpuk tanpa struktur pola yang harmonis. | **Harmoni Carousel + Grid:** Carousel untuk narasi (Buku & Serial Zaid), Grid 2x2 untuk utilitas (TB-40, Mitra, Tokoh). | Pengguna dapat menikmati konten santai secara horizontal dan mengakses alat teknis via grid cepat. |
| **Waktu Menemukan Solusi** | > 30 detik (harus mencari di antara tumpukan kartu). | **< 10 detik** (P3K Tantrum & Curhat diletakkan di slot aksi tercepat teratas). | Memenuhi janji inti produk untuk krisis pengasuhan nyata di lapangan. |
| **Label Navigasi Bawah** | Terancam dipindah ke label puitis/asing yang membingungkan. | Menggunakan 5 label standar industri: `Beranda, Event, Materi, Curhat, Profil`. | Mematuhi *Jakob's Law*; pengguna langsung paham tanpa perlu petunjuk manual. |
| **Status Tangki Cinta** | Menampilkan persentase angka mati `Zaid (95%)`. | Menampilkan status kualitatif reflektif *"Penuh Kehangatan"*. | Mencegah kecemasan dan rasa bersalah semu (*anti-spiritual guilt*). |

---

## 6. Kesimpulan & Status Persetujuan

Arsitektur **Goal-Directed UX** ini resmi disepakati sebagai acuan antarmuka utama PKN Mobile:
1. Menjaga semua fasilitas tetap pada tempatnya yang stabil dan konsisten.
2. Membebaskan pengguna dari kebingungan navigasi.
3. Menjamin aplikasi benar-benar menjadi **alat penenteram jiwa saku (*pocket calming companion*)**, bukan sumber kepenatan digital baru.
