# Variasi Prompt Layout Out of the Box

Pelengkap [DESIGN_SKILLS_ANTI_SLOP.md](DESIGN_SKILLS_ANTI_SLOP.md). Fokus: mengubah struktur informasi UI yang sudah ada tanpa menjadikan setiap konten sebuah kartu.

**Tidak umum bukan berarti sulit digunakan.** Eksperimen pada komposisi isi, bukan memaksa pengguna mempelajari navigasi baru. Pertahankan kontrol familiar, fungsi, brand, aksesibilitas, dan kebenaran konten. Variasi di bawah adalah arah eksplorasi, bukan temuan audit atau desain yang sudah diuji.

## Cara menggunakan

1. Salin **prompt konteks bersama**, lalu tambahkan **satu** prompt variasi. Jangan menempelkan seluruh variasi sekaligus untuk satu layar.
2. Untuk membandingkan beberapa arah, gunakan prompt eksplorasi pada bagian akhir. Jangan langsung mencampur semua pola.
3. Isi target bila diketahui. Jika tidak, minta audit dan rekomendasi, bukan perubahan seluruh aplikasi.
4. Bedakan struktur: list, index, document, sequence, stage, map, atau split view. Menghapus shadow dari grid kartu tidak otomatis menghasilkan layout baru.
5. Kartu tetap boleh untuk kelompok yang benar-benar membutuhkan batas/elevation. Jangan mengubah kartu menjadi rounded panel dengan nama lain lalu menyebutnya non-card.

## Prompt konteks bersama

```text
Baca DESIGN_SKILLS_ANTI_SLOP.md dan instruksi repository.
Gunakan variasi layout yang dilampirkan di bawah sebagai arah desain,
bukan alasan menambah fitur atau mengubah identitas produk.

Target: layar/flow yang disebut dalam permintaan; bila belum disebut,
audit layar yang tersedia dan rekomendasikan satu target sebelum edit.
Platform dan stack: identifikasi dari repo, jangan mengganti framework.
Mode: redesign terarah dengan fungsi, route, state, persistence,
konten sensitif, analytics, dan pola navigasi utama tetap dipertahankan.

Untuk PKN, baca README.md, DESIGN_SYSTEM.md, design/DESIGN_CRITIQUE.md,
COMPLIANCE_AND_ARCHITECTURE.md, dan README codebase target.
Bedakan native prototype/v0/ dari web/device-preview prototype/v1/.
Pertahankan identitas emerald/teal, Nabawi gold, warna pilar semantik,
Inter Latin, Amiri/RTL, serta perilaku Material/Cupertino yang didukung.
Prioritaskan panduan praktis, rendah beban kognitif, tidak menghakimi.
Jangan mengarang dalil, hasil klinis, statistik, progres, atau fitur baru.
Jangan menyamarkan fungsi simulasi sebagai fungsi production.

Audit UI nyata terlebih dahulu. Pisahkan fakta, asumsi, dan usulan.
Pilih struktur berdasarkan tugas dan hubungan informasi, bukan tren.
Jangan membungkus setiap item dalam border + radius + shadow.
Gunakan tipografi, alignment, spacing, divider, dan perubahan surface
berdasarkan peran. Jangan membuat dekorasi menjadi navigasi tersembunyi.

Output awal: alasan kecocokan layout, hierarki isi, urutan baca,
perubahan versus yang dipertahankan, serta fallback mobile/teks besar.
Implementasikan hanya dalam scope yang diminta. Setelah implementasi,
buka UI nyata, bandingkan screenshot pada kondisi setara, exercise
alur yang berubah, dan laporkan pemeriksaan yang benar-benar dilakukan.
Jangan mengklaim desain berhasil hanya karena build atau test lulus.
```

## Peta pilihan

