import { COLORS } from './design_tokens.mjs';

export function buildSystemAndComponentsPages(b) {
  // =========================================================================
  // 1. MULTI-MODE DESIGN VARIABLES (EARTH-TREE LIGHT & TAHAJJUD DARK)
  // =========================================================================
  b.cmd('variable.createCollection', {
    name: 'Earth-Tree Theme',
    modes: ['Light (Warm Sand)', 'Dark (Tahajjud)'],
  });

  const semanticVars = [
    { name: 'bg/canvas', light: COLORS.sand[50], dark: COLORS.basalt[950] },
    { name: 'bg/surface-card', light: COLORS.white, dark: COLORS.basalt[900] },
    { name: 'bg/surface-subtle', light: COLORS.sand[100], dark: COLORS.basalt[800] },
    { name: 'bg/dock-frosted', light: COLORS.white, dark: COLORS.basalt[900] },
    { name: 'text/primary', light: COLORS.basalt[900], dark: COLORS.sand[50] },
    { name: 'text/secondary', light: COLORS.basalt[600], dark: COLORS.sand[300] },
    { name: 'text/muted', light: COLORS.basalt[400], dark: COLORS.sand[400] },
    { name: 'border/subtle', light: COLORS.sand[200], dark: COLORS.basalt[800] },
    { name: 'brand/pine-primary', light: COLORS.pine[600], dark: COLORS.pine[500] },
    { name: 'brand/pine-tint', light: COLORS.pine[50], dark: COLORS.pine[950] },
    { name: 'crisis/terracotta', light: COLORS.terracotta[500], dark: COLORS.terracotta[600] },
    { name: 'crisis/red-urgent', light: COLORS.red[600], dark: COLORS.red[500] },
    { name: 'accent/amber-gold', light: COLORS.amber[500], dark: COLORS.amber[400] },
  ];

  for (const v of semanticVars) {
    b.cmd('variable.create', {
      collection: 'Earth-Tree Theme',
      name: v.name,
      type: 'color',
      values: {
        'Light (Warm Sand)': v.light,
        'Dark (Tahajjud)': v.dark,
      },
    });
  }

  // Spacing & Radius numeric tokens
  b.cmd('variable.createCollection', {
    name: 'Layout & Radius Tokens',
    modes: ['Mobile (430px)'],
  });
  const numericVars = [
    { name: 'radius/card-sm', val: 12 },
    { name: 'radius/card-md', val: 16 },
    { name: 'radius/card-lg', val: 24 },
    { name: 'radius/sheet-xl', val: 32 },
    { name: 'radius/device', val: 44 },
    { name: 'space/page-padding', val: 20 },
    { name: 'space/section-gap', val: 20 },
    { name: 'space/card-gap', val: 12 },
  ];
  for (const nv of numericVars) {
    b.cmd('variable.create', {
      collection: 'Layout & Radius Tokens',
      name: nv.name,
      type: 'number',
      value: nv.val,
    });
  }

  // =========================================================================
  // PAGE 1: 00 - COVER & ARCHITECTURE OVERVIEW
  // =========================================================================
  b.renameInitialPage('00 - Cover & Architecture', '#0B1310');

  const coverId = b.frame({
    name: 'PKN Mobile v2 — Project Cover & Interactive Architecture',
    x: 0,
    y: 0,
    width: 1600,
    height: 960,
    props: {
      fills: [
        {
          type: 'linearGradient',
          stops: ['#052412', '#12120E', '#1C1C17'],
        },
      ],
      cornerRadius: 40,
      stroke: COLORS.pine[700],
      strokeWeight: 2,
      layout: 'vertical',
      gap: 32,
      padding: [56, 64, 56, 64],
      clip: true,
    },
  });

  // Top Header Row
  const coverTop = b.frame({
    name: 'Cover Header Badges',
    parent: coverId,
    width: 1472,
    height: 40,
    props: {
      fill: '#00000000',
      layout: 'horizontal',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      sizingH: 'fill',
      sizingV: 'hug',
    },
  });
  b.badge({
    parent: coverTop,
    text: 'PENDIDIKAN KARAKTER NABAWIYAH (PKN) • MOBILE V2.0',
    bg: COLORS.pine[900],
    fg: COLORS.pine[300],
    fontSize: 12,
    padding: [8, 16, 8, 16],
  });
  b.badge({
    parent: coverTop,
    text: '20 INTERACTIVE SCREENS • 5 PAGES • LIGHT & TAHAJJUD DARK MODE',
    bg: COLORS.terracotta[900],
    fg: COLORS.amber[300],
    fontSize: 12,
    padding: [8, 16, 8, 16],
  });

  // Hero Title & Tagline
  const titleBlock = b.frame({
    name: 'Hero Title Block',
    parent: coverId,
    width: 1472,
    height: 180,
    props: {
      fill: '#00000000',
      layout: 'vertical',
      gap: 12,
      sizingH: 'fill',
      sizingV: 'hug',
    },
  });
  b.text({
    parent: titleBlock,
    text: 'PKN Mobile v2 — Interactive Design System & Full Prototype',
    props: {
      fontFamily: 'Merriweather',
      fontStyle: 'Bold',
      fontSize: 42,
      fill: COLORS.sand[50],
    },
  });
  b.text({
    parent: titleBlock,
    text: '“Koneksi Sebelum Koreksi — Tautkan hati dan penuhi bejana cinta sebelum menegakkan aturan.”',
    props: {
      fontFamily: 'Merriweather',
      fontStyle: 'Italic',
      fontSize: 22,
      fill: COLORS.amber[300],
    },
  });
  b.text({
    parent: titleBlock,
    text: 'Source Prototype: http://100.118.34.69:3018/ • Built with OpenPencil (.fig) & FigCraft (.figcraft) • Goal-Directed Launchpad, Smart P3K 2-Phase Triage, Bento Wiki & E2EE Ruang Qalbu',
    props: {
      fontFamily: 'Plus Jakarta Sans',
      fontStyle: 'Medium',
      fontSize: 15,
      fill: COLORS.sand[300],
    },
  });

  // 4 Architecture Pillar Cards on Cover
  const archGrid = b.frame({
    name: 'Architecture Pillars Grid',
    parent: coverId,
    width: 1472,
    height: 280,
    props: {
      fill: '#00000000',
      layout: 'horizontal',
      gap: 20,
      sizingH: 'fill',
      sizingV: 'hug',
    },
  });

  const archItems = [
    {
      badge: 'PAGE 01 & 02',
      title: 'Earth-Tree Design System & Tokens',
      desc: 'Warm Sand (#FDFBF7), Basalt (#12120E), Deep Pine (#006D30), Terracotta (#C05621), Amber Gold (#D97706).\nTypography: Plus Jakarta Sans, Merriweather Serif, Amiri Arabic.',
      accent: COLORS.pine[500],
      bg: COLORS.basalt[900],
    },
    {
      badge: 'PAGE 03 (7 SCREENS)',
      title: '5 Main Navigation Tabs (Jakob’s Law)',
      desc: '1. Beranda (Nature Tree Hero + Classic Header + Dark Mode)\n2. Event (Agenda Majelis & Daurah)\n3. Materi (Wiki Bento & 3 Carousels)\n4. Curhat (Ruang Qalbu E2EE)\n5. Profil (Identitas, Relasi & TB-40)',
      accent: COLORS.amber[500],
      bg: COLORS.basalt[900],
    },
    {
      badge: 'PAGE 04 (13 SCREENS)',
      title: 'Smart P3K 2-Phase Crisis & Modals',
      desc: '• P3K Genting: Mode Anak Mengamuk & Mode Ortu (60s Breath)\n• P3K Stabil: Debrief & Munajat Anak & Ortu (HALT)\n• Mode Renungan Full-Screen Tadabbur & Clock\n• Walkie-Talkie PTT, RPP 1 Lembar, Modul, Doa, TB-40, Hening, 6 Pilar, Tokoh & Mitra',
      accent: COLORS.terracotta[500],
      bg: COLORS.basalt[900],
    },
    {
      badge: 'PROTOTYPE ENGINE',
      title: 'Full Interactive Wiring & Flows',
      desc: '• 5-Tab Bottom Dock navigation across all screens\n• Emergency <10s triggers to P3K Triage & PTT Modal\n• Dual Triage Switcher (Anak ⇄ Ortu) & Genting ➔ Stabil transitions\n• Theme Toggle (Light ⇄ Tahajjud Dark) & Layout Toggle (Nature ⇄ Classic)',
      accent: COLORS.blue[500],
      bg: COLORS.basalt[900],
    },
  ];

  for (const item of archItems) {
    const cId = b.frame({
      name: item.title,
      parent: archGrid,
      width: 353,
      height: 260,
      props: {
        fill: item.bg,
        cornerRadius: 24,
        stroke: item.accent,
        strokeWeight: 1.5,
        layout: 'vertical',
        gap: 12,
        padding: [24, 24, 24, 24],
        sizingH: 'fixed',
        sizingV: 'fixed',
      },
    });
    b.badge({
      parent: cId,
      text: item.badge,
      bg: item.accent,
      fg: COLORS.white,
      fontSize: 10,
    });
    b.text({
      parent: cId,
      text: item.title,
      width: 305,
      props: {
        fontFamily: 'Merriweather',
        fontStyle: 'Bold',
        fontSize: 18,
        fill: COLORS.sand[50],
      },
    });
    b.text({
      parent: cId,
      text: item.desc,
      width: 305,
      props: {
        fontFamily: 'Plus Jakarta Sans',
        fontStyle: 'Regular',
        fontSize: 12,
        lineHeight: 18,
        fill: COLORS.sand[300],
      },
    });
  }

  // Bottom Inventory Bar on Cover
  const footerBar = b.frame({
    name: 'Prototype Screen Inventory Summary',
    parent: coverId,
    width: 1472,
    height: 84,
    props: {
      fill: COLORS.pine[950],
      cornerRadius: 20,
      stroke: COLORS.pine[800],
      strokeWeight: 1,
      layout: 'horizontal',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [20, 28, 20, 28],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({
    parent: footerBar,
    text: 'Screen Matrix: S01 Beranda (Nature) • S02 Beranda (Classic) • S03 Beranda (Dark) • S04 Event • S05 Materi/Wiki • S06 Curhat • S07 Profil • S08 P3K Anak (Genting) • S09 P3K Ortu (Genting) • S10 P3K Anak (Stabil) • S11 P3K Ortu (Stabil) • S12 PTT Walkie-Talkie • S13 Mode Renungan • S14 RPP 1 Lembar • S15 Modul Harian • S16 Doa Penenang • S17 TB-40 • S18 Hening 3m • S19 6 Pilar Fitrah • S20 Profil Tokoh & Lembaga',
    width: 1416,
    props: {
      fontSize: 12,
      fontStyle: 'SemiBold',
      fill: COLORS.pine[200],
    },
  });

  // =========================================================================
  // PAGE 2: 01 - DESIGN SYSTEM & TOKENS
  // =========================================================================
  b.addPage('01 - Design System & Tokens', '#121614');

  const dsBoard = b.frame({
    name: 'Design System — Earth-Tree Palette, Typography & Tokens',
    x: 0,
    y: 0,
    width: 1680,
    height: 1360,
    props: {
      fill: COLORS.sand[50],
      cornerRadius: 36,
      stroke: COLORS.sand[300],
      strokeWeight: 2,
      layout: 'vertical',
      gap: 32,
      padding: [48, 48, 48, 48],
      clip: true,
    },
  });

  // Header
  const dsHeader = b.frame({
    name: 'Design System Header',
    parent: dsBoard,
    width: 1584,
    height: 80,
    props: {
      fill: COLORS.basalt[900],
      cornerRadius: 24,
      layout: 'horizontal',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [20, 32, 20, 32],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({
    parent: dsHeader,
    text: '01 • PKN Mobile v2 Design System — Earth-Tree Palette & Nabawiyah Typography',
    props: {
      fontFamily: 'Merriweather',
      fontStyle: 'Bold',
      fontSize: 24,
      fill: COLORS.sand[50],
    },
  });
  b.badge({
    parent: dsHeader,
    text: 'WCAG AAA High-Contrast • Warm Sand & Tahajjud Basalt',
    bg: COLORS.pine[600],
    fg: COLORS.white,
    fontSize: 12,
    padding: [6, 14, 6, 14],
  });

  // Color Scales Section
  const paletteGroups = [
    {
      title: '1. Warm Sand (Surface & Canvas — Light Mode)',
      swatches: [
        { name: 'sand-50', hex: COLORS.sand[50], fg: COLORS.basalt[900], role: 'Primary App Canvas' },
        { name: 'sand-100', hex: COLORS.sand[100], fg: COLORS.basalt[900], role: 'Secondary Surface / Pill' },
        { name: 'sand-200', hex: COLORS.sand[200], fg: COLORS.basalt[900], role: 'Card Borders & Dividers' },
        { name: 'sand-300', hex: COLORS.sand[300], fg: COLORS.basalt[900], role: 'Muted Text on Dark' },
        { name: 'sand-400', hex: COLORS.sand[400], fg: COLORS.basalt[900], role: 'Warm Accent Neutral' },
        { name: 'sand-500', hex: COLORS.sand[500], fg: COLORS.white, role: 'Warm Earth Midtone' },
        { name: 'sand-600', hex: COLORS.sand[600], fg: COLORS.white, role: 'Deep Sand Accent' },
      ],
    },
    {
      title: '2. Deep Basalt (Tahajjud Dark Mode & High-Contrast Ink)',
      swatches: [
        { name: 'basalt-50', hex: COLORS.basalt[50], fg: COLORS.basalt[900], role: 'Light Neutral Tint' },
        { name: 'basalt-100', hex: COLORS.basalt[100], fg: COLORS.basalt[900], role: 'Subtle Divider' },
        { name: 'basalt-700', hex: COLORS.basalt[700], fg: COLORS.sand[50], role: 'Secondary Body Copy' },
        { name: 'basalt-800', hex: COLORS.basalt[800], fg: COLORS.sand[50], role: 'Dark Surface / Borders' },
        { name: 'basalt-900', hex: COLORS.basalt[900], fg: COLORS.sand[50], role: 'Primary Text / Dark Card' },
        { name: 'basalt-950', hex: COLORS.basalt[950], fg: COLORS.sand[50], role: 'Tahajjud Dark Canvas' },
      ],
    },
    {
      title: '3. Deep Pine Emerald (Primary Brand, Calm & Growth)',
      swatches: [
        { name: 'pine-50', hex: COLORS.pine[50], fg: COLORS.pine[800], role: 'Soft Badge & PTT Fill' },
        { name: 'pine-100', hex: COLORS.pine[100], fg: COLORS.pine[900], role: 'Highlight Surface' },
        { name: 'pine-500', hex: COLORS.pine[500], fg: COLORS.white, role: 'Active Pulse & Focus' },
        { name: 'pine-600', hex: COLORS.pine[600], fg: COLORS.white, role: 'Primary CTA & Active Tab' },
        { name: 'pine-700', hex: COLORS.pine[700], fg: COLORS.white, role: 'Pressed CTA / Gradient' },
        { name: 'pine-800', hex: COLORS.pine[800], fg: COLORS.white, role: 'Bento Hero Gradient' },
        { name: 'pine-950', hex: COLORS.pine[950], fg: COLORS.pine[300], role: 'Dark Mode Pine Surface' },
      ],
    },
    {
      title: '4. Terracotta & Amber Custom (P3K Crisis, Warmth & Tadabbur Highlights)',
      swatches: [
        { name: 'terracotta-50', hex: COLORS.terracotta[50], fg: COLORS.terracotta[600], role: 'Crisis Tint Surface' },
        { name: 'terracotta-500', hex: COLORS.terracotta[500], fg: COLORS.white, role: 'P3K Crisis Card Start' },
        { name: 'terracotta-600', hex: COLORS.terracotta[600], fg: COLORS.white, role: 'P3K Crisis CTA & End' },
        { name: 'amber-50', hex: COLORS.amber[50], fg: COLORS.amber[600], role: 'Munajat & Hening Surface' },
        { name: 'amber-300', hex: COLORS.amber[300], fg: COLORS.basalt[900], role: 'Quote & Tadabbur Gold' },
        { name: 'amber-500', hex: COLORS.amber[500], fg: COLORS.white, role: 'Daurah Banner Gradient' },
        { name: 'amber-600', hex: COLORS.amber[600], fg: COLORS.white, role: 'Hening Qalbu Primary' },
      ],
    },
  ];

  for (const grp of paletteGroups) {
    const grpFrame = b.frame({
      name: grp.title,
      parent: dsBoard,
      width: 1584,
      height: 148,
      props: {
        fill: COLORS.white,
        cornerRadius: 20,
        stroke: COLORS.sand[200],
        strokeWeight: 1,
        layout: 'vertical',
        gap: 12,
        padding: [16, 20, 16, 20],
        sizingH: 'fill',
        sizingV: 'hug',
      },
    });
    b.text({
      parent: grpFrame,
      text: grp.title,
      props: { fontSize: 14, fontStyle: 'Bold', fill: COLORS.basalt[900] },
    });
    const row = b.frame({
      name: 'Swatch Row',
      parent: grpFrame,
      width: 1544,
      height: 84,
      props: {
        fill: '#00000000',
        layout: 'horizontal',
        gap: 14,
        sizingH: 'fill',
        sizingV: 'hug',
      },
    });
    for (const sw of grp.swatches) {
      const swCard = b.frame({
        name: `Swatch ${sw.name}`,
        parent: row,
        width: 208,
        height: 80,
        props: {
          fill: sw.hex,
          cornerRadius: 14,
          stroke: COLORS.sand[300],
          strokeWeight: 1,
          layout: 'vertical',
          mainAlign: 'spaceBetween',
          padding: [10, 12, 10, 12],
          sizingH: 'fixed',
          sizingV: 'fixed',
        },
      });
      b.text({
        parent: swCard,
        text: `${sw.name}  •  ${sw.hex}`,
        props: { fontSize: 12, fontStyle: 'Bold', fill: sw.fg },
      });
      b.text({
        parent: swCard,
        text: sw.role,
        props: { fontSize: 10, fontStyle: 'Medium', fill: sw.fg },
      });
    }
  }

  // Typography & Elevation Row
  const bottomDsRow = b.frame({
    name: 'Typography & Layout Specifications',
    parent: dsBoard,
    width: 1584,
    height: 360,
    props: {
      fill: '#00000000',
      layout: 'horizontal',
      gap: 24,
      sizingH: 'fill',
      sizingV: 'hug',
    },
  });

  const typoCard = b.frame({
    name: 'Typography Hierarchy (3 Font Families)',
    parent: bottomDsRow,
    width: 960,
    height: 350,
    props: {
      fill: COLORS.white,
      cornerRadius: 24,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'vertical',
      gap: 14,
      padding: [24, 28, 24, 28],
      sizingH: 'fixed',
      sizingV: 'fixed',
    },
  });
  b.text({
    parent: typoCard,
    text: 'Typography Scale — Plus Jakarta Sans (UI) • Merriweather (Reflective Headings) • Amiri (Arabic Dalil & Doa)',
    props: { fontSize: 15, fontStyle: 'Bold', fill: COLORS.pine[700] },
  });
  b.text({
    parent: typoCard,
    text: 'Display / Greeting (Merriweather Bold 24px): Ahlan, Abu Zaid',
    props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 24, fill: COLORS.basalt[900] },
  });
  b.text({
    parent: typoCard,
    text: 'Reflective Quote (Merriweather Italic 14px): "Koneksi Sebelum Koreksi — Tautkan hati dan penuhi bejana cinta sebelum menegakkan aturan."',
    width: 900,
    props: { fontFamily: 'Merriweather', fontStyle: 'Italic', fontSize: 14, fill: COLORS.basalt[700] },
  });
  b.text({
    parent: typoCard,
    text: 'Arabic Dalil & Munajat (Amiri Regular 20px RTL): رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا',
    width: 900,
    props: { fontFamily: 'Amiri', fontStyle: 'Regular', fontSize: 20, fill: COLORS.basalt[900] },
  });
  b.text({
    parent: typoCard,
    text: 'Section Eyebrow (Plus Jakarta Sans ExtraBold 11px Uppercase): PERTOLONGAN SITUASI NYATA (< 10 DETIK)',
    props: { fontFamily: 'Plus Jakarta Sans', fontStyle: 'Bold', fontSize: 11, fill: COLORS.basalt[400] },
  });
  b.text({
    parent: typoCard,
    text: 'Card Title & Body (Plus Jakarta Sans Bold 14px / Regular 12px): Membangun Kedekatan Kalbu Sebelum Koreksi (Fase Tamyiz • Usia 8 Th)',
    props: { fontFamily: 'Plus Jakarta Sans', fontStyle: 'SemiBold', fontSize: 13, fill: COLORS.basalt[900] },
  });

  const rulesCard = b.frame({
    name: 'UX & Ergonomic Principles',
    parent: bottomDsRow,
    width: 600,
    height: 350,
    props: {
      fill: COLORS.basalt[900],
      cornerRadius: 24,
      stroke: COLORS.basalt[800],
      strokeWeight: 1,
      layout: 'vertical',
      gap: 12,
      padding: [24, 28, 24, 28],
      sizingH: 'fixed',
      sizingV: 'fixed',
    },
  });
  b.text({
    parent: rulesCard,
    text: 'Core UX & Syar’i Design Principles',
    props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 18, fill: COLORS.sand[50] },
  });
  const uxRules = [
    '1. 1/3 Nature Tree Hero + 2/3 Rounded Sheet (-mt-6 rounded-t-[32px]) for calm grounding.',
    '2. < 10-Second Emergency Access: P3K Krisis Genting & Ruang Qalbu PTT in top thumb zone.',
    '3. 2-Phase P3K SOP: Phase 1 High-Arousal Triage (Anak vs Ortu) ➔ Phase 2 Stabil Debrief.',
    '4. Anti-Guilt Qualitative Progress: "1 dari 3 Selesai" & warm relational badges (no punitive streaks).',
    '5. Ephemeral Voice & E2EE Privacy: Zero server audio retention in Walkie-Talkie Ruang Qalbu.',
    '6. Pull-Down Over-Scroll Gesture on Beranda opens Full-Screen Mode Renungan & Digital Clock.',
  ];
  for (const r of uxRules) {
    b.text({
      parent: rulesCard,
      text: r,
      width: 544,
      props: { fontSize: 12, fontStyle: 'Medium', fill: COLORS.sand[200], lineHeight: 18 },
    });
  }

  // =========================================================================
  // PAGE 3: 02 - COMPONENT LIBRARY (MASTER REUSABLE COMPONENTS)
  // =========================================================================
  b.addPage('02 - Component Library', '#121614');

  const compBoard = b.frame({
    name: 'Master Component Library & Variants',
    x: 0,
    y: 0,
    width: 1680,
    height: 620,
    props: {
      fill: COLORS.sand[100],
      cornerRadius: 36,
      stroke: COLORS.sand[300],
      strokeWeight: 2,
      layout: 'vertical',
      gap: 28,
      padding: [40, 48, 40, 48],
      clip: true,
    },
  });

  b.text({
    parent: compBoard,
    text: '02 • PKN Mobile v2 Reusable Component Library (Auto-Layout Master Components)',
    props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 24, fill: COLORS.basalt[900] },
  });

  // Row 1 of Master Components: Navigation Bars & Emergency Cards
  const compRow1 = b.frame({
    name: 'Component Row 1 — Navigation & Emergency Cards',
    parent: compBoard,
    width: 1584,
    height: 160,
    props: {
      fill: '#00000000',
      layout: 'horizontal',
      gap: 24,
      sizingH: 'fill',
      sizingV: 'hug',
    },
  });

  // Component 1: Floating Frosted Dock (Light)
  const cDockLight = b.component({
    name: 'Component / Navigation / Floating Dock (Light)',
    parent: compRow1,
    width: 360,
    height: 64,
    registerComponent: 'dock-light',
    props: {
      fill: COLORS.white,
      cornerRadius: 24,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'horizontal',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [8, 16, 8, 16],
    },
  });
  for (const [idx, lbl] of ['⌂ Beranda', '📅 Event', '📖 Materi', '♥ Curhat', '👤 Profil'].entries()) {
    b.text({
      parent: cDockLight,
      text: lbl,
      props: {
        fontSize: 11,
        fontStyle: idx === 0 ? 'Bold' : 'Medium',
        fill: idx === 0 ? COLORS.pine[600] : COLORS.basalt[400],
      },
    });
  }

  // Component 2: Floating Frosted Dock (Tahajjud Dark)
  const cDockDark = b.component({
    name: 'Component / Navigation / Floating Dock (Dark)',
    parent: compRow1,
    width: 360,
    height: 64,
    registerComponent: 'dock-dark',
    props: {
      fill: COLORS.basalt[900],
      cornerRadius: 24,
      stroke: COLORS.basalt[800],
      strokeWeight: 1,
      layout: 'horizontal',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [8, 16, 8, 16],
    },
  });
  for (const [idx, lbl] of ['⌂ Beranda', '📅 Event', '📖 Materi', '♥ Curhat', '👤 Profil'].entries()) {
    b.text({
      parent: cDockDark,
      text: lbl,
      props: {
        fontSize: 11,
        fontStyle: idx === 0 ? 'Bold' : 'Medium',
        fill: idx === 0 ? COLORS.pine[400] : COLORS.sand[400],
      },
    });
  }

  // Component 3: Emergency Card — P3K Krisis Genting
  const cP3kCard = b.component({
    name: 'Component / EmergencyCard / P3K Krisis Genting',
    parent: compRow1,
    width: 190,
    height: 112,
    registerComponent: 'card-p3k',
    props: {
      fills: [{ type: 'linearGradient', stops: [COLORS.terracotta[500], COLORS.terracotta[600]] }],
      cornerRadius: 20,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [14, 14, 14, 14],
    },
  });
  b.badge({ parent: cP3kCard, text: '⚠️ P3K GENTING', bg: '#FFFFFF33', fg: COLORS.white, fontSize: 9 });
  b.text({ parent: cP3kCard, text: 'P3K Krisis Genting\nAnak mengamuk & ortu burnout', width: 162, props: { fontSize: 12, fontStyle: 'Bold', fill: COLORS.white } });

  // Component 4: Emergency Card — Ruang Qalbu Curhat AI
  const cCurhatCard = b.component({
    name: 'Component / EmergencyCard / Curhat Batin AI',
    parent: compRow1,
    width: 190,
    height: 112,
    registerComponent: 'card-curhat',
    props: {
      fills: [{ type: 'linearGradient', stops: [COLORS.pine[600], COLORS.pine[700]] }],
      cornerRadius: 20,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [14, 14, 14, 14],
    },
  });
  b.badge({ parent: cCurhatCard, text: '🎙️ RUANG QALBU', bg: '#FFFFFF33', fg: COLORS.white, fontSize: 9 });
  b.text({ parent: cCurhatCard, text: 'Curhat Batin AI\nBicara tanpa dihakimi', width: 162, props: { fontSize: 12, fontStyle: 'Bold', fill: COLORS.white } });

  // Component 5: Search Bar with PTT Button
  const cSearch = b.component({
    name: 'Component / Input / FTS5 Search Bar + PTT',
    parent: compRow1,
    width: 360,
    height: 48,
    registerComponent: 'search-ptt',
    props: {
      fill: COLORS.white,
      cornerRadius: 16,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'horizontal',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [8, 12, 8, 14],
    },
  });
  b.text({ parent: cSearch, text: '🔍 Cari panduan adab, dalil, atau tips...', props: { fontSize: 12, fill: COLORS.basalt[400] } });
  b.badge({ parent: cSearch, text: '🎙️ PTT', bg: COLORS.pine[50], fg: COLORS.pine[600], fontSize: 10 });

  // Row 2 of Master Components: Cards & Tiles
  const compRow2 = b.frame({
    name: 'Component Row 2 — Agenda, Carousel, Bento & Directory Cards',
    parent: compBoard,
    width: 1584,
    height: 240,
    props: {
      fill: '#00000000',
      layout: 'horizontal',
      gap: 24,
      sizingH: 'fill',
      sizingV: 'hug',
    },
  });

  // Component 6: Agenda Majelis Card
  const cAgenda = b.component({
    name: 'Component / Card / Agenda Majelis Highlight',
    parent: compRow2,
    width: 380,
    height: 170,
    registerComponent: 'card-agenda',
    props: {
      fills: [{ type: 'linearGradient', stops: [COLORS.amber[600], COLORS.terracotta[500]] }],
      cornerRadius: 24,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [16, 16, 16, 16],
    },
  });
  b.badge({ parent: cAgenda, text: '🔴 H-3 MENUJU MAJELIS AKBAR • SABTU, 18 OKT', bg: '#00000040', fg: COLORS.white, fontSize: 10 });
  b.text({ parent: cAgenda, text: 'Daurah Akbar: Menumbuhkan Fitrah Keimanan Usia Tamyiz', width: 348, props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 15, fill: COLORS.white } });
  b.text({ parent: cAgenda, text: '🗣️ Ust. Abdul Kholiq, Lc. & Tim Litbang SKIS • Daftar ➔', width: 348, props: { fontSize: 11, fontStyle: 'SemiBold', fill: COLORS.sand[100] } });

  // Component 7: Activity Carousel Card (In-Progress Modul)
  const cCarousel = b.component({
    name: 'Component / Card / Activity Carousel Slide',
    parent: compRow2,
    width: 260,
    height: 180,
    registerComponent: 'card-activity',
    props: {
      fill: COLORS.white,
      cornerRadius: 20,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [14, 14, 14, 14],
    },
  });
  b.badge({ parent: cCarousel, text: '📖 LANJUTKAN MODUL • BAB 3/5 (65%)', bg: COLORS.pine[50], fg: COLORS.pine[600], fontSize: 10 });
  b.text({ parent: cCarousel, text: 'Membangun Kedekatan Kalbu Sebelum Koreksi (Tamyiz)', width: 232, props: { fontSize: 12, fontStyle: 'Bold', fill: COLORS.basalt[900] } });
  b.text({ parent: cCarousel, text: 'Tersisa 8 menit • Sentuhan rahmat', width: 232, props: { fontSize: 10, fill: COLORS.basalt[400] } });
  b.button({ parent: cCarousel, label: 'Lanjutkan Belajar ▶', bg: COLORS.pine[600], fg: COLORS.white, width: 232, height: 34, radius: 10, fontSize: 11 });

  // Component 8: Utility Grid Tile
  const cUtility = b.component({
    name: 'Component / Tile / Instrumen Utilitas Praktis',
    parent: compRow2,
    width: 190,
    height: 104,
    registerComponent: 'tile-utility',
    props: {
      fill: COLORS.white,
      cornerRadius: 18,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [12, 14, 12, 14],
    },
  });
  b.badge({ parent: cUtility, text: '📝 KBM ADAB', bg: COLORS.pine[50], fg: COLORS.pine[600], fontSize: 9 });
  b.text({ parent: cUtility, text: 'Generator RPP\nRencana aksi 1 lembar', width: 162, props: { fontSize: 12, fontStyle: 'Bold', fill: COLORS.basalt[900] } });

  // Component 9: Tokoh Asatidzah Directory Card
  const cTokoh = b.component({
    name: 'Component / Directory / Kartu Tokoh Asatidzah',
    parent: compRow2,
    width: 250,
    height: 190,
    registerComponent: 'card-tokoh',
    props: {
      fill: COLORS.white,
      cornerRadius: 20,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      padding: [14, 14, 14, 14],
    },
  });
  b.badge({ parent: cTokoh, text: 'DEWAN PEMBINA', bg: COLORS.pine[50], fg: COLORS.pine[600], fontSize: 9 });
  b.text({ parent: cTokoh, text: 'Ust. Abdul Kholiq, Lc.\nPengasuh Kuttab & SKIS', width: 222, props: { fontSize: 12, fontStyle: 'Bold', fill: COLORS.basalt[900] } });
  b.text({ parent: cTokoh, text: 'Fokus: Fitrah Iman & Manhaj\nKarya: Buku "Tiga Bahasa Mendidik"', width: 222, props: { fontSize: 10, fill: COLORS.basalt[600] } });
  b.button({ parent: cTokoh, label: 'Lihat Profil & Karya ➔', bg: COLORS.sand[100], fg: COLORS.pine[600], width: 222, height: 32, radius: 10, fontSize: 11 });

  // Component 10: P3K Step Action Row
  const cStepRow = b.component({
    name: 'Component / P3K / Emergency Step Card',
    parent: compRow2,
    width: 360,
    height: 76,
    registerComponent: 'card-p3k-step',
    props: {
      fill: COLORS.sand[50],
      cornerRadius: 16,
      stroke: COLORS.red[200],
      strokeWeight: 2,
      layout: 'horizontal',
      crossAlign: 'center',
      gap: 12,
      padding: [12, 14, 12, 14],
    },
  });
  b.badge({ parent: cStepRow, text: '1 • WAJIB AWAL', bg: COLORS.red[600], fg: COLORS.white, fontSize: 10, padding: [6, 10, 6, 10], radius: 10 });
  b.text({
    parent: cStepRow,
    text: 'Amankan Radius Bahaya Fisik\nJauhkan benda tajam/keras, tangga & jalan raya (Hifzhun Nafs)',
    width: 230,
    props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.basalt[900] },
  });
}
