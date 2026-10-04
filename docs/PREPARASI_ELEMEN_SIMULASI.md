# Inventaris & Preparasi Elemen Modul Simulasi Virtual "Baitul Fitrah & Madinah Virtual"

> **Status Dokumen:** Technical & Design Asset Specification  
> **Target Framework:** Flutter 3.24+ | Flame Engine 1.18+ | Bonfire 3.11+ | Rive 0.13+ | Isar 3.1+  
> **Konsep Induk:** [`docs/GAME_CONCEPT_VIRTUAL_FITRAH.md`](file:///home/abuhafi/Project/PKN-healing-mobile-app/docs/GAME_CONCEPT_VIRTUAL_FITRAH.md)  
> **Kajian Stack:** [`docs/TECH_STACK_GAME_ANALYSIS.md`](file:///home/abuhafi/Project/PKN-healing-mobile-app/docs/TECH_STACK_GAME_ANALYSIS.md)

---

## 1. Ringkasan Eksekutif Kebutuhan Elemen

Untuk mewujudkan modul gamifikasi dan simulasi virtual manusia serta komunitas islami (*Baitul Fitrah & Madinah Virtual*) yang berjalan mulus dalam satu binary Flutter tanpa memperberat perangkat, seluruh kebutuhan dikelompokkan ke dalam 6 domain preparasi utama:

```
┌─────────────────────────────────────────────────────────────────────────┐
│              6 DOMAIN ELEMEN PREPARASI SIMULASI VIRTUAL                 │
├──────────────────┬──────────────────┬──────────────────┬────────────────┤
│ 1. ASET RIVE     │ 2. TILESET 2D    │ 3. SOUNDSCAPE    │ 4. DATABASE &  │
│    VEKTOR & RIG  │    & BONFIRE     │    & SFX NABAWI  │    DATA MODELS │
│ • 6 Model Usia   │ • 7 Lokasi Peta  │ • Audio Alami    │ • Isar Schemas │
│ • Tangki Cinta   │ • Collision Map  │ • Adzan & Wudhu  │ • Riverpod     │
│ • State Machine  │ • Lighting Siklus│ • Hening Khusyuk │   Game Bridge  │
├──────────────────┴──────────────────┼──────────────────┴────────────────┤
│ 5. FORMULA MATEMATIKA DELTA-TIME AFK│ 6. BANK SKENARIO & BAHASA HATI    │
│ • Algoritma Luring (Zero Battery)   │ • 50+ Dilema Adab per Usia        │
│ • The Welcome Back Ledger           │ • Real-to-Virtual Bridge Quests   │
└─────────────────────────────────────┴───────────────────────────────────┘
```

---

## 2. Domain 1: Elemen Aset Visual Rive Vector & Rigging (`.riv`)

Animasi karakter mengandalkan vektor interaktif Rive karena ukurannya yang sangat kecil (~150–250 KB per karakter), mendukung manipulasi parameter real-time (*State Machine Inputs*), serta render 60–120 FPS tanpa frame drop.

### 2.1. Matriks Karakter & Fase Perkembangan Fitrah
| No | Kode Karakter | Fase Usia / Peran | Karakteristik Fisik & Busana | Kebutuhan Animasi Pokok |
| :--- | :--- | :--- | :--- | :--- |
| 1 | `char_thufulah_boy` | Fase Thufulah (2–6 thn, Balita Laki-laki) | Celana kain longgar, kaos polos/koko mini, mata bulat besar, proporsi tubuh 1:3. | Berlari riang, jatuh tersandung, menangis tantrum, memeluk kaki orang tua, tidur lelap. |
| 2 | `char_thufulah_girl`| Fase Thufulah (2–6 thn, Balita Perempuan) | Gaun katun longgar, jilbab mini karet elastis, boneka kain di tangan. | Merajuk, tepuk tangan gembira, menyusu/minum duduk tangan kanan, pelukan manja. |
| 3 | `char_tamyiz` | Fase Tamyiz (7–10 thn, Anak Mulai Shalat) | Peci rajut, celana di atas mata kaki, sarung/koko rapi, proporsi tubuh 1:4. | Gerakan wudhu tertib, takbiratul ihram, ruku', sujud, membaca buku sirah, merapikan sajadah. |
| 4 | `char_murahaqah` | Fase Murahaqah (10–14 thn, Pra-Baligh) | Busana syar'i remaja, ransel kuttab, postur mulai tegap, proporsi tubuh 1:5. | Menulis di meja, melipat sajadah, ekspresi merenung/bingung, diskusi dengan ayah, memisahkan ranjang tidur. |
| 5 | `char_ayah` | Ayah / Qawwamun (Dewasa) | Baju koko/gamis kasual, jenggot rapi, postur tegap pelindung, proporsi 1:6.5. | Mensejajarkan tinggi (jongkok bicara), memeluk anak erat, mengimami shalat, tersenyum hangat, bekerja di meja. |
| 6 | `char_bunda` | Bunda / Madrasah Utama (Dewasa) | Gamis longgar & khimar panjang syar'i anggun, tasbih jari, proporsi 1:6. | Mendekap anak menangis, menyuapi makanan sunnah, menyimak keluh kesah (reflective listening), membaca mushaf. |

### 2.2. Spesifikasi Input State Machine Rive
Setiap file `.riv` wajib mengimplementasikan interface State Machine bernama `SM_CharacterFitrah` dengan input standar:

```text
Inputs:
├── loveTankLevel        : Number (Float 0.0 - 100.0) -> Mengontrol ekspresi bibir & kelopak mata
├── nafsState            : Number (Integer: 0=Ammarah, 1=Lawwamah, 2=Muthma'innah)
├── isInteractingWithReal: Boolean (True jika dipicu oleh Real-to-Virtual Bridge)
├── triggerCry           : Trigger (Pemicu tantrum / kesedihan krisis)
├── triggerHug           : Trigger (Pemicu animasi pelukan hangat pemulihan)
├── triggerShalat        : Trigger (Pemicu siklus shalat 5 waktu)
├── triggerAdabMakan     : Trigger (Duduk tegak, baca basmalah, tangan kanan)
└── triggerSleep         : Trigger (Meringkuk miring ke kanan menghadap kiblat)
```

### 2.3. Checklist Berkas Aset Vektor Rive
- [ ] `assets/simulation/rive/character_thufulah_boy.riv` (Rig & State Machine)
- [ ] `assets/simulation/rive/character_thufulah_girl.riv` (Rig & State Machine)
- [ ] `assets/simulation/rive/character_tamyiz.riv` (Rig & State Machine)
- [ ] `assets/simulation/rive/character_murahaqah.riv` (Rig & State Machine)
- [ ] `assets/simulation/rive/character_parent_ayah.riv` (Rig & State Machine)
- [ ] `assets/simulation/rive/character_parent_bunda.riv` (Rig & State Machine)
- [ ] `assets/simulation/rive/fx_love_burst.riv` (Efek partikel cahaya saat Tangki Cinta terisi)
- [ ] `assets/simulation/rive/ui_love_tank_gauge.riv` (Meteran dinamis Tangki Cinta di HUD)

---

## 3. Domain 2: Elemen Lingkungan 2D, Tileset & Bonfire Engine

Peta lingkungan dirender menggunakan sistem isometrik 2D / 2.5D melalui framework Bonfire yang terintegrasi di atas Flame Engine.

### 3.1. 7 Lokasi Peta Komunitas (Peta Madinah Virtual)
1. **Venue 1: Baitul Fitrah (Rumah Tinggal Utama)**
   - *Area:* Ruang Tamu Hangat, Ruang Keluarga Lesehan, Musholla Rumah (menghadap Kiblat), Dapur Barakah (meja makan adab), Kamar Anak Usia 0–7, Kamar Anak Terpisah Usia 10+ (sesuai sabda Nabi tentang pemisahan ranjang).
2. **Venue 2: Kuttab / Sekolah Adab**
   - *Area:* Halaqah melingkar beralas karpet, rak mushaf Al-Qur'an, papan tulis kayu, halaman bermain tanah/pasir.
3. **Venue 3: Masjid Jami' Nabawi**
   - *Area:* Ruang utama shalat dengan shaf lurus, mimbar khutbah, tempat wudhu dengan air mengalir (pancuran hemat air sunnah), pelataran terbuka beratap teduh.
4. **Venue 4: Taman Fitrah & Kebun Alam**
   - *Area:* Kolam ikan air tawar, pohon kurma/zaitun rindang, pasir mainan sensori anak, jalan setapak batu alam untuk melatih motorik kasar balita.
5. **Venue 5: Pasar & Koperasi Barakah**
   - *Area:* Lapak pedagang buah dan kurma, timbangan dacing presisi adil, etalase kotak infaq/sedekah subuh, papan aturan jual-beli tanpa riba/gharar.
6. **Venue 6: Asrama Santri & Bilik Muraja'ah**
   - *Area:* Ranjang kayu bertingkat rapi, loker buku kitab kuning, sudut tasmi' hafalan 1-on-1.
7. **Venue 7: Ruang Kerja Halal Ayah**
   - *Area:* Meja arsitek/komputer kerja, lemari dokumen usaha halal, jam dinding penanda waktu shalat tepat waktu.

### 3.2. Spesifikasi Teknis Tileset & Sprite
- **Grid Projection:** Isometric 2:1 projection (lebar tile 64px, tinggi tile 32px) atau Diamond Orthogonal 32x32px.
- **Format Peta:** Tiled Map Editor (`.tmx` diekspor ke `.json`).
- **Lapisan Peta (Map Layers):**
  1. `Floor`: Ubin parket kayu, karpet permadani, rumput alam, pasir.
  2. `Walls_Collision`: Dinding bata, pintu, sekat ruangan, jendela (memiliki komponen Bonfire `CollisionArea`).
  3. `Furniture_Interactive`: Sajadah musholla, rak buku, meja makan, tempat tidur (memiliki trigger interaksi).
  4. `Lighting_Ambient`: Dynamic color filter siklus 24 jam (Fajar: oranye lembut; Siang: putih hangat cerah; Maghrib: lembayung senja; Malam: biru gelap temaram).

### 3.3. Checklist Berkas Lingkungan & Tileset
- [ ] `assets/simulation/maps/home_baitul_fitrah.json` (Peta Tiled Ruangan Rumah)
- [ ] `assets/simulation/maps/kuttab_school.json` (Peta Tiled Sekolah Adab)
- [ ] `assets/simulation/maps/masjid_jami.json` (Peta Tiled Masjid)
- [ ] `assets/simulation/maps/fitrah_garden.json` (Peta Tiled Kebun/Taman)
- [ ] `assets/simulation/tilesets/interior_house_tiles.png` (Atlas tekstur furnitur & dinding)
- [ ] `assets/simulation/tilesets/nature_props_tiles.png` (Atlas pohon kurma, rumput, kolam)
- [ ] `assets/simulation/tilesets/islamic_props.png` (Sajadah, mushaf, mimbar, teko wudhu)

---

## 4. Domain 3: Elemen Audio, Soundscape & SFX Nabawiyah

Pengalaman audio dirancang untuk menghadirkan ketenangan jiwa (*Tazkiyatun Nafs*) tanpa kebisingan musik digital yang menguras dopamin secara artifisial.

### 4.1. Audio Ambience Alami (Soundscape)
| Nama Aset | Durasi / Sifat | Deskripsi & Konteks Pemutaran |
| :--- | :--- | :--- |
| `amb_dawn_birds.mp3` | 120s Loop | Kicauan burung fajar lembut dan desau dedaunan kurma saat waktu Subuh & Dhuha. |
| `amb_wudhu_water.mp3` | 60s Loop | Gemericik air mengalir tenang dari pancuran tempat wudhu masjid. |
| `amb_home_hearth.mp3` | 90s Loop | Suasana hangat dalam rumah, desau angin jendela, halaman asri. |
| `amb_night_serenity.mp3`| 120s Loop | Keheningan malam bertabur jangkrik samar untuk sesi tidur/tahajjud. |

### 4.2. Sound Effects (SFX) Interaksi Penuh Makna
- [ ] `sfx_door_knock_salam.wav`: Ketukan pintu kayu lembut diikuti bisikan "Assalamu'alaikum".
- [ ] `sfx_love_fill_chime.wav`: Denting genta harpa akustik lembut (C-Major pentatonis) saat Tangki Cinta anak terisi.
- [ ] `sfx_sigh_relief.wav`: Desah napas lega anak setelah dekap tenang (*crying stopped*).
- [ ] `sfx_page_turn_sirah.wav`: Suara kertas buku sirah dibalik saat membaca bersama.
- [ ] `sfx_adhan_subuh_snippet.mp3`: Cuplikan lafadz adzan merdu *"Ash-shalatu khairum minan naum"* saat siklus subuh.
- [ ] `sfx_adhan_general.mp3`: Lafadz *"Allahu Akbar, Allahu Akbar"* penanda panggilan shalat 5 waktu.

---

## 5. Domain 4: Skema Database Isar & Model Status Simulasi

Penyimpanan status virtual di perangkat lokal mengandalkan Isar Database karena kecepatan kueri ACID mikro-detik (< 1 ms), mendukung ratusan log riwayat tanpa lag.

### 5.1. Entitas `CharacterEntity`
Menyimpan data identitas, usia fitrah, dan barometer jiwa setiap insan virtual di keluarga.

```dart
@collection
class CharacterEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String characterUuid;

  late String name;
  late String gender; // 'male' | 'female'
  late String agePhase; // 'thufulah' | 'tamyiz' | 'murahaqah' | 'baligh'
  late int exactAgeYears;

  // Barometer Fitrah
  late double loveTankLevel; // 0.0 s.d. 100.0
  late int nafsState; // 0: Ammarah, 1: Lawwamah, 2: Muthma'innah

  // Posisi Terakhir
  late String currentVenueId; // 'home' | 'kuttab' | 'masjid' | 'garden'
  late double posX;
  late double posY;

  // Timestamp Pembaruan
  late DateTime lastStateCalculatedAt;

  // Catatan Adab Akumulatif (19 Butir Adab)
  late List<String> masteredAdabKeys;
}
```

### 5.2. Entitas `LedgerEventEntity` (Rekaman Catatan Kejadian AFK)
Menyimpan rekaman peristiwa yang terjadi selama pengguna tidak membuka aplikasi (*Away From Keyboard*).

```dart
@collection
class LedgerEventEntity {
  Id id = Isar.autoIncrement;

  late String characterUuid;
  late DateTime eventTimestamp;
  late String venueId;
  late String category; // 'routine' | 'crisis_dilemma' | 'adab_breakthrough' | 'prayer'

  late String title;
  late String narrativeText; // Narasi sastra bahasa hati yang menyejukkan

  // Dilema & Keputusan Tertunda
  late bool isPendingDilemma;
  String? dilemmaScenarioId;
  bool isResolved = false;
  String? chosenResolutionKey;

  // Dampak Hasil
  double loveTankImpact = 0.0;
  int nafsImpact = 0;
}
```

### 5.3. Entitas `RealToVirtualMissionEntity` (Jembatan Aksi Nyata)
Menghubungkan amalan nyata orang tua/guru di dunia fisik dengan reward kemakmuran dunia virtual.

```dart
@collection
class RealToVirtualMissionEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String missionKey;

  late String title;
  late String realWorldActionDescription;
  late int suggestedDurationMinutes;
  late String targetAgePhase;

  // Benefit
  late double loveTankReward;
  late String virtualGardenSeedReward; // misal: 'seed_kurma_kesabaran'

  bool isCompletedToday = false;
  DateTime? lastCompletedAt;
}
```

---

## 6. Domain 5: Formula Matematika Simulasi Offline (Delta-Time AFK Engine)

Simulasi **TIDAK** menjalankan game loop aktif saat aplikasi ditutup (menjamin nol konsumsi baterai). Seluruh kejadian dihitung secara deterministik matematika pada milidetik aplikasi dibuka kembali (*On App Resume / Cold Start*):

$$\Delta t = t_{\text{resume}} - t_{\text{last\_exit}}$$

### 6.1. Formula Penurunan Alami Tangki Cinta
Kebutuhan kedekatan emosional berbeda berdasarkan fase usia. Balita (*Thufulah*) membutuhkan kehadiran pengasuh lebih intens dibandingkan remaja:

$$\text{Decay}(\Delta t, \text{Fase}) = \lambda_{\text{fase}} \times \Delta t \quad (\text{satuan jam})$$

| Fase Usia | Koefisien Luruh ($\lambda$) | Penjelasan Fitrah |
| :--- | :--- | :--- |
| **Thufulah (0–6 thn)** | $3.5\text{ poin / jam}$ | Tangki cinta cepat susut; anak mudah gelisah & tantrum jika orang tua 'absen' lama. |
| **Tamyiz (7–10 thn)** | $2.0\text{ poin / jam}$ | Anak mulai mandiri dan berteman di kuttab, namun tetap butuh sambutan hangat saat pulang. |
| **Murahaqah (10–14 thn)**| $1.2\text{ poin / jam}$ | Mulai stabil, kehausan afeksi bergeser ke dialog apresiasi dan rasa dipercaya. |
| **Baligh / Syabab (15+)** | $0.8\text{ poin / jam}$ | Lebih otonom; afeksi diwujudkan lewat bimbingan peran peradaban dan visi hidup. |

*Batas Bawah Emosional:* Tangki cinta tidak akan jatuh di bawah $15.0$ secara otomatis (mencegah kepanikan ekstrem / *guilt-shaming* pada orang tua).

### 6.2. Evaluasi Siklus Waktu Shalat & Aktivitas Rutin
Jika dalam rentang $[t_{\text{last\_exit}}, t_{\text{resume}}]$ melintasi jadwal shalat lokal:
1. Sistem mencatat `LedgerEventEntity` kategori `prayer`.
2. Karakter diposisikan sedang/telah shalat berjamaah di musholla rumah atau Masjid Jami'.
3. Jika Tangki Cinta saat waktu shalat $> 60$, karakter shalat dengan khusyuk (*Nafs Muthma'innah*).
4. Jika Tangki Cinta $< 30$, timbul potensi peristiwa dilema (misal: enggan wudhu karena dingin).

### 6.3. Generator Dilema Tertunda (*Pending Dilemma*)
- Probabilitas timbulnya dilema dihitung proporsional terhadap $\Delta t$ dan kekosongan Tangki Cinta:
  $$P(\text{Dilemma}) = \min\left(0.85, \frac{\Delta t}{6\text{ jam}} \times \frac{100 - \text{loveTank}}{60}\right)$$
- Maksimal **1 krisis dilema aktif** per anak dalam satu sesi login agar orang tua tidak merasa terbebani (*anti-overwhelm*).

---

## 7. Domain 6: Bank Konten Skenario, Dilema Adab & Bahasa Hati

Konten skenario ditulis secara sastrawi dan berbasis riset Nabawiyah untuk mendidik intuisi orang tua/pendidik saat menghadapi realitas harian.

### 7.1. Sampel Bank Dilema Adab per Fase Usia
```
┌────────────────────────────────────────────────────────────────────────┐
│ SKENARIO DILEMA #THUF-01: "Tumpahan Susu di Atas Mushaf Ayah"          │
├────────────────────────────────────────────────────────────────────────┤
│ • Fase Usia   : Thufulah (3.5 tahun)                                   │
│ • Venue       : Baitul Fitrah (Ruang Tamu)                             │
│ • Pemicu      : Tangki Cinta = 38. Rasa ingin tahu motorik.             │
│ • Deskripsi   : Si kecil ingin meniru Ayah membaca mushaf sambil minum │
│                 susu gelas. Susu tumpah membasahi karpet & tepi mushaf.│
│                 Si kecil ketakutan, bibirnya bergetar hendak menangis. │
├────────────────────────────────────────────────────────────────────────┤
│ Pilihan Respons Bahasa Hati Orang Tua:                                 │
│ 1. [Opsi Marah / Reaktif]: "Kan sudah dibilang jangan bawa gelas ke    │
│    sajadah! Lihat mushaf Ayah jadi basah!"                             │
│    -> Dampak: Tangki Cinta -25, Nafs Ammarah, Anak merasa tertolak.   │
│                                                                        │
│ 2. [Opsi Reflektif & Bahasa Hati (Rekomendasi Nabawi)]:                │
│    Jongkok sejajar mata anak, dekap lembut, lalu berkata: "Adek kaget  │
│    ya susunya tumpah? Tidak apa-apa, Adek aman. Yuk kita ambil lap     │
│    bersama untuk bersihkan mushaf dan karpet."                         │
│    -> Dampak: Tangki Cinta +30, Nafs Muthma'innah, Adab tanggung jawab.│
└────────────────────────────────────────────────────────────────────────┘
```

### 7.2. Sampel Katalog Real-to-Virtual Bridge Quests
| ID Misi | Judul Misi Dunia Nyata | Aksi Fisik Nyata | Reward Virtual |
| :--- | :--- | :--- | :--- |
| `R2V_HUG_01` | *Dekapan Menit Emas* | Peluk anakmu secara tulus selama 3 menit tanpa memegang gawai sama sekali. | Tangki Cinta Karakter penuh 100% + Bibit Bunga Kesabaran di Kebun Fitrah. |
| `R2V_BEDTIME_01`| *Bisikan Sirah Pengantar Tidur* | Bacakan 1 kisah keberanian shahabat cilik (misal: Ali bin Abi Thalib ra.) sebelum tidur. | Log narasi haru di Ledger + Status Tidur Berkah sepanjang malam. |
| `R2V_MOSQUE_01` | *Langkah Menuju Rumah-Nya* | Gandeng tangan anak laki-laki berjalan kaki menuju shalat berjamaah di masjid terdekat. | Karakter virtual membuka interaksi khusus di Masjid Jami' Nabawi. |

---

## 8. Ringkasan Kebutuhan Berkas & Aset Baru

Berikut adalah ringkasan inventaris berkas yang perlu disiapkan di dalam repositori:

```text
PKN-healing-mobile-app/
├── assets/
│   └── simulation/
│       ├── rive/
│       │   ├── character_thufulah_boy.riv
│       │   ├── character_thufulah_girl.riv
│       │   ├── character_tamyiz.riv
│       │   ├── character_murahaqah.riv
│       │   ├── character_parent_ayah.riv
│       │   ├── character_parent_bunda.riv
│       │   └── ui_love_tank_gauge.riv
│       ├── maps/
│       │   ├── home_baitul_fitrah.json
│       │   └── kuttab_school.json
│       ├── tilesets/
│       │   ├── interior_house_tiles.png
│       │   └── islamic_props.png
│       └── audio/
│           ├── amb_dawn_birds.mp3
│           ├── amb_wudhu_water.mp3
│           ├── sfx_love_fill_chime.wav
│           └── sfx_door_knock_salam.wav
└── lib/features/simulation/
    ├── data/
    │   ├── models/ (CharacterEntity, LedgerEventEntity, MissionEntity)
    │   ├── repositories/ (SimulationRepository)
    │   └── content_bank/ (50+ JSON skenario dilema bahasa hati)
    ├── domain/
    │   └── services/ (DeltaTimeSimulationEngine, LoveTankCalculator)
    └── presentation/
        ├── controllers/ (SimulationController, LedgerNotifier)
        ├── screens/ (KampungFitrahScreen, WelcomeBackLedgerScreen, DilemmaDialogScreen)
        └── game/ (BaitulFitrahGame, CharacterComponent, InteractiveFurnitureComponent)
```