| Variasi | Struktur utama | Cocok untuk | Batas utama |
| --- | --- | --- | --- |
| 1. Editorial terbuka | Halaman dokumen dengan hirarki tipografi | Feed kurasi, bacaan, insight | Jangan berubah menjadi majalah dekoratif |
| 2. Action spine | Satu tindakan utama dan cabang bantuan | Panduan situasional | Jangan memaksakan wizard atau langkah baru |
| 3. Indeks bertingkat | Direktori kategori dan baris terbuka | Modul, materi tersimpan | Harus tetap mudah dipindai |
| 4. Timeline bermakna | Jalur urutan dengan isi tanpa kotak | Sesi atau riwayat nyata | Jangan mengarang progres atau urutan |
| 5. Kanvas tiga zona | Komposisi konteks, inti, dan alat | Layar fokus atau insight | Posisi bukan satu-satunya petunjuk |
| 6. Master-detail rail | Indeks ringkas dan bidang detail | Eksplorasi materi di layar besar | Mobile bukan dua kolom yang diperkecil |
| 7. Peta topik terarah | Hubungan topik dengan jalur list setara | Jelajah relasi konten nyata | Relasi harus tersedia dan dapat dijelaskan |
| 8. Panggung satu fokus | Satu konten aktif dengan kendali tenang | Lesson player atau audio yang ada | Tidak menyembunyikan kontrol penting |

## 1. Editorial terbuka: isi mengalir, bukan tumpukan kartu

**Ide:** tampilan seperti dokumen hidup. Panduan terpenting menjadi pembuka, materi lain menjadi bagian/row dengan hierarki tipografi dan jeda yang disengaja. Tidak perlu serif, cream, atau ornamen editorial.

**Cocok:** feed kurasi, insight setelah onboarding, atau materi dengan teks yang memang penting. **Tidak cocok:** kumpulan aksi dengan status independen yang perlu batas kuat.

```text
Gunakan arah Editorial Terbuka pada layar target.

Bangun halaman sebagai aliran informasi, bukan grid atau stack kartu.
Mulai dengan konteks singkat dan satu panduan nyata yang paling berguna.
Susun isi pendukung menjadi bagian terbuka dengan heading yang jelas,
baris materi berlabel, dan jeda tipografi; metadata berada setelah isi utama.
Gunakan divider hanya ketika hubungan informasi benar-benar berganti.

Jadikan treatment sumber/rujukan yang sudah ada sebagai detail khas:
terbaca dan dapat ditelusuri, bukan ornamen atau quote raksasa.
Jangan mengganti font brand dengan serif demi kesan editorial.
Jangan menambah eyebrow uppercase, nomor bagian palsu, atau kolom koran.
Pencarian, filter, bookmark, dan aksi lain tetap mudah ditemukan jika ada.

Pada mobile gunakan satu urutan baca vertikal; paragraf dan judul
harus tetap terbaca saat teks diperbesar. Konten panjang tidak boleh
mendorong semua kontrol penting menjadi sulit ditemukan.
Di layar lebar, metadata boleh menjadi margin notes dengan urutan
semantics yang tetap sama, bukan teks kecil yang wajib dibaca.

Buktikan bahwa hierarki membantu menemukan panduan dan membuka materi.
Jika hanya menghapus border kartu tanpa mengubah hierarki, revisi layout.
```

## 2. Action spine: layar dibangun di sekitar tindakan, bukan koleksi konten

**Ide:** satu poros tindakan yang jelas. Penjelasan, alternatif, dan rujukan melekat sebagai cabang sekunder; bukan deretan kartu yang bersaing.

**Cocok:** panduan situasional, bantuan praktis, tugas dengan satu tindakan utama. **Tidak cocok:** katalog yang perlu membandingkan banyak item setara.

