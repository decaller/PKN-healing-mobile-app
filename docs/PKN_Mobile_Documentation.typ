#set document(
  title: "PKN Healing Mobile App - Dokumentasi Lengkap Desain, Sistem & Progres",
  author: "Tim Pengembang & Desain PKN Mobile",
  date: auto
)

// Setup Halaman
#set page(
  paper: "a4",
  margin: (x: 2cm, top: 2.5cm, bottom: 2.5cm),
  header: context {
    if counter(page).get().first() > 2 [
      #set text(size: 8pt, fill: rgb("64748B"), font: "Liberation Sans")
      *PKN Healing Mobile App* --- Dokumentasi Desain, Arsitektur & Progres
      #h(1fr)
      Oktober 2026
      #v(2pt)
      #line(length: 100%, stroke: 0.5pt + rgb("CBD5E1"))
    ]
  },
  footer: context {
    if counter(page).get().first() > 2 [
      #line(length: 100%, stroke: 0.5pt + rgb("CBD5E1"))
      #v(2pt)
      #set text(size: 8pt, fill: rgb("64748B"), font: "Liberation Sans")
      Pendidikan Karakter Nabawiyah & Tazkiyatun Nafs
      #h(1fr)
      Halaman #counter(page).get().first() dari #counter(page).final().first()
    ]
  }
)

#set text(
  font: ("Liberation Sans", "Noto Sans"),
  size: 9.5pt,
  fill: rgb("0F172A"),
  lang: "id"
)

#set par(
  justify: true,
  leading: 0.7em
)

// Styling Heading Default (sebelum outline di-set tanpa penomoran)
#show heading.where(level: 1): it => block(spacing: 1.8em)[
  #v(0.5em)
  #text(fill: rgb("0F766E"), weight: "bold", size: 15pt)[
    #if it.numbering != none [ #counter(heading).display() ]
    #it.body
  ]
  #v(3pt)
  #line(length: 100%, stroke: 1.5pt + rgb("0D9488"))
  #v(0.5em)
]

#show heading.where(level: 2): it => block(spacing: 1.4em)[
  #text(fill: rgb("134E4A"), weight: "bold", size: 12pt)[
    #if it.numbering != none [ #counter(heading).display() ]
    #it.body
  ]
  #v(2pt)
]

#show heading.where(level: 3): it => block(spacing: 1.1em)[
  #text(fill: rgb("1E293B"), weight: "bold", size: 10.5pt)[
    #if it.numbering != none [ #counter(heading).display() ]
    #it.body
  ]
  #v(1pt)
]

// Styling Tabel
#show table.cell.where(y: 0): set text(weight: "bold", fill: white)
#let tbl_header_fill = rgb("0F766E")
#let tbl_alt_fill = rgb("F8FAFC")

// Fungsi Callout Box
#let callout_tldr(body) = block(
  fill: rgb("0D9488").lighten(90%),
  stroke: (left: 3.5pt + rgb("0D9488"), rest: 0.5pt + rgb("CCFBF1")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  spacing: 1.2em,
  [
    #grid(
      columns: (20pt, 1fr),
      gutter: 8pt,
      text(size: 13pt)[⚡],
      [
        #text(weight: "bold", fill: rgb("0F766E"), size: 9.5pt)[Lead TL;DR < 10 Detik]\
        #text(size: 9pt, fill: rgb("134E4A"))[#body]
      ]
    )
  ]
)

#let callout_warning(body) = block(
  fill: rgb("F59E0B").lighten(90%),
  stroke: (left: 3.5pt + rgb("F59E0B"), rest: 0.5pt + rgb("FEF3C7")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  spacing: 1.2em,
  [
    #grid(
      columns: (20pt, 1fr),
      gutter: 8pt,
      text(size: 13pt)[⚠️],
      [
        #text(weight: "bold", fill: rgb("B45309"), size: 9.5pt)[Batas Toleransi Syar'i & Keamanan]\
        #text(size: 9pt, fill: rgb("78350F"))[#body]
      ]
    )
  ]
)

#let callout_tip(body) = block(
  fill: rgb("10B981").lighten(92%),
  stroke: (left: 3.5pt + rgb("10B981"), rest: 0.5pt + rgb("D1FAE5")),
  radius: (right: 6pt),
  inset: (x: 12pt, y: 10pt),
  spacing: 1.2em,
  [
    #grid(
      columns: (20pt, 1fr),
      gutter: 8pt,
      text(size: 13pt)[💡],
      [
        #text(weight: "bold", fill: rgb("047857"), size: 9.5pt)[Resep Praktis Lapangan]\
        #text(size: 9pt, fill: rgb("064E3B"))[#body]
      ]
    )
  ]
)

#let badge(txt, bg, fg) = box(
  fill: bg,
  radius: 4pt,
  inset: (x: 6pt, y: 2.5pt),
  baseline: 1pt,
  text(fill: fg, size: 7.5pt, weight: "bold")[#txt]
)

#let phone_frame(img_path, h: 195pt) = block(
  stroke: 1pt + rgb("CBD5E1"),
  radius: 8pt,
  clip: true,
  image(img_path, height: h)
)

// -------------------------------------------------------------
// HALAMAN COVER
// -------------------------------------------------------------
#align(center + horizon)[
  #block(
    width: 100%,
    fill: rgb("0F766E"),
    radius: 12pt,
    inset: (x: 24pt, y: 32pt)
  )[
    #text(fill: rgb("D4AF37"), size: 12pt, weight: "bold", tracking: 2pt)[
      MANHAJ PENDIDIKAN KARAKTER NABAWIYAH
    ]
    #v(8pt)
    #text(fill: white, size: 24pt, weight: "bold")[
      PKN Healing Mobile App
    ]
    #v(6pt)
    #text(fill: rgb("CCFBF1"), size: 12pt)[
      Dokumentasi Komprehensif Arsitektur, Desain Sistem, Journey Native, & Progres Virtual Fitrah
    ]
  ]

  #v(20pt)

  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 10pt,
    badge("Flutter 3.24+ & Dart 3.5+", rgb("E0F2FE"), rgb("0369A1")),
    badge("OpenPencil v0.15.1 (166 Frames)", rgb("F3E8FF"), rgb("7E22CE")),
    badge("Flame + Bonfire + Rive", rgb("FEF3C7"), rgb("B45309")),
    badge("WCAG 2.1 AA Target >= 48dp", rgb("DCFCE7"), rgb("15803D"))
  )

  #v(24pt)

  #align(left)[
    #block(
      width: 100%,
      fill: rgb("F8FAFC"),
      stroke: 1pt + rgb("E2E8F0"),
      radius: 8pt,
      inset: 16pt
    )[
      #text(weight: "bold", size: 11pt, fill: rgb("0F766E"))[Ikhtisar Dokumen & Metadata Teknis:]
      #v(6pt)
      #grid(
        columns: (140pt, 1fr),
        row-gutter: 8pt,
        text(weight: "bold")[Repositori Asal:], text([`https://github.com/decaller/PKN-healing-mobile-app`]),
        text(weight: "bold")[Target Platform:], text([Flutter (Single Unified Binary untuk Android & iOS)]),
        text(weight: "bold")[Desain Master:], text([`design/PKN_Healing_App_Design.fig` (OpenPencil SceneGraph)]),
        text(weight: "bold")[Cakupan Dokumen:], text([README.md, DESIGN_SYSTEM.md, design/README.md, design/ANALISIS_DAN_PENGEMBANGAN.md, TODO_HANDOFF.md, docs/]),
        text(weight: "bold")[Cakupan Persona:], text([16 Persona Stabil dalam 5 Ranah Ekosistem (53 Layar x Light/Dark = 111 Viewport Utama)]),
        text(weight: "bold")[Modul Simulasi:], text([Baitul Fitrah & Madinah Virtual (51 Layar Mobile + 4 Companion = 55 Frame)]),
        text(weight: "bold")[Status Implementasi:], text([Fase 1--6 Selesai (13/13 Test Passing); Fase 7--12 Siap Eksekusi]),
        text(weight: "bold")[Versi & Tanggal:], text([Versi 2.0.0 --- 6 Oktober 2026])
      )
    ]
  ]

  #v(20pt)
  #text(fill: rgb("64748B"), size: 9pt)[
    Diterbitkan untuk Tim Pengembang, UI/UX Designer, Stakeholder Lembaga, dan Asatidzah Pembina PKN
  ]
]

