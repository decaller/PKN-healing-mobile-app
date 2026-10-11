---
name: contextual-anti-slop-redesign
description: Gunakan saat mengubah desain UI yang sudah ada, mengaudit tampilan generik atau terasa buatan AI, memoles aplikasi mobile/web, atau menyusun redesign yang harus menjaga identitas, aksesibilitas, dan fungsi produk.
---
# Skill Desain Terpadu: Contextual Anti-Slop Redesign
## Tujuan dan cara pakai
Ubah UI yang sudah ada menjadi lebih jelas, khas, dan matang berdasarkan konteks produk. Anti-slop bukan menyembunyikan penggunaan AI: tujuannya menghilangkan keputusan generik, dekorasi tanpa fungsi, dan konten tidak kredibel.
Dokumen ini menyatukan prinsip beberapa skill, bukan menyalin seluruh isinya. Bisa digunakan sebagai panduan tunggal atau dilampirkan sebagai konteks untuk agen coding. Tidak memerlukan skill sumber untuk menjalankan workflow di bawah. Dokumen tidak otomatis terpasang sebagai skill pada suatu harness.
1. Lampirkan file ini atau minta agen membacanya.
2. Gunakan prompt siap pakai pada bagian akhir.
3. Jika target layar tidak disebutkan, audit dahulu dan usulkan target. Jangan diam-diam mengubah seluruh aplikasi.
4. Default: evolusi terarah, bukan penulisan ulang aplikasi atau pergantian brand.
## 1. Urutan keputusan
Jika prinsip bertentangan, gunakan urutan ini:
1. Keselamatan pengguna, kebenaran konten, aksesibilitas, dan fungsi yang harus dipertahankan.
2. Permintaan pengguna dan batasan scope.
3. Identitas brand, pola platform, dan design system proyek.
4. Kejelasan tugas, hierarki, dan konsistensi lintas layar.
5. Keunikan visual dan preferensi estetika.
Jangan menerapkan aturan landing page secara literal pada aplikasi mobile. Jangan mengganti font, warna ungu, ikon, kartu, atau grid hanya karena sering dipakai AI. Masalahnya adalah penggunaan otomatis tanpa alasan, bukan keberadaan elemen tersebut.
**Definisi selesai:** perubahan terlihat pada UI nyata, tugas utama tetap bekerja, state relevan tetap terbaca, dan hasil diverifikasi. Kompilasi saja tidak membuktikan kualitas desain.
## 2. Kumpulkan konteks sebelum memilih gaya
Baca instruksi repository, dokumen produk, design system, manifest dependency, router, theme/token, komponen bersama, sumber konten, dan kode layar target. Buka UI yang berjalan atau screenshot yang tersedia sebelum membuat klaim visual.
Catat ringkas:
| Konteks | Yang harus diketahui |
| --- | --- |
| Produk | Tujuan produk, tugas utama layar, hasil yang pengguna inginkan |
| Pengguna | Persona, bahasa, kondisi penggunaan, beban kognitif, kebutuhan aksesibilitas |
| Permukaan | Native mobile, web app, prototype, atau halaman brand/marketing |
| Scope | Layar/flow/file target, mode preserve atau overhaul, hal yang tidak boleh berubah |
| Brand | Logo, warna dengan perannya, font, ikon, aset, suara konten |
| Sistem | Stack, dependency, token, komponen bersama, platform adaptation |
| Perilaku | Navigasi, state, penyimpanan, form, analytics, integrasi, fitur simulasi |
| Bukti | Screenshot awal, masalah nyata, status yang belum diuji |
Pisahkan **fakta**, **asumsi**, dan **belum terverifikasi**. Jangan menyebut UI buruk hanya dari nama file. Jika data penting tersedia di repo, baca, jangan tanyakan ulang. Tanya hanya jika keputusan yang belum terjawab benar-benar mengubah arah atau berisiko merusak scope.
Nyatakan satu kalimat arah:
> Ini adalah [permukaan] untuk [pengguna dalam situasi konkret], dengan tugas utama [tugas], sehingga desain perlu [karakter dan hierarki], sambil mempertahankan [identitas dan kontrak].
## 3. Audit desain lama
Sebelum mengedit, buat daftar **Pertahankan / Perbaiki / Hapus** dengan alasan dan bukti.
- **Pertahankan:** identitas yang dikenali, alur yang bekerja, konten tepercaya, aksesibilitas yang sudah baik.
- **Perbaiki:** prioritas tindakan, keterbacaan, kontras, ritme spacing, konsistensi komponen, state yang tidak jelas.
- **Hapus:** dekorasi tanpa makna, CTA duplikat, pembungkus kartu berlebihan, label internal yang membingungkan pengguna.
Prioritaskan:
1. Risiko keselamatan, fungsi rusak, dan kontrol tidak dapat digunakan.
2. Tugas utama tidak terlihat atau hierarki membingungkan.
3. Teks, kontras, spacing, dan ketidakkonsistenan token.
4. Komponen generik yang tidak cocok dengan jenis informasi.
5. Detail khas dan motion yang memang membantu.
Jangan mengubah nama route, urutan flow, kontrak data, persistence key, event analytics, logo, atau copy legal/sensitif dalam pekerjaan visual tanpa permintaan yang sesuai.
## 4. Prinsip anti-slop
### Kekhasan datang dari produk
- Gunakan tugas, konten, dan aset nyata sebagai bahan desain, bukan template kategori seperti “wellness pasti beige” atau “teknologi pasti dark neon”.
- Pilih satu ciri khas yang relevan: susunan panduan singkat, treatment kutipan sumber, ritme ilustrasi, atau pola tindakan. Biarkan bagian lain tenang.
- Uji substitusi: jika nama dan logo diganti dan desain masih cocok untuk hampir semua produk, keputusan visual belum cukup kontekstual.
- Jangan mengganti klise pertama dengan klise kedua, misalnya dari gradient ungu menjadi serif-cream-editorial tanpa alasan.
- UI familiar tetap bernilai. Navigasi standar bukan slop; navigasi unik yang menyulitkan pengguna bukan kemajuan.
### Hindari sebagai default, bukan larangan brand
- Gradient ungu-biru, glow neon, gradient text, glassmorphism, atau grain di seluruh permukaan.
- Hero besar, angka statistik raksasa, tiga kartu identik, bento, dan carousel tanpa kebutuhan informasi.
- Semua informasi dibungkus kartu berlapis, semua aksi berbentuk pill, semua heading diberi eyebrow uppercase.
- Asimetri paksa, whitespace berlebihan, font display eksotis, atau tekstur yang menurunkan keterbacaan mobile.
- Ikon dekoratif di setiap baris, ornamen religius tanpa makna, animasi berulang, dan scroll hijacking.
- Copy seperti “seamless”, “next-gen”, “elevate”, atau “premium” tanpa menjelaskan tindakan/manfaat konkret.
Pertahankan pilihan tersebut jika memang bagian identitas atau membantu tugas. Jelaskan alasan penggunaannya. Warna status/error dan warna kategori semantik boleh berbeda dari aksen brand; jangan menghapus makna demi aturan satu warna.
### Kejujuran konten
Jangan mengarang testimoni, profil pengguna, persentase, hasil klinis, kutipan agama, aktivitas, atau bukti sosial agar tampilan terasa hidup. Gunakan data yang tersedia. Tandai data contoh dan fungsi simulasi secara jujur. Jangan mengganti placeholder dengan klaim palsu yang tampak nyata.
## 5. Sistem visual yang kohesif
### Tipografi
- Pertahankan font brand yang berfungsi; perbaiki ukuran, weight, line-height, dan wrapping sebelum mengganti keluarga font.
- Bedakan judul, isi, label, dan metadata melalui hierarki yang terbaca, bukan banyak keluarga font.
- Untuk mobile, gunakan ukuran berbasis sistem/platform dan dukung pembesaran teks. Jangan memaksa headline dua baris atau tombol satu baris dengan mengecilkan teks aksesibel.
- Cek teks panjang, bahasa Indonesia, angka, campuran Latin-Arab, RTL, dan font fallback. Jangan memotong informasi penting.
- Penggunaan serif, Inter, atau font lain harus mengikuti brand dan keterbacaan, bukan daftar font populer pengganti.
### Warna dan permukaan
- Gunakan token semantik: background, surface, text, muted text, primary, on-primary, border, focus, serta status.
- Pertahankan warna brand, rapikan peran dan kontrasnya. Jangan memilih light/dark karena kategori aplikasi saja.
- Warna kategori harus punya label; warna tidak boleh menjadi satu-satunya penanda.
- Tetapkan satu aturan radius, elevation, dan border berdasarkan peran komponen. Variasi terkontrol boleh, variasi acak tidak.
- Kartu hanya untuk kelompok informasi atau affordance yang membutuhkannya. Pilih list, divider, atau spacing jika lebih jelas.
### Layout
- Satu tindakan utama yang jelas pada tiap konteks; jangan menghilangkan aksi sekunder yang memang diperlukan.
- Letakkan informasi yang dapat langsung dipakai sebelum metadata dan penjelasan panjang.
- Gunakan grid/spacing proyek. Koreksi alignment optis tanpa menambah sistem spacing paralel.
- Jaga konsistensi pola berulang dalam UI produk. Tidak perlu membuat tiap layar berbeda agar terlihat kreatif.
- Hormati safe area, keyboard, system bar, bottom navigation, orientasi, dan layar besar.
### Motion dan state
- Motion menjelaskan feedback, perpindahan state, atau hubungan elemen. Jangan menambahkan motion hanya agar terasa “premium”.
- Hindari animasi yang memicu layout terus-menerus; gunakan primitive platform dan hormati reduced motion.
- Rancang state yang relevan: normal, pressed, selected, disabled, loading, empty, error, success, serta offline bila didukung.
- Jangan menciptakan state atau fitur baru di luar kontrak. Spinner atau skeleton dipilih berdasarkan durasi dan informasi, bukan larangan estetika mutlak.
- Jangan membuat konten utama menunggu animasi masuk untuk dapat dibaca.
## 6. Aksesibilitas dan kualitas mobile
- Target sentuh minimal 48×48 dp pada Android; perhatikan standar platform lain. Area sentuh boleh lebih besar dari glyph visual.
- Target kontras teks normal minimal 4.5:1; teks besar dan komponen nonteks relevan minimal 3:1 sesuai kriteria WCAG. Ukur, jangan menilai dari tampilan saja.
- Dukung pembesaran teks, pembacaan screen reader, urutan fokus, label kontrol, serta selected/disabled state yang semantik.
- Jangan menyembunyikan label penting di tooltip atau mengandalkan hover pada mobile.
- Jaga fokus terlihat pada web/keyboard. Gunakan semantik native; ARIA khusus web, bukan pengganti semantics Flutter.
- Untuk Flutter, gunakan theme dan widget bersama, semantics yang tepat, serta adaptasi Material/Cupertino yang sudah ada. Jangan memindahkan proyek ke Compose, React, atau Tailwind.
- Verifikasi reduced motion, light/dark yang didukung, teks panjang, dan campuran RTL. Pemeriksaan otomatis tidak membuktikan kepatuhan penuh.
## 7. Workflow implementasi dan bukti
1. **Baseline:** jalankan target yang benar, rekam screenshot dan tugas utama. Jika runtime tidak tersedia, sebutkan batasan dan gunakan bukti yang benar-benar ada.
2. **Audit:** tampilkan temuan terurut dan keputusan Pertahankan / Perbaiki / Hapus.
3. **Arah:** tetapkan hierarki, token, ciri khas, dan scope. Pilih evolusi konservatif jika brief tidak meminta overhaul.
4. **Implementasi:** gunakan stack, theme, komponen, dan aset yang sudah ada. Periksa dependency sebelum import; jangan menambah library untuk efek sederhana.
5. **Dampak bersama:** perubahan token/global component harus diperiksa pada semua pemakai yang terpengaruh. Update caller bila kontrak berubah dalam scope.
6. **Smoke visual:** buka hasil nyata, ambil screenshot pembanding, jalankan tugas utama, dan amati state. Native perlu emulator/device; web preview hanya membuktikan permukaan preview.
7. **Verifikasi teknis:** jalankan perintah relevan yang tersedia. Jika fungsi/kontrak berubah, verifikasi perilaku tersebut. Jangan mengklaim test/build lulus tanpa output.
8. **Serah terima:** laporkan perubahan, hal yang dipertahankan, bukti, dan batasan. Perbarui dokumentasi desain bila token/pola permanen berubah.
### Checklist penerimaan
- [ ] Scope dan platform target jelas; tidak mengubah aplikasi lain atau prototype lain diam-diam.
- [ ] Ada audit baseline berbasis bukti, bukan asumsi visual dari kode.
- [ ] Tugas utama lebih mudah ditemukan; fungsi lama dalam scope tetap bekerja.
- [ ] Brand tetap dikenali; ciri khas berasal dari konteks, bukan tren generik.
- [ ] Tidak ada data palsu, klaim sensitif baru, atau fitur simulasi yang disamarkan.
- [ ] Theme/token/komponen konsisten; status semantik tidak dihapus demi estetika.
- [ ] Touch target, kontras, teks besar, state, dan semantics diperiksa pada permukaan terkait.
- [ ] Screenshot dan smoke alur dicatat; hasil teknis hanya dilaporkan bila dijalankan.
- [ ] Tidak ada scaffold, dead control, dependency tidak terpakai, atau placeholder yang menyamar sebagai implementasi.
## 8. Konteks proyek PKN
Ringkasan repository saat dokumen disusun; baca ulang sumber sebelum implementasi karena struktur dan konten dapat berubah.
| Area | Konteks dan sumber |
| --- | --- |
| Tujuan | PKN, Pendidikan Karakter Nabawiyah & Tazkiyatun Nafs; dukungan edukatif/praktis dan microlearning. Persona mencakup orang tua/caregiver, pendidik, pelajar, serta pembelajar dewasa. Sumber: `README.md`. |
| Prinsip | Tenang, tepercaya, rendah kebisingan, tidak menghakimi; tanpa streak shaming atau leaderboard komparatif. Pilih persona dan tugas layar, jangan menyamaratakan semua pengguna. |
| Codebase | `prototype/v0/` adalah codebase native Android/iOS kanonikal menurut README root; `prototype/v1/` adalah Flutter Web/device-preview prototype. Jangan menganggap keduanya satu target. |
| Stack v1 | Dart/Flutter, Riverpod, GoRouter, SharedPreferences, Material 3 dan adaptasi Cupertino. Periksa `prototype/v1/pubspec.yaml`. |
| Sumber desain | `DESIGN_SYSTEM.md`, `design/README.md`, `design/DESIGN_CRITIQUE.md`; implementasi theme: `prototype/v1/lib/app/theme/app_theme.dart`; primitive: `prototype/v1/lib/core/widgets/`. |
| Identitas | Emerald/teal primary, aksen Nabawi gold, enam warna pilar MOC; Inter Latin dan Amiri Arab; light/dark, spacing 4/8 dp. Jangan menggantinya secara otomatis demi anti-slop. |
| Layar v1 | Onboarding JTBD dan insight, feed, daftar modul, lesson player, profil. Router: `prototype/v1/lib/app/router/app_router.dart`. |
| Konten | Utamakan panduan situasional singkat, lalu penjelasan dan sumber. Rubrik adab BT/MT/BK/MM tidak boleh berubah menjadi ranking atau penilaian menghakimi anak. |
| Batas sensitif | Baca `COMPLIANCE_AND_ARCHITECTURE.md`. Jangan mengarang dalil, mengubah safeguarding/legal copy diam-diam, atau membuat klaim klinis. Mismatch panduan krisis dalam critique perlu dilaporkan, bukan diselesaikan sepihak lewat redesign. |
| Simulasi | `prototype/v1/README.md` menjelaskan audio dan sharing yang masih simulasi. Pertahankan disclosure. Preview bukan bukti fungsi production. |
| Aset | Periksa aset sumber di `prototype/v1/assets/`. UI kit umum dalam repo bukan otomatis aset brand PKN atau aset berlisensi untuk penggunaan ini. |
**Arah yang layak diuji, bukan hasil audit visual:** guidance-first, tindakan singkat yang dapat langsung dipakai, sumber agama terbaca, metadata tidak mendominasi, dan pola list/kartu yang sesuai informasi. Tidak perlu menambahkan ornamen Arab, grafik emosi, chat, atau latihan napas jika fitur tersebut tidak ada pada target.
**Belum terverifikasi dalam pembuatan dokumen ini:** tampilan runtime saat ini, aksesibilitas nyata, aset yang disetujui per layar, dan target redesign pilihan pengguna. Tidak ada UI aplikasi yang diubah.
## 9. Prompt siap pakai: redesign PKN yang sudah ada
Salin prompt berikut ke agen coding bersama file ini. Target default adalah preview v1 agar tidak mencampur implementasi native kanonikal; ganti target secara eksplisit jika yang dimaksud v0.
```text
Baca DESIGN_SKILLS_ANTI_SLOP.md dan instruksi repository sebelum bekerja.
Tugas:
Redesign UI PKN yang sudah ada agar lebih khas, tenang, mudah dibaca, dan tidak
terasa sebagai template AI. Kerjakan evolusi desain dalam stack saat ini,
bukan rewrite aplikasi, penambahan fitur, atau penggantian brand.
Target:
prototype/v1/ sebagai Flutter Web/device-preview prototype.
Mulai dengan audit Beranda/feed dan komponen bersama yang dipakainya.
Jangan mengubah prototype/v0/, flow lain, atau seluruh tema tanpa menilai
pemakai yang terdampak. Jika konteks permintaan menyebut layar lain,
gunakan layar itu dan nyatakan scope sebelum edit.
Konteks:
PKN mendukung pembelajaran karakter/adab dan pendampingan praktis.
Fokus desain pada pengguna yang membutuhkan panduan situasional singkat
saat beban kognitif tinggi; jangan anggap semua persona memiliki tugas sama.
Utamakan tindakan yang bisa langsung dipakai, baru penjelasan dan sumber.
Nada konten tidak menghakimi, tidak menimbulkan rasa bersalah, dan tidak
memakai leaderboard atau streak shaming.
Sumber yang perlu dibaca:
README.md, DESIGN_SYSTEM.md, design/README.md,
design/DESIGN_CRITIQUE.md, COMPLIANCE_AND_ARCHITECTURE.md,
prototype/v1/README.md, prototype/v1/pubspec.yaml,
router, theme, primitive bersama, serta kode layar target yang sebenarnya.
Pertahankan:
Brand emerald/teal dan Nabawi gold; warna kategori semantik;
Inter Latin dan Amiri/RTL untuk Arab; konten dan kutipan yang tersedia;
routes, state Riverpod, persistence, pencarian, filter, bookmark,
navigasi adaptif Material/Cupertino, dan pilihan tema yang didukung.
Jangan mengubah copy legal, safeguarding, dalil, atau kontrak fungsi
atas nama perbaikan visual. Laporkan mismatch konten sensitif.
Audio/sharing yang simulasi harus tetap dijelaskan sebagai simulasi.
Anti-slop:
Jangan menambahkan gradient/glow, glass card, bento, angka statistik,
ornamen religius, foto generik, ikon di setiap baris, atau animasi berulang
hanya agar tampak premium. Jangan menghapus kartu, font, atau warna brand
hanya karena dianggap sering dipakai AI. Pilih struktur berdasarkan tugas.
Gunakan satu ciri khas yang relevan; bagian lain tenang dan konsisten.
Tidak boleh ada testimoni, hasil klinis, kutipan, atau fitur palsu.
Proses:
1. Jalankan preview yang benar dan dokumentasikan baseline nyata.
2. Bedakan fakta, asumsi, dan hal yang belum terverifikasi.
3. Laporkan audit terurut: Pertahankan / Perbaiki / Hapus.
4. Nyatakan arah desain, hierarki, token yang berubah, dan batas scope.
5. Implementasikan perubahan terarah dengan theme/komponen yang ada.
6. Periksa layar pemakai bila komponen bersama berubah.
7. Buka UI hasil; ambil screenshot sebelum/sesudah pada kondisi sebanding.
8. Exercise pencarian, filter, bookmark, navigasi, serta state yang terdampak.
9. Periksa teks besar, touch target, kontras, light/dark, dan Latin-Arab.
10. Jalankan pemeriksaan relevan dari README target dan perbarui dokumen
    desain bila pola/token permanen berubah.
Verifikasi v1:
Dari prototype/v1, gunakan perintah README yang tersedia, termasuk
flutter analyze dan flutter test bila environment mendukung.
Preview dapat dijalankan dengan flutter run -d web-server
--web-hostname=0.0.0.0 --web-port=8181.
Jika dependency, SDK, atau runtime menghalangi, laporkan error sebenarnya;
jangan mengklaim screenshot, tes, aksesibilitas, atau fungsi sudah terbukti.
Output:
- Scope dan arah desain dalam satu paragraf.
- Temuan audit dan keputusan, bukan deskripsi estetika kosong.
- Perubahan file/komponen dan fungsi yang dipertahankan.
- Bukti screenshot dan hasil smoke alur yang benar-benar dilakukan.
- Hasil pemeriksaan teknis serta batasan yang belum terverifikasi.
Kriteria selesai:
Tindakan utama lebih mudah ditemukan, hierarki lebih terbaca,
brand tetap dikenali, fungsi dalam scope tidak regresi,
dan tidak ada dekorasi/data palsu yang menggantikan kebutuhan pengguna.
```
## 10. Template konteks untuk proyek lain
Isi fakta yang diketahui; agen harus membaca repo untuk sisanya, bukan mengarang.
```text
Gunakan DESIGN_SKILLS_ANTI_SLOP.md untuk redesign UI yang sudah ada.
Produk dan tugas utama: [nama, tujuan, tindakan utama layar].
Pengguna dan situasi: [persona, bahasa, perangkat, kondisi penggunaan].
Target: [codebase, layar/route, komponen, platform].
Mode: preserve; overhaul hanya jika diminta secara eksplisit.
Identitas yang dijaga: [warna/peran, font, logo, aset, tone].
Masalah dengan bukti: [screenshot, alur, atau observasi pengguna].
Tidak boleh berubah: [fungsi, route, data, konten sensitif, tracking].
Referensi: [contoh dan kualitas spesifik yang dipinjam, bukan disalin].
Anti-referensi: [pola yang tidak cocok dan alasannya].
Verifikasi: [runtime, alur utama, state, perangkat, perintah proyek].
Audit sebelum edit. Gunakan stack dan komponen yang ada.
Jangan menambah fitur/data palsu. Laporkan perubahan dan bukti nyata.
```
## 11. Sumber sintesis dan adaptasi
- `design-taste-frontend`: brief-first, anti-default, audit-first, preservasi brand. Prinsipnya diadaptasi; aturan hero, stack Next.js, dan motion tinggi tidak dipaksakan ke mobile.
- `redesign-existing-projects`: scan, diagnose, targeted fix dalam stack lama. Saran data “terlihat realistis” tidak diadopsi sebagai izin mengarang data.
- `impeccable`: konteks produk, pembedaan brand/product UI, hierarki, restraint, dan kritik refleks kategori. Dokumen ini tidak membutuhkan command/loader Impeccable.
- `frontend-design`: subject-grounded identity, satu signature, dan self-critique. Familiaritas UI produk tetap diprioritaskan daripada novelty.
- `mobile-android-design`: pola platform, touch target, theme, dan adaptasi mobile. Contoh Compose tidak menjadi alasan migrasi dari Flutter.
- `accessibility-compliance`: kontras, semantics, teks besar, fokus, screen reader, dan reduced motion.
Rujukan resmi untuk pemeriksaan lanjutan:
- Flutter accessibility: https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility
- Flutter adaptive/responsive UI: https://docs.flutter.dev/ui/adaptive-responsive
- Material Design: https://m3.material.io/
- Apple Human Interface Guidelines: https://developer.apple.com/design/human-interface-guidelines
- WCAG 2.2: https://www.w3.org/TR/WCAG22/
Dokumen ini adalah panduan kerja, bukan sertifikasi aksesibilitas atau bukti bahwa hasil desain otomatis bebas slop. Nilai hasil dari UI nyata dan tugas pengguna.
