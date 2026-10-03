# PKN — Desain Journey Native

## Analisis sumber dan keputusan

Sumber utama: seluruh 505 baris `docs/USER_JOURNEYS.md`, dibandingkan dengan `DESIGN_SYSTEM.md` dan tree desain lama. Matriks sumber berisi **16 persona dalam 5 ranah**. Lima layar awal diperbarui; layar tugas dan state ditambahkan sebagai frame, teks, bentuk, dan komponen native, bukan screenshot.

Alur bersama: **O1 ranah → O2 peran/fase kondisional → O3 bottleneck/waktu → O4 keluaran personal → H**. Fase ditampilkan untuk keluarga/guru/pelajar, tidak diwajibkan pada pengelola atau peneliti. O4 memperlihatkan contoh profil Ayah; pilihan semua persona dan rekomendasi pilarnya tersedia pada O2 dan MAP. Profil dapat diubah, bukan label permanen.

Lead ringkas didahulukan. Krisis adalah fitur bantuan, bukan pilar. Deck tepat **5 langkah**: fenomena, prinsip/dalil, kuis respons, ucapan praktis, doa/refleksi. Dkf adalah feedback pada langkah 3, bukan langkah 6. Primer pemula memiliki 5 hari, tidak dikunci streak. Bookmark, jurnal, audio luring, penyimpanan sukses/gagal, dan konten luring memiliki state tersendiri.

Konflik sumber diselesaikan mengikuti journey dan permintaan pengguna: donut adab 100% dihapus walaupun dokumen sistem lama menyebutnya. Tidak ada skor total adab, leaderboard, atau streak shaming. Rubrik: BT Belum Tampak, MT Mulai Tampak, BK Berkembang, MM Membudaya. Token pilar mengikuti DESIGN_SYSTEM: P1 Mulai #6366F1; P2 Fase #0EA5E9; P3 Bakat #8B5CF6; P4 Keluarga #F43F5E; P5 Lembaga & Guru #10B981; P6 Dalil #D4AF37.

## Cakupan persona

Semua jalur dimulai dengan onboarding bersama. Identifier berikut adalah prefix nama frame native. Rentang berarti seluruh layar pada rentang, bukan satu layar ringkasan.

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

## Halaman dan manifest ekspor

| Halaman | ID |
|---|---|
| Design System & Tokens | `0:3` (canvas `0:4`) |
| Layar Aplikasi PKN — lima layar awal diperbarui | `0:107` |
| Parcours • 16 Persona / 5 Ranah | `0:233` |
| Komponen & Peta Journey | `0:1611` |

| Prefix | Frame ID tersimpan | Layar/state | Page ID |
|---|---|---|---|
| O1 | `0:108` | Amanah Anda hari ini | `0:107` |
| H | `0:133` | Ruang tarbiyah Anda | `0:107` |
| Dk3 | `0:158` | Pilih respons | `0:107` |
| R5 | `0:179` | Laporan pertumbuhan adab | `0:107` |
| A1 | `0:204` | Audio untuk menemani malam | `0:107` |
| O2 | `0:234` | Peran dan fase fokus | `0:233` |
| O3 | `0:259` | Apa yang paling mendesak? | `0:233` |
| O4 | `0:284` | Arah yang sesuai amanah | `0:233` |
| F | `0:303` | Mode Eksekutif • 3 menit | `0:233` |
| K | `0:325` | Tenang dulu, Bunda | `0:233` |
| N | `0:347` | Peta 4 fase tarbiyah | `0:233` |
| N2 | `0:372` | Primer orang tua • 5 hari | `0:233` |
| T1 | `0:397` | Cerita & sentra bermain | `0:233` |
| T2 | `0:422` | Tertib shalat bersama | `0:233` |
| T3 | `0:447` | Mediasi dengan menjaga martabat | `0:233` |
| T3b | `0:469` | Thaharah • ruang privat | `0:233` |
| T4 | `0:491` | Mentoring pemuda | `0:233` |
| T4b | `0:513` | Menjaga iffah bersama | `0:233` |
| T5 | `0:535` | Pendampingan jiwa dewasa | `0:233` |
| R1 | `0:557` | Fast-Tap • observasi adab | `0:233` |
| R2 | `0:651` | Fast-Tap • observasi adab | `0:233` |
| R3 | `0:745` | Fast-Tap • observasi adab | `0:233` |
| R4 | `0:815` | Bukti kecil yang bermakna | `0:233` |
| L1 | `0:841` | Filter program Maqashid | `0:233` |
| L1b | `0:867` | Keputusan program tahunan | `0:233` |
| L2 | `0:889` | Kurikulum adab non-formal | `0:233` |
| L2b | `0:911` | Komitmen rumah & lembaga | `0:233` |
| L2c | `0:941` | Portofolio naratif santri | `0:233` |
| L3 | `0:963` | Audit 8 standar PKN | `0:233` |
| L3b | `0:997` | Prioritas transformasi | `0:233` |
| D1 | `0:1019` | Silabus kajian tematik | `0:233` |
| D2 | `0:1041` | Penelusuran sumber | `0:233` |
| D3 | `0:1063` | Syarah & registry status | `0:233` |
| B1 | `0:1085` | Eksplorasi TB40 | `0:233` |
| B2 | `0:1121` | Eksplorasi TB40 | `0:233` |
| B3 | `0:1157` | Eksplorasi TB40 | `0:233` |
| B4 | `0:1193` | Eksplorasi TB40 | `0:233` |
| B5 | `0:1229` | Eksplorasi TB40 | `0:233` |
| B6 | `0:1265` | Empat ruang kontribusi | `0:233` |
| B7 | `0:1299` | Rencana kontribusi kecil | `0:233` |
| Dk1 | `0:1329` | Fenomena nyata | `0:233` |
| Dk2 | `0:1350` | Prinsip & dalil | `0:233` |
| Dk4 | `0:1371` | Kalimat yang dapat dicoba | `0:233` |
| Dk5 | `0:1392` | Doa & refleksi | `0:233` |
| Dkf | `0:1413` | Umpan balik respons | `0:233` |
| A2 | `0:1432` | Unduh & dengar luring | `0:233` |
| A3 | `0:1461` | Audio tetap menemani | `0:233` |
| J | `0:1490` | Jurnal syukur malam | `0:233` |
| S0 | `0:1516` | Bookmark masih kosong | `0:233` |
| S1 | `0:1532` | Panduan tersimpan | `0:233` |
| E1 | `0:1554` | Tersimpan untuk dilanjutkan | `0:233` |
| E2 | `0:1573` | Belum berhasil menyimpan | `0:233` |
| E3 | `0:1592` | Anda sedang luring | `0:233` |
| MAP | `0:1627` | 16 persona • linked screen IDs | `0:1611` |