#pagebreak()

// -------------------------------------------------------------
// DAFTAR ISI (UNNUMBERED)
// -------------------------------------------------------------
#outline(
  title: [Daftar Isi Dokumentasi],
  indent: auto,
  depth: 3
)

#pagebreak()

// Mulai penomoran bab setelah daftar isi
#set heading(numbering: "1.1")

// -------------------------------------------------------------
// BAB 1: KONSEP INTI, LATAR BELAKANG & FILOSOFI MANHAJ
// -------------------------------------------------------------
= Konsep Inti, Latar Belakang & Filosofi Manhaj

== Latar Belakang Masalah Riil
Banyak orang tua dan pendidik hari ini mengalami fenomena *caregiver burnout* (kelelahan pengasuhan mental dan fisik) dan terjebak dalam rasa bersalah (*parenting guilt*) yang berkepanjangan. 

Di lapangan, ditemukan krisis-krisis nyata:
- *Ayah (Qawwamun):* Sering tereduksi perannya sebatas penyedia nafkah materi (*breadwinner* semata), bingung membangun kedekatan emosional mendalam (*heart-to-heart dialogue*), atau sebaliknya bertindak keras fisik karena tidak memahami batas toleransi syar'i.
- *Bunda (Madrasah Utama):* Menghadapi ledakan tantrum balita dalam kondisi fisik yang letih, terjebak siklus marah-menyesal (*yelling-remorse cycle*), serta kehabisan energi batin (*emotional depletion*).
- *Guru & Pendidik:* Terbebani administrasi kaku, memaksakan beban akademis calistung dini pada anak usia bermain (PAUD/TK), atau menghukum murid dengan amarah tanpa sentuhan *Bahasa Hati*.
- *Siswa & Santri:* Mengalami krisis identitas akibat sistem ranking sekolah konvensional yang memicu perasaan "tidak berbakat", serta rentan terhadap distraksi adiktif gawai.

*PKN Healing Mobile App* dirancang bukan sekadar aplikasi artikel teks pasif, melainkan sebagai *sahabat saku penenteram jiwa* (*pocket spiritual companion*) yang memberikan pertolongan instan hitungan detik berbasis dalil shahih dan kaidah tarbiyah kenabian.

== Empat Pilar Filosofis Manhaj Nabawiyah
Aplikasi ini berakar pada prinsip tarbiyah Salafush Shalih:

+ *Iman Sebelum Al-Qur'an & Adab Sebelum Ilmu:* Merujuk atsar Shahabat Jundub bin Abdillah dan Abdullah bin Umar radhiyallahu 'anhum. Anak ditanamkan kecintaan kepada Allah dan Rasul-Nya terlebih dahulu secara riang, dilatih adab keseharian, sebelum dibebani tuntutan hafalan atau hukum teoritis berat.
+ *Tiga Bahasa Mendidik:*
  - *Bahasa Tubuh:* Sikap tubuh yang tenang, mendekat, berlutut setara tinggi mata anak, dan memberikan dekapan yang aman.
  - *Bahasa Mata:* Sorot mata teduh penuh penerimaan dan kasih sayang, bukan tatapan tajam mengintimidasi.
  - *Bahasa Hati:* Komunikasi jiwa yang tulus, memvalidasi emosi anak terlebih dahulu sebelum memperbaiki tindakannya (*Connection Before Correction*).