```text
Gunakan arah Action Spine pada layar target.

Identifikasi tindakan utama yang sudah ada dan letakkan sebagai poros
komposisi: konteks singkat, kalimat panduan, kontrol tindakan,
lalu bantuan sekunder. Jangan membuat hero marketing.
Pisahkan area utama dan pendukung melalui spacing, alignment,
dan hierarki teks, bukan kartu besar dengan kartu kecil di dalamnya.

Jika informasi berupa langkah nyata, tampilkan urutannya sepanjang
poros vertikal. Jika bukan langkah, jangan beri nomor atau garis progres.
Penjelasan panjang dan rujukan boleh memakai disclosure yang berlabel
jelas, tetapi informasi keselamatan dan prasyarat tidak boleh disembunyikan.
Tetap tampilkan pilihan keluar/kembali dan alternatif yang diperlukan.

Jangan mengubah flow menjadi wizard, menambah pertanyaan,
atau menambahkan tombol “selesai” bila kontrak tersebut tidak ada.
Jangan mengedit copy sensitif agar cocok dengan komposisi.

Mobile: utamakan satu kolom. Aksi boleh melekat di bawah hanya jika
safe area, keyboard, teks besar, dan konten akhir tidak tertutup.
Jika sticky tidak aman, gunakan aksi inline yang mudah ditemukan.
Verifikasi tindakan utama dan akses bantuan dengan konten panjang.
```

## 3. Indeks bertingkat: katalog sebagai direktori, bukan galeri kartu

**Ide:** kategori menjadi penanda orientasi, item menjadi baris yang dapat dipindai. Identitas datang dari tipografi indeks dan ritme, bukan thumbnail generik.

**Cocok:** daftar modul, pustaka materi, hasil pencarian, bookmark. **Tidak cocok:** konten yang pemilihannya memang bergantung pada gambar besar.

```text
Gunakan arah Indeks Bertingkat pada layar target.

Ubah katalog menjadi direktori terbuka: heading kelompok yang jelas,
baris judul, ringkasan singkat jika membantu pemilihan, metadata relevan,
dan affordance membuka materi. Hindari kotak individual per item.
Bangun perbedaan kategori melalui label dan spacing; warna kategori
boleh mendukung orientasi tetapi tidak menjadi satu-satunya penanda.

Jika tersedia urutan modul yang sah, gunakan nomor sebagai informasi.
Jika tidak, jangan menambah penomoran dekoratif, level, atau ranking.
Jangan menambahkan alfabet A-Z atau kategori baru tanpa struktur data.
Pertahankan pencarian, filter, dan bookmark yang sudah ada.
Bedakan area membuka item dari kontrol bookmark tanpa tap target ambigu.

Mobile: row boleh bertambah tinggi saat teks membesar; jangan mengunci
satu baris atau memotong judul penting. Header kelompok yang sticky
hanya boleh dipakai jika tidak menutupi item dan urutan fokus tetap logis.
Layar lebar boleh memakai kolom metadata sejajar, bukan grid kartu.

Verifikasi pencarian, hasil kosong, filter aktif, dan buka item panjang.
Pastikan kepadatan bukan alasan membuat teks terlalu kecil.
```

## 4. Timeline bermakna: urutan menjadi struktur visual

**Ide:** jalur vertikal menghubungkan tahapan atau kejadian yang benar-benar berurutan. Isi terbuka di sisi jalur, tanpa kartu pada setiap titik.

**Cocok:** tahapan sesi, urutan modul yang sah, riwayat dengan waktu nyata. **Tidak cocok:** konten setara atau feed acak.

