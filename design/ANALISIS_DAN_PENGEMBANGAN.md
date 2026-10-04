# Laporan Analisis dan Pengembangan Desain PKN

**Berkas:** [PKN_Healing_App_Design.fig](PKN_Healing_App_Design.fig)  
**Referensi:** [README](README.md), [DESIGN_SYSTEM](../DESIGN_SYSTEM.md), [USER_JOURNEYS](../docs/USER_JOURNEYS.md)  
**Pembaruan:** 4 Oktober 2026  
**Status:** Implementasi desain native dan simulasi browser; bukti terbatas pada inspeksi/smoke yang disebutkan, bukan audit aksesibilitas atau kesiapan produksi menyeluruh.

## 1. Ringkasan Implementasi

- **Persona:** 16 persona tetap dipetakan melalui key layar stabil; matriks lengkap di README. Pemetaan bukan validasi usability terhadap pengguna nyata.
- **Layar utama:** 53 key × Light/Dark, empat varian tablet L1/R1 dan H_Android, total **111 viewport**. MAP terpisah. Mobile dasar 390×844, Android 412×915, tablet 768×1024; klaim grid seragam 428×1040 sudah tidak berlaku.
- **Komponen utama:** Tiga master header, docked CTA dan navigasi empat tab; **333 instance** pada viewport utama. Propagasi menggunakan `figma.graph.syncInstances`, bukan perubahan otomatis yang sudah dibuktikan pada setiap editor.
- **Tema:** 14 color variables native pada koleksi `PKN`, mode Light/Dark dan binding scene; sumber tema dapat diekspor ke Dart.
- **Tipografi:** Metadata root `pknTypography` menetapkan Inter Display26/36, Heading18/27, Subhead15/23, Body13/20, Caption12/18 serta Amiri Arabic28/48. Skala lama Plus Jakarta Sans/Poppins bukan sumber sinkronisasi aktual.
- **Dalil:** D2/Dk2 menggunakan penggalan QS Ali Imran 3:159 dengan atribusi [Quran.com Indonesia](https://quran.com/id/keluarga-imran/159). Tidak ada klaim seluruh registry turats/takhrij telah diverifikasi.
- **Prototype:** Enam start aplikasi utama tersedia pada browser; native reactions/flow starting points tidak writable melalui API yang diperiksa. Klik dan state browser bukan backend atau implementasi Flutter lengkap.

## 2. Koreksi atas Audit Lama

| Klaim sebelumnya | Status yang dapat dipertanggungjawabkan |
|---|---|
| Semua layar hanya Dark | Utama memiliki padanan Light/Dark; Virtual Fitrah tidak memiliki padanan Dark lengkap. |
| Semua layar grid 428×1040 dan navigasi y992 | Viewport ukuran perangkat dengan konten terpisah dan dock; resize proxy harus dihitung eksplisit. |
| Komponen detached tanpa instance | Header/CTA/navigasi utama kini instance; propagasi radius diuji dengan syncInstances. |
| Font hanya Inter, Arab belum tersedia | Amiri dimuat, penggalan ayat diatribusikan; RTL seluruh aplikasi belum diaudit. |
| Tidak ada prototype berjalan | Browser prototype berjalan terpisah; native reactions tetap tidak tersedia. |
| Radar audit delapan standar | L3 berupa daftar standar/prioritas ilustratif; bukan radar audit tervalidasi. |
| Radar TB40 sebagai hasil | B6 radar ilustratif empat kluster, tanpa skor pribadi atau scoring resmi. |
| WCAG AA/AAA dan 100% target sentuh | Target utama ≥48 adalah keputusan desain; bukan audit semua kontrol, pasangan warna, keyboard atau pembaca layar. |
| Nol collision, semua layout 100% terselesaikan | Smoke sampel terbatas; tidak ada bukti bebas overlap/clipping seluruh layar, ukuran dan text scaling. |
| Kesiapan handoff 90% | Tidak ada persentase kesiapan yang tervalidasi. Desain editable, prototype dan token membantu handoff; fungsi produksi tetap terpisah. |

Jumlah node/halaman/ID dari audit lama tidak dipertahankan sebagai metrik terkini. Generator dan serialisasi mengubah tree; gunakan `screenKey` serta manifest terbaru, bukan ID lama dalam tabel dokumentasi.

## 3. Persona dan Isi Pedagogis

Onboarding bersama O1–O4/H mempertahankan peran/fase kondisional. Ranah keluarga memakai F/K/N/N2, guru T1–T5 serta R1–R5, lembaga L1–L3b, kajian/peneliti D1–D3, santri B1–B7 dan mandiri A1–A3/J. Deck tepat lima langkah Dk1–Dk5; Dkf feedback langkah ketiga. Utility S0/S1/E1–E3 menyediakan contoh bookmark/kosong/error/luring.

Rubrik BT Belum Tampak, MT Mulai Tampak, BK Berkembang, MM Membudaya memakai bukti naratif tanpa nilai total adab, donut persentase, ranking atau streak shaming. Pertanyaan TB40, nama 19 butir rubrik dan delapan standar audit masih ilustratif; pemetaan tidak mengesahkan instrumen, psikometri atau sumber syar'i. Konten sumber tambahan memerlukan review ahli sebelum dipakai produksi.

## 4. Virtual Fitrah

Generator `generate-virtual-fitrah.js` mendefinisikan **51 layar mobile + 4 companion** pada tiga halaman miliknya. Empat companion: GF_HOME_Dark, GF_AVATAR_Dark, GF_MAP_Web 1440×1050 dan GF_MAP_Tablet 1024×1050. Inventori lengkap key ada di README dan root `pknGameManifest` setelah generasi.

Kelompok layar:

1. **Ledger/panen:** GF_LEDGER, GF_HARVEST, GF_HARVEST_DONE.
2. **Tujuh venue:** rumah, sekolah, masjid, kebun, pasar, asrama, tetangga; key GF_HOME/GF_SCHOOL/GF_MOSQUE/GF_GARDEN/GF_MARKET/GF_DORM/GF_NEIGHBOUR.
3. **Panel aktivitas:** enam venue di luar rumah memiliki `_ACT`; rumah menampilkan ruang keluarga, dua ruang tidur dan musholla.
4. **Avatar/perkembangan:** GF_MAP, GF_AVATAR, GF_CARE, GF_ADAB, GF_AGES, GF_PRIVACY, GF_TB40.
5. **Ritme/jembatan nyata:** GF_RHYTHM, GF_AFK, GF_BRIDGE, GF_CHECKIN, GF_CHECKIN_DONE, GF_BREAK.
6. **Lima skenario:** GF_SCENARIOS, GF_Q1–GF_Q5, masing-masing tiga feedback _A/_B/_C.
7. **Roadmap:** GF_ROADMAP menghubungkan konsep dan batas implementasi.

Scene venue adalah geometri isometrik native editable, bukan screenshot dan bukan engine game hidup. GDD diterjemahkan menjadi layar adab, perawatan, usia, privasi/persetujuan anak, ritme ibadah, AFK aman tanpa penalti, check-in sukarela, panen dan jeda lembut 10–15 menit. Waktu salat ilustratif; TB40 bukan inventori resmi 40 butir. Interaksi browser adalah simulasi lokal: tidak ada backend, AI hidup, ekonomi nyata, pengawasan anak, layanan notifikasi/jadwal salat aktual atau diagnosis. Tidak ada klaim konsep simulasi sudah menjadi fitur Flutter produksi.

## 5. Pipeline dan Identitas Stabil

Commands lengkap dan contoh resize ada di README:

```bash
openpencil eval design/PKN_Healing_App_Design.fig --stdin -w < design/generate-journeys.js
openpencil eval design/PKN_Healing_App_Design.fig --stdin -w < design/generate-virtual-fitrah.js
node design/generate-prototype.mjs
node design/sync-tokens.mjs
node design/sync-tokens.mjs --check
openpencil eval design/PKN_Healing_App_Design.fig --stdin < design/resize-viewport.js
```

Root `pknPrototype`/`pknGamePrototype` menyimpan specs dan flow browser. `pknGameManifest` menyimpan inventori game; generator utama hanya mengembalikan manifest saat dijalankan. Lookup `screenKey` dari berkas yang baru dibuka adalah kontrak identitas ekspor utama, bukan root manifest yang tidak tersimpan. Node ID companion dapat dibedakan dengan nama/page. Jangan menyalin ID lama sebagai kontrak. Browser dapat disajikan dari `design/prototype.html` melalui server statis lokal.

Helper resize mengaplikasikan constraint child dan normalisasi chrome secara eksplisit. `resize()` atau metadata STRETCH/MAX saja pada proxy tidak otomatis membuktikan resize responsif. Konten native dipotong viewport; scroll native belum berjalan, sedangkan browser menyediakan scroll nyata. Import Figma cloud, native prototype cloud dan kolaborasi cloud belum diuji.

## 6. Bukti Teramati dan Batas Verifikasi

Parent melaporkan bukti fase utama berikut:

- `graph.updateNode` dan `graph.syncInstances` mengubah radius CTA menjadi22 pada 111 CTA utama; override instance dapat mempertahankan nilai lain.
- Helper H 412×915 menghasilkan dock y751/tinggi164, CTA lebar364 dan navigasi lebar412.
- `node design/sync-tokens.mjs --check` lulus.
- Native mode smoke pada H: `graph.resolveColorVariableForNode` mengembalikan Background Light #F8FAFC, kemudian #121417 setelah variableModes diubah ke Dark; check token setelah reopen tetap lulus.
- Berkas gabungan memiliki tujuh halaman (empat utama +tiga game), **166 frame dengan screenKey unik** (111 utama +55 game); seluruh166 PNG terbaru diekspor ulang. Companion memiliki empat key unik. Ini verifikasi inventory/ekspor, bukan audit visual setiap layar.
- `flutter analyze lib/app/theme` tanpa issue; smoke runtime sementara light/dark/Arabic lulus lalu dibuang. Cakupannya tema, bukan seluruh aplikasi.
- Browser final memuat **104 layar kanonis dan12 flow** (enam utama +enam Virtual Fitrah), bukan166 viewport tema/companion native.
- Parent membuka tujuh tombol Buka venue pada peta; masing-masing menghasilkan header berbeda. Semua15 pilihan A/B/C pada GF_Q1–GF_Q5 mencapai feedback _A/_B/_C dengan judul berbeda.
- Parent menempuh ledger → panen → selesai, bridge → check-in dengan input textarea → selesai, serta jeda → AFK → ledger.
- Simulator avatar dengan input love20 menampilkan “Tawarkan pendampingan hangat; tidak ada hukuman.” Ini respons simulasi fiktif, bukan pengukuran anak.
- Pemeriksaan visual peta Web native melihat semua tujuh label tanpa clipping; peta browser terlihat tanpa overlap utama pada surface yang diperiksa. Tidak digeneralisasi ke semua layar/ukuran.

Bukti tersebut tidak digeneralisasi menjadi WCAG100%, bebas collision seluruh desain, semua ukuran responsif, semua fungsi game produksi selesai atau audit klinis/syar'i. Dokumen ini tidak menjalankan tests/build/lint; verifikasi proyek dimiliki parent. Bukti browser di atas berasal dari interaksi surface aktual parent, bukan hanya inspeksi source atau ekspor berhasil.

## 7. Prioritas Lanjutan Berdasarkan Batas Nyata

- **Konten/keamanan:** review ahli atas dalil, rubrik, standar audit dan instrumen TB40 sebelum rilis; pisahkan contoh dari sumber resmi.
- **Aksesibilitas:** audit actual surface Light/Dark, text scaling, focus/keyboard, TalkBack/VoiceOver, bahasa/RTL dan seluruh target sentuh. Kontras token tunggal tidak cukup.
- **Usability:** uji pengguna pada enam persona-flow dan alur game dengan persetujuan, privasi serta pemisahan dunia simulasi/aksi nyata.
- **Produksi:** implementasikan persistence, audio/unduhan/latar belakang, laporan dan game runtime hanya dengan kontrak produk yang disepakati. State contoh tidak dianggap layanan berjalan.
- **Interop:** uji import Figma cloud dan perilaku komponen/variables/constraints di editor target sebelum menjanjikan handoff interaktif native.

Prioritas ini adalah batas yang belum terbukti, bukan tambahan scope yang diklaim sudah selesai.