+ *Empat Fase Perkembangan Fitrah:*
  - *Fase Thufulah (2--7 Tahun):* Fitrah keimanan dan bermain riang; haram sanksi fisik; tanpa menakut-nakuti neraka.
  - *Fase Tamyiz (7--10 Tahun):* Pembiasaan shalat 5 waktu secara bertahap dan menggembirakan; nalar pembedaan baik-buruk; tanpa sanksi pukulan.
  - *Fase Murahaqah (10--14 Tahun):* Pemisahan ranjang (*madhaji'*), batas syar'i kedisiplinan shalat (pukulan mendidik hanya setelah genap 10 tahun, tanpa melukai dan haram wajah), serta penanaman rasa malu (*haya'*).
  - *Fase Baligh & Syabab (14--18+ Tahun):* Kematangan aqil baligh mukallaf, kemandirian finansial dan sosial, penjagaan kehormatan (*iffah*), dan penemuan peran peradaban (*syakilah*).
+ *Talents-Based 40 (TB-40):* Pemetaan 40 ragam bakat fitrah ciptaan Allah dalam 4 kluster (*Al-Qiyadah*, *Al-Fashahah*, *Al-Idarah*, *Al-Fikriyyah*), menegaskan bahwa setiap anak diciptakan unik dan tidak ada anak yang "bodoh" atau "gagal".

== Prinsip Anti-Guilt UX & Non-Gamification
Berbeda dengan aplikasi modern yang mengeksploitasi dopamin melalui gamifikasi adiktif:
- *Tanpa Streak Shaming:* Tidak ada notifikasi intimidatif ("Kamu kehilangan streak 10 hari!"). Pengguna yang lama rehat disambut dengan salam kehangatan dan doa thuma'ninah.
- *Tanpa Leaderboard Komparatif:* Menghilangkan peringkat skor antar-orang tua atau santri yang memicu riya', ujub, atau rasa rendah diri.
- *Pelacakan Adab Kualitatif:* Mengganti nilai angka dengan 4 status perkembangan: *BT* (Belum Tampak), *MT* (Mulai Tampak), *BK* (Berkembang), dan *MM* (Membudaya).

== Trio Format Micro-Learning
Untuk menjawab keterbatasan waktu orang tua dan guru:
+ *10-Second Lead TL;DR:* Intisari eksekutif 2--3 kalimat di baris teratas kartu gagasan. Solusi praktis dan kalimat yang harus diucapkan tersaji dalam 10 detik pertama.
+ *5-Minute Interactive Deck:* Modul belajar 5 kartu berformat interaktif: (1) Fenomena riil & kesalahan umum; (2) Kaidah manhaj & dalil nash; (3) Kuis respons adab lapangan; (4) Kalimat respons praktis (*action script*); (5) Doa refleksi jiwa & muhasabah.
+ *Pemutar Audio Sirah & Tazkiyah Hands-Free:* Mendukung pemutaran audio di latar belakang (*background playback*) dengan kendali mudah, cocok didengarkan ayah saat menyetir atau bunda saat menidurkan anak.

== Taksonomi 6 Pilar MOC (Maps of Content)
Seluruh materi diatur dalam 6 Pilar Pengetahuan yang dinavigasi melalui filter chip di beranda:

#table(
  columns: (45pt, 120pt, 80pt, 1fr),
  fill: (col, row) => if row == 0 { tbl_header_fill } else if calc.even(row) { tbl_alt_fill } else { none },
  align: (center, left, center, left),
  [Pilar], [Nama Pilar], [Aksen Warna], [Fokus & Cakupan Materi],
  [P1], [Mulai di Sini], [#badge("#6366F1", rgb("EEF2FF"), rgb("4338CA"))], [Peta konsep dasar, glosarium fitrah, orientasi belajar bertahap.],
  [P2], [Tumbuh Kembang], [#badge("#0EA5E9", rgb("F0F9FF"), rgb("0369A1"))], [4 fase usia (Thufulah, Tamyiz, Murahaqah, Baligh), batas syar'i.],
  [P3], [Bakat TB-40], [#badge("#8B5CF6", rgb("F5F3FF"), rgb("6D28D9"))], [40 Bakat Nabawiyah, asesmen syakilah, 4 kluster potensi insan.],
  [P4], [Praktik Keluarga], [#badge("#F43F5E", rgb("FFF1F2"), rgb("BE123C"))], [Solusi krisis rumah, peran Ayah Qawwamun, Bunda Madrasah, tangki cinta.],
  [P5], [Lembaga & Guru], [#badge("#10B981", rgb("ECFDF5"), rgb("047857"))], [KBM kelas, apersepsi sirah 5 menit, SOP iklim adab, filter Maqashid.],
  [P6], [Khazanah Dalil], [#badge("#D4AF37", rgb("FEF9C3"), rgb("854D0E"))], [Verifikasi nash Qur'an, takhrij hadits, derajat sanad, syarah turats.]
)

#pagebreak()

// -------------------------------------------------------------
// BAB 2: EKOSISTEM PERSONA & USER JOURNEYS
// -------------------------------------------------------------
= Ekosistem Persona & User Journeys

== Matriks 16 Persona dalam 5 Ranah
Aplikasi ini memetakan 16 persona pengguna dalam 5 ranah ekosistem peran:

#table(
  columns: (30pt, 85pt, 55pt, 1fr, 50pt),
  fill: (col, row) => if row == 0 { tbl_header_fill } else if calc.even(row) { tbl_alt_fill } else { none },
  align: (center, left, center, left, center),
  [No], [Persona], [Ranah], [Aha Moment & Alur Tugas], [Pilar],
  [01a], [Ayah / Qawwamun], [Keluarga], [F eksekutif/prinsip/ucapan/batas; S1 bookmark; Dk1--5; R1--5], [P4 / P2],
  [01b], [Bunda / Pengasuh], [Keluarga], [K respons cepat krisis; S1; A1--3 hands-free; R1--5], [P4 / P1],
  [01], [Orang Tua Pemula], [Keluarga], [N peta 4 fase; N2 primer 5 hari; Dk1--5], [P1],
  [02a], [Guru Thufulah], [Guru], [T1 sirah/aktivitas/komunikasi wali; A2; R1--5], [P5 / P2],
  [02b], [Guru Tamyiz], [Guru], [T2 rutinitas kelas/shalat/RPP; R1--5; D2 sumber], [P5 / P2],
  [02c], [Guru Murahaqah], [Guru], [T3 mediasi; T3b thaharah/privasi; E1], [P5 / P2],
  [02d], [Pembimbing Syabab], [Guru], [T4 mentoring; T4b iffah; B1--7 kontribusi], [P3 / P5],
  [02e], [Pembimbing Dewasa], [Guru], [T5 tiga lapisan jiwa/rekonsiliasi; Dk1--5; J], [P1 / P4],
  [02], [Guru Umum], [Guru], [R1--3 19 butir fast-tap; R4 bukti; R5 laporan naratif], [P5],
  [03a], [Pengelola Formal], [Lembaga], [L1 maqashid/KOSP; L1b keputusan program; L3--L3b prioritas], [P5],
  [03b], [Pengelola Non-Formal], [Lembaga], [L2 kurikulum; L2b komitmen wali; L2c portofolio], [P5 / P6],
  [03], [Pengelola Umum], [Lembaga], [L3 audit 8 standar; L3b prioritas tahun pertama], [P5],
  [04], [Fasilitator Kajian], [Keilmuan], [D1 silabus/dalil sheet/outline; D2--D3 telaah], [P6 / P1],
  [05], [Peneliti Dalil], [Keilmuan], [D2 sumber/status; D3 syarah/nash/ijtihad; S1], [P6],
  [06], [Siswa / Santri], [Pelajar], [B1--5 lima pertanyaan; B6 ilustrasi 4 kluster; B7 peran], [P3],
  [07], [Pembelajar Mandiri], [Mandiri], [A1 audio malam; A2 unduh; A3 latar belakang; J syukur], [P1 / P4]
)

== Alur Bersama (Shared Onboarding Journey)
Seluruh persona memulai interaksi melalui alur onboarding terpadu:
#align(center)[
  #block(
    fill: rgb("F1F5F9"),
    stroke: 1pt + rgb("CBD5E1"),
    radius: 6pt,
    inset: 10pt
  )[
    *O1: Pilih Ranah* $arrow.r$ *O2: Peran & Fase Kondisional* $arrow.r$ *O3: Bottleneck & Waktu* $arrow.r$ *O4: Rekomendasi Personal* $arrow.r$ *H: Beranda Tarbiyah*
  ]
]
Fase tumbuh kembang hanya ditampilkan untuk keluarga, guru, dan pelajar, serta tidak dipaksakan pada pengelola atau peneliti. Profil awal dapat disesuaikan kembali kapan saja melalui profil pengguna.

== Peta Master SceneGraph Figma
#figure(
  image("../design/previews/journey_MAP.png", width: 85%),
  caption: [Parcours Master Map 16 Persona dalam SceneGraph Figma (Menghubungkan 111 Viewport Utama dan 55 Frame Virtual Fitrah)]
)

== Enam Alur Detail Persona Representatif

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  [
    === 1. Persona Ayah (Qawwamun)
    - *Pemicu:* Pulang kerja letih, anak enggan shalat maghrib.
    - *Alur:* Buka mode eksekutif $arrow.r$ Lead TL;DR < 10 detik batasan usia 7 vs 10 tahun $arrow.r$ Terapkan *Tiga Bahasa Mendidik* (lutut sejajar, tatap mata lembut, suara tenang) $arrow.r$ Catat di rubrik kualitatif (*BK: Berkembang*) $arrow.r$ Simpan template dialog Luqman.
    
    === 2. Persona Bunda (Pusat Krisis)
    - *Pemicu:* Balita 3 tahun tantrum hebat di lantai, ibu burnout.
    - *Alur:* Buka tab krisis cepat (*Layar K*) $arrow.r$ Panduan verbal < 60 detik (Validasi emosi tanpa ceramah, dekap dari samping) $arrow.r$ Anak tenang $arrow.r$ Winding-down malam memutar audio tazkiyatun nafs bunda ($arrow.r$ hati tenteram tanpa rasa bersalah).
  ],
  [
    === 3. Guru Tamyiz (Adab Shalat & KBM)
    - *Pemicu:* Persiapan KBM shalat Zhuhur berjamaah di sekolah.
    - *Alur:* Akses P5 $arrow.r$ Unduh apersepsi sirah Anas bin Malik cilik 3 menit $arrow.r$ Pelaksanaan shalat $arrow.r$ Observasi langsung via Fast-Tap Rubric 19 Butir Adab (BT/MT/BK/MM) $arrow.r$ Ekspor laporan naratif deskriptif ke grup wali santri.

    === 4. Santri / Pemuda (TB-40)
    - *Pemicu:* Santri galau memilih penjurusan kuliah dan merasa tak berbakat.
    - *Alur:* Buka modul TB-40 $arrow.r$ Jawab kuis interaktif 5 langkah (B1--B5) $arrow.r$ Tinjau visualisasi 4 kluster bakat (B6) $arrow.r$ Pahami syakilah dan keteladanan shahabat $arrow.r$ Temukan arah studi dan portofolio kontribusi peradaban.
  ]
)

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  [
    === 5. Mudir / Pengelola Formal (KOSP)
    - *Pemicu:* Rapat kerja tahunan program sekolah agar guru tidak burnout.
    - *Alur:* Akses tata kelola P5 (L1) $arrow.r$ Buka *The Maqashid Program Filter* $arrow.r$ Klasifikasikan kegiatan ke kuadran syar'i: Dharuriyyat, Hajiyyat, Tahsiniyyat $arrow.r$ Pangkas kegiatan seremonial berlebih $arrow.r$ Alokasikan anggaran ke kesejahteraan guru dan pelatihan ortu.
  ],
  [
    === 6. Pembelajar Mandiri (Sakinah)
    - *Pemicu:* Profesional kantor stres, gelisah, dan mudah marah.
    - *Alur:* Akses P1 $arrow.r$ Buka modul 5 menit *Tiga Lapisan Jiwa* (Ammarah, Lawwamah, Muthma'innah) $arrow.r$ Latihan muhasabah melatih *Ash-Shabr* $arrow.r$ Putar audio sirah malam pengantar istirahat $arrow.r$ Jiwa thuma'ninah dan siap beristirahat.
  ]
)

#pagebreak()

// -------------------------------------------------------------
// BAB 3: SPESIFIKASI DESIGN SYSTEM NATIVE (V2.0)
// -------------------------------------------------------------
= Spesifikasi Design System Native (v2.0)

== Visi & Nilai Inti Desain
Antarmuka PKN Mobile dibangun di atas integrasi keanggunan eksekutif Nabawiyah, rekayasa kognitif ramah pengguna (*zero-fluff*), dan kepatuhan syar'i manhaj.

- *Fitrah-First, Bukan Peringkat:* Menghilangkan angka mati, persaingan komparatif (*leaderboard*), dan digantikan oleh perkembangan kualitatif adab (*BT - MT - BK - MM*).
- *Koneksi Sebelum Koreksi:* Hierarki visual memprioritaskan sentuhan hati (*Bahasa Hati*) dan validasi emosi sebelum sanksi disiplin atau koreksi teknis.
- *Rekayasa Kognitif Zero-Fluff:* Meminimalkan beban kognitif orang tua lelah dan guru terburu-buru dengan menyajikan *Lead TL;DR < 10 Detik* di posisi teratas.
- *Keselamatan Manhaj:* Perlindungan anak: larangan sanksi fisik pada balita, batas sanksi disiplin shalat hanya setelah genap usia 10 tahun (tanpa melukai dan haram memukul wajah).
- *Aksesibilitas sebagai Target:* Kontras warna normal $gt.eq 4.5:1$, target sentuh utama minimal $48 times 48 thin "dp"$, dukungan Arab Amiri/RTL, dan semantik pembaca layar.

== Sistem Warna Kanonikal (Color Tokens)
Koleksi native `PKN` memiliki 14 color variables dengan binding Light dan Dark mode:

#table(
  columns: (95pt, 75pt, 75pt, 1fr),
  fill: (col, row) => if row == 0 { tbl_header_fill } else if calc.even(row) { tbl_alt_fill } else { none },
  align: (left, center, center, left),
  [Token], [Dark Mode], [Light Mode], [Peruntukan & Semantik],
  [`Background`], [`#121417`], [`#F8FAFC`], [Latar utama kanvas viewport],
  [`Surface`], [`#1E2229`], [`#FFFFFF`], [Kartu konten, bottom sheet, dock navigasi],
  [`PrimarySoft`], [`#163D38`], [`#E6F4F1`], [Latar callout box, chip terpilih, container aktif],
  [`Border`], [`#475569`], [`#E2E8F0`], [Garis batas pemisah kartu dan divider],
  [`TextPrimary`], [`#FFFFFF`], [`#0F172A`], [Teks judul utama, isi tebal, kontras tinggi],
  [`TextSecondary`], [`#CBD5E1`], [`#475569`], [Teks penjelasan, metadata, label pendukung],
  [`Primary`], [`#5EEAD4`], [`#0F766E`], [Tombol aksi utama (CTA), aksen brand utama],
  [`OnPrimary`], [`#0F172A`], [`#FFFFFF`], [Teks di atas latar tombol CTA]
)

=== Rubrik Adab Kualitatif (BT - MT - BK - MM)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 8pt,
  block(fill: rgb("EF4444").lighten(90%), stroke: 1pt + rgb("EF4444"), inset: 8pt, radius: 6pt)[
    #text(weight: "bold", fill: rgb("B91C1C"))[BT (Belum Tampak)]\
    #text(size: 8pt)[#badge("#EF4444", rgb("FEE2E2"), rgb("991B1B"))]\
    Perilaku belum teramati; catat konteks tanpa melabeli anak.
  ],
  block(fill: rgb("F59E0B").lighten(90%), stroke: 1pt + rgb("F59E0B"), inset: 8pt, radius: 6pt)[
    #text(weight: "bold", fill: rgb("B45309"))[MT (Mulai Tampak)]\
    #text(size: 8pt)[#badge("#F59E0B", rgb("FEF3C7"), rgb("92400E"))]\
    Muncul sesekali dengan dorongan dan pengingat lembut.
  ],
  block(fill: rgb("10B981").lighten(90%), stroke: 1pt + rgb("10B981"), inset: 8pt, radius: 6pt)[
    #text(weight: "bold", fill: rgb("047857"))[BK (Berkembang)]\
    #text(size: 8pt)[#badge("#10B981", rgb("D1FAE5"), rgb("065F46"))]\
    Muncul konsisten atas kesadaran dan pendampingan.
  ],
  block(fill: rgb("3B82F6").lighten(90%), stroke: 1pt + rgb("3B82F6"), inset: 8pt, radius: 6pt)[
    #text(weight: "bold", fill: rgb("1D4ED8"))[MM (Membudaya)]\
    #text(size: 8pt)[#badge("#3B82F6", rgb("DBEAFE"), rgb("1E40AF"))]\
    Telah menjadi karakter alami dan menginspirasi sekitar.
  ]
)

