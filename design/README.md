# PKN — Desain Journey Native

## Analisis sumber dan keputusan

Sumber utama: seluruh 505 baris `docs/USER_JOURNEYS.md`, dibandingkan dengan `DESIGN_SYSTEM.md` dan tree desain lama. Matriks sumber berisi **16 persona dalam 5 ranah**. Lima layar awal diperbarui; layar tugas dan state ditambahkan sebagai frame, teks, bentuk, dan komponen native, bukan screenshot.

Alur bersama: **O1 ranah → O2 peran/fase kondisional → O3 bottleneck/waktu → O4 keluaran personal → H**. Fase ditampilkan untuk keluarga/guru/pelajar, tidak diwajibkan pada pengelola atau peneliti. O4 memperlihatkan contoh profil Ayah; pilihan semua persona dan rekomendasi pilarnya tersedia pada O2 dan MAP. Profil dapat diubah, bukan label permanen.

Lead ringkas didahulukan. Krisis adalah fitur bantuan, bukan pilar. Deck tepat **5 langkah**: fenomena, prinsip/dalil, kuis respons, ucapan praktis, doa/refleksi. Dkf adalah feedback pada langkah 3, bukan langkah 6. Primer pemula memiliki 5 hari, tidak dikunci streak. Bookmark, jurnal, audio luring, penyimpanan sukses/gagal, dan konten luring memiliki state tersendiri.

Konflik sumber diselesaikan mengikuti journey dan permintaan pengguna: donut adab 100% dihapus walaupun dokumen sistem lama menyebutnya. Tidak ada skor total adab, leaderboard, atau streak shaming. Rubrik: BT Belum Tampak, MT Mulai Tampak, BK Berkembang, MM Membudaya. Token pilar mengikuti DESIGN_SYSTEM: P1 Mulai #6366F1; P2 Fase #0EA5E9; P3 Bakat #8B5CF6; P4 Keluarga #F43F5E; P5 Lembaga & Guru #10B981; P6 Dalil #D4AF37.

## Cakupan persona

Semua jalur dimulai dengan onboarding bersama. Identifier berikut adalah **key layar stabil**, bukan node ID. Rentang berarti seluruh layar pada rentang. Resolusi key ke node dilakukan melalui manifest root setelah membuka berkas.

| Persona | Ranah | Aha dan alur tugas | Pilar |
|---|---|---|---|
| 01a Ayah | Keluarga | F eksekutif/prinsip/ucapan/batas; S1 bookmark; Dk1–5; R1–5 | P4 / P2 |
| 01b Bunda | Keluarga | K respons cepat; S1; A1–3 hands-free; R1–5 | P4 / P1 |
| 01 Pemula | Keluarga | N peta 4 fase; N2 primer 5 hari; Dk1–5 | P1 |
| 02a Guru Thufulah | Guru | T1 sirah/aktivitas/komunikasi wali; A2; R1–5 | P5 / P2 |
| 02b Guru Tamyiz | Guru | T2 rutinitas kelas/shalat/RPP; R1–5; D2 sumber | P5 / P2 |
| 02c Guru Murahaqah | Guru | T3 mediasi; T3b thaharah/privasi; E1 | P5 / P2 |
| 02d Pembimbing Syabab | Guru | T4 mentoring; T4b iffah; B1–7 kontribusi | P3 / P5 |
| 02e Pembimbing Dewasa | Guru | T5 tiga lapisan jiwa/rekonsiliasi; Dk1–5; J | P1 / P4 |
| 02 Guru Umum | Guru | R1–3 berisi 19 butir fast-tap; R4 bukti; R5 laporan naratif | P5 |
| 03a Pengelola Formal | Lembaga | L1 maqashid/KOSP; L1b keputusan program; L3–L3b prioritas | P5 |
| 03b Pengelola Non-formal | Lembaga | L2 kurikulum; L2b komitmen wali; L2c portofolio naratif | P5 / P6 |
| 03 Pengelola Umum | Lembaga | L3 audit 8 standar; L3b prioritas tahun pertama | P5 |
| 04 Fasilitator Kajian | Keilmuan | D1 silabus/dalil sheet/outline; D2–D3 telaah | P6 / P1 |
| 05 Peneliti Dalil | Keilmuan | D2 sumber/status; D3 syarah/nash/ijtihad; S1 | P6 |
| 06 Siswa/Santri | Pelajar | B1–5 lima pertanyaan; B6 ilustrasi 4 kluster; B7 kontribusi | P3 |
| 07 Pembelajar Mandiri | Mandiri | A1 audio malam; A2 unduh/luring; A3 latar belakang; J syukur | P1 / P4 |

