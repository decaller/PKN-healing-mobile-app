import { COLORS } from './design_tokens.mjs';

function populateBerandaBody(b, bodyId, screenKey, { dark = false, classicHeader = false } = {}) {
  const cardBg = dark ? COLORS.basalt[900] : COLORS.white;
  const subBg = dark ? COLORS.basalt[950] : COLORS.sand[50];
  const pillBg = dark ? COLORS.basalt[800] : COLORS.sand[100];
  const borderCol = dark ? COLORS.basalt[800] : COLORS.sand[200];
  const textPri = dark ? COLORS.sand[50] : COLORS.basalt[900];
  const textSec = dark ? COLORS.sand[300] : COLORS.basalt[600];
  const textMut = dark ? COLORS.sand[400] : COLORS.basalt[400];
  const pineCol = dark ? COLORS.pine[400] : COLORS.pine[600];

  if (!classicHeader) {
    // Pull-Down Over-Scroll Indicator (Trigger to Mode Renungan)
    const pullBar = b.frame({
      name: 'Pull-Down Over-Scroll Indicator (Mode Renungan Trigger)',
      parent: bodyId,
      width: 390,
      height: 28,
      registerTrigger: `${screenKey}:open:renungan-pull`,
      props: {
        fills: [{ type: 'linearGradient', stops: [COLORS.pine[900], COLORS.pine[800]] }],
        cornerRadius: 10,
        layout: 'horizontal',
        mainAlign: 'center',
        crossAlign: 'center',
        padding: [4, 12, 4, 12],
        sizingH: 'fill',
        sizingV: 'fixed',
      },
    });
    b.text({
      parent: pullBar,
      text: '↓ Tarik ke bawah untuk Mode Renungan (Tadabbur & Jam Digital)...',
      props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.amber[300] },
    });

    // Variant A: Nature Tree Hero (1/3 Screen)
    const heroId = b.frame({
      name: 'Variant A: Hero Pohon Alam 1/3 Layar',
      parent: bodyId,
      width: 390,
      height: 220,
      props: {
        fills: [{ type: 'linearGradient', stops: ['#072A16', '#0F3D23', '#141A16'] }],
        cornerRadius: 24,
        stroke: COLORS.pine[700],
        strokeWeight: 1,
        layout: 'vertical',
        mainAlign: 'spaceBetween',
        padding: [16, 16, 16, 16],
        sizingH: 'fill',
        sizingV: 'fixed',
      },
    });

    const heroTop = b.frame({
      name: 'Hero Top Controls',
      parent: heroId,
      width: 358,
      height: 38,
      props: {
        fill: '#00000000',
        layout: 'horizontal',
        mainAlign: 'spaceBetween',
        crossAlign: 'center',
        sizingH: 'fill',
        sizingV: 'fixed',
      },
    });
    b.text({
      parent: heroTop,
      text: 'Ahlan, Abu Zaid',
      props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 22, fill: COLORS.white },
    });

    const heroRightBtns = b.frame({
      name: 'Hero Action Buttons',
      parent: heroTop,
      width: 150,
      height: 36,
      props: {
        fill: '#00000000',
        layout: 'horizontal',
        mainAlign: 'max',
        crossAlign: 'center',
        gap: 6,
        sizingH: 'hug',
        sizingV: 'hug',
      },
    });
    const layoutBtn = b.frame({
      name: 'Btn Toggle Layout',
      parent: heroRightBtns,
      width: 58,
      height: 30,
      registerTrigger: `${screenKey}:toggle:layout`,
      props: {
        fill: '#FFFFFF26',
        cornerRadius: 999,
        layout: 'horizontal',
        mainAlign: 'center',
        crossAlign: 'center',
        padding: [4, 10, 4, 10],
      },
    });
    b.text({ parent: layoutBtn, text: 'Klasik', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.white } });

    const themeBtn = b.frame({
      name: 'Btn Theme Toggle',
      parent: heroRightBtns,
      width: 32,
      height: 32,
      registerTrigger: `${screenKey}:toggle:theme`,
      props: {
        fill: '#FFFFFF26',
        cornerRadius: 999,
        layout: 'horizontal',
        mainAlign: 'center',
        crossAlign: 'center',
      },
    });
    b.text({ parent: themeBtn, text: dark ? '☀️' : '🌙', props: { fontSize: 12, fill: COLORS.white } });

    const avatarBtn = b.frame({
      name: 'Btn Avatar Profil',
      parent: heroRightBtns,
      width: 34,
      height: 34,
      registerTrigger: `${screenKey}:open:profil-avatar`,
      props: {
        fill: COLORS.pine[600],
        cornerRadius: 999,
        stroke: COLORS.emerald[400],
        strokeWeight: 2,
        layout: 'horizontal',
        mainAlign: 'center',
        crossAlign: 'center',
      },
    });
    b.text({ parent: avatarBtn, text: 'AZ', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.white } });

    // Calm Anchor Quote Card inside Tree Hero
    const quoteCard = b.frame({
      name: 'Quote Nabawiyah Card (Tap to Open Mode Renungan)',
      parent: heroId,
      width: 358,
      height: 128,
      registerTrigger: `${screenKey}:open:renungan`,
      props: {
        fill: '#00000073',
        cornerRadius: 18,
        stroke: '#FFFFFF40',
        strokeWeight: 1,
        layout: 'vertical',
        mainAlign: 'spaceBetween',
        crossAlign: 'center',
        padding: [12, 14, 12, 14],
        sizingH: 'fill',
        sizingV: 'fixed',
      },
    });
    b.text({
      parent: quoteCard,
      text: '❝ SENTUHAN QALBU HARI INI',
      props: { fontSize: 9, fontStyle: 'Bold', fill: COLORS.amber[300], textAlign: 'center' },
    });
    b.text({
      parent: quoteCard,
      text: '"Koneksi Sebelum Koreksi — Tautkan hati dan penuhi bejana cinta sebelum menegakkan aturan."',
      width: 330,
      props: { fontFamily: 'Merriweather', fontStyle: 'Italic', fontSize: 12, fill: COLORS.sand[50], textAlign: 'center' },
    });
    b.badge({
      parent: quoteCard,
      text: '↓ Ketuk / Tarik ke Bawah untuk Mode Renungan',
      bg: '#FFFFFF26',
      fg: COLORS.sand[100],
      fontSize: 9,
    });
  } else {
    // Variant B: Classic Header
    const classicHdr = b.frame({
      name: 'Variant B: Header Klasik',
      parent: bodyId,
      width: 390,
      height: 130,
      props: {
        fill: cardBg,
        cornerRadius: 20,
        stroke: borderCol,
        strokeWeight: 1,
        layout: 'vertical',
        gap: 10,
        padding: [14, 16, 14, 16],
        sizingH: 'fill',
        sizingV: 'fixed',
      },
    });
    const chTop = b.frame({
      name: 'Classic Header Row',
      parent: classicHdr,
      width: 358,
      height: 48,
      props: {
        fill: '#00000000',
        layout: 'horizontal',
        mainAlign: 'spaceBetween',
        crossAlign: 'center',
        sizingH: 'fill',
        sizingV: 'fixed',
      },
    });
    const chLeft = b.frame({
      name: 'Greeting & Phase',
      parent: chTop,
      width: 200,
      height: 46,
      props: { fill: '#00000000', layout: 'vertical', gap: 2 },
    });
    b.text({ parent: chLeft, text: '● FASE TAMYIZ • USIA 8 TH', props: { fontSize: 10, fontStyle: 'Bold', fill: pineCol } });
    b.text({ parent: chLeft, text: 'Ahlan, Abu Zaid', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 20, fill: textPri } });

    const chRight = b.frame({
      name: 'Classic Controls',
      parent: chTop,
      width: 140,
      height: 34,
      props: { fill: '#00000000', layout: 'horizontal', gap: 6, crossAlign: 'center' },
    });
    const btnNature = b.frame({
      name: 'Btn Switch to Nature Hero',
      parent: chRight,
      width: 68,
      height: 30,
      registerTrigger: `${screenKey}:toggle:layout`,
      props: { fill: pillBg, cornerRadius: 999, stroke: borderCol, strokeWeight: 1, layout: 'horizontal', mainAlign: 'center', crossAlign: 'center' },
    });
    b.text({ parent: btnNature, text: '🌲 Alam', props: { fontSize: 10, fontStyle: 'Bold', fill: pineCol } });

    const btnThemeC = b.frame({
      name: 'Btn Theme Toggle',
      parent: chRight,
      width: 32,
      height: 32,
      registerTrigger: `${screenKey}:toggle:theme`,
      props: { fill: pillBg, cornerRadius: 999, layout: 'horizontal', mainAlign: 'center', crossAlign: 'center' },
    });
    b.text({ parent: btnThemeC, text: '🌙', props: { fontSize: 12, fill: textPri } });

    const quoteBar = b.frame({
      name: 'Classic Quote Box',
      parent: classicHdr,
      width: 358,
      height: 44,
      registerTrigger: `${screenKey}:open:renungan`,
      props: { fill: subBg, cornerRadius: 12, stroke: borderCol, strokeWeight: 1, layout: 'horizontal', mainAlign: 'center', crossAlign: 'center', padding: [8, 12, 8, 12], sizingH: 'fill', sizingV: 'fixed' },
    });
    b.text({
      parent: quoteBar,
      text: '"Koneksi Sebelum Koreksi — Tautkan hati dan penuhi bejana cinta sebelum menegakkan aturan."',
      width: 334,
      props: { fontFamily: 'Merriweather', fontStyle: 'Italic', fontSize: 10, fill: textSec, textAlign: 'center' },
    });
  }

  // Integrated FTS5 Search Bar + PTT
  const searchBar = b.frame({
    name: 'FTS5 Search Bar + PTT Walkie-Talkie',
    parent: bodyId,
    width: 390,
    height: 44,
    props: {
      fill: cardBg,
      cornerRadius: 16,
      stroke: borderCol,
      strokeWeight: 1,
      layout: 'horizontal',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [8, 10, 8, 14],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({
    parent: searchBar,
    text: '🔍 Cari panduan adab, dalil, atau tips...',
    props: { fontSize: 11, fontStyle: 'Medium', fill: textMut },
  });
  const pttQuickBtn = b.frame({
    name: 'Btn PTT Search',
    parent: searchBar,
    width: 58,
    height: 28,
    registerTrigger: `${screenKey}:open:curhat-ptt`,
    props: {
      fill: dark ? COLORS.pine[950] : COLORS.pine[50],
      cornerRadius: 10,
      layout: 'horizontal',
      mainAlign: 'center',
      crossAlign: 'center',
    },
  });
  b.text({ parent: pttQuickBtn, text: '🎙️ PTT', props: { fontSize: 10, fontStyle: 'Bold', fill: pineCol } });

  // GOAL 1: PERTOLONGAN SITUASI NYATA (< 10 DETIK)
  const g1Sec = b.frame({
    name: 'Goal 1: Pertolongan Situasi Nyata (< 10 Detik)',
    parent: bodyId,
    width: 390,
    height: 126,
    props: { fill: '#00000000', layout: 'vertical', gap: 6, sizingH: 'fill', sizingV: 'hug' },
  });
  const g1Hdr = b.frame({
    name: 'Goal 1 Header',
    parent: g1Sec,
    width: 390,
    height: 18,
    props: { fill: '#00000000', layout: 'horizontal', mainAlign: 'spaceBetween', crossAlign: 'center', sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: g1Hdr, text: 'PERTOLONGAN SITUASI NYATA (< 10 DETIK)', props: { fontSize: 10, fontStyle: 'Bold', fill: textMut } });
  b.text({ parent: g1Hdr, text: 'Aksi Cepat', props: { fontSize: 10, fontStyle: 'Bold', fill: pineCol } });

  const g1Grid = b.frame({
    name: 'Emergency 2-Column Grid',
    parent: g1Sec,
    width: 390,
    height: 100,
    props: { fill: '#00000000', layout: 'horizontal', gap: 10, sizingH: 'fill', sizingV: 'fixed' },
  });

  const p3kCard = b.frame({
    name: 'Action Card 1: P3K Krisis Genting',
    parent: g1Grid,
    width: 190,
    height: 100,
    registerTrigger: `${screenKey}:open:p3k`,
    props: {
      fills: [{ type: 'linearGradient', stops: [COLORS.terracotta[500], COLORS.terracotta[600]] }],
      cornerRadius: 18,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [12, 14, 12, 14],
      sizingH: 'fixed',
      sizingV: 'fixed',
    },
  });
  b.badge({ parent: p3kCard, text: '🚨 P3K GENTING', bg: '#FFFFFF33', fg: COLORS.white, fontSize: 9 });
  b.text({ parent: p3kCard, text: 'P3K Krisis Genting\nAnak mengamuk & ortu burnout', width: 162, props: { fontSize: 12, fontStyle: 'Bold', fill: COLORS.white } });

  const curhatCard = b.frame({
    name: 'Action Card 2: Curhat Batin AI',
    parent: g1Grid,
    width: 190,
    height: 100,
    registerTrigger: `${screenKey}:open:curhat`,
    props: {
      fills: [{ type: 'linearGradient', stops: [COLORS.pine[600], COLORS.pine[700]] }],
      cornerRadius: 18,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [12, 14, 12, 14],
      sizingH: 'fixed',
      sizingV: 'fixed',
    },
  });
  b.badge({ parent: curhatCard, text: '🌿 RUANG QALBU', bg: '#FFFFFF33', fg: COLORS.white, fontSize: 9 });
  b.text({ parent: curhatCard, text: 'Curhat Batin AI\nBicara tanpa dihakimi', width: 162, props: { fontSize: 12, fontStyle: 'Bold', fill: COLORS.white } });

  // GOAL 2: AMALAN ADAB HARI INI (DAILY CADENCE)
  const g2Sec = b.frame({
    name: 'Goal 2: Amalan Adab Hari Ini',
    parent: bodyId,
    width: 390,
    height: 186,
    props: {
      fill: cardBg,
      cornerRadius: 22,
      stroke: borderCol,
      strokeWeight: 1,
      layout: 'vertical',
      gap: 8,
      padding: [14, 14, 14, 14],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  const g2Hdr = b.frame({
    name: 'Amalan Header',
    parent: g2Sec,
    width: 362,
    height: 24,
    props: { fill: '#00000000', layout: 'horizontal', mainAlign: 'spaceBetween', crossAlign: 'center', sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: g2Hdr, text: '☑️ Amalan Adab Hari Ini', props: { fontSize: 13, fontStyle: 'Bold', fill: textPri } });
  b.badge({ parent: g2Hdr, text: '1 dari 3 Selesai', bg: pillBg, fg: pineCol, fontSize: 10 });

  const tasks = [
    { done: true, title: '✓ Dekap Ananda Zaid 3 menit (Bahasa Hati)', sub: 'Tautkan kontak mata teduh sebelum bertanya PR' },
    { done: false, title: '☐ Tahan amarah & puasa lisan saat lelah', sub: "Kazhmul ghaizh (QS. Ali 'Imran: 134)" },
    { done: false, title: '☐ Dzikir sore & doa kelembutan kalbu anak', sub: "Munajat pengisian tangki cinta dari Allah Ta'ala" },
  ];
  for (const t of tasks) {
    const tRow = b.frame({
      name: t.title,
      parent: g2Sec,
      width: 362,
      height: 40,
      props: {
        fill: subBg,
        cornerRadius: 12,
        layout: 'vertical',
        mainAlign: 'center',
        padding: [6, 10, 6, 10],
        sizingH: 'fill',
        sizingV: 'fixed',
      },
    });
    b.text({
      parent: tRow,
      text: t.title,
      props: { fontSize: 11, fontStyle: 'Bold', fill: t.done ? textMut : textPri },
    });
    b.text({
      parent: tRow,
      text: t.sub,
      props: { fontSize: 9, fill: textMut },
    });
  }

  // AGENDA MAJELIS TERDEKAT (2 AGENDA VERTICAL STACK)
  const agendaSec = b.frame({
    name: 'Highlight Promosi Event Terdekat (2 Agenda)',
    parent: bodyId,
    width: 390,
    height: 232,
    props: { fill: '#00000000', layout: 'vertical', gap: 8, sizingH: 'fill', sizingV: 'fixed' },
  });
  const agHdr = b.frame({
    name: 'Agenda Header',
    parent: agendaSec,
    width: 390,
    height: 18,
    props: { fill: '#00000000', layout: 'horizontal', mainAlign: 'spaceBetween', crossAlign: 'center', sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: agHdr, text: 'AGENDA MAJELIS TERDEKAT • 2 AGENDA', props: { fontSize: 10, fontStyle: 'Bold', fill: textMut } });
  const seeAllEvent = b.frame({
    name: 'Link Lihat Semua Event',
    parent: agHdr,
    width: 85,
    height: 18,
    registerTrigger: `${screenKey}:open:event-all`,
    props: { fill: '#00000000', layout: 'horizontal', mainAlign: 'max', crossAlign: 'center' },
  });
  b.text({ parent: seeAllEvent, text: 'Lihat Semua ➔', props: { fontSize: 10, fontStyle: 'Bold', fill: pineCol } });

  const ag1 = b.frame({
    name: 'Agenda 1: Daurah Akbar (H-3)',
    parent: agendaSec,
    width: 390,
    height: 98,
    registerTrigger: `${screenKey}:open:event-1`,
    props: {
      fills: [{ type: 'linearGradient', stops: [COLORS.amber[600], COLORS.terracotta[500]] }],
      cornerRadius: 20,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [10, 14, 10, 14],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({ parent: ag1, text: '🔴 H-3 Menuju Majelis Akbar  •  Sabtu, 18 Okt', props: { fontSize: 9, fontStyle: 'Bold', fill: COLORS.sand[100] } });
  b.text({ parent: ag1, text: 'Daurah Akbar: Menumbuhkan Fitrah Keimanan Usia Tamyiz', width: 362, props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 11, fill: COLORS.white } });
  b.text({ parent: ag1, text: '🗣️ Ust. Abdul Kholiq, Lc. • Masjid SKIS Cikarang & Zoom • Daftar ➔', width: 362, props: { fontSize: 10, fill: COLORS.white } });

  const ag2 = b.frame({
    name: 'Agenda 2: Kajian Khusus Pasutri',
    parent: agendaSec,
    width: 390,
    height: 98,
    registerTrigger: `${screenKey}:open:event-2`,
    props: {
      fills: [{ type: 'linearGradient', stops: [COLORS.pine[700], COLORS.emerald[700]] }],
      cornerRadius: 20,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [10, 14, 10, 14],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({ parent: ag2, text: '🟡 Kajian Khusus Pasutri  •  Ahad, 26 Okt', props: { fontSize: 9, fontStyle: 'Bold', fill: COLORS.sand[100] } });
  b.text({ parent: ag2, text: 'Memulihkan Hutang Pengasuhan & Menyelaraskan Visi Ayah Bunda', width: 362, props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 11, fill: COLORS.white } });
  b.text({ parent: ag2, text: '🗣️ Ust. Bayu, S.Pd. & Ummu Khusna, M.Psi. • Online Zoom • Daftar ➔', width: 362, props: { fontSize: 10, fill: COLORS.white } });

  // REKOMENDASI AKTIVITAS (CAROUSEL PREVIEW)
  const rekSec = b.frame({
    name: 'Rekomendasi Aktivitas Carousel',
    parent: bodyId,
    width: 390,
    height: 132,
    props: { fill: '#00000000', layout: 'vertical', gap: 6, sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: rekSec, text: 'REKOMENDASI AKTIVITAS (GESER ➔)', props: { fontSize: 10, fontStyle: 'Bold', fill: textMut } });
  const rekRow = b.frame({
    name: 'Carousel Slides Row',
    parent: rekSec,
    width: 390,
    height: 108,
    props: { fill: '#00000000', layout: 'horizontal', gap: 10, sizingH: 'fill', sizingV: 'fixed' },
  });

  const slide1 = b.frame({
    name: 'Slide 1: Lanjutkan Modul Bab 3/5',
    parent: rekRow,
    width: 190,
    height: 108,
    registerTrigger: `${screenKey}:open:modul`,
    props: { fill: cardBg, cornerRadius: 16, stroke: borderCol, strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [10, 12, 10, 12], sizingH: 'fixed', sizingV: 'fixed' },
  });
  b.text({ parent: slide1, text: '📖 Bab 3/5 • 65%', props: { fontSize: 9, fontStyle: 'Bold', fill: pineCol } });
  b.text({ parent: slide1, text: 'Membangun Kedekatan Kalbu Sebelum Koreksi', width: 166, props: { fontSize: 11, fontStyle: 'Bold', fill: textPri } });
  b.badge({ parent: slide1, text: 'Lanjutkan Belajar ▶', bg: COLORS.pine[600], fg: COLORS.white, fontSize: 9 });

  const slide2 = b.frame({
    name: 'Slide 2: Hening Qalbu 3 Menit',
    parent: rekRow,
    width: 190,
    height: 108,
    registerTrigger: `${screenKey}:open:hening`,
    props: { fill: cardBg, cornerRadius: 16, stroke: borderCol, strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [10, 12, 10, 12], sizingH: 'fixed', sizingV: 'fixed' },
  });
  b.text({ parent: slide2, text: '🧘 Hening Qalbu • 3m', props: { fontSize: 9, fontStyle: 'Bold', fill: COLORS.amber[500] } });
  b.text({ parent: slide2, text: 'Latihan Resonansi Suara Rendah Sebelum Menegur', width: 166, props: { fontSize: 11, fontStyle: 'Bold', fill: textPri } });
  b.badge({ parent: slide2, text: 'Mulai Latihan Hening ⏱', bg: COLORS.amber[600], fg: COLORS.white, fontSize: 9 });

  // INSTRUMEN & UTILITAS PRAKTIS (6 TOMBOL LENGKAP — 2x3 GRID)
  const utilSec = b.frame({
    name: 'Instrumen & Utilitas Praktis (6 Fasilitas)',
    parent: bodyId,
    width: 390,
    height: 220,
    props: { fill: '#00000000', layout: 'vertical', gap: 8, sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: utilSec, text: 'INSTRUMEN & UTILITAS PRAKTIS (6 FASILITAS SIAP PAKAI)', props: { fontSize: 10, fontStyle: 'Bold', fill: textMut } });

  const utils = [
    [
      { key: 'rpp', badge: '📝 KBM Adab', title: 'Generator RPP', sub: 'Rencana aksi 1 lembar', col: pineCol },
      { key: 'modul-grid', badge: '📘 Kurikulum', title: 'Modul Harian', sub: 'Panduan mikro per fase', col: COLORS.blue[500] },
    ],
    [
      { key: 'doa', badge: '🤲 Munajat', title: 'Doa Penenang', sub: "Takhrij doa & wirid syar'i", col: COLORS.amber[500] },
      { key: 'tb40', badge: '🧭 TB-40', title: 'Tafsir Bakat 40', sub: 'Peta fitrah & 6 rumpun', col: COLORS.terracotta[500] },
    ],
    [
      { key: 'pustaka', badge: '📚 Pustaka', title: 'Pustaka Buku', sub: 'Buku fisik & e-book', col: COLORS.emerald[600] },
      { key: 'kemitraan', badge: '🏛️ Mitra', title: 'Kemitraan', sub: 'Coaching & visitasi', col: COLORS.purple[600] },
    ],
  ];

  for (const [rIdx, pair] of utils.entries()) {
    const uRow = b.frame({
      name: `Utility Row ${rIdx + 1}`,
      parent: utilSec,
      width: 390,
      height: 58,
      props: { fill: '#00000000', layout: 'horizontal', gap: 10, sizingH: 'fill', sizingV: 'fixed' },
    });
    for (const u of pair) {
      const uCard = b.frame({
        name: `Utility: ${u.title}`,
        parent: uRow,
        width: 190,
        height: 58,
        registerTrigger: `${screenKey}:open:${u.key}`,
        props: {
          fill: cardBg,
          cornerRadius: 14,
          stroke: borderCol,
          strokeWeight: 1,
          layout: 'vertical',
          mainAlign: 'spaceBetween',
          padding: [8, 12, 8, 12],
          sizingH: 'fixed',
          sizingV: 'fixed',
        },
      });
      b.text({ parent: uCard, text: `${u.badge}  •  ${u.title}`, props: { fontSize: 11, fontStyle: 'Bold', fill: textPri } });
      b.text({ parent: uCard, text: u.sub, props: { fontSize: 9, fill: textMut } });
    }
  }
}

export function buildMainScreensPage(b) {
  // =========================================================================
  // PAGE 4: 03 - MAIN APP SCREENS (5 TABS + THEME & LAYOUT VARIANTS)
  // =========================================================================
  b.addPage('03 - Main App Screens (Light & Dark)', '#0E1512');

  // Screen 1: Beranda — Variant A: Nature Tree Hero (Light Default)
  const s1 = b.mobileScreen({
    name: 'S01 • Tab 1: Beranda — Nature Hero (Light Default)',
    x: 0,
    y: 0,
    width: 430,
    height: 1410,
    dark: false,
    activeTab: 'beranda',
    registerScreen: 's01-beranda-nature',
  });
  populateBerandaBody(b, s1.bodyId, 's01-beranda-nature', { dark: false, classicHeader: false });

  // Screen 2: Beranda — Variant B: Classic Header (Light)
  const s2 = b.mobileScreen({
    name: 'S02 • Tab 1: Beranda — Classic Header Variant (Light)',
    x: 490,
    y: 0,
    width: 430,
    height: 1410,
    dark: false,
    activeTab: 'beranda',
    registerScreen: 's02-beranda-classic',
  });
  populateBerandaBody(b, s2.bodyId, 's02-beranda-classic', { dark: false, classicHeader: true });

  // Screen 3: Beranda — Tahajjud Dark Mode
  const s3 = b.mobileScreen({
    name: 'S03 • Tab 1: Beranda — Tahajjud Dark Mode',
    x: 980,
    y: 0,
    width: 430,
    height: 1410,
    dark: true,
    activeTab: 'beranda',
    registerScreen: 's03-beranda-dark',
  });
  populateBerandaBody(b, s3.bodyId, 's03-beranda-dark', { dark: true, classicHeader: false });

  // =========================================================================
  // Screen 4: Tab 2 — Event (Majelis & Daurah)
  // =========================================================================
  const s4 = b.mobileScreen({
    name: 'S04 • Tab 2: Event — Agenda Majelis & Daurah',
    x: 1470,
    y: 0,
    width: 430,
    height: 1410,
    dark: false,
    activeTab: 'event',
    registerScreen: 's04-event',
  });
  const evHdr = b.frame({
    name: 'Event Header',
    parent: s4.bodyId,
    width: 390,
    height: 54,
    props: { fill: '#00000000', layout: 'vertical', gap: 2, sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: evHdr, text: 'AGENDA TALAQQI', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.amber[600] } });
  b.text({ parent: evHdr, text: 'Majelis & Daurah', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 22, fill: COLORS.basalt[900] } });

  // Segmented Filter
  const segRow = b.frame({
    name: 'Segmented Filter (3 Tabs)',
    parent: s4.bodyId,
    width: 390,
    height: 40,
    props: {
      fill: COLORS.sand[200],
      cornerRadius: 14,
      layout: 'horizontal',
      gap: 6,
      padding: [4, 4, 4, 4],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  for (const [idx, tabLbl] of ['Akan Datang', 'Daftar Saya', 'Arsip Kajian'].entries()) {
    const segBtn = b.frame({
      name: `Filter: ${tabLbl}`,
      parent: segRow,
      width: 123,
      height: 32,
      props: {
        fill: idx === 0 ? COLORS.white : '#00000000',
        cornerRadius: 10,
        layout: 'horizontal',
        mainAlign: 'center',
        crossAlign: 'center',
      },
    });
    b.text({
      parent: segBtn,
      text: tabLbl,
      props: { fontSize: 11, fontStyle: 'Bold', fill: idx === 0 ? COLORS.pine[600] : COLORS.basalt[500] },
    });
  }

  const eventsData = [
    {
      tag: 'Daurah Nasional',
      tagBg: COLORS.pine[50],
      tagFg: COLORS.pine[600],
      date: 'Sabtu, 18 Okt 2026',
      title: 'Menumbuhkan Fitrah Keimanan Sebelum Usia Baligh',
      speaker: 'Pemateri: Ust. Abdul Kholiq & Tim Litbang Karakter SKIS',
      meta: 'Kapasitas: 500 Peserta • Masjid SKIS Cikarang & Zoom',
    },
    {
      tag: 'Kajian Khusus Pasutri',
      tagBg: COLORS.terracotta[50],
      tagFg: COLORS.terracotta[600],
      date: 'Ahad, 26 Okt 2026',
      title: 'Memulihkan Hutang Pengasuhan & Menyelaraskan Visi Ayah Bunda',
      speaker: 'Pemateri: Ust. Bayu & Ummu Khusna',
      meta: 'Online Zoom Only • Eksklusif Pasutri',
    },
    {
      tag: 'Workshop Kurikulum SOTAB',
      tagBg: COLORS.amber[50],
      tagFg: COLORS.amber[600],
      date: 'Sabtu, 07 Nov 2026',
      title: 'Praktik Penyusunan RPP Adab 1 Lembar & Living Rehearsal KBM',
      speaker: 'Pemateri: Ust. Bayu, S.Pd., M.Ed. & Dewan Guru SOTAB',
      meta: 'Depok & Live Streaming • 28 Sekolah Mitra',
    },
  ];

  for (const ev of eventsData) {
    const evCard = b.frame({
      name: `Event: ${ev.title.slice(0, 28)}`,
      parent: s4.bodyId,
      width: 390,
      height: 156,
      props: {
        fill: COLORS.white,
        cornerRadius: 20,
        stroke: COLORS.sand[200],
        strokeWeight: 1,
        layout: 'vertical',
        mainAlign: 'spaceBetween',
        padding: [16, 16, 16, 16],
        sizingH: 'fill',
        sizingV: 'fixed',
      },
    });
    const topR = b.frame({
      name: 'Top Row',
      parent: evCard,
      width: 358,
      height: 22,
      props: { fill: '#00000000', layout: 'horizontal', mainAlign: 'spaceBetween', crossAlign: 'center', sizingH: 'fill', sizingV: 'fixed' },
    });
    b.badge({ parent: topR, text: ev.tag, bg: ev.tagBg, fg: ev.tagFg, fontSize: 10 });
    b.text({ parent: topR, text: ev.date, props: { fontSize: 11, fill: COLORS.basalt[400] } });

    b.text({ parent: evCard, text: ev.title, width: 358, props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 14, fill: COLORS.basalt[900] } });
    b.text({ parent: evCard, text: ev.speaker, width: 358, props: { fontSize: 11, fill: COLORS.basalt[500] } });

    const botR = b.frame({
      name: 'Bottom Row',
      parent: evCard,
      width: 358,
      height: 30,
      props: { fill: '#00000000', layout: 'horizontal', mainAlign: 'spaceBetween', crossAlign: 'center', sizingH: 'fill', sizingV: 'fixed' },
    });
    b.text({ parent: botR, text: ev.meta, props: { fontSize: 10, fill: COLORS.basalt[400] } });
    b.badge({ parent: botR, text: 'Daftar ➔', bg: COLORS.pine[600], fg: COLORS.white, fontSize: 10, padding: [6, 12, 6, 12], radius: 8 });
  }

  // =========================================================================
  // Screen 5: Tab 3 — Materi (Wiki & Direktori Bento)
  // =========================================================================
  const s5 = b.mobileScreen({
    name: 'S05 • Tab 3: Materi — Wiki & Direktori Bento',
    x: 1960,
    y: 0,
    width: 430,
    height: 1410,
    dark: false,
    activeTab: 'materi',
    registerScreen: 's05-materi',
  });

  const matHdr = b.frame({
    name: 'Wiki Header',
    parent: s5.bodyId,
    width: 390,
    height: 52,
    props: { fill: '#00000000', layout: 'vertical', gap: 2, sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: matHdr, text: 'PUSAT KHAZANAH & DIREKTORI', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.pine[600] } });
  b.text({ parent: matHdr, text: 'Wiki & Direktori', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 22, fill: COLORS.basalt[900] } });

  // Search + Micro Filter Pills
  const wikiSearch = b.frame({
    name: 'Wiki Search Input',
    parent: s5.bodyId,
    width: 390,
    height: 40,
    props: { fill: COLORS.white, cornerRadius: 14, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'horizontal', crossAlign: 'center', padding: [8, 14, 8, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: wikiSearch, text: '🔍 Cari 6 pilar, asatidzah, lembaga, istilah...', props: { fontSize: 11, fill: COLORS.basalt[400] } });

  const pillRow = b.frame({
    name: 'Micro Filter Pills',
    parent: s5.bodyId,
    width: 390,
    height: 28,
    props: { fill: '#00000000', layout: 'horizontal', gap: 6, sizingH: 'fill', sizingV: 'fixed' },
  });
  for (const [idx, pLbl] of ['Semua', '6 Pilar Fitrah', 'Tokoh Asatidzah', 'Lembaga Mitra', 'Pustaka'].entries()) {
    b.badge({
      parent: pillRow,
      text: pLbl,
      bg: idx === 0 ? COLORS.pine[600] : COLORS.sand[100],
      fg: idx === 0 ? COLORS.white : COLORS.basalt[600],
      fontSize: 10,
    });
  }

  // 1. Bento Box Grid: Khazanah Utama
  const bentoHero = b.frame({
    name: 'Bento 1: Indeks 6 Pilar Fitrah Nabawiyah (Hero Tile)',
    parent: s5.bodyId,
    width: 390,
    height: 146,
    registerTrigger: 's05-materi:open:pilar',
    props: {
      fills: [{ type: 'linearGradient', stops: [COLORS.pine[900], COLORS.pine[800], COLORS.basalt[900]] }],
      cornerRadius: 24,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [14, 16, 14, 16],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.badge({ parent: bentoHero, text: '🟢 FONDASI UTAMA PKN • 110 RUJUKAN', bg: '#FFFFFF26', fg: COLORS.pine[200], fontSize: 9 });
  b.text({ parent: bentoHero, text: 'Indeks 6 Pilar Fitrah Nabawiyah', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 16, fill: COLORS.white } });
  b.text({
    parent: bentoHero,
    text: "Hierarki pengasuhan: Iman & Rububiyyah, Belajar & Nalar, Bakat & Kepemimpinan, Jasmani, Perkembangan Usia, dan Seksualitas Syar'i.",
    width: 358,
    props: { fontSize: 10, fill: COLORS.sand[200] },
  });
  b.text({ parent: bentoHero, text: '[Tauhid]  [TB-40]  [Tamyiz]   •   Telusuri Pilar ➔', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.pine[300] } });

  const bentoSubRow = b.frame({
    name: 'Bento Sub Row (Glosarium & Media)',
    parent: s5.bodyId,
    width: 390,
    height: 88,
    props: { fill: '#00000000', layout: 'horizontal', gap: 10, sizingH: 'fill', sizingV: 'fixed' },
  });
  const bGlos = b.frame({
    name: 'Bento 2: Glosarium Syakilah',
    parent: bentoSubRow,
    width: 190,
    height: 88,
    props: { fill: COLORS.white, cornerRadius: 18, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [12, 14, 12, 14], sizingH: 'fixed', sizingV: 'fixed' },
  });
  b.badge({ parent: bGlos, text: '🔤 42 ISTILAH', bg: COLORS.amber[50], fg: COLORS.amber[600], fontSize: 9 });
  b.text({ parent: bGlos, text: "Glosarium Syakilah\nKamus terminologi syar'i", width: 162, props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.basalt[900] } });

  const bMed = b.frame({
    name: 'Bento 3: Media & Riset',
    parent: bentoSubRow,
    width: 190,
    height: 88,
    props: { fill: COLORS.white, cornerRadius: 18, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [12, 14, 12, 14], sizingH: 'fixed', sizingV: 'fixed' },
  });
  b.badge({ parent: bMed, text: '🎬 4 FORMAT', bg: COLORS.blue[50], fg: COLORS.blue[600], fontSize: 9 });
  b.text({ parent: bMed, text: 'Media & Riset\nArtikel, audio, RPP, video', width: 162, props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.basalt[900] } });

  // 2. Carousel Tokoh Asatidzah PKN
  const tokSec = b.frame({
    name: 'Section: Tokoh Asatidzah & Pakar Pembina',
    parent: s5.bodyId,
    width: 390,
    height: 150,
    props: { fill: '#00000000', layout: 'vertical', gap: 6, sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: tokSec, text: 'TOKOH ASATIDZAH & PAKAR PEMBINA (4 NARASUMBER)', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.basalt[400] } });
  const tokRow = b.frame({
    name: 'Tokoh Cards Row',
    parent: tokSec,
    width: 390,
    height: 126,
    props: { fill: '#00000000', layout: 'horizontal', gap: 10, sizingH: 'fill', sizingV: 'fixed' },
  });
  const tokohList = [
    { role: 'Dewan Pembina', name: 'Ust. Abdul Kholiq, Lc.', sub: 'Pengasuh Kuttab & SKIS', fokus: 'Fokus: Fitrah Iman & Manhaj\nKarya: Tiga Bahasa Mendidik' },
    { role: 'Litbang Kurikulum', name: 'Ust. Bayu, S.Pd., M.Ed.', sub: 'Kepala Riset SOTAB', fokus: 'Fokus: Living Rehearsal KBM\nKarya: 19 Butir & RPP 1 Lembar' },
  ];
  for (const tk of tokohList) {
    const tkCard = b.frame({
      name: `Tokoh: ${tk.name}`,
      parent: tokRow,
      width: 190,
      height: 126,
      registerTrigger: 's05-materi:open:tokoh',
      props: { fill: COLORS.white, cornerRadius: 16, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [10, 12, 10, 12], sizingH: 'fixed', sizingV: 'fixed' },
    });
    b.badge({ parent: tkCard, text: tk.role, bg: COLORS.pine[50], fg: COLORS.pine[600], fontSize: 8 });
    b.text({ parent: tkCard, text: `${tk.name}\n${tk.sub}`, width: 166, props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.basalt[900] } });
    b.text({ parent: tkCard, text: tk.fokus, width: 166, props: { fontSize: 9, fill: COLORS.basalt[600] } });
  }

  // 3. Carousel Lembaga Mitra PKN
  const lemSec = b.frame({
    name: 'Section: Jaringan Lembaga Mitra',
    parent: s5.bodyId,
    width: 390,
    height: 140,
    props: { fill: '#00000000', layout: 'vertical', gap: 6, sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: lemSec, text: 'JARINGAN LEMBAGA MITRA (SKIS • SOTAB • HU • DARUL ATSAR)', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.basalt[400] } });
  const lemRow = b.frame({
    name: 'Lembaga Cards Row',
    parent: lemSec,
    width: 390,
    height: 116,
    props: { fill: '#00000000', layout: 'horizontal', gap: 10, sizingH: 'fill', sizingV: 'fixed' },
  });
  const lemList = [
    { tag: 'Model Full-Day', name: 'SKIS (Karakter Insan Sholih)', loc: 'Cikarang & Bekasi • 450+ Santri', desc: 'Laboratorium adab & fitrah iman TK & Kuttab.' },
    { tag: 'Litbang KBM', name: 'SOTAB (Talent & Adab Based)', loc: 'Depok & Bogor • 28 Sekolah', desc: 'Pusat kurikulum RPP 1 lembar & simulasi RPG.' },
  ];
  for (const lm of lemList) {
    const lmCard = b.frame({
      name: `Lembaga: ${lm.name}`,
      parent: lemRow,
      width: 190,
      height: 116,
      registerTrigger: 's05-materi:open:tokoh',
      props: { fill: COLORS.white, cornerRadius: 16, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [10, 12, 10, 12], sizingH: 'fixed', sizingV: 'fixed' },
    });
    b.badge({ parent: lmCard, text: lm.tag, bg: COLORS.purple[50], fg: COLORS.purple[600], fontSize: 8 });
    b.text({ parent: lmCard, text: `${lm.name}\n${lm.loc}`, width: 166, props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.basalt[900] } });
    b.text({ parent: lmCard, text: lm.desc, width: 166, props: { fontSize: 9, fill: COLORS.basalt[500] } });
  }

  // 4. Pustaka Buku & Artikel Pilihan
  const artSec = b.frame({
    name: 'Section: Pustaka Buku & Artikel Riset Terkini',
    parent: s5.bodyId,
    width: 390,
    height: 220,
    props: { fill: '#00000000', layout: 'vertical', gap: 8, sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: artSec, text: 'PUSTAKA BUKU & ARTIKEL RISET TERKINI', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.basalt[400] } });

  const art1 = b.frame({
    name: 'Artikel 1: Tiga Bahasa Mendidik',
    parent: artSec,
    width: 390,
    height: 88,
    props: { fill: COLORS.white, cornerRadius: 16, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [10, 14, 10, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: art1, text: 'Manhaj PKN • 4 Menit Baca  •  Ust. Abdul Kholiq (240 Hal)', props: { fontSize: 9, fontStyle: 'Bold', fill: COLORS.pine[600] } });
  b.text({ parent: art1, text: 'Tiga Bahasa Mendidik: Hati, Lisan, dan Tangan Terukur', width: 362, props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 12, fill: COLORS.basalt[900] } });
  b.text({ parent: art1, text: 'Hirarki penerapan nabawiyah dari usia 0–7 tahun (Thufulah) hingga 10–14 tahun (Murahaqah).', width: 362, props: { fontSize: 10, fill: COLORS.basalt[500] } });

  const art2 = b.frame({
    name: 'Artikel 2: Membasuh Luka Pengasuhan',
    parent: artSec,
    width: 390,
    height: 88,
    props: { fill: COLORS.white, cornerRadius: 16, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [10, 14, 10, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: art2, text: 'Tazkiyatun Nafs • 6 Menit Baca  •  Ust. Ahmad Ridwan (195 Hal)', props: { fontSize: 9, fontStyle: 'Bold', fill: COLORS.terracotta[600] } });
  b.text({ parent: art2, text: 'Membasuh Luka Pengasuhan: Pendidik atau Luka yang Mengajar?', width: 362, props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 12, fill: COLORS.basalt[900] } });
  b.text({ parent: art2, text: 'Muhasabah bejana batin orang tua agar tidak menumpahkan amarah masa kecil kepada anak.', width: 362, props: { fontSize: 10, fill: COLORS.basalt[500] } });

  // =========================================================================
  // Screen 6: Tab 4 — Curhat (Ruang Qalbu & E2EE Chat)
  // =========================================================================
  const s6 = b.mobileScreen({
    name: 'S06 • Tab 4: Curhat — Ruang Qalbu & PTT E2EE',
    x: 2450,
    y: 0,
    width: 430,
    height: 1410,
    dark: false,
    activeTab: 'curhat',
    registerScreen: 's06-curhat',
  });

  const curHdr = b.frame({
    name: 'Curhat Header',
    parent: s6.bodyId,
    width: 390,
    height: 54,
    props: { fill: '#00000000', layout: 'vertical', gap: 2, sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: curHdr, text: "PENDAMPINGAN BATIN SYAR'I", props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.pine[600] } });
  b.text({ parent: curHdr, text: 'Ruang Qalbu', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 22, fill: COLORS.basalt[900] } });

  // E2EE Privacy Banner
  const e2eeBox = b.frame({
    name: 'Privacy Assurance E2EE Banner',
    parent: s6.bodyId,
    width: 390,
    height: 68,
    props: {
      fill: COLORS.pine[50],
      cornerRadius: 18,
      stroke: COLORS.pine[200],
      strokeWeight: 1,
      layout: 'horizontal',
      crossAlign: 'center',
      gap: 10,
      padding: [12, 14, 12, 14],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({
    parent: e2eeBox,
    text: '🔒 Privasi E2EE & Suara Ephemeral: Rekaman suara langsung dihapus begitu teks dibuat. Admin server sama sekali tidak bisa membaca curhat Anda.',
    width: 362,
    props: { fontSize: 11, fontStyle: 'Medium', fill: COLORS.pine[800], lineHeight: 16 },
  });

  // Chat Bubble 1: AI Greeting
  const chat1 = b.frame({
    name: 'AI Message 09:15',
    parent: s6.bodyId,
    width: 350,
    height: 82,
    props: {
      fill: COLORS.white,
      cornerRadius: 18,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [12, 14, 12, 14],
      sizingH: 'fixed',
      sizingV: 'fixed',
    },
  });
  b.text({
    parent: chat1,
    text: "Q • Assalamu'alaykum Abu Zaid. Bagaimana bejana hatimu hari ini? Apakah ada kepenatan pengasuhan yang ingin dicurahkan?",
    width: 322,
    props: { fontSize: 11, fill: COLORS.basalt[800], lineHeight: 16 },
  });
  b.text({ parent: chat1, text: '09:15', props: { fontSize: 9, fill: COLORS.basalt[400] } });

  // Chat Bubble 2: User Message
  const chat2 = b.frame({
    name: 'User Message 09:17',
    parent: s6.bodyId,
    width: 350,
    height: 84,
    props: {
      fill: COLORS.pine[600],
      cornerRadius: 18,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [12, 14, 12, 14],
      sizingH: 'fixed',
      sizingV: 'fixed',
    },
  });
  b.text({
    parent: chat2,
    text: 'Tadi pagi saya hampir membentak Zaid karena ia menumpahkan susu saat saya sedang tergesa-gesa berangkat kerja...',
    width: 322,
    props: { fontSize: 11, fill: COLORS.white, lineHeight: 16 },
  });
  b.text({ parent: chat2, text: '09:17', props: { fontSize: 9, fill: COLORS.pine[100] } });

  // Chat Bubble 3: AI Tazkiyah Response + Doa Attachment
  const chat3 = b.frame({
    name: 'AI Response 09:18',
    parent: s6.bodyId,
    width: 360,
    height: 138,
    props: {
      fill: COLORS.white,
      cornerRadius: 18,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [12, 14, 12, 14],
      sizingH: 'fixed',
      sizingV: 'fixed',
    },
  });
  b.text({
    parent: chat3,
    text: 'Q • Alhamdulillah Anda mampu menahannya. Ingatlah bahwa tumpahnya susu adalah peristiwa lahiriah, sedangkan respon tenang Anda adalah pahala tazkiyah di sisi Allah.',
    width: 332,
    props: { fontSize: 11, fill: COLORS.basalt[800], lineHeight: 16 },
  });
  const doaAttach = b.frame({
    name: 'Pinned Doa Chip',
    parent: chat3,
    width: 332,
    height: 34,
    registerTrigger: 's06-curhat:open:doa',
    props: {
      fill: COLORS.sand[50],
      cornerRadius: 10,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'horizontal',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [6, 10, 6, 10],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({ parent: doaAttach, text: '🤲 Doa Penenang Marah disematkan', props: { fontSize: 10, fontStyle: 'Medium', fill: COLORS.basalt[800] } });
  b.text({ parent: doaAttach, text: 'Sematkan ➔', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.pine[600] } });

  // Walkie-Talkie Trigger Button
  b.button({
    parent: s6.bodyId,
    label: '🎙️ Mulai Bicara dengan Walkie-Talkie (PTT)',
    bg: COLORS.pine[600],
    fg: COLORS.white,
    width: 'fill',
    height: 48,
    radius: 16,
    fontSize: 12,
    registerTrigger: 's06-curhat:open:ptt',
  });

  // =========================================================================
  // Screen 7: Tab 5 — Profil (Identitas, Relasi & E2EE)
  // =========================================================================
  const s7 = b.mobileScreen({
    name: 'S07 • Tab 5: Profil — Identitas, Relasi Keluarga & TB-40',
    x: 2940,
    y: 0,
    width: 430,
    height: 1410,
    dark: false,
    activeTab: 'profil',
    registerScreen: 's07-profil',
  });

  const prHdr = b.frame({
    name: 'Profil Header',
    parent: s7.bodyId,
    width: 390,
    height: 54,
    props: { fill: '#00000000', layout: 'vertical', gap: 2, sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: prHdr, text: 'PUSAT AKUN', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.pine[600] } });
  b.text({ parent: prHdr, text: 'Profil Pengguna', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 22, fill: COLORS.basalt[900] } });

  // User Identity Card
  const idCard = b.frame({
    name: 'User Identity Card',
    parent: s7.bodyId,
    width: 390,
    height: 96,
    props: {
      fill: COLORS.white,
      cornerRadius: 24,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'horizontal',
      crossAlign: 'center',
      gap: 14,
      padding: [16, 16, 16, 16],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  const avCircle = b.frame({
    name: 'Avatar Circle',
    parent: idCard,
    width: 56,
    height: 56,
    props: { fill: COLORS.pine[600], cornerRadius: 999, stroke: COLORS.pine[400], strokeWeight: 2, layout: 'horizontal', mainAlign: 'center', crossAlign: 'center' },
  });
  b.text({ parent: avCircle, text: 'AZ', props: { fontSize: 18, fontStyle: 'Bold', fill: COLORS.white } });

  const idInfo = b.frame({
    name: 'Identity Details',
    parent: idCard,
    width: 280,
    height: 64,
    props: { fill: '#00000000', layout: 'vertical', mainAlign: 'spaceBetween' },
  });
  b.text({ parent: idInfo, text: 'Abu Zaid (Ahmad)', props: { fontSize: 15, fontStyle: 'Bold', fill: COLORS.basalt[900] } });
  b.text({ parent: idInfo, text: 'Peran: Ayah & Pengurus Sekolah', props: { fontSize: 11, fill: COLORS.basalt[400] } });
  b.badge({ parent: idInfo, text: '🔐 Akun Terenkripsi E2EE', bg: COLORS.pine[50], fg: COLORS.pine[600], fontSize: 10 });

  // Lingkaran Relasi Keluarga
  const relCard = b.frame({
    name: 'Lingkaran Relasi Keluarga (Anti-Guilt)',
    parent: s7.bodyId,
    width: 390,
    height: 126,
    props: {
      fill: COLORS.white,
      cornerRadius: 20,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [14, 16, 14, 16],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({ parent: relCard, text: 'LINGKARAN RELASI KELUARGA', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.basalt[400] } });
  const r1 = b.frame({
    name: 'Relasi 1: Ananda Zaid',
    parent: relCard,
    width: 358,
    height: 36,
    props: { fill: COLORS.sand[50], cornerRadius: 10, layout: 'horizontal', mainAlign: 'spaceBetween', crossAlign: 'center', padding: [6, 12, 6, 12], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: r1, text: 'Ananda Zaid (8 Th • Tamyiz)', props: { fontSize: 12, fontStyle: 'Bold', fill: COLORS.basalt[800] } });
  b.badge({ parent: r1, text: 'Penuh Kehangatan', bg: COLORS.pine[50], fg: COLORS.pine[600], fontSize: 10 });

  const r2 = b.frame({
    name: 'Relasi 2: Ummu Zaid',
    parent: relCard,
    width: 358,
    height: 36,
    props: { fill: COLORS.sand[50], cornerRadius: 10, layout: 'horizontal', mainAlign: 'spaceBetween', crossAlign: 'center', padding: [6, 12, 6, 12], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: r2, text: 'Ummu Zaid (Pasangan)', props: { fontSize: 12, fontStyle: 'Bold', fill: COLORS.basalt[800] } });
  b.badge({ parent: r2, text: 'Saling Menguatkan', bg: COLORS.pine[50], fg: COLORS.pine[600], fontSize: 10 });

  // Cermin Bakat Fitrah (TB-40)
  const tbCard = b.frame({
    name: 'Cermin Bakat Fitrah (TB-40)',
    parent: s7.bodyId,
    width: 390,
    height: 124,
    registerTrigger: 's07-profil:open:tb40',
    props: {
      fill: COLORS.white,
      cornerRadius: 20,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [14, 16, 14, 16],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({ parent: tbCard, text: 'CERMIN BAKAT FITRAH (TB-40)', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.basalt[400] } });
  b.text({ parent: tbCard, text: 'Bakat Dominan Diri:  Al-Qiyadah & Hikmah', props: { fontSize: 13, fontStyle: 'Bold', fill: COLORS.pine[600] } });
  b.text({
    parent: tbCard,
    text: "Kuatkan kelebihan dominan, pelihara kekurangan pada batas minimal fardhu 'ain. Ketuk untuk membuka peta 6 rumpun TB-40.",
    width: 358,
    props: { fontSize: 11, fill: COLORS.basalt[500] },
  });
}