== Sistem Tipografi & Dalil Turats
Sumber sinkronisasi aktual tipografi adalah root metadata `pknTypography`:

#table(
  columns: (65pt, 45pt, 50pt, 65pt, 55pt, 1fr),
  fill: (col, row) => if row == 0 { tbl_header_fill } else if calc.even(row) { tbl_alt_fill } else { none },
  align: (left, center, center, center, center, left),
  [Role], [Ukuran], [Bobot], [Font Family], [Line Height], [Penerapan & Semantik],
  [Display], [26 pt], [700 Bold], [Inter], [36 pt], [Judul layar utama & hero header],
  [Heading], [18 pt], [700 Bold], [Inter], [27 pt], [Judul seksi konten & kartu pilar],
  [Subhead], [15 pt], [400 Regular], [Inter], [23 pt], [Subjudul, lead insight, pertanyaan],
  [Body], [13 pt], [400 Regular], [Inter], [20 pt], [Teks narasi bacaan, opsi kuis],
  [Caption], [12 pt], [400 Regular], [Inter], [18 pt], [Metadata, tanggal, durasi baca],
  [Arabic], [28 pt], [400 Regular], [Amiri], [48 pt], [Penggalan dalil Qur'an & Hadits berharakat]
)

=== Contoh Blok Teks Dalil Turats (`ArabicDalilCard`)
Pada layar D2 dan Dk2 disajikan penggalan *QS Ali Imran 3:159* (bersumber resmi dari *Quran.com Indonesia*):

#block(
  fill: rgb("FEF9C3").lighten(70%),
  stroke: 1pt + rgb("D4AF37"),
  radius: 8pt,
  inset: 14pt,
  [
    #align(right)[
      #text(font: "Amiri", size: 14pt, dir: rtl, fill: rgb("78350F"))[
        فَبِمَا رَحْمَةٍ مِّنَ اللَّهِ لِنتَ لَهُمْ ۖ وَلَوْ كُنتَ فَظًّا غَلِيظَ الْقَلْبِ لَانفَضُّوا مِنْ حَوْلِكَ
      ]
    ]
    #v(4pt)
    #text(size: 8.5pt, fill: rgb("1E293B"))[
      *"Maka berkat rahmat Allah engkau (Muhammad) berlaku lemah lembut terhadap mereka. Sekiranya engkau bersikap keras dan berhati kasar, tentulah mereka menjauhkan diri dari sekitarmu."* (QS. Ali 'Imran: 159)
    ]
    #v(2pt)
    #text(size: 7.5pt, fill: rgb("B45309"), weight: "bold")[Rujukan: Quran.com Indonesia | Takhrij Manhaj: Kelembutan mendahului ketegasan]
  ]
)

