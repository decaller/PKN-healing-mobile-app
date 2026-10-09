# 🎨 PKN Mobile Design System Specification
## *(Pendidikan Karakter Nabawiyah & Tafsir Bakat 40)*
### Version: 2.0.0 • Kontrak desain native, prototype browser & tema Flutter

---

## 1. Visi, Nilai Inti & Prinsip Desain

Desain antarmuka PKN Mobile dibangun di atas perpaduan antara **keanggunan eksekutif Nabawiyah**, **rekayasa kognitif ramah pengguna (*zero-fluff*)**, dan **kepatuhan syar'i manhaj**.

| Pilar Filosofi | Prinsip Penerapan dalam Desain UI/UX |
|---|---|
| **Fitrah-First, Bukan Peringkat** | Menghilangkan angka mati (*ranking*), persaingan toksik (*leaderboard*), dan komparasi sosial. Digantikan oleh pelacakan kualitatif adab (**BT - MT - BK - MM**), keunikan syakilah (TB-40), serta apresiasi proses. |
| **Koneksi Sebelum Koreksi** | Hierarki visual memprioritaskan sentuhan hati (*Bahasa Hati*) dan validasi emosi sebelum menyajikan konsekuensi kedisiplinan atau aturan teknis. |
| **Rekayasa Kognitif Zero-Fluff** | Menekan beban mental (*extraneous cognitive load*) orang tua yang lelah setelah bekerja dan guru yang terburu-buru menyiapkan KBM. Menyajikan solusi instan 10 detik (*Lead TL;DR*) paling atas (*above the fold*). |
| **Keselamatan Manhaj & Batas Klinis** | Perlindungan anak: larangan sanksi fisik pada balita, batas sanksi disiplin mendidik hanya setelah usia 10 tahun (tidak memukul wajah/tidak melukai), serta penegasan bahwa asesmen adalah panduan fitrah, bukan vonis psikometrik permanen. |
| **Aksesibilitas sebagai Target** | Sasaran kontras teks normal ≥4.5:1, target sentuh utama 48×48 dp, Arab Amiri/RTL, dan semantics pembaca layar. Ini persyaratan implementasi, bukan klaim WCAG/TalkBack/VoiceOver sudah lulus. |

---

## 2. Sistem Warna (Color Tokens)

### 2.1 Warna Utama & Merek Nabawiyah
- **Fitrah Emerald (Brand Primary):** `#0D9488` (Teal 600) — Melambangkan kesuburan fitrah, ketenangan, dan keseimbangan spiritual.
- **Fitrah Emerald Dark:** `#0F766E` (Teal 700) — Varian gelap untuk kontras tinggi pada latar terang.
- **Nabawi Gold (Accent / Secondary):** `#D4AF37` — Emas elegan yang melambangkan kemuliaan akhlak dan khazanah ilmu kenabian.
- **Emerald Green (Success / Thriving):** `#10B981` (Green 500) — Indikator kemajuan positif dan keberhasilan adab.
- **Deep Indigo:** `#6366F1` (Indigo 500) — Aksen navigasi dan pondasi manhaj (P1).

### 2.2 Warna Permukaan & Mode Tampilan
| Token | Dark Mode (`ThemeMode.dark`) | Light Mode (`ThemeMode.light`) | Peruntukan |
|---|---|---|---|
| `Background` | `#121417` | `#F8FAFC` | Latar viewport |
| `Surface` | `#1E2229` | `#FFFFFF` | Kartu dan dock |
| `PrimarySoft` | `#163D38` | `#E6F4F1` | Callout dan pilihan |
| `Border` | `#475569` | `#E2E8F0` | Garis pemisah |
| `TextPrimary` | `#FFFFFF` | `#0F172A` | Teks primer |
| `TextSecondary` | `#CBD5E1` | `#475569` | Teks sekunder |
| `Primary` | `#5EEAD4` | `#0F766E` | CTA |
| `OnPrimary` | `#0F172A` | `#FFFFFF` | Teks pada CTA |

Sumber aktual: koleksi native `PKN`, mode Light/Dark, variable `Tokens/Color/<Nama>`. Delapan token di atas ditambah Pillar1–6 menghasilkan 14 variables. `surfaceElevated`/`textMuted` bukan variable native dalam kontrak ini. Warna status rubrik dan callout di bawah adalah spesifikasi pendukung, bukan bukti binding seluruh warna.

### 2.3 Rubrik Adab Kualitatif (BT - MT - BK - MM)
Menggantikan sistem nilai angka/peringkat dengan 4 status perkembangan fitrah:
- **BT (Belum Tampak):** `#EF4444` — Perilaku belum teramati; catat konteks tanpa melabeli anak.
- **MT (Mulai Tampak):** `#F59E0B` — Muncul sesekali dengan dukungan.
- **BK (Berkembang):** `#10B981` — Berkembang dengan praktik dan pendampingan.
- **MM (Membudaya):** `#3B82F6` — Kebiasaan makin konsisten; tetap gunakan bukti naratif.

