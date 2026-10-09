# 💖 Konsep Mekanik: Sistem Riyadhoh & Dinamika Tangki Cinta
## *(Menggantikan Kunci Prasyarat Kaku Menjadi Biaya Energi Batin & Latihan Jiwa)*

> **Dokumen:** Spesifikasi Mekanik Game Design Inti  
> **Tanggal:** 8 Oktober 2026  
> **Konsep Kunci:** **Riyadhoh** (pengerahan tenaga batin untuk berakhlak mulia di luar bakat alami) dan **Tangki Cinta** (kapasitas daya tahan emosional & kasih sayang yang dapat terisi dan terkuras).

---

## 1. Filosofi & Latar Belakang: Mengapa Mekanik Ini Jauh Lebih Hidup?

### 1.1. Kelemahan Sistem "Pilihan Terkunci" (Rigid Gating)
Pada sistem RPG konvensional, jika karakter tidak memiliki skor bakat/skill tertentu, sebuah pilihan respon diberi gembok abu-abu (*disabled/turned off*).  
Dalam dunia nyata pengasuhan:
* **Tidak ada respon adab yang mustahil dilakukan manusia.** Seorang ayah yang bertemperamen kaku dan keras sekalipun **bisa** memilih untuk berlutut dan berbicara sangat lembut kepada anaknya.
* Namun, melakukan sesuatu yang **bukan bakat alaminya** membutuhkan **perjuangan batin yang luar biasa berat (*Mujahadah / Riyadhoh*)**!

### 1.2. Landasan Manhaj: Akhlak Bawaan (*Jibilliy*) vs Akhlak Usaha (*Muktasab*)
Dalam kaidah Tazkiyatun Nafs (Imam Al-Ghazali & Ibnul Qayyim):
1. **Akhlak Jibilliy (Fitrah Bawaan / Bakat Alami TB-40):** Perilaku mulia yang mengalir spontan tanpa beban pikiran (*suhulah*). Contoh: Orang yang memiliki bakat *Rifq* (Kelembutan) sejak lahir sangat mudah tersenyum saat anak rewel.
2. **Akhlak Muktasab melalui Riyadhoh (Latihan Jiwa):** Seseorang yang tidak berbakat lembut, tetapi **memaksa hawa nafsunya** untuk tetap bersikap lembut demi mencari ridha Allah. Ini adalah **Riyadhoh**.
3. **Syarat Riyadhoh:** Seseorang hanya sanggup melakukan Riyadhoh jika **Tangki Cinta dan Energi Ruhaninya masih memiliki daya**. Jika tangkinya kosong kering (*caregiver burnout*), daya sabarnya runtuh dan ia jatuh ke dalam kemarahan (*Ghadhab*).

---

## 2. Arsitektur Mekanik Permainan

```
┌────────────────────────────────────────────────────────────────────────┐
│ 🎮 ATURAN EMAS MEKANIK RIYADHOH                                        │
├────────────────────────────────────────────────────────────────────────┤
│ 1. SEMUA PILIHAN TERBUKA sejak awal (Tidak ada gembok kaku).           │
│ 2. Setiap pilihan MEMAKAN KUOTA TANGKI CINTA.                          │
│ 3. Jika pilihan sesuai bakat alami ➔ BIAYA CINTA SANGAT MURAH.         │
│ 4. Jika pilihan BUKAN bakat alami ➔ BIAYA CINTA MAHAL (RIYADHOH).      │
│ 5. Pilihan terkunci HANYA JIKA Tangki Cinta < Biaya Riyadhoh.          │
│ 6. Pemain dapat MERECHARGE Tangki Cinta lewat aksi batin atau event.   │
└────────────────────────────────────────────────────────────────────────┘
```

```mermaid
flowchart TD
    P["Pemain Memilih Respon (Misal: Kelembutan Mumtaz)"] --> C{"Apakah Karakter Memiliki Bakat Ini?"}
    
    C -->|Bakat Alami Tinggi (Lvl 3-4)| NAT["Respon Mengalir Alami<br>Biaya: 5–10 Tangki Cinta"]
    C -->|Bukan Bakatnya (Lvl 0-1)| RIY["Membutuhkan RIYADHOH<br>Biaya: 30–45 Tangki Cinta"]
    
    NAT --> CHK{"Tangki Cinta Cukup?"}
    RIY --> CHK
    
    CHK -->|Ya (Cinta Tersedia)| EXEC["Aksi Berhasil Dieksekusi!<br>Tangki Cinta Berkurang Sesuai Biaya"]
    CHK -->|Tidak (Tangki Kosong)| EXH["TERKUNCI KARENA KELELAHAN JIWA:<br>'Tangki Cinta Tidak Cukup untuk Riyadhoh'<br>➔ Wajib Recharge Batin Dahulu"]
```