== Sistem Spasial, Grid & Ergonomi
- *Grid 8-Point:* Jarak spasial menggunakan kelipatan 4/8 dp (`xxs: 4`, `xs: 8`, `sm: 12`, `md: 16`, `lg: 20`, `xl: 24`, `xxl: 32`, `xxxl: 48 dp`). Margin ponsel standar 16 dp.
- *Sudut Lengkung (Border Radius):*
  - Badge / Pill: `20.0 dp`
  - Tombol & Input Field: `14.0 dp`
  - Kartu Konten: `16.0 dp`
  - Container Hero & Modal: `24.0 dp`
- *Target Sentuh Ergonomis:* Area sentuh minimum $48 times 48 thin "dp"$ untuk seluruh tombol primer; Bottom bar navigasi tinggi 64 dp; Opsi kuis tinggi minimal 56 dp.

== Showcase Visual Design Tokens
#figure(
  image("../design/previews/00_design_system_tokens.png", width: 80%),
  caption: [Showcase Design System & Color Tokens PKN Mobile Native (Mode Light/Dark & Tipografi Inter/Amiri)]
)

#pagebreak()

== Referensi & Inspirasi Desain Modern UI/UX (Oiloil UI & 21st.dev)
Guna menjaga mutu estetika antarmuka tetap mutakhir, memancarkan ketenangan batin (*calm technology*), serta menyajikan interaktivitas yang anggun tanpa mengorbankan kesederhanaan manhaj nabawiyah, dua platform desain kelas dunia dijadikan rujukan utama:

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  block(
    fill: rgb("F0FDFA"),
    stroke: 1pt + rgb("99F6E4"),
    radius: 8pt,
    inset: 12pt,
    [
      #text(weight: "bold", size: 10.5pt, fill: rgb("0F766E"))[#link("https://ui.oiloil.org/en/")[Oiloil UI]]\
      #text(size: 8.5pt, style: "italic", fill: rgb("115E59"))[Minimalist, Elegant & Calm Interface Reference]\
      #v(6pt)
      #text(weight: "bold", size: 8.5pt)[Filosofi Relevan:]\
      #text(size: 8.5pt)[Desain minimalis yang mengutamakan ruang bernapas (*whitespace*), tipografi bersih, dan peredaman beban kognitif (*zero visual noise*).]\
      #v(4pt)
      #text(weight: "bold", size: 8.5pt)[Penerapan di PKN Mobile:]\
      #text(size: 8.5pt)[
        - Beranda tarbiyah & kartu gagasan *Lead TL;DR* bebas distraksi.
        - Tata letak kontemplatif pada modul muhasabah, doa, dan tazkiyah.
        - Formulir asesmen adab kualitatif yang menenangkan jiwa (*stress-free*).
      ]
    ]
  ),
  block(
    fill: rgb("FFFBEB"),
    stroke: 1pt + rgb("FDE68A"),
    radius: 8pt,
    inset: 12pt,
    [
      #text(weight: "bold", size: 10.5pt, fill: rgb("B45309"))[#link("https://21st.dev/")[21st.dev]]\
      #text(size: 8.5pt, style: "italic", fill: rgb("92400E"))[State-of-the-Art Micro-Interactions & Design Engineering]\
      #v(6pt)
      #text(weight: "bold", size: 8.5pt)[Filosofi Relevan:]\
      #text(size: 8.5pt)[Komponen antarmuka modern berbasis rekayasa desain (*design engineering*) dengan animasi mikro halus dan gestur taktil kelas dunia.]\
      #v(4pt)
      #text(weight: "bold", size: 8.5pt)[Penerapan di PKN Mobile:]\
      #text(size: 8.5pt)[
        - Geser interaktif modul 5 langkah (*Primer Deck* / swipeable flashcards).
        - Modal interaktif *Learning Tooltip* pada respon terkunci (*turned off*).
        - Widget HUD dinamis *Tangki Cinta* & *Barometer Jiwa (Nafs)*.
        - Transisi mikro dialog *Bahasa Hati* & gulungan digital *Welcome Back Ledger*.
      ]
    ]
  )
)

#v(8pt)

=== Matriks Implementasi Komponen UI vs Sumber Inspirasi

#table(
  columns: (130pt, 100pt, 1fr),
  fill: (col, row) => if row == 0 { tbl_header_fill } else if calc.even(row) { tbl_alt_fill } else { none },
  align: (left, left, left),
  [Komponen / Layar], [Sumber Inspirasi], [Pola Interaksi & Prinsip UX],
  [Feed Kartu Gagasan Tarbiyah], [Oiloil UI], [Kartu berjarak lega (*whitespace*), tipografi hierarkis, Lead TL;DR < 10 detik tanpa clutter visual.],
  [Tazkiyah, Doa & Muhasabah], [Oiloil UI], [Latar belakang lembut (*calm tone*), teks Arab berharakat jelas, peredaman stimulasi sensorik berlebih.],
  [Formulir Rubrik Adab (BT--MM)], [Oiloil UI], [Selektor ramah jemari tanpa skor angka shaming; fokus pada refleksi kualitatif yang menenangkan.],
  [Primer Deck 5 Langkah], [21st.dev], [Transisi kartu geser halus (*smooth swipe spring physics*), indikator progres dot elegan.],
  [Educational Learning Tooltip], [21st.dev], [Modal *popover* kontekstual saat opsi terkunci di-tap; membedah teks dalil & gap fitrah.],
  [HUD Tangki Cinta & Nafs], [21st.dev], [Barometer status beranimasi fluida (*fluid state transitions*) dengan ikon ekspresi mikro.],
  [The Welcome Back Ledger], [Oiloil UI + 21st.dev], [Estetika perkamen kuno minimalis dipadukan dengan interaktivitas gulungan digital responsif.]
)

#pagebreak()

// -------------------------------------------------------------
// BAB 4: DESAIN JOURNEY NATIVE & ARTEFAK OPENPENCIL
// -------------------------------------------------------------
= Desain Journey Native & Artefak OpenPencil

== Master Berkas & Inventori Viewport
Berkas master tersimpan di `design/PKN_Healing_App_Design.fig` dan dikelola menggunakan tool native *OpenPencil v0.15.1*. Berkas ini terdiri dari *7 halaman* dengan total *166 frame berscreenKey unik*:

+ *111 Viewport Aplikasi Utama:*
  - 53 key layar kanonis
  - Masing-masing memiliki varian mode *Light* dan *Dark* (106 viewport)
  - Ditambah varian tablet (`L1_Tablet`, `L1_Tablet_Dark`, `R1_Tablet`, `R1_Tablet_Dark`)
  - Ditambah varian Android kanonikal (`H_Android`)
  - Viewport berdimensi nyata: Mobile 390#sym.times;844, Android 412#sym.times;915, Tablet 768#sym.times;1024 (menggantikan asumsi kanvas seragam 428#sym.times;1040).