### 2.4 Warna 6 Pilar MOC (Maps of Content)
Setiap pilar taksonomi memiliki identitas warna visual konsisten:
- **P1: Mulai di Sini (Manhaj & Glosarium):** `#6366F1` (Indigo)
- **P2: Fase Tumbuh Kembang (Pedoman Usia):** `#0EA5E9` (Sky Blue)
- **P3: Fitrah & Bakat TB-40 (Syakilah):** `#8B5CF6` (Violet / Purple)
- **P4: Praktik Keluarga (Parenting & Rumah):** `#F43F5E` (Rose / Coral)
- **P5: Lembaga & Guru (Pedagogi & KBM):** `#10B981` (Emerald)
- **P6: Khazanah Dalil (Takhrij & Turats):** `#D4AF37` (Nabawi Gold)

### 2.5 Wadah Callout Khusus (Callout Containers)
- `[!summary]` **Lead TL;DR 10 Detik:** Latar `#0D9488` dengan opasitas 12%, border kiri `#0D9488` ($4\text{ dp}$).
- `[!warning]` **Batas Toleransi Syar'i:** Latar `#F59E0B` dengan opasitas 12%, border kiri `#F59E0B` ($4\text{ dp}$).
- `[!tip]` **Resep Praktis Lapangan:** Latar `#10B981` dengan opasitas 12%, border kiri `#10B981` ($4\text{ dp}$).

---

## 3. Sistem Tipografi (Typography Scale)

Sumber sinkronisasi aktual adalah root pluginData **`pknTypography`**, bukan skala aspiratif lama Plus Jakarta Sans/Poppins/Uthman Taha. `sync-tokens.mjs` membaca metadata ini dan color variables native lalu menghasilkan token Dart. Inter dipakai untuk Latin, Amiri untuk Arab.

| Role | Ukuran | Bobot | Family | Tinggi baris absolut | Kegunaan |
|---|---|---|---|---|---|
| Display | 26 | 700 | Inter | 36 | Judul layar |
| Heading | 18 | 700 | Inter | 27 | Heading |
| Subhead | 15 | 400 | Inter | 23 | Subjudul |
| Body | 13 | 400 | Inter | 20 | Isi |
| Caption | 12 | 400 | Inter | 18 | Metadata |
| Arabic | 28 | 400 | Amiri | 48 | Penggalan dalil |