```text
Gunakan arah Timeline Bermakna pada layar target hanya jika data
memiliki urutan atau waktu yang nyata. Jika tidak, jelaskan ketidakcocokan
dan rekomendasikan Indeks Bertingkat; jangan menciptakan urutan.

Gunakan jalur vertikal tipis untuk menghubungkan tahap/kejadian.
Tempatkan judul dan isi secara terbuka di sampingnya; titik/status
harus punya label teks. Tampilan current/completed/locked hanya boleh
mengikuti state yang benar-benar ada, bukan dugaan dari posisi item.

Jangan memakai dot dekoratif untuk semua paragraf atau garis panjang
hanya demi tampilan. Jangan membuat progres persentase, streak,
ranking, atau status keberhasilan palsu. Jangan zigzag kiri-kanan
pada mobile karena merusak scanning dan urutan baca.

Teks besar: jalur mengikuti tinggi isi tanpa menimpa label.
Screen reader membaca urutan yang sama dengan urutan visual;
garis dekoratif tidak perlu diumumkan sebagai konten.
Pertahankan interaksi membuka/melanjutkan yang sudah tersedia.

Verifikasi item panjang, awal/akhir urutan, serta perubahan status
jika kontrak target memang mendukung perubahan tersebut.
```

## 5. Kanvas tiga zona: komposisi spasial yang tetap terurut

**Ide:** konteks ringkas, bidang isi dominan, dan alat pendukung memiliki bobot spasial berbeda. Bukan bento dengan delapan kotak.

**Cocok:** insight atau layar fokus dengan sedikit elemen bermakna. **Tidak cocok:** list panjang, teks padat, atau kebutuhan membandingkan banyak item.

```text
Gunakan arah Kanvas Tiga Zona pada layar target.

Susun tiga zona tanpa kotak individual:
A. Konteks ringkas di atas atau sisi awal.
B. Isi/tindakan utama sebagai bidang dominan yang terbaca langsung.
C. Alat atau sumber pendukung sebagai baris/rail sekunder.
Bentuk asimetri dari bobot dan posisi, bukan rotasi, overlap,
absolute positioning acak, atau konten yang keluar layar.

Zona harus berasal dari elemen yang tersedia. Jika hanya ada dua peran,
gunakan dua zona; jangan mengarang isi agar komposisi terasa penuh.
Satu perubahan surface boleh membantu memisahkan bidang utama,
tetapi jangan berubah menjadi tiga kartu besar.
Tidak ada label “zona A/B/C” pada UI pengguna.

Pada mobile runtuhkan menjadi konteks, inti, pendukung dalam satu kolom.
Pada teks besar, gunakan aliran layout intrinsik, bukan tinggi tetap.
Urutan semantics tetap logis pada semua ukuran; makna tidak boleh
bergantung pada posisi kanan/kiri saja, termasuk untuk RTL.

Verifikasi tindakan utama terlihat tanpa pengguna harus menebak
area mana yang interaktif. Jika ruang kosong memaksa scrolling
sebelum isi berguna, kurangi whitespace, bukan mengecilkan teks.
```

## 6. Master-detail rail: navigasi materi dan isi dalam satu ruang

**Ide:** indeks menjadi rail sederhana; detail menjadi bidang terbuka. Hubungan selection dan isi menggantikan banyak kartu preview.

**Cocok:** katalog/detail di tablet atau desktop bila relasinya sudah ada. **Tidak cocok:** layar kecil yang harus mempertahankan dua panel sekaligus.

```text
Gunakan arah Master-Detail Rail pada target yang sudah memiliki
relasi daftar dan detail. Jangan menambahkan struktur navigasi baru
untuk memaksakan pola ini.

Di layar lebar, gunakan rail indeks yang ringkas dan bidang detail
terbuka. Tampilkan selection dengan teks/status semantik dan satu
indikator visual yang jelas; bukan kartu aktif ber-glow.
Isi detail memiliki hierarki sendiri dan tetap dapat dibuka melalui
route yang sudah ada. Pertahankan pencarian, state, dan bookmark.

Pada mobile, gunakan daftar lalu detail sesuai navigasi yang ada;
jangan mengecilkan dua kolom. Pertahankan back navigation,
selected item, dan posisi scroll sesuai kontrak lama.
Perpindahan panel tidak boleh kehilangan fokus atau mengubah history
secara diam-diam. Jangan menyembunyikan konten di hover preview.

Panel dapat dipisahkan oleh spacing atau divider tunggal.
Tidak perlu floating sidebar, glass panel, nested card,
atau animasi setiap kali pengguna memilih materi.

Verifikasi pilihan item, kembali ke daftar, route langsung,
teks besar, dan kehilangan selection saat layar berubah ukuran.
```