+ *55 Frame Virtual Fitrah:*
  - 51 layar mobile
  - 4 frame companion: `GF_HOME_Dark`, `GF_AVATAR_Dark`, `GF_MAP_Web` (1440#sym.times;1050), dan `GF_MAP_Tablet` (1024#sym.times;1050).

== Tiga Master Component Utama & 333 Instance
Struktur desain native dibangun dengan relasi master-component yang ketat:
- `Status & Header`: Master penunjuk fase, judul, dan status bar perangkat.
- `Docked Primary Action`: Master CTA melayang di bagian bawah dengan tinggi dan padding aman.
- `Four-Tab Icon Navigation`: Master navigasi utama (Beranda, Player, Rubrik, Profil).

Sebanyak *333 instance* terpasang pada 111 viewport utama. Propagasi master diverifikasi secara terprogram: saat radius tombol CTA diubah menjadi 22 pada master, eksekusi `figma.graph.syncInstances` berhasil mempropagasi perubahan ke seluruh 111 CTA pada viewport turunan.

== Viewport Resize Helper (`resize-viewport.js`)
Karena properti constraint pada proxy tidak otomatis menyesuaikan tata letak saat ukuran frame berubah, skrip helper `design/resize-viewport.js` menghitung ulang posisi dan ukuran child serta chrome secara eksplisit. Pengujian smoke pada layar H dari 390#sym.times;844 ke 412#sym.times;915 menghasilkan penyesuaian akurat: dock y=751 (tinggi 164), CTA lebar 364, navigasi lebar 412.

== Pipeline Ekspor & Sinkronisasi Token Dart
Sinkronisasi desain ke Flutter dijalankan melalui pipeline otomatis:
```bash
node design/sync-tokens.mjs         # Menghasilkan lib/app/theme/color_palette.dart & pkn_tokens.dart
node design/sync-tokens.mjs --check # Memvalidasi drift tanpa mengubah berkas
```

== Galeri Visual Antarmuka Aplikasi Utama (Koleksi 1)

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  align: center,
  figure(
    phone_frame("../design/previews/screen_01_onboarding_jtbd.png"),
    caption: [Screen 01: Onboarding Diagnostik JTBD]
  ),
  figure(
    phone_frame("../design/previews/screen_02_beranda_tarbiyah.png"),
    caption: [Screen 02: Beranda Tarbiyah & Filter 6 Pilar MOC]
  )
)

#v(8pt)

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  align: center,
  figure(
    phone_frame("../design/previews/screen_03_pemain_modul.png"),
    caption: [Screen 03: Pemain Modul 5 Menit Interaktif]
  ),
  figure(
    phone_frame("../design/previews/screen_04_laporan_adab.png"),
    caption: [Screen 04: Fast-Tap Rubric & Laporan Adab]
  )
)

#pagebreak()

== Galeri Visual Antarmuka Aplikasi Utama (Koleksi 2)

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  align: center,
  figure(
    phone_frame("../design/previews/screen_05_pemutar_audio_sirah.png"),
    caption: [Screen 05: Pemutar Audio Sirah Hands-Free]
  ),
  figure(
    phone_frame("../design/previews/journey_K_crisis.png"),
    caption: [Layar Krisis Bunda (Respons Cepat < 60 Detik)]
  )
)

#v(8pt)

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  align: center,
  figure(
    phone_frame("../design/previews/journey_R1_rubric.png"),
    caption: [Fast-Tap Rubric 19 Butir Adab Guru]
  ),
  figure(
    phone_frame("../design/previews/journey_B6_clusters.png"),
    caption: [Visualisasi 4 Kluster Bakat TB-40 Santri]
  )
)

#pagebreak()

// -------------------------------------------------------------
// BAB 5: MODUL SIMULASI KEHIDUPAN & GAMIFIKASI "VIRTUAL FITRAH"
// -------------------------------------------------------------
= Modul Simulasi Kehidupan "Virtual Fitrah"

== Konsep "Baitul Fitrah & Madinah Virtual"
Modul gamifikasi *Virtual Fitrah* menghadirkan simulasi kehidupan insan dan komunitas islami yang menolak paradigma materialisme game konvensional. Simulasi ini berfokus pada:
- *Pertumbuhan Karakter Ruhani:* Perkembangan anak virtual diukur dari kelembutan adab dan kebersihan jiwa, bukan akumulasi koin virtual.
- *Interaksi Syar'i:* Menghormati privasi, pemisahan tempat tidur anak usia 10 tahun, adab berpakaian, serta keutamaan shalat berjamaah di masjid.

== Arsitektur "Unified Flutter Bundle"
Seluruh modul edukasi dan game simulasi disatukan dalam *satu aplikasi Flutter tunggal* (*single binary*) menggunakan teknologi:

#table(
  columns: (100pt, 90pt, 1fr),
  fill: (col, row) => if row == 0 { tbl_header_fill } else if calc.even(row) { tbl_alt_fill } else { none },
  align: (left, left, left),
  [Komponen], [Teknologi], [Peran & Justifikasi],
  [Host App], [Flutter (Dart 3.5+)], [Satu kode tunggal Android & iOS, startup instan (< 1 detik).],
  [Core Game Loop], [Flame Engine 1.18+], [Game loop 2D isometrik murni Dart. Tambahan APK hanya +3--5 MB, RAM 35--50 MB, 60--120 FPS.],
  [Simulasi Komunitas], [Bonfire 3.11+], [Pathfinding otomatis karakter, tabrakan dinding, dialog *Bahasa Hati*, siklus cahaya shalat.],
  [Avatar Vektor], [Rive 0.13+], [Animasi vektor berbasis State Machine (~200 KB per model), ekspresi mikro menangis/shalat/tersenyum.],
  [Penyimpanan Luring], [Isar Database 3.1+], [Database NoSQL lokal super cepat untuk log *The Welcome Back Ledger*.],
  [Simulasi Latar], [WorkManager & Delta-Time], [Algoritma matematika selisih waktu tanpa render loop latar (zero battery drain).]
)

== Tujuh Venue Komunitas Islami Isometrik
Dunia virtual dibangun dari 7 venue isometrik native editable yang saling terhubung:
+ *Rumah Baitul Fitrah (`GF_HOME`):* Terdiri dari ruang keluarga, dua kamar tidur bersekat (sesuai syariat pemisahan tempat tidur usia 10 tahun), dan musholla rumah.
+ *Sekolah Kuttab (`GF_SCHOOL` / `_ACT`):* Ruang halaqah adab dan sirah santri.
+ *Masjid Jami' (`GF_MOSQUE` / `_ACT`):* Pusat shalat berjamaah 5 waktu dan kajian ilmu.
+ *Kebun Alam (`GF_GARDEN` / `_ACT`):* Zona tadabbur alam, cocok tanam, dan panen kebajikan.
+ *Pasar Niaga (`GF_MARKET` / `_ACT`):* Praktik muamalah syar'i, kejujuran takaran, dan sedekah.
+ *Asrama Santri (`GF_DORM` / `_ACT`):* Ruang kemandirian, ukhuwah, dan tahajjud bersama.
+ *Komunitas Tetangga (`GF_NEIGHBOUR` / `_ACT`):* Silaturahim, berbagi makanan, dan hak tetangga.

== Virtual Human: Tangki Cinta & Tiga Lapisan Jiwa
Setiap anak virtual memiliki dua barometer fitrah utama:
- *Tangki Cinta (Love Tank, 0--100):* Mengukur rasa aman emosional. Jika di bawah 30%, avatar menunjukkan ekspresi cemas/menangis. Pada simulasi prototype, input nilai 20 memicu respons pedagogis: *"Tawarkan pendampingan hangat; tidak ada hukuman."*
- *Barometer Jiwa (Nafs):* Bergerak dinamis antara *Nafs Ammarah* (dikuasai amarah), *Nafs Lawwamah* (menyesali kesalahan), dan *Nafs Muthma'innah* (tenang & thuma'ninah).

== Mekanik AFK & "The Welcome Back Ledger"
Saat aplikasi ditutup, sistem tidak menjalankan game loop latar yang boros baterai, melainkan mencatat timestamp keluar ($t_0$). Saat pengguna membuka kembali ($t_1$), formula matematika menghitung selisih waktu ($Delta t$) dan merangkum kejadian harian dalam *The Welcome Back Ledger* (buku gulungan kejadian adab) untuk diselesaikan pengguna.

== Mekanik "Real-to-Virtual Bridge" (Anti-Kecanduan Layar)
Untuk mencegah anak/orang tua kecanduan layar:
#callout_tip[
  *Aksi di Dunia Nyata Mengisi Energi Virtual:* Pengguna mendapatkan energi atau bibit tanaman virtual bukan dengan terus menatap layar, melainkan dengan menuntaskan misi di dunia nyata (misalnya: memeluk anak tanpa HP selama 3 menit, shalat berjamaah tepat waktu, atau membacakan sirah pengantar tidur).
]

#pagebreak()

== Galeri Visual Virtual Fitrah

