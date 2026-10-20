// OpenPencil Master Design Generator for PKN Healing Mobile App v2
// Generates complete Figma artboards for Core Flows (P3K & Curhat AI), Stitch Variants, and Design Tokens

const C = {
  // Brand Earth-Tree Palette
  pine950: '#0A1612',
  pine900: '#11251C',
  pine800: '#14261C',
  pine700: '#1B3526',
  pine600: '#006D30',
  pine500: '#1B8A43',
  pine100: '#D5F2DC',
  pine50: '#EDF9F0',
  
  terracotta700: '#943E1F',
  terracotta600: '#9C4114',
  terracotta500: '#C05621',
  terracotta200: '#F2D4C4',
  terracotta50: '#FDF7F4',
  
  sand50: '#FDFBF7',
  sand100: '#F7F2E7',
  sand200: '#EEE5D1',
  sand400: '#CFB990',
  sand600: '#9E8156',
  
  basalt950: '#12120E',
  basalt900: '#1C1C17',
  basalt800: '#2B2B28',
  basalt700: '#3E3E3B',
  basalt400: '#71756E',
  basalt100: '#E7E7E7',
  basalt50: '#F6F6F6',
  
  amber500: '#D97706',
  amber400: '#F59E0B',
  amber300: '#FCD34D',
  
  emeraldAccent: '#79DB8D',
  white: '#FFFFFF',
  cardBorder: '#E2E8F0',
};

// Robust paint converter supporting 6-digit hex, 8-digit hex (with alpha), and transparent
const paint = (h, fallbackAlpha = 1) => {
  if (!h || h === 'transparent') return [];
  if (h.startsWith('rgba')) {
    const parts = h.match(/[\d.]+/g);
    if (!parts || parts.length < 3) return [];
    const r = parseFloat(parts[0]) / 255;
    const g = parseFloat(parts[1]) / 255;
    const b = parseFloat(parts[2]) / 255;
    const a = parts.length >= 4 ? parseFloat(parts[3]) : 1;
    if (a <= 0) return [];
    return [{ type: 'SOLID', color: { r, g, b }, opacity: a }];
  }
  const r = parseInt(h.slice(1, 3), 16) / 255;
  const g = parseInt(h.slice(3, 5), 16) / 255;
  const b = parseInt(h.slice(5, 7), 16) / 255;
  let a = fallbackAlpha;
  if (h.length === 9) {
    a = parseInt(h.slice(7, 9), 16) / 255;
  }
  if (a <= 0) return [];
  return [{
    type: 'SOLID',
    color: { r, g, b },
    opacity: a
  }];
};

await figma.loadFontAsync({ family: 'Inter', style: 'Regular' });
await figma.loadFontAsync({ family: 'Inter', style: 'Bold' });
try {
  await figma.loadFontAsync({ family: 'Amiri', style: 'Regular' });
} catch(e) {
  console.log('Amiri font loaded fallback');
}

function box(p, name, x, y, w, h, color = C.white, r = 16) {
  const n = figma.createFrame();
  n.name = name;
  n.resize(w, h);
  n.fills = paint(color);
  n.cornerRadius = r;
  p.appendChild(n);
  n.x = x;
  n.y = y;
  return n;
}

function text(p, s, x, y, w = 340, size = 13, color = C.basalt900, bold = false, font = 'Inter') {
  const n = figma.createText();
  n.name = s.slice(0, 50);
  n.fontName = { family: font === 'Amiri' ? 'Amiri' : 'Inter', style: bold ? 'Bold' : 'Regular' };
  n.fontSize = size;
  n.characters = s;
  n.fills = paint(color);
  const lineH = size * 1.45;
  const charsPerLine = Math.max(1, Math.floor(w / (size * 0.58)));
  const lines = Math.ceil(s.length / charsPerLine);
  n.resize(w, Math.max(lineH, lines * lineH));
  p.appendChild(n);
  n.x = x;
  n.y = y;
  return n;
}

function pill(p, s, x, y, bgCol, textCol, fontSize = 10) {
  const calculatedW = Math.max(50, s.length * 6.5 + 16);
  const f = box(p, 'Pill: ' + s, x, y, calculatedW, 22, bgCol, 11);
  text(f, s, 8, 3.5, calculatedW - 16, fontSize, textCol, true);
  return f;
}

// Vector First Aid Cross Icon
function drawFirstAidCross(parent, x, y, size = 18, crossColor = C.white) {
  const icon = box(parent, 'First Aid Cross', x, y, size, size, 'transparent', 0);
  const thick = size * 0.32;
  box(icon, 'H-Bar', 0, (size - thick) / 2, size, thick, crossColor, thick / 2);
  box(icon, 'V-Bar', (size - thick) / 2, 0, thick, size, crossColor, thick / 2);
  return icon;
}

// Vector Equalizer Waveform
function drawWaveform(parent, x, y, barColor = C.pine500) {
  const heights = [8, 16, 28, 40, 24, 34, 18, 10];
  const barW = 4;
  const gap = 6;
  const totalW = heights.length * (barW + gap) - gap;
  const container = box(parent, 'Audio Waveform Equalizer', x, y, totalW, 44, 'transparent', 0);
  heights.forEach((h, i) => {
    box(container, 'WaveBar ' + (i + 1), i * (barW + gap), (44 - h) / 2, barW, h, barColor, 2);
  });
  return container;
}

// -------------------------------------------------------------
// SETUP PAGES
// -------------------------------------------------------------
figma.root.name = 'PKN Healing Mobile App v2 • Master Figma Design';

while (figma.root.children.length > 1) {
  figma.root.children[1].remove();
}
const p1 = figma.root.children[0];
p1.name = '📱 01 • Core Flows (P3K & Curhat AI)';
for (const child of p1.children.slice()) child.remove();