---

## 3. Formula Matematika Biaya Riyadhoh

Setiap pilihan respon memiliki nilai **Base Cost** (Biaya Dasar Emosi) berdasarkan tingkat keluhuran adabnya (*Tier Mumtaz, Jayyid, Dha'if, Munkar*).

### Rumus Perhitungan Biaya:
$$\text{Biaya Cinta} = \max\Big(\text{Min Cost}, \; \text{Base Cost} - (\text{Level Bakat TB-40} \times \text{Diskon Bakat})\Big)$$

### Parameter Standar:
* **Diskon Bakat per Level:** 7 s.d. 8 Poin Cinta per Level Bakat (Skala 0–4).
* **Min Cost:** 5 Poin Cinta (setiap tindakan tetap membutuhkan perhatian sadar).

### Tabel Simulasi Biaya Berdasarkan Bakat:

| Pilihan Respon | Tier Adab | Base Cost | Pemain A (Punya Bakat Rifq Lvl 4) | Pemain B (Bukan Bakatnya, Rifq Lvl 0) |
|---|---|---|---|---|
| **Kelembutan Mendalam (Rifq)** | *MUMTAZ* | 35 Cinta | **7 Cinta** *(Mengalir spontan)* | **35 Cinta** *(Riyadhoh Berat!)* |
| **Ketegasan Santun (Syajaa'ah)** | *JAYYID* | 20 Cinta | **20 Cinta** *(Riyadhoh Ringan)* | **6 Cinta** *(Jika bakatnya Qiyadah)* |
| **Menunda / Kompromi Lelah** | *DHA'IF* | 10 Cinta | **10 Cinta** | **10 Cinta** *(Pilihan pelarian saat lelah)* |
| **Bentakan Spontan / Emosi** | *MUNKAR* | **0 Cinta** | **0 Cinta** *(Murah energi, tapi merusak hubungan)* | **0 Cinta** *(Godaan Nafs Ammarah)* |

> **Insight Pedagogis yang Kuat:**  
> Pilihan buruk (*Munkar/Membentak*) biayanya **0 Cinta** karena tidak membutuhkan kontrol diri sama sekali (hawa nafsu mengalir bebas).  
> Sebaliknya, pilihan terbaik (*Mumtaz*) membutuhkan biaya cinta yang besar bagi orang yang belum terbiasa. Inilah esensi mendidik diri!

---

## 4. Mekanisme Pengisian Ulang (Recharging Tangki Cinta)

Ketika Tangki Cinta menipis dan pemain tidak sanggup membayar biaya Riyadhoh, pemain memiliki dua jalur pemulihan:

### 4.1. Recharging Aktif (Aksi Pilihan Pemain / Ritual Thuma'ninah)
Sebelum memilih kalimat untuk anak, pemain dapat mengklik tombol **"Ambil Jeda (The Golden Pause)"**:
1. **Dzikir & Ta'awwudz:**  
   * Membaca ta'awwudz dan istighfar $\rightarrow$ **+15 Tangki Cinta** (meredakan kepulan amarah syetan).
2. **Wudhu dengan Air Dingin:**  
   * Mengambil air wudhu (sesuai sabda Nabi ﷺ bahwa amarah itu dari api dan padam dengan air) $\rightarrow$ **+25 Tangki Cinta**.
3. **Duduk / Berbaring Sejenak:**  
   * Menurunkan postur tubuh dari berdiri menjadi duduk $\rightarrow$ **+10 Tangki Cinta**.
4. **Real-to-Virtual Bridge (Aksi Nyata di Rumah):**  
   * Meletakkan ponsel, memeluk pasangan/anak di dunia nyata selama 2 menit, minum segelas air putih $\rightarrow$ **+35 Tangki Cinta**.

### 4.2. Recharging Pasif (Terpicu oleh Peristiwa / Event-Driven)
Tangki Cinta terisi secara dramatis oleh kejadian di dalam narasi:
1. **Bahasa Mata Anak (The Innocent Gaze):**  
   * Anak mendongak menatap mata ayah dengan kepolosan $\rightarrow$ **+20 Tangki Cinta**.
2. **Dukungan Pasangan (Co-caregiver Solidarity):**  
   * Bunda membawakan secangkir teh hangat ke ruang tamu atau menepuk pundak Ayah $\rightarrow$ **+25 Tangki Cinta**.
3. **Panggilan Adzan & Shalat Berjamaah:**  
   * Melangkah bersama ke masjid / musholla rumah $\rightarrow$ **Tangki Cinta Terisi Penuh (100%)**.
4. **Istirahat Malam yang Tenang:**  
   * Pergantian episode / tidur lelap $\rightarrow$ **Reset ke Kondisi Segar**.

---

## 5. Tampilan Antarmuka (UI/UX) Pilihan Riyadhoh

Pada panel dialog Flutter native, setiap opsi menampilkan lencana biaya cinta secara transparan:

```
┌────────────────────────────────────────────────────────────────────────┐
│ 💖 TANGKI CINTA AYAH: 28 / 100 [████████░░░░░░░░░░░░░░░░░░░]          │
├────────────────────────────────────────────────────────────────────────┤
│ Zaid: "Bentar lagi, Yah! Jangan diganggu dulu!"                        │
├────────────────────────────────────────────────────────────────────────┤
│ PILIHAN RESPON:                                                        │
│                                                                        │
│ 1. [MUMTAZ - RIFQ] Berlutut sejajar mata dan hargai menaranya.         │
│    ⚡ Butuh Riyadhoh: -35 Cinta  ❌ (KURANG 7 CINTA)                    │
│    [🔒 Jiwamu terlalu lelah saat ini. Ambil Jeda / Wudhu dahulu!]      │
│                                                                        │
│ 2. [JAYYID - ANA'AH] Berdiri diam sejenak, menghela nafas tanpa suara. │
│    ⚡ Butuh Riyadhoh: -15 Cinta  ✅ (CUKUP - Sisa 13 Cinta)            │
│                                                                        │
│ 3. [DHA'IF] Biarkan dia bermain dan tinggalkan tanpa kejelasan.        │
│    ⚡ Biaya: -5 Cinta           ✅ (CUKUP)                            │
│                                                                        │
│ 4. [MUNKAR] "Berani kamu membantah Ayah?!" (Bentak & Rebut Balok)      │
│    ⚡ Biaya: 0 Cinta             ⚠️ (GRATIS ENERGI, TAPI MERUSAK JIWA) │
│                                                                        │
│ ────────────────────────────────────────────────────────────────────── │
│ [ 💧 Ambil Air Wudhu (+25 Cinta) ]   [ 📿 Istighfar & Duduk (+15 Cinta) ]│
└────────────────────────────────────────────────────────────────────────┘
```

---

## 6. Contoh Alur Keputusan Permainan: Belajar Menahan Diri

1. **Kondisi Awal:** Abu Zaid pulang kantor dengan sisa **Tangki Cinta = 28**.
2. **Dilema:** Abu Zaid ingin memilih respon *Mumtaz (Kelembutan Rifq)*, tetapi karena bakat *Rifq*-nya masih taraf awal (MT / Level 1), biaya Riyadhoh adalah **35 Cinta**.
3. **Tantangan:** Pilihan tersebut tidak bisa ditekan karena **28 < 35**. Muncul pesan bijak:  
   > *“Jiwamu letih dari perjalanan kerja. Kamu tidak sanggup memaksakan kelembutan saat ini tanpa mengisi bekal batinmu terlebih dahulu.”*
4. **Tindakan Pemain:** Pemain menekan tombol **[💧 Ambil Air Wudhu]**.  
   * Layar menampilkan teks kontemplatif:  
     > *“Air dingin membasahi wajah dan lenganmu. Panas di kepalamu mereda. Detak jantungmu melambat.”*  
   * Tangki Cinta bertambah +25 $\rightarrow$ **Kini menjadi 53**.
5. **Eksekusi:** Pilihan *Mumtaz* kini menyala terang! Pemain menekannya, mengurangkan 35 Cinta (sisa 18), dan Abu Zaid berhasil merespon Zaid dengan kelembutan yang mengubah suasana rumah menjadi sakinah.

---

## 7. Keunggulan Sistem Riyadhoh Dibanding Sistem RPG Lain

1. **Mengajarkan *Self-Awareness* Orang Tua:**  
   Pemain belajar bahwa kegagalan bersikap lembut sering kali bukan karena mereka "orang tua jahat", melainkan karena **mereka belum mengisi Tangki Cinta diri mereka sendiri** (*Caregiver Burnout*).
2. **Menghormati Usaha Batin (*Mujahadah*):**  
   Setiap kali pemain membayar biaya Riyadhoh yang mahal, game memberikan apresiasi naratif:  
   > *“Kamu baru saja menaklukkan egomu sendiri. Ini adalah jihad batin yang disukai Allah.”*
3. **Integrasi Organik dengan Formula Manhaj PKN:**  
   Mekanik ini menyatukan dua pilar agung PKN: **Koneksi Sebelum Koreksi** (isi tangki cinta dulu) dan **Tazkiyatun Nafs** (latihan riyadhoh bertahap).