#figure(
  block(
    stroke: 1pt + rgb("CBD5E1"),
    radius: 8pt,
    clip: true,
    image("../design/previews/journey_GF_MAP_Web.png", width: 92%)
  ),
  caption: [Atlas Komunitas Madinah Virtual (7 Venue Komunitas Isometrik: Rumah, Sekolah, Masjid, Kebun, Pasar, Asrama, Tetangga)]
)

#v(14pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 12pt,
  align: center,
  figure(
    phone_frame("../design/previews/journey_GF_HOME.png", h: 175pt),
    caption: [Baitul Fitrah: Rumah Isometrik]
  ),
  figure(
    phone_frame("../design/previews/journey_GF_AVATAR.png", h: 175pt),
    caption: [Panel Perawatan Avatar]
  ),
  figure(
    phone_frame("../design/previews/journey_GF_LEDGER.png", h: 175pt),
    caption: [The Welcome Back Ledger]
  )
)

#pagebreak()

// -------------------------------------------------------------
// BAB 6: LAPORAN ANALISIS, KOREKSI AUDIT & BATAS FAKTUAL
// -------------------------------------------------------------

== Sistem Narasi Multikarakter, Gating Prasyarat & Jalur Islah

Untuk memantapkan pemahaman praktis materi PKN, modul simulasi menghadirkan sistem narasi interaktif berbasis skenario graf berarah (*Pre-Authored Graph Node Tree*) dengan mekanisme kontrol multi-karakter dan evaluasi pilihan respons berbasis fitrah:

+ *Kendali Bergantian Lintas 6 Fase Usia (Thufulah s.d. Syaikh):*
  Pemain mengendalikan berbagai karakter lintas generasi fitrah:
  - *Thufulah (2--7 Thn):* Perspektif fitrah bermain murni, ketergantungan afeksi, dan kepolosan batin.
  - *Tamyiz (7--10 Thn):* Nalar pembedaan awal, pergulatan rasa malas shalat, dan kejujuran bicara.
  - *Murahaqah (10--14 Thn):* Batas privasi tempat tidur (*madhaji'*), penguatan rasa malu (*haya'*), dan gejolak pubertas.
  - *Baligh (14--17 Thn):* Kematangan aqil baligh mukallaf, pencarian peran peradaban, dan kemandirian ibadah.
  - *Syabab (18--40 Thn):* Amanah kepemimpinan keluarga (Ayah Qawwamun & Bunda Madrasah), manajemen stres kerja.
  - *Syaikh (40+ Thn):* Sesepuh keluarga / murabbi yang meneduhkan, mediator konflik, dan sumber hikmah ruhiyah.

+ *Antologi Episodik Hybrid & Mode Estafet (POV Relay):*
  Skenario mendukung mode *solo* per karakter maupun mode *estafet kasus multi-perspektif (POV Relay)*. Dalam satu insiden krisis di sebuah venue (misal: penolakan shalat di Baitul Fitrah), pemain mengendalikan kedua belah pihak secara bergantian: mengendalikan Anak Tamyiz saat emosi, lalu beralih mengendalikan Ayah Syabab untuk merespons, dan beralih ke Kakek Syaikh untuk mediasi.

+ *Hierarki Pilihan Jawaban & Gating Prasyarat (Turned Off Choices):*
  Seluruh kemungkinan respon ditampilkan secara transparan di layar dari tingkat terbaik hingga terburuk:
  - *Mumtaz (Tier Terbaik - Adab Nabawiyah):* Respon Tiga Bahasa Mendidik, kelembutan, dan dalil shahih.
  - *Jayyid Jiddan / Jayyid (Tier Baik/Cukup):* Respon instruktif wajar yang aman secara syar'i.
  - *Dha'if (Tier Sub-Optimal):* Respon kompromistis atau menunda kewajiban.
  - *Munkar (Tier Terburuk):* Bentakan emosional, ancaman fisik balita, atau pelabelan toksik.
  
  Sebagian opsi respon berstatus *turned off* (abu-abu nonaktif dengan ikon gembok) jika karakter belum memenuhi predikat prasyarat komposit:
  $ "isChoiceEnabled" = ("Bakat TB-40" >= "minTalent") and ("Adab" >= "minAdab") and ("LoveTank" >= "minLoveTank") and ("Nafs" in "requiredNafs") $

+ *Inspeksi Edukatif (Learning Tooltip):*
  Pilihan nonaktif dapat diklik/di-tap untuk memunculkan modal edukatif:
  - *Teks Dalil & Hikmah Syar'i:* Penjelasan mengapa tindakan ini merupakan keteladanan tertinggi sunnah.
  - *Analisis Gap Fitrah:* Penjelasan mengapa opsi terkunci (contoh: *"Ayah sedang lelah sehingga Tangki Cinta di bawah 60% dan Adab Tahan Amarah masih bertaraf MT"*).

+ *Tanpa Game Over: Percabangan Jalur Islah & Rekonsiliasi:*
  Sesuai prinsip *Anti-Guilt UX*, memilih opsi buruk tidak menyebabkan *Game Over*. Dampak alami terjadi (Tangki Cinta anjlok, anak menangis), lalu alur bercabang ke fase *Islah & Rekonsiliasi* (muhasabah, istighfar, meminta maaf kepada anak, pelukan hangat tanpa gawai).

+ *Format Data Luring Graph Node Tree JSON:*
  Seluruh pohon skenario disimpan secara terstruktur di `assets/data/scenarios/*.json` (didemonstrasikan pada berkas percontohan `skenario_krisis_shalat_rumah.json`).

#pagebreak()

= Laporan Analisis, Koreksi Audit & Batas Faktual

== Koreksi atas Klaim Audit Lama
Dalam iterasi pengembangan terkini, sejumlah klaim dari audit sistem lama telah dikoreksi demi akurasi teknis:

#table(
  columns: (120pt, 1fr),
  fill: (col, row) => if row == 0 { tbl_header_fill } else if calc.even(row) { tbl_alt_fill } else { none },
  align: (left, left),
  [Klaim Audit Lama], [Status Faktual Terverifikasi],
  [Semua layar hanya varian Dark], [Seluruh 53 key utama memiliki padanan Light dan Dark lengkap (total 111 viewport). Virtual Fitrah berbasis tema cerah dengan 2 companion dark.],
  [Semua layar kanvas seragam 428#sym.times;1040], [Viewport menggunakan ukuran perangkat nyata (Mobile 390#sym.times;844, Android 412#sym.times;915, Tablet 768#sym.times;1024). Resize proxy wajib dihitung eksplisit.],
  [Komponen detached tanpa master], [Tiga master utama (Header, Docked CTA, Navigasi 4-tab) terhubung ke 333 instance; propagasi radius 22 terbukti via `syncInstances`.],
  [Font hanya Inter, teks Arab belum ada], [Font Amiri dimuat resmi; penggalan QS Ali Imran 3:159 diatribusikan ke Quran.com Indonesia.],
  [Tidak ada prototype interaktif], [Browser prototype berjalan terpisah (`design/prototype.html`) memuat 104 layar kanonis dan 12 flows interaktif.],
  [Donut persentase adab 100%], [Dihapus menyeluruh. Tidak ada persentase total adab atau leaderboard shaming; diganti narasi kualitatif BT-MT-BK-MM.],
  [Radar TB-40 sebagai skor hasil asesmen], [B6 radar adalah visualisasi ilustratif 4 kluster, bukan hasil skor psikometrik otomatis.],
  [Klaim WCAG 100% dan Zero Collision], [Target sentuh $gt.eq 48"dp"$ adalah parameter desain; bukan klaim sertifikasi WCAG/TalkBack/VoiceOver resmi.]
)

