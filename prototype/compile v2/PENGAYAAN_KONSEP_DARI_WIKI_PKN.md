# Pengayaan Konsep Tarbiyah Nabawiyah dari Repositori Wiki-PKN

> **Status:** Dokumen Sintesis Konseptual & Panduan Fitur (*Feature Enrichment Guide*)  
> **Sumber Analisis:** Repositori [`/home/abuhafi/Project/wiki-pkn`](file:///home/abuhafi/Project/wiki-pkn) diekstraksi menggunakan engine **Oh My Pi (OMP v18.8.0)**.  
> **Berkas Sumber:** `IDE_APLIKASI_MOBILE_PKN.md`, `analisis-desain/`, `content/Toolkit KBM/`, `content/Materi SOTAB/`, dan `content/Dalil/`.  
> **Dokumen Terkait:** [`KRITIK_DAN_EVALUASI_SISTEM.md`](KRITIK_DAN_EVALUASI_SISTEM.md), [`EVALUASI_UX_DAN_GOAL_DIRECTED_REDESIGN.md`](EVALUASI_UX_DAN_GOAL_DIRECTED_REDESIGN.md).

---

## 1. Ringkasan Eksekutif Pengayaan Konsep

Analisis mendalam terhadap khazanah `wiki-pkn` dari beberapa sudut pandang membuktikan bahwa repositori tersebut memuat ratusan instrumen, metodologi tarbiyah, dan formulasi adab yang sangat matang. 

Alih-alih membuat aplikasi menjadi rumit, konsep-konsep ini disaring menjadi **4 pilar pengayaan fungsional** yang memperkuat modul-modul PKN Mobile v2:

1. **Role-Based Adaptive Context (Bukan 13 Aplikasi Terpisah):**  
   13 persona interdisipliner disederhanakan menjadi **sakelar konteks aktif ringan** (misal: konteks *"Di Rumah"* vs *"Di Kelas"*). Navigasi tetap stabil 5 tab, namun rekomendasi amalan dan panduan beradaptasi secara elegan.
2. **Instrumen 19 Butir Observasi Karakter:**  
   Menjadi standar rubrik kualitatif (*BT, MT, BK, MM*) pada Modul Ceklist Harian (Modul 8) dan Relasi Keluarga/Santri (Modul 9), menggantikan sistem ranking angka mati.
3. **Psikologi Tazkiyah SOTAB (Serial Menghapus Noda Hati & Hutang Pengasuhan):**  
   Menjadi fondasi dialog batin pada Ruang Qalbu (Modul 11) dan simulasi Serial Zaid (Modul 12).
4. **SOP Tantrum < 10 Detik & Ekspor RPP 1 Lembar:**  
   Menyediakan instrumen nyata di lapangan untuk krisis emosi kilat dan kebutuhan profesional guru mitra.

---

## 2. Matriks Pengayaan Antar-Modul dari Wiki-PKN

| Modul v2 | Konsep yang Diadopsi dari `wiki-pkn` | Sumber Dokumen | Implementasi Nyata pada Aplikasi |
| :--- | :--- | :--- | :--- |
| **Modul 1: Event** | Agenda Majelis Daurah & Badge Kelulusan | `IDE_APLIKASI_MOBILE_PKN.md` | Banner promosi H-3 di Beranda + slot lencana keikutsertaan daurah di Profil. |
| **Modul 6: Wiki** | 6 Format Bahan Ajar & Software Rujukan | `analisis-desain/03` | Artikel, Audio Kajian, Slide, Modul, Worksheet, Case Study + integrasi OpenBayan/Qaf. |
| **Modul 6 & 11:** | **Template RPP 1 Lembar & Bank Prompt Guru** | `Toolkit KBM/` | Fitur ekspor langsung PDF A4 siap cetak (15% Pembuka, 70% Inti, 15% Penutup). |
| **Modul 8: Ceklist** | **19 Butir Observasi Karakter** | `Toolkit KBM/Instrumen 19 Butir` | Rubrik kualitatif non-gamified: *Belum Tampak (BT), Mulai Tampak (MT), Berkembang (BK), Membudaya (MM)*. |
| **Modul 9: Relasi** | **Tiga Bahasa Mendidik per Fase Usia** | `content/Dalil/` & `Materi SOTAB` | Bahasa Hati (0–7 th), Bahasa Lisan (7–10 th), Bahasa Tangan Terukur (10–14 th). |
| **Modul 10: Onboarding**| Konteks Peran Ringan (Ayah/Bunda/Guru/Santri) | `persona/README.md` | Wizard 4 langkah yang mempersonalisasi preset amalan tanpa membebani form panjang. |
| **Modul 11: Curhat AI** | **Menghapus Noda Hati (9 Serial SOTAB)** | `Materi SOTAB/MENGHAPUS NODA HATI` | Dialog empati batin yang membantu orang tua membalut luka masa lalu tanpa menyalahkan diri (*anti-guilt*). |
| **Modul 12: Cerita** | **Rehearsal Adab & Skenario Krisis Nyata** | `Bank Cerita Sirah & SOTAB` | Dialog bercabang 3 respon: *Nafs Muthma'innah (Mumtaz)* vs *Lawwamah* vs *Ammarah (Munkar-Ego)*. |
| **Beranda (P3K)** | **SOP "Tantrum Itu Indah" (< 10 Detik)** | `Materi SOTAB/TANTRUM ITU INDAH` | Tindakan kilat 3 langkah: Amankan ➔ Tahan amarah/lisan ➔ Tunggu reda ➔ Dekap saat anak siap. |

---

## 3. Rincian Konsep Kunci yang Diterapkan

### A. 19 Butir Observasi Pertumbuhan Karakter (Untuk Modul 8 & 9)
Mengadopsi taksonomi resmi `Toolkit KBM`, penilaian adab dibagi ke dalam 4 domain fitrah:
1. **Domain Ubudiyah (5 Butir):** Disiplin shalat awal waktu, thaharah mandiri, tilawah harian, adab berdoa, dan dzikir lisan.
2. **Domain Adabiyah (6 Butir):** Menghormati orang tua/guru, adab berbicara santun (bebas celaan), adab makan-minum, adab bertamu, ketaatan pada kesepakatan, dan kepedulian sosial (*itsar*).
3. **Domain Khuluqiyah (4 Butir):** Kejujuran (*ash-shidq*), rasa malu syar'i (*al-haya'*), kesabaran saat diuji (*ash-shabr*), dan pemaaf (*al-'afw*).
4. **Domain Qiyadiyah (4 Butir):** Tanggung jawab amanah, inisiatif mandiri, ketabahan (*al-himmah*), dan kepemimpinan adil.

*Kaidah Penerapan:* Bukan sebagai skor raport angka, melainkan sebagai **catatan perkembangan kualitatif** yang dicatat oleh orang tua/guru saat anak menunjukkan kemajuan adab.

---

### B. Integrasi Serial SOTAB: "Menghapus Noda Hati" & "Hutang Pengasuhan" (Modul 11)
Berdasarkan serial 9 bagian `MENGHAPUS NODA HATI` dan `TANDA ORANGTUA PUNYA HUTANG PENGASUHAN`:
- Orang tua yang sering membentak anak umumnya bertindak bukan karena anak jahat, melainkan karena **bejana batin orang tua sendiri sedang terluka atau mengalami kekosongan tangki cinta**.
- **Peran Ruang Qalbu (Curhat AI):**
  - AI bertindak sebagai pendengar setia yang tidak menghakimi (*non-judgmental listener*).
  - Mengarahkan orang tua untuk beristighfar dan merenungi: *"Apakah yang sedang berbicara ini adalah ketegasan adab, atau luka batin masa laluku yang belum sembuh?"*
  - Menuntun taubat nasuha, memulihkan hubungan dengan meminta maaf secara tulus kepada anak, dan mengisi ulang bejana jiwa dengan sujud di keheningan malam.

---

### C. Standardisasi P3K SOP Tantrum < 10 Detik (Beranda)
Berdasarkan esai `TANTRUM ITU INDAH.md`:
> *"Tantrum bukan kejahatan anak, melainkan ketidakmampuan sistem syaraf balita dalam mengartikulasikan gelombang emosi yang meluap. Tugas orang tua bukan menghentikan tangis dengan ancaman, melainkan menjadi jangkar ketenangan yang kokoh."*

**Protokol 4 Langkah di Aplikasi:**
1. **Detik 0–3 (Amankan Fisik):** Jauhkan benda tajam/berbahaya. Dekap anak setara tinggi mata jika anak mengizinkan.
2. **Detik 4–6 (Puasa Lisan & Amarah):** Haram membentak, menghardik, memukul wajah, atau mencap anak "nakal". Tahan nafas dan bacakan ta'awwudz di dalam hati.
3. **Detik 7–10 (Validasi Perasaan):** Ucapkan kalimat tenang: *"Ayah/Bunda di sini. Kamu aman. Luapkan dulu tangismu sampai lega."*
4. **Pasca-Reda (Pemulihan & Koneksi):** Beri segelas air putih, peluk hangat, lalu diskusikan akar masalah secara santai tanpa mengungkit kesalahan masa lalu.

---

### D. Fitur Ekspor RPP Karakter Nabawiyah 1 Lembar (Modul 6 & 11)
Bagi pengguna dengan profil Guru/Pendidik di sekolah mitra:
- Guru dapat memanfaatkan hasil konsultasi Curhat AI atau template di Wiki untuk menghasilkan **RPP Karakter 1 Lembar (Format PDF A4 Siap Cetak)**.
- **Komposisi RPP:**
  - *Identitas Pembelajaran:* Kelas/Fase usia fitrah, topik bahasan, alokasi waktu.
  - *Target Integrasi Tri-Komponen:* Iman (Tauhid & Cinta), Adab (Sikap Lahiriah), Ilmu (Kognitif).
  - *Struktur Waktu Alami:*
    - 15% Apersepsi Sirah & Pembuka Menggugah Hati.
    - 70% Aktivitas Eksplorasi Alamiah / Diskusi Nilai.
    - 15% Refleksi Jiwa & Doa Penutup.
  - *Instrumen Observasi:* 2-3 butir karakter terpilih dari 19 Butir Observasi.

---

## 4. Kesimpulan Integrasi

Kekayaan materi `wiki-pkn` kini telah memiliki **jalur integrasi yang jelas dan terukur** ke dalam aplikasi PKN Mobile v2. Setiap konsep yang diadopsi memperkuat nilai ruhani dan kemudahan praktis tanpa mengorbankan kesederhanaan antarmuka atau menambah kerumitan teknis yang tidak perlu.