## 7. Peta topik terarah: hubungan nyata, bukan dekorasi node

**Ide:** konten dijelajahi melalui relasi yang tersedia, dengan daftar aksesibel yang setara. Ini variasi paling eksperimental dan paling bersyarat.

**Cocok:** konten yang memiliki relasi eksplisit dan membantu pemilihan. **Tidak cocok:** relasi hasil tebakan atau kebutuhan akses cepat saat krisis.

```text
Eksplorasi arah Peta Topik Terarah dalam mode konsep dahulu.
Periksa apakah sumber data benar-benar memiliki relasi antar topik.
Jika tidak ada, hentikan arah peta dan rekomendasikan indeks;
jangan menyimpulkan relasi agama, psikologis, atau pedagogis sendiri.

Jika relasi tersedia, susun topik sebagai area berlabel atau jalur
terarah yang tenang, bukan kartu floating dalam force-directed graph.
Setiap hubungan harus dapat dijelaskan dengan label atau teks.
Tampilkan pilihan aktif dan akses membuka materi secara eksplisit.
Jangan mengubah popularitas menjadi ukuran node tanpa data yang sah.

Sediakan daftar linear setara yang mencapai konten dan relasi sama.
Pada mobile, gunakan daftar berkelompok sebagai jalur utama;
peta hanya alternatif jika mudah digunakan tanpa drag/pinch wajib.
Tidak ada navigasi yang hanya bisa ditemukan lewat gesture.
Tidak perlu animasi node, orbit, zoom sinematik, atau connector ramai.

Pertahankan filter/kategori yang ada. Jangan memperkenalkan peta
sebagai pengganti bantuan langsung atau flow keselamatan.
Sebelum implementasi yang mengubah interaksi, tampilkan konsep,
tradeoff, dan kebutuhan persetujuan scope secara jelas.
Verifikasi akses konten setara dengan keyboard/screen reader.
```

## 8. Panggung satu fokus: isi utama bukan kartu dalam dashboard

**Ide:** satu materi aktif mengisi bidang utama; kontrol menjadi lapisan hierarki yang tenang. Fokus tidak berarti UI fullscreen tanpa jalan keluar.

**Cocok:** lesson player, audio, bacaan fokus, atau latihan yang memang sudah ada. **Tidak cocok:** katalog atau layar dengan beberapa tugas paralel.

```text
Gunakan arah Panggung Satu Fokus pada layar konsumsi materi yang ada.

Jadikan isi aktif sebagai bidang utama tanpa kartu pembungkus.
Tampilkan judul/konteks secukupnya, isi yang terbaca, lalu kontrol
utama dan pendukung dengan prioritas jelas. Sumber, transkrip,
dan metadata menjadi bagian sekunder yang mudah dicapai jika tersedia.
Jangan menambah waveform, timer, animasi napas, atau progress ring
jika tidak ada data/state dan kontrak fitur yang mendukungnya.

Pertahankan kembali/keluar, akses sumber, status playback,
dan kontrol aksesibilitas yang sudah ada. Jangan menyembunyikan
kontrol penting sampai pengguna tap area kosong.
Fungsi audio simulasi tetap ditandai, bukan diberi visual
playback meyakinkan yang mengesankan audio benar-benar diputar.

Mobile: hormati safe area, keyboard bila relevan, dan teks besar.
Konten panjang boleh scroll; kontrol sticky hanya jika tidak menutup
isi akhir. Pada layar lebar, batasi lebar bacaan, bukan membesarkan
semua elemen untuk memenuhi ruang kosong.

Gunakan motion hanya untuk feedback/state yang nyata;
reduced motion tidak boleh menghilangkan instruksi.
Verifikasi buka materi, kontrol yang tersedia, kembali,
dan keterbacaan sumber tanpa bergantung pada animasi.
```