== Bukti Teramati secara Faktual
- *Uji Propagasi Master CTA:* Pembaruan radius master menjadi 22 berhasil dipropagasikan ke seluruh 111 CTA viewport utama.
- *Uji Resize Helper:* Eksekusi `resize-viewport.js` pada layar H (412#sym.times;915) menghasilkan dock y=751/tinggi 164, CTA lebar 364, navigasi lebar 412.
- *Integritas Token Dart:* Skrip `node design/sync-tokens.mjs --check` lulus 100% tanpa drift antara variabel Figma dan kode tema Flutter.
- *Smoke Native Variables:* Resolusi variabel warna pada frame H mengembalikan `#F8FAFC` (Light) dan `#121417` (Dark).
- *Ekspor 166 Frame PNG:* Seluruh 166 frame berscreenKey unik berhasil diekspor ulang ke direktori `design/previews/`.
- *Interaktivitas Browser Prototype:* Memuat 104 layar kanonis, membuka 7 venue dengan header unik, 15 cabang feedback skenario (A/B/C) pada Q1--Q5, alur panen, serta dialog Tangki Cinta.

== Batas Verifikasi & Rekomendasi Lanjutan
#callout_warning[
  *Batas Ruang Lingkup Verifikasi:*
  - *Konten Syar'i:* Rujukan hadits dan teks dalil di luar kutipan ayat yang telah diatribusikan tetap memerlukan penelaahan intensif asatidzah dan dewan pakar turats sebelum rilis produksi.
  - *Aksesibilitas:* Pengujian pembaca layar (*TalkBack* di Android dan *VoiceOver* di iOS) serta uji *Dynamic Text Scaling* wajib dijalankan pada rilis aplikasi perangkat fisik.
  - *Data Simulasi:* Data prototype browser bersifat lokal sementara (tanpa backend/API aktif).
]

#pagebreak()

// -------------------------------------------------------------
// BAB 7: STATUS PROGRES & ROADMAP PENGEMBANGAN HANDOFF
// -------------------------------------------------------------
= Status Progres & Roadmap Pengembangan Handoff

== Status Fase Selesai (Phase 1 s.d. 6)
Pengembangan aplikasi telah menuntaskan seluruh fondasi arsitektur dan antarmuka utama:

#table(
  columns: (70pt, 1fr, 70pt),
  fill: (col, row) => if row == 0 { tbl_header_fill } else if calc.even(row) { tbl_alt_fill } else { none },
  align: (center, left, center),
  [Fase], [Lingkup Pekerjaan & Hasil], [Status],
  [Phase 1], [Tooling lokal, Riverpod state management, unit test LessonPlayer (13/13 passing).], [#badge("SELESAI", rgb("DCFCE7"), rgb("15803D"))],
  [Phase 2], [Token warna kanonikal (`AppColors`), tipografi Inter, komponen `AdabBadge`, `ArabicDalilCard`.], [#badge("SELESAI", rgb("DCFCE7"), rgb("15803D"))],
  [Phase 3], [Onboarding diagnostik JTBD 4 langkah, pemetaan arketipe persona, persistensi `SharedPreferences`.], [#badge("SELESAI", rgb("DCFCE7"), rgb("15803D"))],
  [Phase 4], [Pemain modul Primer 5 langkah (teks, kuis, poll, blank), laporan naratif adab BT-MM.], [#badge("SELESAI", rgb("DCFCE7"), rgb("15803D"))],
  [Phase 5], [Feed Deepstash 6 Pilar MOC, Lead TL;DR < 10 detik, bookmark offline, pencarian kata kunci.], [#badge("SELESAI", rgb("DCFCE7"), rgb("15803D"))],
  [Phase 6], [Integrasi 16 persona, 111 viewport utama + 55 frame game (total 166 frame), laporan audit desain.], [#badge("SELESAI", rgb("DCFCE7"), rgb("15803D"))]
)

== Roadmap Eksekusi Engine Simulasi (Phase 7 s.d. 12)
Berikut adalah daftar tugas terprioritasi untuk implementasi engine Flame, Bonfire, dan Rive:

#table(
  columns: (70pt, 1fr, 80pt),
  fill: (col, row) => if row == 0 { tbl_header_fill } else if calc.even(row) { tbl_alt_fill } else { none },
  align: (center, left, center),
  [Fase], [Rencana Implementasi & Deliverable], [Target],
  [Phase 7], [Pemasangan dependensi engine; definisi skema database Isar (`CharacterEntity`, `LedgerEventEntity`, `RealToVirtualMissionEntity`, `ScenarioProgressEntity`); parser luring Graph Node Tree JSON di `assets/data/scenarios/`.], [#badge("READY / UPCOMING", rgb("FEF3C7"), rgb("B45309"))],
  [Phase 8], [Pipeline aset Rive (`.riv`) 6 arketipe usia; rigging State Machine Inputs (`loveTankLevel`, `nafsState`, gestur adab, mikroekspresi).], [#badge("PLANNED", rgb("F1F5F9"), rgb("475569"))],
  [Phase 9], [Peta Tiled isometrik 7 venue; zona interaksi furnitur, collision detection Bonfire, sistem siklus cahaya 24 jam shalat.], [#badge("PLANNED", rgb("F1F5F9"), rgb("475569"))],
  [Phase 10], [Algoritma matematika delta-time AFK offline; UI gulungan digital `WelcomeBackLedgerScreen` (< 100 ms render).], [#badge("PLANNED", rgb("F1F5F9"), rgb("475569"))],
  [Phase 11], [Katalog 50+ skenario multi-karakter (Thufulah s.d. Syaikh) format JSON Graph; sistem kendali estafet POV Relay; widget prerequisite choice gating; learning tooltip dalil; percabangan jalur Islah (No Game Over).], [#badge("PLANNED", rgb("F1F5F9"), rgb("475569"))],
  [Phase 12], [Integrasi soundscape alami & adzan; audit performa memori (RAM < 50 MB, startup < 1 dtk, 60 FPS); rilis beta Flutter.], [#badge("PLANNED", rgb("F1F5F9"), rgb("475569"))]
)

#pagebreak()

== Struktur Direktori Kode Proyek
Proyek ini mengadopsi struktur arsitektur modern *Feature-First Clean Architecture*:

```text
PKN-healing-mobile-app/
├── lib/
│   ├── app/                # Konfigurasi aplikasi, tema (AppTheme), routing (GoRouter)
│   ├── core/               # Widget bersama (AdabBadge, ArabicDalilCard, PknCalloutBox)
│   └── features/
│       ├── feed/           # Beranda tarbiyah, feed ide MOC, Lead TL;DR
│       ├── lessons/        # Player modul 5 menit & laporan pertumbuhan adab
│       ├── onboarding/     # Diagnostik JTBD 4 langkah & trajektori persona
│       └── profile/        # Profil pengguna & penyesuaian peran
├── design/                 # Master berkas OpenPencil (.fig), prototype.html, previews/ (176 file)
├── docs/                   # USER_JOURNEYS.md, personas/ (17 file), GAME_CONCEPT_VIRTUAL_FITRAH.md
└── test/                   # Automated unit & widget tests (13 test passing)
```

== Panduan Perintah Pengembang (CLI Reference)
```bash
# Pengujian Kode Flutter
flutter pub get               # Memperbarui dependensi paket
flutter analyze               # Menjalankan static analysis (wajib 0 issues)
flutter test                  # Menjalankan seluruh unit test (13/13 passing)
flutter run                   # Menjalankan aplikasi pada perangkat / emulator

# Otomasi Desain & Token OpenPencil
node design/sync-tokens.mjs         # Ekspor token warna dan tipografi ke Flutter
node design/sync-tokens.mjs --check # Pemeriksaan validasi drift token
openpencil info design/PKN_Healing_App_Design.fig # Cek struktur berkas master desain
```

#v(20pt)
#align(center)[
  #text(fill: rgb("0F766E"), weight: "bold", size: 10pt)[
    --- Akhir Dokumen Dokumentasi PKN Healing Mobile App ---
  ]\
  #text(fill: rgb("64748B"), size: 8pt)[
    Dokumentasi ini disusun secara terpadu berdasarkan seluruh spesifikasi README, Design System, Artefak OpenPencil, User Journeys, dan Modul Virtual Fitrah.
  ]
]
