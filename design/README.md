# 🎨 PKN Healing Mobile App — OpenPencil & Figma Design

Berkas desain visual resmi aplikasi **PKN Healing Mobile App** (*Pendidikan Karakter Nabawiyah & Tafsir Bakat 40*) yang dirancang menggunakan toolkit **OpenPencil**.

---

## 📂 Lokasi Berkas Desain

| Berkas / Direktori | Tipe | Deskripsi |
| :--- | :--- | :--- |
| `design/PKN_Healing_App_Design.fig` | **OpenPencil / Figma Document** | Dokumen desain utama berformat native `.fig` berisi seluruh token, blueprint komponen, dan layar aplikasi. |
| `design/previews/` | **High-Res Visual Previews (PNG)** | Hasil ekspor visual siap lihat dari setiap layar dan halaman Design System. |

---

## 📑 Struktur Halaman Dokumen Desain (`PKN_Healing_App_Design.fig`)

Dokumen ini memiliki 2 halaman utama:

### 1. `📐 Design System & Tokens`
- **Banner Header**: Visi Fitrah-First, Manhaj Guardrails, dan standar WCAG 2.1 AA.
- **Palet Warna Fitrah & 6 Pilar MOC**:
  - *Fitrah Emerald* (`#0D9488`, `#14B8A6`, `#0F766E`)
  - *Nabawi Gold* (`#D4AF37`) & *Amber* (`#F59E0B`)
  - *6 Pilar MOC*: P1 Hijau (`#059669`), P2 Biru Langit (`#0284C7`), P3 Ungu Fitrah (`#7C3AED`), P4 Oranye Keluarga (`#EA580C`), P5 Merah Krisis (`#DC2626`), P6 Abu Manhaj (`#4B5563`).
  - *4 Rubrik Evaluasi Adab Kualitatif*: 🔴 BT (Belum Terlihat), 🟡 MT (Mulai Terlihat), 🟢 BK (Berkembang), 🔵 MM (Membudaya).
- **Skala Tipografi**: Display (28px), Heading (20px), Subhead (16px), Body (14px), Caption (11px), dan Arabic Dalil Native RTL (24px).
- **Blueprint Komponen**:
  - *Arabic Dalil Card* (RTL dengan Takhrij & Terjemahan)
  - *Lead TL;DR Callout Box* (Primacy Rule: Solusi 10 Detik)
  - *Komparasi 2 Kolom* (🔴 Kebiasaan Umum vs ✅ Pendekatan PKN)
  - *Action Buttons* (Target sentuh minimal 48dp)
  - *Action Checklist* (Recency Rule: Daftar Tilik Praktik Rumah)

### 2. `📱 Layar Aplikasi PKN`
- `01_Onboarding_JTBD_Amanah_Peran` (Node `0:1182`): Stepper 4 langkah fitrah (Amanah Peran, Target Fase, Krisis, Komitmen Harian).
- `02_Beranda_Tarbiyah_QuickCrisisHub` (Node `0:774`): Header emerald, Quick Crisis Hub banner, 6 pilar MOC chip bar, featured card.
- `03_Pemain_Modul_Kuis_Interaktif` (Node `0:429`): Studi kasus tantrum balita / shalat tamyiz tanpa skoring menghakimi.
- `04_Laporan_Pertumbuhan_Adab` (Node `0:379`): Donut progress 100%, evaluasi adab BK & MM, checklist aksi harian.
- `05_Pemutar_Audio_Sirah_Nabawiyah` (Node `0:642`): Kartu pemutar audio sirah dengan scrubber, tombol putar, kontrol durasi, dan playlist kajian.

---

## 🖼️ Pratinjau Visual (`design/previews/`)

- `design/previews/00_design_system_tokens.png`
- `design/previews/screen_01_onboarding_jtbd.png`
- `design/previews/screen_02_beranda_tarbiyah.png`
- `design/previews/screen_03_pemain_modul.png`
- `design/previews/screen_04_laporan_adab.png`
- `design/previews/screen_05_pemutar_audio_sirah.png`

---

## 🛠️ Cara Membuka & Mengekspor dengan OpenPencil CLI

```bash
# Menampilkan informasi dokumen
openpencil info design/PKN_Healing_App_Design.fig

# Menampilkan daftar halaman
openpencil pages design/PKN_Healing_App_Design.fig

# Ekspor ulang halaman Design System ke PNG
openpencil export design/PKN_Healing_App_Design.fig --page "📐 Design System & Tokens" -f png -o design/previews/00_design_system_tokens.png

# Ekspor salah satu frame ke SVG
openpencil export design/PKN_Healing_App_Design.fig --node "0:774" -f svg -o design/previews/screen_02_beranda_tarbiyah.svg
```

Dokumen ini juga dapat langsung diimpor / dibuka di **Figma** (desktop / web) tanpa konversi tambahan.