const p2 = figma.createPage();
p2.name = '🌲 02 • Stitch Minimalist Redesigns';

const p3 = figma.createPage();
p3.name = '🎨 03 • Design Tokens & UI Kit';

console.log('Pages initialized.');

// -------------------------------------------------------------
// PAGE 1: CORE FLOWS (5 MOBILE SCREENS)
// -------------------------------------------------------------
const W = 390;
const H = 844;
const GAP = 60;

function addStatusBar(screen, isDark = false) {
  const sb = box(screen, 'Status Bar (iOS/Android)', 0, 0, W, 44, 'transparent', 0);
  text(sb, '9:41', 24, 13, 60, 14, isDark ? C.white : C.basalt900, true);
  text(sb, '5G  100%', W - 80, 15, 60, 11, isDark ? C.white : C.basalt900, true);
}

function addBottomDock(screen, activeTab = 'Beranda') {
  const dock = box(screen, 'Floating 5-Tab Dock', 20, H - 76, W - 40, 60, C.white, 30);
  dock.strokes = paint(C.cardBorder);
  dock.strokeWeight = 1;
  const tabs = [
    { name: 'Beranda', icon: '⌂' },
    { name: 'Event', icon: '✦' },
    { name: 'Materi', icon: '≡' },
    { name: 'Curhat', icon: '♡' },
    { name: 'Profil', icon: '○' }
  ];
  const tabW = (W - 40) / tabs.length;
  tabs.forEach((tab, i) => {
    const isActive = tab.name === activeTab;
    const tabFrame = box(dock, 'Tab: ' + tab.name, i * tabW, 6, tabW, 48, 'transparent', 0);
    const col = isActive ? C.pine600 : C.basalt400;
    text(tabFrame, tab.icon, tabW / 2 - 8, 4, 20, 14, col, true);
    text(tabFrame, tab.name, 0, 24, tabW, 10, col, isActive);
    if (isActive) {
      const dot = figma.createEllipse();
      dot.resize(4, 4);
      dot.fills = paint(C.pine600);
      tabFrame.appendChild(dot);
      dot.x = tabW / 2 - 2;
      dot.y = 40;
    }
  });
}

