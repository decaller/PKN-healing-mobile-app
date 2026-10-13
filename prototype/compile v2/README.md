# PKN Mobile v2 — Master Architecture Blueprint & Unified Modular Specification

> **Status:** Cetak Biru Arsitektur & Perencanaan Ulang Terverifikasi (v2)  
> **Tanggal Rilis Dokumen:** 13 Oktober 2026  
> **Basis Desain:** Earth-Tree Design System (*Sand Ecru, Mineral Basalt, Meadow Pine, Merriweather, Plus Jakarta Sans, Amiri*)  
> **Framework Host:** Flutter (Dart 3.7+ / Flutter 3.29+)  
> **Target Lokasi Implementasi:** [`/home/abuhafi/Project/pkn-mobile`](file:///home/abuhafi/Project/pkn-mobile)  
> **Arsitektur Data:** Dual-Database Engine Backend v2 (*Drift SQLite Offline-First + LibSQL Vector 384-dim + Directus CMS*)  

---

## 1. Visi Produk & Filosofi Inti

**PKN Mobile** adalah aplikasi saku penenteram jiwa dan pendampingan keluarga berbasis **Manhaj Pendidikan Karakter Nabawiyah (PKN)** dan **Tazkiyatun Nafs Syar'i**. Aplikasi ini dirancang menggunakan prinsip **Dual-Core Calm Technology**:
1. **Pilar 1: Khazanah & Perkakas Nyata (Wiki-Tools Hub)**: Solusi situasi nyata < 10 detik, katalog literatur resmi, agenda majelis akbar, dan manajemen adab sehari-hari tanpa beban kognitif berlebih.
2. **Pilar 2: Refleksi Jiwa & Pendampingan Batin (Spiritual AI & Narrative Rehearsal)**: Teman curhat beradab tanpa penilaian (*non-judgmental*), simulasi dialektika suara bakat fitrah (TB-40), serta latihan pengasuhan berbasis adab tanpa kekerasan verbal/fisik.

### Prinsip Anti-Guilt UX & Non-Gamification
- **Bebas Streak Shaming:** Tidak ada notifikasi pemaksa (*"Kamu kehilangan streak 10 hari!"*). Pengguna yang rehat disambut dengan salam kehangatan dan doa ketenangan jiwa.
- **Bebas Leaderboard Riya':** Tidak ada sistem ranking komparatif antar-keluarga atau antar-santri.
- **Metrik Adab Kualitatif Otentik:** Penilaian adab menggunakan rubrik fitrah:
  - **BT** (*Belum Tampak*)
  - **MT** (*Mulai Tampak*)
  - **BK** (*Berkembang*)
  - **MM** (*Membudaya*)
- **Tiga Bahasa Mendidik:** Bahasa Tubuh (tenang & aman), Bahasa Mata (tatap cinta), Bahasa Hati (tautkan ruh).

---

## 2. Struktur Navigasi & Pola Komponen Modular Terpadu

Navigasi utama menggunakan **Floating Frosted Acrylic Dock 5 Tab** di bagian bawah layar:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        SHELL NAVIGASI 5 TAB                            │
├───────────────┬───────────────┬───────────────┬───────────────┬────────┤
│   Tab 1:      │    Tab 2:     │    Tab 3:     │    Tab 4:     │ Tab 5: │
│   BERANDA     │    EVENT      │     WIKI      │   CURHAT AI   │ PROFIL │
│   (Home)      │   (Agenda)    │  (Khazanah)   │ (Ruang Qalbu) │ (User) │
└───────────────┴───────────────┴───────────────┴───────────────┴────────┘
```
*Catatan:* Modul **Cerita Interaktif**, **Buku**, **Tafsir Bakat 40**, **Ceklist Harian**, **Relasi**, dan **Kemitraan Lembaga** dapat diakses melalui kartu bento unggulan di Beranda, Tool Page khusus, maupun User Widget di Profil. Seluruh modul dilindungi mekanisme **Dynamic Feature Flags** yang adaptif.

### Standar Dekomposisi 6 Surface Komponen
Setiap modul dipecah menjadi 6 komponen visual yang konsisten:
1. **Home Widget:** Kartu bento / ringkasan dinamis di halaman Beranda.
2. **Bottom Bar Button:** Tombol tab navigasi langsung (khusus Beranda, Event, Wiki, Curhat AI, dan Profil).
3. **Tool Page / Explore Page:** Halaman dashboard / eksplorasi fungsional modul.
4. **List Page:** Halaman daftar entitas dengan filter, pencarian, dan pengelompokan.
5. **Detail Page:** Tampilan membaca / interaksi mendalam suatu entitas.
6. **User Widget:** Kartu / metrik ringkasan modul terkait yang disematkan di halaman Profil User.

---

## 3. Matriks 12 Modul Utama (Urutan Prioritas Modular)

| No | Modul | Surface Terpasang | Hubungan Data & Peran Inti |
| :---: | :--- | :--- | :--- |
| **1** | **Event (Agenda)** | Home Widget, Bottom Bar, List, Detail, Profile Badge | Daurah, seminar, majelis akbar, filter kategori, badge keikutsertaan di profil. |
| **2** | **Buku (Pustaka)** | Home Widget, List, Detail | Katalog buku fisik/digital karya asatidzah PKN, sinopsis, daftar isi, pemesanan. |
| **3** | **Profil & Rekan** | Home Widget, List, Detail | Direktori Tokoh (4 asatidzah) dan Lembaga (6 institusi pengadopsi standar PKN). |
| **4** | **Kemitraan Lembaga** | Home Widget, List, Detail | Program kerjasama institusi (Konsultasi Online, Visitasi, Coaching Guru, Daurah). |
| **5** | **User (Profil)** | Home Widget, Bottom Bar, Detail Page | Identitas akun, peran keluarga/lembaga, koleksi badge, agregator User Widget. |
| **6** | **Wiki (Khazanah)** | Home Widget, Bottom Bar, Explore, Detail, User Widget | Wiki Penulis (6 format) + Wiki AI (Paradigma, Bakat, Dalil, Doa, Software Bantuan). |
| **7** | **Tafsir Bakat 40** | Home Widget, Tool Page, List, Detail, User Widget | Peta 40 bakat fitrah (Ihsan vs Afat), radar chart rumpun bakat, cermin batin. |
| **8** | **Ceklist Harian** | Home Widget, Tool Page, List, Detail, User Widget | Amanah adab harian, modal review amalan (Muthma'innah, Lawwamah, Ammarah). |
| **9** | **Relasi Qalbiyah** | Home Widget, Tool Page, List, Detail, User Widget | Neraca jiwa keluarga/santri, dinamika Tangki Cinta, tadabbur AI harian. |
| **10** | **Onboarding** | Wizard 4 Langkah (Diri, Kerja, Relasi, Ceklist) | Personalisasi profil awal terpandu (bisa dilewati) yang menginisialisasi modul 5, 8, 9. |
| **11** | **Curhat AI** | Home Widget, Bottom Bar, Tool Page, List, Detail | Ruang Qalbu, Walkie-talkie PTT waveform, pijakan dialog, riwayat konsultasi amanah. |
| **12** | **Cerita Interaktif** | Home Widget, Tool Hub, List, Detail | Living narrative Serial Zaid, skenario krisis adab 10 detik, dialektika bakat TB-40. |

---

## 4. Arsitektur Data Terintegrasi (Backend v2)

Mengadopsi arsitektur dari `prototype/backend v2`:
```
┌────────────────────────────────────────────────────────────────────────┐
│                        FLUTTER CLIENT ENGINE                           │
│  ┌──────────────────────────────┐    ┌──────────────────────────────┐  │
│  │    Drift SQLite Database     │    │   Embedded LibSQL Database   │  │
│  │   (Mutasi & Data Personal)   │    │    (OTA Bundle Zstandard)    │  │
│  │ • User Profile & Badges      │    │ • Wiki Articles FTS5         │  │
│  │ • Ceklist Harian & Muhasabah │    │ • 384-dim Vector Embeddings  │  │
│  │ • Relasi Keluarga            │    │ • Katalog Buku & Tokoh       │  │
│  │ • Outbox Mutation Queue      │    │ • Event & Agenda Daurah      │  │
│  └──────────────┬───────────────┘    └──────────────▲───────────────┘  │
└─────────────────┼───────────────────────────────────┼──────────────────┘
                  │ Sync (REST/HTTP)                  │ OTA Update (.zst)
┌─────────────────▼───────────────────────────────────┴──────────────────┐
│                           BACKEND v2 HUB                               │
│  • Directus CMS (Port 8055): Manajemen Event, Buku, Lembaga, Tokoh    │
│  • Alexandrie Search Engine (Port 8201): FTS5 & Semantic Indexing      │
│  • MCP Stdio Server: 6 Tools AI Knowledge Integration                  │
│  • Build Pipeline: build_knowledge_db.py -> knowledge_v4.db.zst (7 MB) │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 5. Hubungan Dokumen Terkait di Direktori Ini

1. 📋 [MODULAR_MODULES_DECOMPOSITION.md](file:///home/abuhafi/Project/PKN-healing-mobile-app/prototype/compile%20v2/MODULAR_MODULES_DECOMPOSITION.md) — Rincian teknis 12 modul dan struktur per komponen widget.
2. 🗄️ [DATABASE_AND_BACKEND_SCHEMA.md](file:///home/abuhafi/Project/PKN-healing-mobile-app/prototype/compile%20v2/DATABASE_AND_BACKEND_SCHEMA.md) — Skema tabel Drift & LibSQL terpadu.
3. 🚀 [PHASED_IMPLEMENTATION_ROADMAP.md](file:///home/abuhafi/Project/PKN-healing-mobile-app/prototype/compile%20v2/PHASED_IMPLEMENTATION_ROADMAP.md) — Rencana aksi eksekusi 4 fase di `/home/abuhafi/Project/pkn-mobile`.