Letter spacing metadata adalah 0. Tinggi Flutter dihitung sebagai lineHeight/fontSize. Teks utilitas generator dapat menggunakan ukuran/bobot khusus; tabel adalah kontrak token, bukan klaim setiap node identik dengan role. Skala lama headline28/22/body16/14 tidak lagi menjadi sumber generator. D2/Dk2 memakai penggalan [QS Ali Imran 3:159 dari Quran.com Indonesia](https://quran.com/id/keluarga-imran/159), attribution dan alignment kanan; metadata RTL native tidak membuktikan RTL seluruh aplikasi.

---

## 4. Sistem Spasial, Grid & Geometri (Layout Foundations)

### 4.1 Grid 8-Point Standar
Token jarak menggunakan basis 4/8 dp; ini panduan, bukan hasil audit bahwa semua node adalah kelipatan 8:
- `spacing.xxs` = 4 dp
- `spacing.xs` = 8 dp
- `spacing.sm` = 12 dp
- `spacing.md` = 16 dp (Margin sisi ponsel standar / padding kartu)
- `spacing.lg` = 20 dp (Padding layar luar ponsel)
- `spacing.xl` = 24 dp (Jarak antar blok seksi)
- `spacing.xxl` = 32 dp (Jarak pemisah besar)
- `spacing.xxxl` = 48 dp (Tinggi target sentuh minimum)

### 4.2 Sudut Lengkung (Border Radius)
- **Kecil (Pill / Badge):** `20.0 dp` — Chip pilar MOC, badge Adab, indikator fase.
- **Sedang (Button & Input):** `14.0 dp` — Tombol aksi utama, text field, audio scrubber card.
- **Besar (Content Card):** `16.0 dp` — Kartu Feed Deepstash, opsi pilihan kuis.
- **Ekstra Besar (Container / Hero):** `24.0 dp` — Kartu Hero TL;DR, Bottom Sheet modal.

### 4.3 Target Sentuh Ergonomis (Touch Targets)
Target ergonomis utama (bukan sertifikasi WCAG):
- **Minimum Target Area:** $48 \times 48\text{ dp}$.
- **Tombol Navigasi Bawah:** Tinggi $64\text{ dp}$ (area aman sentuh).
- **Opsi Kuis:** Tinggi minimal $56\text{ dp}$ dengan padding internal lapang.

---

## 5. Spesifikasi Komponen Utama (Component Specifications)

### 5.1 Kartu Lead TL;DR 10 Detik (`PknCalloutBox`)
- **Tujuan:** Memberikan jawaban instan bagi orang tua yang panik menghadapi krisis balita atau guru yang terburu-buru menyiapkan kelas.
- **Tata Letak:**
  - Border kiri tebal $4\text{ dp}$ warna aksen pilar.
  - Latar belakang lembut (opasitas 10%).
  - Ikon penanda di kiri atas (⚡ untuk TL;DR, ⚠️ untuk Batas Syar'i, 💡 untuk Resep Lapangan).
  - Teks kata kunci tebal di depan (*Front-Loaded*).

### 5.2 Lencana Adab Kualitatif (`AdabBadge`)
- **Tujuan:** Menampilkan status pertumbuhan adab tanpa memicu perbandingan toksik.
- **Varian:**
  - `BT`: Belum Tampak
  - `MT`: Mulai Tampak
  - `BK`: Berkembang
  - `MM`: Membudaya
- **Aksesibilitas:** Wajib menyertakan atribut `semanticsLabel` agar dibacakan tuntas oleh TalkBack/VoiceOver.

### 5.3 Blok Teks Dalil & Takhrij Turats (`ArabicDalilCard`)
- **Tujuan:** Menyajikan rujukan Al-Qur'an dan Hadits dengan penghormatan tertinggi terhadap kaidah turats.
- **Tata Letak:**
  - Latar belakang berhias pola emas halus atau sudut melengkung $18\text{ dp}$.
  - Teks Arab token aktual Amiri28/48; native alignment kanan dan metadata RTL, Flutter `TextDirection.rtl` saat merender teks Arab.
  - Atribusi sumber dan tautan konteks; jangan mengarang takhrij/derajat hadis.
  - Terjemahan Indonesia menggunakan role Inter sesuai hierarki layar.

### 5.4 5-Minute Primer Microlearning Deck
- **Tujuan:** Pelatihan kilat 5 menit berbasis kartu geser interaktif (Google Primer format).
- **Jenis Kartu:**
  1. `TextInsightCard`: Paragraf padat $< 50$ kata + Key Takeaway badge.
  2. `SwipePollCard`: Pertanyaan intuisi ya/tidak dengan gestur geser & umpan balik instan.
  3. `MultipleChoiceCard`: Studi kasus nyata dengan 3–4 opsi + penjelasan hikmah.
  4. `FillInBlankCard`: Rekonstruksi kalimat kunci fitrah dengan bank kata interaktif.
- **Indikator Kemajuan:** Segmented Progress Bar di AppBar atas (menunjukkan posisi step $N$ dari total langkah).

### 5.5 Laporan Naratif Pertumbuhan Adab (`AdabGrowthReport`)
- **Tujuan:** Refleksi perkembangan, bukan nilai total atau peringkat.
- **Elemen:** Bukti kecil, konteks, status BT/MT/BK/MM, narasi dan aksi berikutnya.
- Donut persentase/angka total adab dari spesifikasi lama dihapus. Radar B6 hanya ilustrasi empat kluster TB40, bukan hasil psikometrik. L3 adalah daftar delapan standar ilustratif dan prioritas, bukan radar audit tervalidasi.

### 5.6 Pemutar Audio Sirah & Tazkiyah (`PknAudioPlayerSheet`)
- **Tujuan:** Pendampingan audio riang bagi ibu saat menyusui/menidurkan anak, serta podcast daurah Ustadz Abdul Kholiq.
- **Elemen:**
  - Mini-player melayang di atas bottom navigation bar.
  - Full-screen sheet dengan tombol Play/Pause besar ($64\times 64\text{ dp}$), slider durasi, pengatur kecepatan baca ($1.0\times, 1.25\times, 1.5\times$), dan daftar bab/sirah.

---

## 6. Pemetaan Template Figma (`template/*.fig`) ke Aplikasi PKN

Menggunakan **OpenPencil**, layar aplikasi ditransformasikan dari template yang tersedia:

Template adalah referensi historis, bukan identifier handoff saat ini. Gunakan key layar (`O1`, `H`, `Dk1–5`, `R1–5`, `A1–3`) dan lookup `screenKey` dari berkas terbaru; node ID lama tidak stabil. Game menyimpan root pknGameManifest; generator utama mengembalikan manifest tanpa menyimpan root manifest.

Implementasi utama memiliki 53 key Light/Dark, empat varian tablet L1/R1 dan H_Android: 111 viewport. Tiga master header/CTA/navigasi terhubung ke 333 instance. Propagasi perlu `figma.graph.syncInstances`; proxy resize memerlukan `design/resize-viewport.js`. Native clipped viewport tidak menyediakan scroll yang sudah berjalan; browser menyediakan scroll, enam start dan state simulasi. Tidak ada native reactions writable atau cloud prototype yang diklaim.

Virtual Fitrah menambahkan 51 mobile + 4 companion dengan tujuh venue native isometrik editable (rumah, sekolah, masjid, kebun, pasar, asrama, tetangga). Ini scene desain dan simulasi browser, bukan runtime game, asesmen resmi, AI, layanan salat atau backend. Inventori key/kelompok dan commands regenerasi tersedia di [design/README.md](design/README.md).

Browser game merender tujuh venue SVG inline, hotspot peta, feedback A/B/C dan dock Rumah/Peta/Kabar/Jeda. Companion browser responsif, bukan reproduksi semua dimensi frame native. Simulator avatar dan check-in opsional hanya state sesi lokal, bukan AI atau engine AFK hidup.

---

## 7. Rambu Manhaj & Batas Keamanan Anak (*Safety Guardrails*)

1. **Larangan Sanksi Fisik Balita:** UI tidak boleh menampilkan opsi atau saran sanksi fisik pada anak usia di bawah 7 tahun.
2. **Batas Sanksi Usia 10 Tahun:** Peringatan tegas (*Callout Warning*) muncul pada modul anak tamyiz bahwa sanksi mendidik hanya boleh setelah 10 tahun penuh bila membangkang shalat, tanpa melukai dan haram memukul wajah.
3. **Tanpa Label Permanen Anak:** Pada asesmen TB-40 anak/remaja, hasil berupa eksplorasi kecenderungan fitrah, dilarang memberi label anak "tidak berbakat", "nakal", atau "sulit diatur".
4. **Bukan Pengganti Terapi Klinis:** Desain memakai disclaimer edukasi, bukan diagnosis medis/psikologis atau terapi. Jangan menganggap semua surface produksi telah memiliki semantics/disclaimer sebelum diverifikasi.

## 8. Sinkronisasi dan Bukti Terbatas

`node design/sync-tokens.mjs` menghasilkan `lib/app/theme/color_palette.dart` dan `pkn_tokens.dart`; `node design/sync-tokens.mjs --check` mendeteksi drift tanpa menulis. `AppTheme.light`/`dark` mengonsumsi hasilnya. Parent mengamati check token lulus, analisis terbatas `lib/app/theme` tanpa issue, dan smoke runtime sementara light/dark/Arabic. Itu bukan bukti seluruh Flutter, game produksi, WCAG atau pembaca layar lulus. Bukti scene/prototype dan batas terbaru berada di [laporan desain](design/ANALISIS_DAN_PENGEMBANGAN.md).

Inventori final: tujuh halaman,166 screenKey unik (111 utama +55 game), seluruh166 PNG terbaru diekspor. Browser104 layar kanonis/12 flow; parent mengamati tujuh venue,15 feedback A/B/C dan alur panen/check-in/jeda. Angka ekspor tidak berarti audit semua layar. Empat companion game memiliki key unik; ID node tetap dicari ulang setelah reopen.

---

## 9. Referensi & Inspirasi Desain Modern UI/UX

Untuk menjaga kualitas visual antarmuka tetap mutakhir, menenangkan jiwa (*calm technology*), dan interaktif tanpa mengorbankan kesederhanaan manhaj nabawiyah, dua platform berikut dijadikan rujukan desain utama:

1. **[Oiloil UI](https://ui.oiloil.org/en/)** — *Minimalist, Elegant & Calm Interface Reference*
   - **Filosofi Relevan:** Desain minimalis yang mengutamakan ruang bernapas (*whitespace*), tipografi bersih, dan peredaman beban kognitif pengguna (*zero visual noise*).
   - **Penerapan di PKN Mobile:**
     - Tampilan beranda tarbiyah dan feed kartu gagasan *Lead TL;DR*.
     - Tata letak kontemplatif pada modul muhasabah, doa, dan tazkiyatun nafs.
     - Antarmuka formulir asesmen kualitatif yang bebas stres.

2. **[21st.dev](https://21st.dev/)** — *State-of-the-Art Micro-Interactions & Design Engineering*
   - **Filosofi Relevan:** Komponen UI modern berbasis rekayasa desain (*design engineering*) dengan animasi mikro yang halus, gestur taktil, dan interaksi komponen kelas dunia.
   - **Penerapan di PKN Mobile:**
     - Kartu modul geser interaktif 5 langkah (*Primer Deck*).
     - Modal interaktif *Educational Learning Tooltip* saat pemain mengetuk pilihan adab yang berstatus terkunci (*turned off*).
     - Widget HUD animasi pengukur *Tangki Cinta (Love Tank)* dan *Barometer Jiwa (Nafs)*.
     - Transisi dialog *Bahasa Hati* dan gulungan digital *The Welcome Back Ledger*.