## Artefak dan manifest

`design/PKN_Healing_App_Design.fig` berisi objek native editable yang dibuat melalui OpenPencil v0.15.1. Tidak ada perubahan cloud Figma atau URL kolaborasi; import Figma cloud belum diuji.

Fase aplikasi utama memuat **53 key layar**, masing-masing dalam Light dan Dark, **4 varian tablet** (`L1_Tablet`, `R1_Tablet` dan padanan `_Dark`) serta **H_Android**: total **111 viewport**. Peta persona MAP terpisah dari jumlah viewport. Ukuran mobile dasar 390×844, Android 412×915, tablet 768×1024; bukan lagi kanvas seragam 428×1040. Konten panjang dipisahkan dari dock dan dipotong viewport. Native scrolling belum diimplementasikan; browser prototype menyediakan scroll nyata.

Library utama memiliki tiga master: `Status & header`, `Docked primary action`, `Four-tab icon navigation`; 333 instance dipakai pada 111 viewport. Propagasi perubahan master membutuhkan `figma.graph.updateNode` lalu `figma.graph.syncInstances`; instance override dapat mempertahankan nilai sendiri. Pemeriksaan parent mengubah radius CTA menjadi 22 dan mengamati propagasi pada 111 CTA.

Gunakan `screenKey`, bukan daftar node ID yang mudah basi. Generator utama mengembalikan manifest saat dijalankan, tetapi tidak menyimpannya sebagai root field; `pknGameManifest` menyimpan frame dan scene Virtual Fitrah. Node ID dapat berubah saat serialisasi. Lookup frame dari berkas yang baru dibuka sebelum ekspor. Data `pknPrototype` dan `pknGamePrototype` menjadi sumber browser prototype, bukan native reactions.

## Regenerasi dan penggunaan

Jalankan dari root, dengan CLI OpenPencil dan Node.js tersedia. Generator hanya membangun ulang halaman/aset yang dimilikinya; simpan perubahan manual sebelum regenerasi.

```bash
openpencil info design/PKN_Healing_App_Design.fig
openpencil eval design/PKN_Healing_App_Design.fig --stdin -w < design/generate-journeys.js
openpencil eval design/PKN_Healing_App_Design.fig --stdin -w < design/generate-virtual-fitrah.js
node design/generate-prototype.mjs
node design/sync-tokens.mjs
node design/sync-tokens.mjs --check
openpencil eval design/PKN_Healing_App_Design.fig -c 'return figma.root.findAll(n=>n.type==="FRAME"&&n.getPluginData("screenKey")).map(n=>({key:n.getPluginData("screenKey"),id:n.id,name:n.name,page:n.parent.name}));' --json
```

Buka `design/prototype.html` melalui server statis lokal. Enam start aplikasi utama: Ayah/F, Bunda/K, Guru Tamyiz/T2, Santri/B1, Mudir/L1, Mandiri/A1. Nama flow Santri masih menyebut radar; radar B6 adalah ilustrasi empat kluster, **bukan hasil asesmen**. Generator prototype juga membaca flow Virtual Fitrah bila datanya tersedia. Native `reactions` dan flow starting points tidak writable pada API yang diperiksa; start dan klik yang berjalan berada di browser, bukan Figma cloud.

Untuk ekspor, ambil ID dari lookup terkini lalu gunakan `openpencil export ... --node <ID> -f png -o <output> --font-policy warn`. Parent mengekspor ulang **seluruh166 frame screenKey** (111 utama +55 game) ke PNG; keberhasilan ekspor tidak berarti semua166 telah diaudit visual/aksesibilitas.