Master komponen: tombol `0:1612`, lead `0:1615`, rubrik `0:1618`, mini-player `0:1621`, navigasi `0:1624`. Komposisi layar memakai helper layout yang sama; bukan instance terikat ke master. Layar panjang adalah kanvas konten scroll, bukan klaim viewport produksi.

## Membuka, regenerasi, ekspor

`design/PKN_Healing_App_Design.fig` ditulis oleh OpenPencil v0.15.1 melalui API createFrame/createText/createComponent. Tidak ada perubahan cloud Figma atau URL kolaborasi. Kompatibilitas import Figma cloud belum diuji.

`design/generate-journeys.js` adalah generator reproducible, bukan kode Flutter. Jalankan dari root:

```bash
openpencil info design/PKN_Healing_App_Design.fig
openpencil eval design/PKN_Healing_App_Design.fig --stdin -w < design/generate-journeys.js
openpencil eval design/PKN_Healing_App_Design.fig -c 'return figma.root.children.map(p=>({id:p.id,name:p.name,frames:p.children.map(n=>({id:n.id,name:n.name}))}));' --json
openpencil export design/PKN_Healing_App_Design.fig --node 0:325 -f png -o design/previews/journey_K_crisis.png --font-policy warn
openpencil export design/PKN_Healing_App_Design.fig --node 0:557 -f png -o design/previews/journey_R1_rubric.png --font-policy warn
openpencil export design/PKN_Healing_App_Design.fig --node 0:1265 -f png -o design/previews/journey_B6_clusters.png --font-policy warn
openpencil export design/PKN_Healing_App_Design.fig --node 0:1627 -f png -o design/previews/journey_MAP.png --font-policy warn
```

OpenPencil renumber node ID ketika serialisasi; **manifest menggunakan ID hasil reopen, bukan ID sementara hasil generator**. Setelah regenerasi, baca ulang tree dan sesuaikan manifest/ekspor. Prefix layar tetap stabil. Pratinjau lama bernama screen_01 sampai screen_05 adalah artefak historis sampai diekspor ulang; tidak menjadi bukti desain terbaru.

Smoke ekspor setelah perbaikan koordinat: journey_K_crisis.png (75,1 KB), journey_R1_rubric.png (66,6 KB), journey_B6_clusters.png (68,8 KB), journey_MAP.png (161,4 KB). Pemeriksaan visual K menunjukkan empat kartu, tombol simpan, dan navigasi; R1 menunjukkan tujuh baris rubrik dan seluruh tombol tanpa clipping. Penyebab ekspor blank sebelumnya: appendChild mempertahankan posisi global. Generator sekarang melakukan append terlebih dahulu lalu menetapkan koordinat lokal. Semua layar, komponen, dan MAP diregenerasi dengan urutan benar.

Verifikasi akhir: seluruh **53 layar dan satu peta journey** berhasil diekspor ke `design/previews/journey_<prefix>.png` sesuai manifest. Pemeriksaan visual sampel K, R1, B6, dan L1 menunjukkan konten terbaca, tombol terlihat, dan tidak ada overlap utama. B6 memuat empat kartu kluster; bukan radar hasil asesmen karena instrumen dan scoring resmi belum tersedia. Ekspor berhasil bukan bukti import Figma cloud atau audit aksesibilitas menyeluruh.

## Batas yang jujur

- Prototype klik native tidak tersedia pada proxy Plugin API yang diperiksa (tidak ada reactions/setReactions). MAP dan nama action menyediakan target identifier editable; pluginData navigationTarget/nextScreen bukan interaksi berjalan.
- Tidak ada audio aktual, unduhan, background playback, penyimpanan, asesmen, pembuatan laporan atau generator outline berjalan. Ini state desain dan keluaran contoh, bukan implementasi aplikasi.
- Tidak ada matan Arab/derajat hadis rekaan. D1–D3 memperlihatkan kebutuhan metadata sumber, syarah dan registry dengan status belum diverifikasi. Konten pedagogis, doa dengan kata sendiri, pertanyaan TB40, nama 19 butir rubrik, dan nama 8 standar audit **ilustratif**, bukan klaim instrumen/dalil resmi. Sumber turats, takhrij ahli, instrumen TB40 dan rubric/audit otoritatif belum tersedia dalam sumber yang diperiksa.
- Font native Inter mengikuti dokumen lama; tipografi Arab final/RTL belum diuji karena tidak memasukkan kutipan yang belum bersumber. WCAG/TalkBack/VoiceOver tidak dinyatakan lulus; desain menyediakan target utama ≥48 dan teks kontras gelap, tetapi perlu audit actual surface.
- Tidak mengubah Flutter. Tidak menjalankan build, lint, test permanen, atau formatter.