## Prompt eksplorasi: bandingkan tiga struktur, bukan tiga skin

```text
Baca DESIGN_SKILLS_ANTI_SLOP.md dan DESIGN_LAYOUT_PROMPT_VARIATIONS.md.
Audit layar target, lalu pilih tiga variasi yang paling sesuai dari
Editorial Terbuka, Action Spine, Indeks Bertingkat, Timeline Bermakna,
Kanvas Tiga Zona, Master-Detail Rail, Peta Topik Terarah,
dan Panggung Satu Fokus.

Jangan implementasikan tiga versi dulu. Buat tiga konsep dengan isi,
brand, dan fungsi yang sama. Bedakan struktur informasi dan urutan
interaksi; mengganti warna, radius, atau shadow bukan variasi layout.
Jangan memilih pola yang membutuhkan relasi/state/fitur yang tidak ada.

Untuk setiap konsep, jelaskan:
- tugas pengguna dan alasan kecocokan;
- urutan baca dan letak tindakan utama;
- cara pengelompokan tanpa default kartu;
- fallback mobile, teks besar, serta semantics;
- fungsi yang dipertahankan dan risiko perubahan;
- asumsi yang belum terbukti.

Pilih satu rekomendasi berdasarkan kemudahan tugas, kekhasan yang
relevan, aksesibilitas, dan risiko, bukan keunikan semata.
Jika user meminta implementasi sekaligus dan pilihan dapat dibuat
aman dalam scope, lanjutkan hanya rekomendasi itu; jika permintaan
hanya eksplorasi, berhenti pada konsep dan rekomendasi.
Jangan menyebut konsep tervalidasi tanpa hasil penggunaan nyata.
```

## Prompt kritik: apakah masih card-first dengan nama lain?

```text
Evaluasi rancangan layout terhadap tugas pengguna dan data nyata.

Periksa apakah setiap item masih memiliki background/border/radius/
shadow sendiri. Jika ya, jelaskan kebutuhan masing-masing pembungkus.
Panel besar yang berisi banyak panel kecil bukan otomatis non-card.
Cari grouping yang dapat diubah menjadi hierarchy, list, divider,
sequence, atau bidang terbuka tanpa menghilangkan affordance.

Periksa juga apakah anti-card menjadi dogma: jika penghapusan batas
membuat tap target, grouping, atau status tidak jelas, pertahankan
container yang memang membantu. Jangan memaksakan kartu nol persen.

Nilai novelty dari struktur dan hubungan informasi, bukan ornamen.
Apakah pengguna tetap dapat menemukan tindakan, membaca teks besar,
mengakses sumber, dan menavigasi tanpa gesture tersembunyi?
Laporkan koreksi konkret dan bukti yang masih dibutuhkan.
```

## Checklist sebelum memakai variasi

- [ ] Pola cocok dengan tugas dan data yang benar-benar ada.
- [ ] Perbedaan struktur nyata, bukan pergantian skin kartu.
- [ ] Navigasi utama familiar; eksperimen tidak menyembunyikan kontrol.
- [ ] Tidak ada urutan, relasi, progres, statistik, atau konten palsu.
- [ ] Ada fallback mobile/teks besar dengan urutan baca yang logis.
- [ ] Semantics, kontras, tap target, dan reduced motion tetap dijaga.
- [ ] Dampak terhadap fungsi/route/state dinilai sebelum implementasi.
- [ ] Hasil konsep dibedakan dari hasil runtime yang benar-benar diuji.

Dokumen ini menambahkan pilihan komposisi, bukan menggantikan kontrak keselamatan, preservasi brand, dan verifikasi dalam dokumen utama.