### Resize viewport eksplisit

```bash
# Default: H menjadi 412×915; tanpa -w hanya smoke, tidak menyimpan berkas.
openpencil eval design/PKN_Healing_App_Design.fig --stdin < design/resize-viewport.js
# Permintaan lain ditulis ke root pluginData pknResizeRequest sebelum helper dijalankan.
openpencil eval design/PKN_Healing_App_Design.fig -c 'figma.root.setPluginData("pknResizeRequest",JSON.stringify({screen:"R1",width:412,height:915}));' -w
openpencil eval design/PKN_Healing_App_Design.fig --stdin -w < design/resize-viewport.js
```

Constraint metadata saja tidak cukup: `resize()` pada proxy tidak otomatis menerapkannya. Helper menghitung ulang posisi/ukuran child dan chrome. Smoke H 412×915 yang diamati parent menghasilkan dock y=751/tinggi164, CTA lebar364, navigasi lebar412. Ini bukti satu skenario helper, bukan klaim responsif otomatis untuk semua ukuran.

## Token, tema dan tipografi

Koleksi native `PKN` memiliki **14 color variables** dengan mode Light/Dark: Background, Surface, TextPrimary, TextSecondary, Border, Primary, PrimarySoft, OnPrimary, Pillar1–6. Binding dan mode disimpan pada scene; browser membaca token, Flutter menerima keluaran generator `color_palette.dart` dan `pkn_tokens.dart`. `AppTheme.light`/`dark` mengonsumsi token tema. `--check` membandingkan keluaran tanpa menulisnya.