// SCREEN 1: HOMESCREEN (P3K & CURHAT SIDE-BY-SIDE)
{
  const s1 = box(p1, '📱 01.1 • Homescreen (P3K & Curhat AI Bersandingan)', 0, 60, W, H, C.sand50, 44);
  s1.clipsContent = true;
  
  // Hero Section (Pine Forest Dark Canopy)
  const heroH = 345;
  const hero = box(s1, 'Nature Tree Hero Header (Misty Pine)', 0, 0, W, heroH, C.pine950, 0);
  hero.clipsContent = true;
  
  // Forest Canopy Decorative Layers
  const canopy1 = figma.createEllipse();
  canopy1.resize(320, 240);
  canopy1.fills = paint(C.pine700);
  canopy1.opacity = 0.45;
  hero.appendChild(canopy1);
  canopy1.x = -60;
  canopy1.y = -40;

  const canopy2 = figma.createEllipse();
  canopy2.resize(260, 220);
  canopy2.fills = paint(C.pine800);
  canopy2.opacity = 0.55;
  hero.appendChild(canopy2);
  canopy2.x = W - 180;
  canopy2.y = 20;

  addStatusBar(hero, true);

  // Pull-down gesture pill cue
  const pullCue = box(hero, 'Pull-down Cue Pill', W / 2 - 95, 48, 190, 24, '#00000066', 12);
  pullCue.strokes = paint('#FFFFFF33');
  text(pullCue, '↓ Tarik ke bawah untuk Mode Jam', 12, 5, 170, 10, C.emeraldAccent, true);

  // Greeting & User bar
  text(hero, 'Ahlan, Abu Zaid', 24, 82, 220, 19, C.white, true);
  text(hero, 'Menemani proses healing qalbu • Baiti Jannati', 24, 106, 260, 11, '#94A3B8', false);
  
  // Quick Actions: Moon Toggle & Avatar
  const moon = box(hero, 'Night Mode Toggle', W - 88, 84, 34, 34, '#FFFFFF1A', 17);
  moon.strokes = paint('#FFFFFF26');
  text(moon, '☾', 11, 8, 16, 14, C.white, true);

  const avatar = box(hero, 'Avatar Monogram', W - 48, 84, 34, 34, C.pine700, 17);
  avatar.strokes = paint(C.emeraldAccent);
  avatar.strokeWeight = 1.5;
  text(avatar, 'AZ', 9, 8, 20, 12, C.white, true);

  // Daily Tadabbur Frosted Glass Card
  const quoteCard = box(hero, 'Daily Tadabbur Glass Card', 20, 138, W - 40, 132, '#00000088', 20);
  quoteCard.strokes = paint(C.emeraldAccent);
  quoteCard.strokeWeight = 1;
  quoteCard.opacity = 0.95;

  text(quoteCard, '✦ RENUNGAN QALBU HARI INI', 16, 12, 180, 10, C.emeraldAccent, true);
  text(quoteCard, 'Buka Mode Jam >', W - 170, 12, 120, 10, '#FFFFFFBB', true);
  
  // Arabic text
  text(quoteCard, 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ', 20, 36, W - 80, 18, C.white, false, 'Amiri');
  text(quoteCard, '“Ingatlah, hanya dengan mengingat Allah hati menjadi tenteram.”', 20, 72, W - 80, 11, '#E2E8F0', false);
  text(quoteCard, '(Refleksi Parenting Nabawiyah • QS. Ar-Ra\'d: 28)', 20, 98, W - 80, 10, C.emeraldAccent, false);

  // Overlapping Content Sheet
  const sheet = box(s1, 'Content Surface Sheet', 0, 285, W, H - 285, C.sand50, 28);
  sheet.clipsContent = true;

  // Search Bar Ticker
  const search = box(sheet, 'Search Bar Ticker', 20, 16, W - 40, 44, C.white, 16);
  search.strokes = paint(C.cardBorder);
  text(search, 'Cari agenda daurah, pustaka...', 16, 14, 220, 11.5, C.basalt400);
  pill(search, 'PTT VOICE', W - 125, 10, C.pine50, C.pine600, 9);

  // SECTION: PERTOLONGAN SITUASI NYATA (< 10 DETIK)
  text(sheet, 'PERTOLONGAN SITUASI NYATA (< 10 DETIK)', 20, 72, 250, 10, C.basalt400, true);
  text(sheet, 'Aksi Cepat', W - 80, 72, 60, 10, C.pine600, true);

  // 2-COLUMN SIDE-BY-SIDE CARDS (P3K & CURHAT AI)
  const cardW = (W - 50) / 2; // 170px
  const cardH = 110;

  // Card 1: P3K Krisis Genting
  const p3kCard = box(sheet, 'Card: P3K Krisis Genting (< 10 Detik)', 20, 92, cardW, cardH, C.terracotta500, 20);
  const p3kIconWrap = box(p3kCard, 'First Aid Badge Circle', 14, 12, 28, 28, '#FFFFFF33', 14);
  drawFirstAidCross(p3kIconWrap, 7, 7, 14, C.white);
  pill(p3kCard, '< 10 DETIK', cardW - 80, 14, '#FFFFFF33', C.white, 8.5);
  text(p3kCard, 'P3K Krisis Genting', 14, 48, cardW - 28, 13, C.white, true);
  text(p3kCard, 'Anak mengamuk & ortu burnout', 14, 68, cardW - 28, 10, '#FFFFFFDD');

  // Card 2: Curhat Batin AI
  const curhatCard = box(sheet, 'Card: Curhat Batin AI (Ruang Qalbu)', 20 + cardW + 10, 92, cardW, cardH, C.pine600, 20);
  const curhatIconWrap = box(curhatCard, 'Curhat Icon Circle', 14, 12, 28, 28, '#FFFFFF33', 14);
  text(curhatIconWrap, 'AI', 6, 6, 18, 11, C.white, true);
  pill(curhatCard, 'RUANG QALBU', cardW - 88, 14, '#FFFFFF33', C.white, 8.5);
  text(curhatCard, 'Curhat Batin AI', 14, 48, cardW - 28, 13, C.white, true);
  text(curhatCard, 'Bicara tanpa dihakimi', 14, 68, cardW - 28, 10, '#FFFFFFDD');

  // SECTION: AMALAN ADAB HARI INI
  const adabSection = box(sheet, 'Amalan Adab Tracker Card', 20, 218, W - 40, 136, C.white, 20);
  adabSection.strokes = paint(C.cardBorder);
  text(adabSection, 'Amalan Adab Hari Ini', 16, 12, 160, 12, C.basalt900, true);
  pill(adabSection, '1 dari 3 Selesai', W - 145, 10, C.pine50, C.pine600, 9);

  // Adab Checklist Items
  const row1 = box(adabSection, 'Row 1 (Done)', 12, 40, W - 64, 26, C.pine50, 8);
  row1.strokes = paint(C.pine100);
  text(row1, '✓  Dekap Ananda Zaid 3 menit (Bahasa Hati)', 8, 6, W - 80, 11, C.pine700, true);

  const row2 = box(adabSection, 'Row 2 (Pending)', 12, 70, W - 64, 26, 'transparent', 8);
  row2.strokes = paint(C.cardBorder);
  text(row2, '○  Tahan amarah & puasa lisan saat lelah', 8, 6, W - 80, 11, C.basalt700);

  const row3 = box(adabSection, 'Row 3 (Pending)', 12, 100, W - 64, 26, 'transparent', 8);
  row3.strokes = paint(C.cardBorder);
  text(row3, '○  Dzikir sore & doa kelembutan kalbu anak', 8, 6, W - 80, 11, C.basalt700);

  // Bottom dock
  addBottomDock(s1, 'Beranda');
}

// SCREEN 2: MODAL P3K KRISIS GENTING (< 10 DETIK SOP)
{
  const s2 = box(p1, '🚨 01.2 • Modal P3K Krisis Genting (< 10 Detik SOP)', W + GAP, 60, W, H, C.basalt950, 44);
  s2.clipsContent = true;
  addStatusBar(s2, true);

  // Darkened background simulation
  const modal = box(s2, 'P3K Modal Sheet Surface', 0, 90, W, H - 90, C.white, 32);
  modal.clipsContent = true;

  // Handle & Close
  box(modal, 'Sheet Handle', W / 2 - 20, 10, 40, 4, C.cardBorder, 2);
  const closeBtn = box(modal, 'Close Button', W - 44, 16, 28, 28, C.basalt100, 14);
  text(closeBtn, '✕', 8, 6, 14, 12, C.basalt700, true);

  // Header Title & Mode
  text(modal, 'P3K KONDISI GENTING', 24, 22, 180, 12, C.terracotta600, true);
  pill(modal, 'MODE ANAK', W - 125, 18, C.sand100, C.basalt800, 9);

  // Maqashid Banner
  const maqashid = box(modal, 'Maqashid Priority Banner', 20, 56, W - 40, 94, C.basalt900, 18);
  text(maqashid, 'PRIORITAS MAQASHID: HIFZHUN NAFS (JIWA NO. 1)', 16, 12, W - 72, 10, C.amber400, true);
  text(maqashid, 'Amankan Bahaya & Tahan Lisan', 16, 32, W - 72, 15, C.white, true);
  text(maqashid, 'Tolak bahaya fisik seketika • Anak belum mukallaf (HR. Muslim 3009)', 16, 56, W - 72, 10.5, '#CBD5E1');

  // 3 Steps Container
  const stepsY = 162;
  const stepH = 72;

  // Step 1
  const st1 = box(modal, 'Langkah 1: Amankan Fisik', 20, stepsY, W - 40, stepH, C.terracotta50, 16);
  st1.strokes = paint(C.terracotta200);
  const num1 = box(st1, 'Num 1', 12, 18, 34, 34, C.terracotta600, 10);
  text(num1, '1', 12, 8, 14, 14, C.white, true);
  text(st1, 'Amankan Radius Bahaya Fisik', 56, 14, 210, 12, C.basalt900, true);
  pill(st1, 'WAJIB AWAL', W - 145, 12, C.terracotta200, C.terracotta700, 8);
  text(st1, 'Jauhkan benda tajam/keras, tangga & jalan raya', 56, 38, W - 110, 10.5, C.basalt700);

  // Step 2
  const st2 = box(modal, 'Langkah 2: Sejajar Mata', 20, stepsY + 80, W - 40, stepH, C.sand50, 16);
  st2.strokes = paint(C.cardBorder);
  const num2 = box(st2, 'Num 2', 12, 18, 34, 34, C.pine600, 10);
  text(num2, '2', 12, 8, 14, 14, C.white, true);
  text(st2, 'Duduk Rendah Sejajar Mata', 56, 14, 210, 12, C.basalt900, true);
  text(st2, 'Rendahkan tubuh, hilangkan gestur intimidasi visual', 56, 38, W - 110, 10.5, C.basalt700);

  // Step 3
  const st3 = box(modal, 'Langkah 3: Dekap Hangat', 20, stepsY + 160, W - 40, stepH, C.sand50, 16);
  st3.strokes = paint(C.cardBorder);
  const num3 = box(st3, 'Num 3', 12, 18, 34, 34, C.pine700, 10);
  text(num3, '3', 12, 8, 14, 14, C.white, true);
  text(st3, 'Dekap Hangat & Diamkan Kata', 56, 14, 210, 12, C.basalt900, true);
  text(st3, 'Peluk dadanya erat, puasa ceramah sampai tangis reda', 56, 38, W - 110, 10.5, C.basalt700);

  // Aksi Cepat Sotab Buttons (2-col)
  const actY = stepsY + 242;
  const bW = (W - 50) / 2;
  const btnA = box(modal, 'Aman & Mampu', 20, actY, bW, 48, C.pine50, 14);
  btnA.strokes = paint(C.pine600);
  text(btnA, 'Aman & Mampu?\nPenuhi Sekarang ✓', 12, 8, bW - 24, 10.5, C.pine700, true);

  const btnB = box(modal, 'Bahaya / Tak Aman', 20 + bW + 10, actY, bW, 48, C.terracotta50, 14);
  btnB.strokes = paint(C.terracotta600);
  text(btnB, 'Bahaya / Tak Aman?\nAmankan & Dekap', 12, 8, bW - 24, 10.5, C.terracotta700, true);

  // Main Confirmation CTA
  const cta = box(modal, 'Tombol Konfirmasi Selesai', 20, actY + 60, W - 40, 52, C.pine600, 16);
  text(cta, '✓  Alhamdulillah, Anak Sudah Tenang →', 38, 17, W - 76, 13, C.white, true);
}

// SCREEN 3: FULLSCREEN CLOCK MODE (MODE RENUNGAN)
// Strict Minimalist: Tree Background, Clean Digital Clock, Single Wisdom Quote
{
  const s3 = box(p1, '🕰️ 01.3 • Mode Jam & Renungan Qalbu (Fullscreen Minimal Clock)', (W + GAP) * 2, 60, W, H, C.pine950, 44);
  s3.clipsContent = true;
  addStatusBar(s3, true);

  // Organic Tree Canopy Background Silhouettes
  const bgTree1 = figma.createEllipse();
  bgTree1.resize(440, 360);
  bgTree1.fills = paint(C.pine800);
  bgTree1.opacity = 0.40;
  s3.appendChild(bgTree1);
  bgTree1.x = -40;
  bgTree1.y = 120;

  const bgTree2 = figma.createEllipse();
  bgTree2.resize(360, 300);
  bgTree2.fills = paint(C.pine700);
  bgTree2.opacity = 0.35;
  s3.appendChild(bgTree2);
  bgTree2.x = 80;
  bgTree2.y = 280;

  // Header Bar
  const hBar = box(s3, 'Clock Mode Header', 0, 44, W, 50, 'transparent', 0);
  text(hBar, '✦ TADABBUR QALBU', 24, 16, 200, 11, C.emeraldAccent, true);
  const closeClock = box(hBar, 'Close Clock', W - 80, 10, 56, 28, '#FFFFFF22', 14);
  closeClock.strokes = paint('#FFFFFF33');
  text(closeClock, '✕ Tutup', 8, 7, 40, 10, C.white, true);

  // Center Minimal Digital Clock Display
  const clockBox = box(s3, 'Center Minimal Clock', 20, 145, W - 40, 140, 'transparent', 0);
  text(clockBox, '10 : 31 : 46', 0, 10, W - 40, 44, C.white, true);
  text(clockBox, 'Kamis, 15 Oktober 2026 • 3 Rabi\'ul Akhir 1448 H', 0, 72, W - 40, 12, '#94A3B8');
  text(clockBox, 'Fokus Hening • Kelembutan Hati', 0, 96, W - 40, 11, C.emeraldAccent);

  // Single Inspiring Wisdom Card (Pure & Minimal)
  const cCard = box(s3, 'Wisdom Card Container', 24, 315, W - 48, 250, '#11251CB3', 24);
  cCard.strokes = paint(C.emeraldAccent);
  cCard.strokeWeight = 1;

  text(cCard, '❝', W / 2 - 36, 16, 40, 32, C.amber400, true);
  text(cCard, 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ', 20, 58, W - 88, 22, C.white, false, 'Amiri');
  text(cCard, '“Koneksi Sebelum Koreksi — Tautkan hati dan penuhi bejana cinta sebelum menegakkan aturan.”', 20, 104, W - 88, 13, '#F1F5F9', false);
  
  pill(cCard, 'PRINSIP EMAS MANHAJ PKN', W / 2 - 95, 165, '#1B3526CC', C.emeraldAccent, 9);
  text(cCard, 'Refleksi Parenting Nabawiyah • QS. Ar-Ra\'d: 28', 20, 200, W - 88, 10.5, '#94A3B8');

  // Quote Carousel Indicator
  const dotRow = box(s3, 'Carousel Dots', W / 2 - 45, 585, 90, 16, 'transparent', 0);
  text(dotRow, '‹   ● ○ ○ ○   ›', 8, 0, 80, 12, C.white);

  // Bottom Pull-up cue pill
  const upCue = box(s3, 'Pull-up Cue Pill', W / 2 - 100, H - 90, 200, 36, '#FFFFFF1A', 18);
  upCue.strokes = paint('#FFFFFF25');
  text(upCue, '↑ Geser ke atas untuk Beranda', 16, 10, 170, 11, C.white, true);
}

// SCREEN 4: MODAL CURHAT BATIN AI (WALKIE-TALKIE PTT)
{
  const s4 = box(p1, '🎙️ 01.4 • Modal Curhat Batin AI (Walkie-Talkie Voice PTT)', (W + GAP) * 3, 60, W, H, C.basalt950, 44);
  s4.clipsContent = true;
  addStatusBar(s4, true);

  const modal = box(s4, 'Curhat Modal Sheet Surface', 0, 180, W, H - 180, C.white, 36);
  modal.clipsContent = true;

  // Handle & Close
  box(modal, 'Handle', W / 2 - 20, 10, 40, 4, C.cardBorder, 2);
  const closeBtn = box(modal, 'Close', W - 44, 18, 28, 28, C.basalt100, 14);
  text(closeBtn, '✕', 8, 6, 14, 12, C.basalt700, true);

  // Header Title
  text(modal, 'WALKIE-TALKIE RUANG QALBU', 24, 26, 220, 11, C.pine600, true);

  // Visualizer Icon Circle
  const micCircle = box(modal, 'Audio Pulse Circle', W / 2 - 42, 65, 84, 84, C.pine50, 42);
  micCircle.strokes = paint(C.pine100);
  micCircle.strokeWeight = 2;
  // Vector Mic capsule & base
  box(micCircle, 'Mic Head', 34, 20, 16, 26, C.pine600, 8);
  box(micCircle, 'Mic Stem', 39, 48, 6, 12, C.pine600, 2);
  box(micCircle, 'Mic Base', 32, 60, 20, 4, C.pine600, 2);

  // Title & Description
  text(modal, 'Luapkan Isi Hatimu', 30, 165, W - 60, 18, C.basalt900, true);
  text(modal, 'Bicaralah apa adanya tanpa beban. Suara Anda tidak akan disimpan di server mana pun. Rekaman langsung dihapus begitu selesai diproses (E2EE Ephemeral).', 30, 196, W - 60, 11.5, C.basalt700);

  // Audio Equalizer Waveform Graphic
  drawWaveform(modal, W / 2 - 45, 265, C.pine500);

  // Push to talk primary action
  const pttBtn = box(modal, 'Push-to-Talk Primary CTA', 24, 325, W - 48, 56, C.pine600, 28);
  text(pttBtn, 'Tahan untuk Curhat Suara (PTT)', 52, 19, W - 100, 13, C.white, true);

  // Cancel secondary
  text(modal, 'Batalkan & Kembali', 80, 400, W - 160, 12, C.basalt400);
}

// SCREEN 5: TAB 4 RUANG QALBU (DEDICATED VIEW)
{
  const s5 = box(p1, '💬 01.5 • Tab 4 Ruang Qalbu (Dedicated Voice & Chat Hub)', (W + GAP) * 4, 60, W, H, C.sand50, 44);
  s5.clipsContent = true;
  addStatusBar(s5, false);

  text(s5, 'Ruang Qalbu • Curhat Batin AI', 24, 56, 320, 18, C.basalt900, true);
  text(s5, 'Pendampingan fitrah & tazkiyatun nafs', 24, 82, 320, 11, C.basalt400);

  // Privacy Info Banner
  const priv = box(s5, 'Privacy Banner Card', 20, 110, W - 40, 68, C.pine50, 16);
  priv.strokes = paint(C.pine100);
  text(priv, '✦ JAMINAN PRIVASI E2EE & EPHEMERAL', 14, 10, W - 68, 10, C.pine700, true);
  text(priv, 'Rekaman suara langsung dihapus setelah teks dibuat. Tidak ada admin server yang membaca isi curhat Anda.', 14, 28, W - 68, 10.5, C.pine600);

  // Prompt Templates Carousel
  text(s5, 'TOPIK YANG SERING DITANYAKAN', 20, 195, 240, 10, C.basalt400, true);
  const p1Box = box(s5, 'Preset 1', 20, 215, 165, 64, C.white, 14);
  p1Box.strokes = paint(C.cardBorder);
  text(p1Box, 'Anak Menolak Shalat\nSolusi bertahap usia 7 thn', 10, 12, 145, 10.5, C.basalt800, true);

  const p2Box = box(s5, 'Preset 2', 195, 215, 165, 64, C.white, 14);
  p2Box.strokes = paint(C.cardBorder);
  text(p2Box, 'Ortu Merasa Burnout\nLangkah hening sejenak', 10, 12, 145, 10.5, C.basalt800, true);

  // Sample Chat Bubble
  const chatBubble = box(s5, 'AI Companion Bubble', 20, 300, W - 40, 130, C.white, 20);
  chatBubble.strokes = paint(C.cardBorder);
  text(chatBubble, '✦ Teman Curhat AI • Jawaban Tenang', 14, 12, 220, 11, C.pine600, true);
  text(chatBubble, '“Ayah Bunda yang dirahmati Allah, kelelahan Anda hari ini adalah bukti cinta yang tulus. Tarik nafas perlahan... ingatlah bahwa fitrah ananda pada dasarnya mencintai kebaikan.”', 14, 38, W - 68, 11, C.basalt800);
  text(chatBubble, 'Rujukan: QS. Ar-Ra\'d: 28 & Manhaj Fitrah Tarbiyah', 14, 98, W - 68, 9.5, C.amber500, true);

  // PTT Bar at bottom of screen
  const pttDock = box(s5, 'Voice Bar', 20, H - 150, W - 40, 56, C.pine600, 28);
  text(pttDock, 'Tahan Mic untuk Curhat Suara (PTT)', 45, 19, W - 90, 12, C.white, true);

  addBottomDock(s5, 'Curhat');
}

console.log('Page 1 complete.');

// -------------------------------------------------------------
// PAGE 2: STITCH MINIMALIST REDESIGNS
// -------------------------------------------------------------
// SCREEN 1: VARIANT A (NORDIC MIST SANCTUARY)
{
  const vA = box(p2, '🌲 02.1 • Variant A: Nordic Mist Sanctuary', 0, 60, W, H, '#F4F7F6', 44);
  vA.clipsContent = true;
  addStatusBar(vA, true);

  // Top Misty Hero
  const heroA = box(vA, 'Top Misty Canopy (Height 460)', 0, 0, W, 430, '#0C1613', 0);
  heroA.clipsContent = true;
  
  // Ambient glow
  const mistGlow = figma.createEllipse();
  mistGlow.resize(300, 240);
  mistGlow.fills = paint('#14201D');
  heroA.appendChild(mistGlow);
  mistGlow.x = 40;
  mistGlow.y = 10;

  addStatusBar(heroA, true);

  // Gesture badge
  const cueA = box(heroA, 'Gesture Cue', W / 2 - 95, 48, 190, 24, '#00000055', 12);
  cueA.strokes = paint('#FFFFFF22');
  text(cueA, '↓ Tarik ke bawah untuk Mode Jam', 12, 5, 170, 10, '#6EE7B7', true);

  text(heroA, 'Ahlan, Abu Zaid', 24, 82, 200, 20, C.white, true);
  text(heroA, 'Keluarga Tangguh • Baiti Jannati', 24, 108, 220, 11, '#6EE7B7');

  // Frosted Glass Card
  const fGlass = box(heroA, 'Frosted Glass Tadabbur Card', 20, 145, W - 40, 135, '#12201CA6', 20);
  fGlass.strokes = paint('#FFFFFF1F');
  text(fGlass, '✦ RENUNGAN QALBU HARI INI', 16, 12, 200, 10, '#A7C2B7', true);
  text(fGlass, 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ', 20, 36, W - 80, 19, C.white, false, 'Amiri');
  text(fGlass, '“Koneksi Sebelum Koreksi — Tautkan hati dan penuhi bejana cinta sebelum menegakkan aturan.”', 20, 72, W - 80, 11, '#E2E8F0');
  text(fGlass, '(Refleksi Parenting Nabawiyah • QS. Ar-Ra\'d: 28)', 20, 104, W - 80, 9.5, '#6EE7B7');

  // Body Surface
  const bodyA = box(vA, 'Body Surface', 0, 310, W, H - 310, '#F5F7F6', 28);
  const p3kA = box(bodyA, 'P3K Soothing Rose', 20, 20, W - 40, 70, '#FFF1F2', 18);
  p3kA.strokes = paint('#FECDD3');
  text(p3kA, 'P3K KRISIS GENTING', 16, 12, 160, 11, '#9F1239', true);
  pill(p3kA, '< 10 Detik', W - 130, 10, '#E11D48', C.white, 8);
  text(p3kA, 'Tiga tarikan nafas hening, tatap mata lembut...', 16, 36, W - 80, 10.5, '#881337');

  const adabA = box(bodyA, 'Amalan Adab Nordic', 20, 105, W - 40, 100, C.white, 18);
  adabA.strokes = paint(C.cardBorder);
  text(adabA, 'Amalan Adab Hari Ini', 16, 12, 160, 12, C.basalt900, true);
  pill(adabA, '2 / 3 Selesai', W - 135, 10, '#D1FAE5', '#065F46', 9);
  text(adabA, '✓  Bicara Lembut Tanpa Nada Tinggi', 16, 40, W - 80, 11, '#475569');
  text(adabA, '✓  Mendengarkan Cerita Sampai Tuntas', 16, 64, W - 80, 11, '#475569');

  addBottomDock(vA, 'Beranda');
}

// SCREEN 2: VARIANT B (EARTHY FOREST MONASTIC)
{
  const vB = box(p2, '🌲 02.2 • Variant B: Earthy Forest Monastic', W + GAP, 60, W, H, '#F5F1E9', 44);
  vB.clipsContent = true;
  addStatusBar(vB, true);

  // Deep Forest Header
  const heroB = box(vB, 'Deep Cedar Forest Canopy', 0, 0, W, 420, '#0D1F17', 0);
  heroB.clipsContent = true;
  addStatusBar(heroB, true);

  const cueB = box(heroB, 'Gesture Cue', W / 2 - 95, 48, 190, 24, '#1B352699', 12);
  cueB.strokes = paint('#DDA83A44');
  text(cueB, '↓ Tarik ke bawah untuk Mode Jam', 12, 5, 170, 10, '#F2C975', true);

  text(heroB, 'Ahlan, Abu Zaid', 24, 82, 200, 20, C.white, true);
  text(heroB, 'Menemani proses healing qalbu • Baiti Jannati', 24, 108, 240, 11, '#DDE9E2');

  // Monastic Parchment Card
  const mCard = box(heroB, 'Monastic Glass/Parchment Card', 20, 145, W - 40, 135, '#13271DC7', 20);
  mCard.strokes = paint('#BA862455');
  text(mCard, '✦ RENUNGAN MONASTIK QALBU', 16, 12, 200, 10, '#F2C975', true);
  text(mCard, 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ', 20, 36, W - 80, 19, '#FAF8F5', false, 'Amiri');
  text(mCard, '“Koneksi Sebelum Koreksi — Tautkan hati dan penuhi bejana cinta sebelum menegakkan aturan.”', 20, 72, W - 80, 11, '#EBE5D8');
  text(mCard, '(Prinsip Emas Manhaj PKN • QS. Ar-Ra\'d: 28)', 20, 104, W - 80, 9.5, '#DDA83A');

  // Parchment Body
  const bodyB = box(vB, 'Parchment Surface', 0, 310, W, H - 310, '#F5F1E9', 28);
  const p3kB = box(bodyB, 'P3K Terracotta', 20, 20, W - 40, 70, '#FDF6F0', 18);
  p3kB.strokes = paint('#E6CCB8');
  text(p3kB, 'P3K KRISIS GENTING', 16, 12, 160, 11, '#943E1F', true);
  pill(p3kB, '< 10 Detik', W - 130, 10, '#C86843', C.white, 8);
  text(p3kB, 'Dekapan hangat, 3 nafas hening, pandangan sejajar', 16, 36, W - 80, 10.5, '#6E6454');

  addBottomDock(vB, 'Beranda');
}

// SCREEN 3: VARIANT C (ZEN MINIMALIST PAPER)
{
  const vC = box(p2, '🌲 02.3 • Variant C: Zen Minimalist Paper', (W + GAP) * 2, 60, W, H, '#FDFBF7', 44);
  vC.clipsContent = true;
  addStatusBar(vC, true);

  // Pure Dawn Mist Header
  const heroC = box(vC, 'Dawn Mist Canopy', 0, 0, W, 410, '#1A1D1A', 0);
  heroC.clipsContent = true;
  addStatusBar(heroC, true);

  const cueC = box(heroC, 'Gesture Cue Hairline', W / 2 - 95, 48, 190, 24, '#00000040', 12);
  cueC.strokes = paint('#E8E4DC33');
  text(cueC, '↓ Tarik ke bawah untuk Mode Jam', 12, 5, 170, 10, '#FFFFFFEE', true);

  text(heroC, 'Ahlan, Abu Zaid', 24, 82, 200, 20, C.white, true);
  text(heroC, 'Menemani proses healing qalbu • Baiti Jannati', 24, 108, 240, 11, '#CBD5E1');

  // Zen Hairline Card
  const zCard = box(heroC, 'Zen Hairline Tadabbur Card', 20, 145, W - 40, 135, '#00000066', 20);
  zCard.strokes = paint('#FFFFFF33');
  zCard.strokeWeight = 1;
  text(zCard, '✦ RENUNGAN QALBU', 16, 12, 200, 10, '#FBBF24', true);
  text(zCard, 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ', 20, 36, W - 80, 19, C.white, false, 'Amiri');
  text(zCard, '“Ingatlah, hanya dengan mengingat Allah hati menjadi tenteram.”', 20, 72, W - 80, 11, '#E2E8F0');
  text(zCard, '(QS. Ar-Ra\'d: 28)', 20, 104, W - 80, 9.5, '#FBBF24');

  // Washi Paper Body
  const bodyC = box(vC, 'Washi Paper Surface', 0, 310, W, H - 310, '#FDFBF7', 28);
  bodyC.strokes = paint('#E8E4DC');
  bodyC.strokeWeight = 1;

  const p3kC = box(bodyC, 'Hairline P3K Card', 20, 20, W - 40, 68, C.white, 16);
  p3kC.strokes = paint('#FCA5A5');
  p3kC.strokeWeight = 1;
  text(p3kC, 'P3K KRISIS GENTING', 16, 12, 160, 11, '#991B1B', true);
  pill(p3kC, '< 10 Detik', W - 130, 10, '#FEE2E2', '#B91C1C', 8);
  text(p3kC, 'Tiga tarikan nafas hening, tatap mata lembut...', 16, 36, W - 80, 10.5, '#7F1D1D');

  addBottomDock(vC, 'Beranda');
}

console.log('Page 2 complete.');

// -------------------------------------------------------------
// PAGE 3: DESIGN TOKENS & UI KIT
// -------------------------------------------------------------
{
  text(p3, 'PKN HEALING MOBILE APP — DESIGN SYSTEM & TOKENS', 40, 40, 750, 22, C.basalt900, true);
  text(p3, 'Token Warna Earth-Tree, Tipografi Amiri & Plus Jakarta Sans, dan Komponen Reusable', 40, 70, 650, 13, C.basalt400);

  // COLOR SWATCHES
  const colorFamilies = [
    { name: 'Pine (Hutan Sejuk)', colors: [C.pine950, C.pine800, C.pine600, C.pine500, C.pine100, C.pine50] },
    { name: 'Terracotta (Krisis & Darurat)', colors: [C.terracotta700, C.terracotta600, C.terracotta500, C.terracotta200, C.terracotta50] },
    { name: 'Sand & Parchment (Kertas Hangat)', colors: [C.sand600, C.sand400, C.sand200, C.sand100, C.sand50] },
    { name: 'Basalt & Charcoal (Netral)', colors: [C.basalt950, C.basalt900, C.basalt800, C.basalt400, C.basalt100, C.basalt50] },
    { name: 'Amber Monk (Kearifan & Aksen)', colors: [C.amber500, C.amber400, C.amber300, C.emeraldAccent] }
  ];

  let swY = 120;
  colorFamilies.forEach(fam => {
    text(p3, fam.name, 40, swY, 300, 12, C.basalt900, true);
    fam.colors.forEach((col, i) => {
      const sw = box(p3, col, 40 + i * 85, swY + 20, 75, 50, col, 8);
      sw.strokes = paint(C.cardBorder);
      text(sw, col, 6, 32, 65, 9, ['#FFFFFF', '#EDF9F0', '#FDF7F4', '#FDFBF7', '#F7F2E7', '#F6F6F6'].includes(col) ? C.basalt900 : C.white, true);
    });
    swY += 95;
  });

  // TYPOGRAPHY SHOWCASE
  const typoY = swY + 20;
  text(p3, 'TIPOGRAFI HIERARKI', 40, typoY, 300, 13, C.basalt900, true);
  
  const typoBox = box(p3, 'Typo Scale', 40, typoY + 24, 560, 320, C.white, 20);
  typoBox.strokes = paint(C.cardBorder);

  text(typoBox, 'Display Header (22pt Bold) — Menemani Healing Qalbu', 20, 16, 480, 20, C.basalt900, true);
  text(typoBox, 'Arabic Ayat (24pt Amiri) — أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ', 20, 78, 520, 22, C.pine800, false, 'Amiri');
  text(typoBox, 'Subhead (15pt Semi) — Koneksi Sebelum Koreksi', 20, 126, 520, 15, C.basalt800, true);
  text(typoBox, 'Body Text (13pt Regular) — Tautkan hati dan penuhi bejana cinta sebelum aturan.', 20, 160, 520, 13, C.basalt700);
  text(typoBox, 'Digital Clock (38pt Mono) — 10 : 31 : 46', 20, 200, 520, 34, C.amber500, true);
  text(typoBox, 'Caption / Badge (10pt Bold) — P3K KRISIS GENTING < 10 DETIK SOP', 20, 276, 520, 10, C.terracotta600, true);

  // REUSABLE UI KIT
  const kitY = typoY;
  text(p3, 'KOMPONEN MASTER REUSABLE', 640, kitY, 300, 13, C.basalt900, true);
  
  const kitBox = box(p3, 'Components Library', 640, kitY + 24, 480, 420, C.white, 20);
  kitBox.strokes = paint(C.cardBorder);

  // Buttons showcase
  text(kitBox, 'Action Buttons', 20, 16, 200, 11, C.basalt400, true);
  const b1 = box(kitBox, 'Primary Button', 20, 36, 200, 44, C.pine600, 22);
  text(b1, 'Mulai Pertolongan Pertama →', 16, 14, 170, 11, C.white, true);

  const b2 = box(kitBox, 'Danger Button', 240, 36, 200, 44, C.terracotta600, 22);
  text(b2, 'P3K Krisis Genting', 36, 14, 150, 11, C.white, true);

  // Badges showcase
  text(kitBox, 'Pill Badges', 20, 100, 200, 11, C.basalt400, true);
  pill(kitBox, '< 10 Detik SOP', 20, 120, C.terracotta50, C.terracotta600, 9);
  pill(kitBox, 'Ruang Qalbu', 140, 120, C.pine50, C.pine600, 9);
  pill(kitBox, 'Tadabbur Qalbu', 250, 120, '#F59E0B22', C.amber500, 9);
  pill(kitBox, 'Mode Renungan', 370, 120, '#00000022', C.basalt800, 9);

  // Tadabbur Card Component
  text(kitBox, 'Tadabbur Qalbu Card Template', 20, 160, 240, 11, C.basalt400, true);
  const tCard = box(kitBox, 'Tadabbur Card', 20, 180, 440, 110, C.pine950, 16);
  tCard.strokes = paint(C.emeraldAccent);
  text(tCard, '✦ RENUNGAN QALBU HARI INI', 14, 10, 200, 9.5, C.emeraldAccent, true);
  text(tCard, 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ', 14, 30, 400, 18, C.white, false, 'Amiri');
  text(tCard, '“Ingatlah, hanya dengan mengingat Allah hati menjadi tenteram.” (QS. Ar-Ra\'d: 28)', 14, 68, 400, 11, '#CBD5E1');

  // Mini Navigation Dock
  text(kitBox, 'Mini Navigation Dock', 20, 310, 200, 11, C.basalt400, true);
  const miniDock = box(kitBox, 'Dock Component', 20, 330, 440, 50, C.white, 25);
  miniDock.strokes = paint(C.cardBorder);
  text(miniDock, '♡  Curhat Batin AI', 160, 16, 140, 12, C.pine600, true);
}

console.log('Page 3 complete. Master Figma file generation complete!');

({
  pages: figma.root.children.map(p => ({
    name: p.name,
    screensCount: p.children.length
  }))
});