Sumber tipografi aktual adalah root `pknTypography`: Inter Display26/36, Heading18/27, Subhead15/23, Body13/20, Caption12/18; Amiri Arabic28/48 (ukuran/tinggi baris). Ini menggantikan skala lama Plus Jakarta Sans/Poppins dan body16/14 sebagai kontrak sinkronisasi, bukan bukti setiap teks utilitas memakai satu role secara mutlak. D2 dan Dk2 memuat **penggalan QS Ali Imran 3:159**, bersumber dari [Quran.com Indonesia](https://quran.com/id/keluarga-imran/159), dengan atribusi, Amiri, dan alignment kanan. Metadata arah RTL native tidak sama dengan bukti implementasi RTL Flutter seluruh aplikasi.

## Virtual Fitrah

Generator `generate-virtual-fitrah.js` mendefinisikan **51 layar mobile + 4 companion** pada halaman `Virtual Fitrah • Mobile`, `Virtual Fitrah • Companion`, dan `Virtual Fitrah • Components`. Companion: `GF_HOME_Dark`, `GF_AVATAR_Dark`, `GF_MAP_Web` (1440×1050), `GF_MAP_Tablet` (1024×1050). Mobile tidak diklaim memiliki padanan Dark lengkap.

Companion final memiliki key unik `GF_HOME_Dark`, `GF_AVATAR_Dark`, `GF_MAP_Web`, `GF_MAP_Tablet`. Seluruh166 frame utama/game memiliki screenKey unik; gunakan lookup setelah reopen untuk node ID terkini.

| Kelompok | Key layar |
|---|---|
| Ledger dan panen | GF_LEDGER, GF_HARVEST, GF_HARVEST_DONE |
| Tujuh venue | GF_HOME, GF_SCHOOL, GF_MOSQUE, GF_GARDEN, GF_MARKET, GF_DORM, GF_NEIGHBOUR |
| Panel aktivitas | GF_SCHOOL_ACT, GF_MOSQUE_ACT, GF_GARDEN_ACT, GF_MARKET_ACT, GF_DORM_ACT, GF_NEIGHBOUR_ACT |
| Avatar dan perkembangan | GF_MAP, GF_AVATAR, GF_CARE, GF_ADAB, GF_AGES, GF_PRIVACY, GF_TB40 |
| Ritme dan jembatan nyata | GF_RHYTHM, GF_AFK, GF_BRIDGE, GF_CHECKIN, GF_CHECKIN_DONE, GF_BREAK |
| Skenario | GF_SCENARIOS, GF_Q1–GF_Q5; setiap pertanyaan memiliki feedback _A, _B, _C terpisah |
| Roadmap | GF_ROADMAP |

Tujuh venue memakai geometri isometrik native editable yang berbeda; rumah memuat ruang keluarga, dua ruang tidur, dan musholla. Ini desain scene, bukan engine permainan produksi. Konsep mencakup ledger adab tanpa peringkat, perawatan avatar, usia/fase, privasi dan persetujuan anak, panen, ritme ibadah, AFK aman, jembatan aktivitas nyata, check-in sukarela, skenario dan jeda lembut 10–15 menit. Jam salat ilustratif; pilihan TB40 bukan inventori resmi 40 butir. Interaksi browser adalah simulasi lokal tanpa backend, AI hidup, ekonomi nyata atau validasi psikometrik; bookmark, pilihan dan tulisan hanya bertahan selama halaman terbuka.

Browser game merender scene SVG inline tujuh venue dan hotspot peta, feedback A/B/C, serta dock Rumah/Peta/Kabar/Jeda. Simulator avatar fiktif dan check-in opsional hanya menyimpan state sesi. Peta browser adalah companion responsif; bukan seluruh frame companion native diekspor menjadi runtime, bukan AI atau mesin AFK hidup.

Prototype final memuat **104 layar kanonis /12 flow** (enam utama +enam game), bukan166 varian viewport native. Parent membuka tujuh venue dengan header berbeda, semua15 pilihan skenario A/B/C menuju feedback berjudul berbeda, alur ledger/panen/selesai, bridge/check-in berisi tulisan/selesai dan jeda/AFK/ledger. Input love20 pada simulator avatar memberi respons “Tawarkan pendampingan hangat; tidak ada hukuman.” Pemeriksaan visual terbatas peta Web native dan peta browser melihat tujuh label tanpa clipping/overlap utama; bukan audit semua layar.

## Bukti dan batas

- Parent mengamati propagasi master CTA dan resize helper sebagaimana angka di atas; pemeriksaan `sync-tokens --check` lulus. Analisis Flutter terbatas `prototype/v0/lib/app/theme` tidak menemukan issue, dan smoke runtime sementara mengamati light/dark/Arabic. Itu bukan pengujian seluruh Flutter atau implementasi game.
- Smoke variable mode native H mengembalikan Background Light #F8FAFC lalu Dark #121417 melalui `graph.resolveColorVariableForNode`; token check setelah reopen tetap lulus. Berkas gabungan memiliki tujuh halaman, bukan empat halaman audit lama.
- Audio, unduhan, background playback, penyimpanan, laporan dan asesmen produksi tidak diimplementasikan oleh desain. Browser mensimulasikan state; tidak mengirim data ke server.
- Pertanyaan TB40, nama 19 butir rubrik dan 8 standar audit ilustratif, bukan instrumen resmi. L3 berupa daftar standar/prioritas, bukan radar audit tervalidasi. B6 radar ilustratif tidak boleh diberi skor pribadi.
- Tidak ada klaim bebas collision pada semua layar, WCAG100%, AA/AAA menyeluruh, TalkBack/VoiceOver lulus, atau persentase kesiapan handoff. Target utama ≥48 adalah pilihan desain; aksesibilitas memerlukan audit surface, semua pasangan warna, keyboard, pembaca layar dan text scaling.
- Konten syar'i di luar penggalan ayat yang diatribusikan tetap membutuhkan review sumber/ahli. Ringkasan pedagogis bukan kutipan ayat/hadis dan aplikasi bukan pengganti layanan klinis.

## Referensi Desain Modern

- **[Oiloil UI](https://ui.oiloil.org/en/):** Rujukan desain antarmuka minimalis, elegan, dan menenangkan jiwa (*calm technology / low visual noise*) untuk feed artikel edukasi dan formulir diagnostik.
- **[21st.dev](https://21st.dev/):** Pustaka inspirasi komponen rekayasa desain (*design engineering*) dengan animasi mikro taktil, cocok untuk modul swipe deck, learning tooltip, dan widget HUD parameter fitrah.

