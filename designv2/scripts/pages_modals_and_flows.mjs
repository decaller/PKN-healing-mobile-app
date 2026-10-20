import { COLORS } from './design_tokens.mjs';

function modalScreenShell(b, { name, x, y, title, subtitle, badgeBg = COLORS.pine[50], badgeFg = COLORS.pine[600], registerScreen, closeTrigger }) {
  const s = b.mobileScreen({
    name,
    x,
    y,
    width: 430,
    height: 1120,
    dark: true,
    showDock: false,
    registerScreen,
  });

  // Top Backdrop Dim Hint
  const dimTop = b.frame({
    name: 'Modal Backdrop Scrim (Tap to Close)',
    parent: s.bodyId,
    width: 390,
    height: 36,
    registerTrigger: closeTrigger,
    props: {
      fill: '#00000080',
      cornerRadius: 12,
      layout: 'horizontal',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [6, 14, 6, 14],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({ parent: dimTop, text: subtitle, props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.sand[200] } });
  b.badge({ parent: dimTop, text: '✕ Tutup', bg: COLORS.basalt[800], fg: COLORS.sand[100], fontSize: 10 });

  // Bottom Sheet Card
  const sheetId = b.frame({
    name: `Bottom Sheet: ${title}`,
    parent: s.bodyId,
    width: 390,
    height: 990,
    props: {
      fill: COLORS.white,
      cornerRadius: 28,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'vertical',
      gap: 12,
      padding: [18, 18, 18, 18],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });

  // Sheet Header
  const hdr = b.frame({
    name: 'Modal Sheet Header',
    parent: sheetId,
    width: 354,
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
    parent: hdr,
    text: title,
    props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 15, fill: COLORS.basalt[900] },
  });
  b.badge({ parent: hdr, text: subtitle, bg: badgeBg, fg: badgeFg, fontSize: 9 });

  return { rootId: s.rootId, sheetId };
}

export function buildModalsAndFlowsPage(b) {
  // =========================================================================
  // PAGE 5: 04 - INTERACTIVE MODALS, P3K TRIAGE & IMMERSIVE FLOWS
  // =========================================================================
  b.addPage('04 - Interactive Modals & Flows', '#0C1210');

  // =========================================================================
  // ROW 1: SMART P3K 2-PHASE EMERGENCY SYSTEM (4 STATES: S08 - S11) + PTT (S12) + RENUNGAN (S13)
  // =========================================================================

  // S08: P3K Genting — Mode Anak Mengamuk
  const s8 = modalScreenShell(b, {
    name: 'S08 • P3K Kondisi Genting — Mode Anak Mengamuk (< 10s)',
    x: 0,
    y: 0,
    title: '🚨 P3K Kondisi Genting',
    subtitle: '👶 Mode Anak',
    badgeBg: COLORS.red[100],
    badgeFg: COLORS.red[700],
    registerScreen: 's08-p3k-genting-anak',
    closeTrigger: 's08:close',
  });

  // Dual Triage Switcher
  const triage8 = b.frame({
    name: 'Dual Triage Switcher (Siapa yang Sedang Genting?)',
    parent: s8.sheetId,
    width: 354,
    height: 44,
    props: { fill: COLORS.sand[100], cornerRadius: 14, layout: 'horizontal', gap: 6, padding: [4, 4, 4, 4], sizingH: 'fill', sizingV: 'fixed' },
  });
  const t8Anak = b.frame({
    name: 'Tab Active: Anak Mengamuk',
    parent: triage8,
    width: 170,
    height: 36,
    props: { fill: COLORS.white, cornerRadius: 10, layout: 'horizontal', mainAlign: 'center', crossAlign: 'center' },
  });
  b.text({ parent: t8Anak, text: '👶 Anak Mengamuk', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.pine[700] } });

  const t8Ortu = b.frame({
    name: 'Tab Switch: Saya Mau Meledak',
    parent: triage8,
    width: 170,
    height: 36,
    registerTrigger: 's08:switch:ortu',
    props: { fill: '#00000000', cornerRadius: 10, layout: 'horizontal', mainAlign: 'center', crossAlign: 'center' },
  });
  b.text({ parent: t8Ortu, text: '🧘 Saya Mau Meledak', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.basalt[500] } });

  // Calm Anchor Visual
  const calm8 = b.frame({
    name: 'Calm Anchor Visual (Hifzhun Nafs)',
    parent: s8.sheetId,
    width: 354,
    height: 92,
    props: { fill: COLORS.basalt[900], cornerRadius: 20, layout: 'vertical', mainAlign: 'spaceBetween', crossAlign: 'center', padding: [12, 14, 12, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: calm8, text: '🛡️ PRIORITAS MAQASHID: HIFZHUN NAFS (KESELAMATAN JIWA NO. 1)', props: { fontSize: 9, fontStyle: 'Bold', fill: COLORS.amber[400] } });
  b.text({ parent: calm8, text: 'Amankan Bahaya & Tahan Lisan', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 16, fill: COLORS.sand[50] } });
  b.text({ parent: calm8, text: 'Tolak bahaya fisik seketika • Anak belum mukallaf (HR. Muslim 3009)', props: { fontSize: 10, fill: COLORS.sand[300] } });

  // 3 Steps
  const stepsAnak = [
    { num: '1 • WAJIB AWAL', col: COLORS.red[600], title: 'Amankan Radius Bahaya Fisik', desc: 'Jauhkan benda tajam/keras, tangga & jalan raya (Hifzhun Nafs)' },
    { num: '2 • GESTUR', col: COLORS.pine[600], title: 'Duduk Rendah Sejajar Mata', desc: 'Rendahkan tubuh, hilangkan gestur intimidasi visual' },
    { num: '3 • RAHMAT', col: COLORS.pine[600], title: 'Dekap Hangat & Diamkan Kata', desc: 'Peluk dadanya erat, puasa ceramah sampai tangis reda' },
  ];
  for (const st of stepsAnak) {
    const stCard = b.frame({
      name: `Step: ${st.title}`,
      parent: s8.sheetId,
      width: 354,
      height: 68,
      props: { fill: COLORS.sand[50], cornerRadius: 16, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [10, 12, 10, 12], sizingH: 'fill', sizingV: 'fixed' },
    });
    b.badge({ parent: stCard, text: st.num, bg: st.col, fg: COLORS.white, fontSize: 9 });
    b.text({ parent: stCard, text: `${st.title} — ${st.desc}`, width: 330, props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.basalt[900] } });
  }

  // 2 Quick Actions SOTAB
  const qRow8 = b.frame({
    name: 'Pilihan Aksi Cepat SOTAB',
    parent: s8.sheetId,
    width: 354,
    height: 64,
    props: { fill: '#00000000', layout: 'horizontal', gap: 10, sizingH: 'fill', sizingV: 'fixed' },
  });
  const q1 = b.frame({
    name: 'Aksi 1: Aman & Mampu',
    parent: qRow8,
    width: 172,
    height: 64,
    props: { fill: COLORS.pine[50], cornerRadius: 14, stroke: COLORS.pine[500], strokeWeight: 2, layout: 'vertical', mainAlign: 'center', crossAlign: 'center', padding: [8, 10, 8, 10], sizingH: 'fixed', sizingV: 'fixed' },
  });
  b.text({ parent: q1, text: 'Aman & Mampu?\nPenuhi Sekarang ✓', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.pine[700], textAlign: 'center' } });

  const q2 = b.frame({
    name: 'Aksi 2: Bahaya / Tak Aman',
    parent: qRow8,
    width: 172,
    height: 64,
    props: { fill: COLORS.amber[50], cornerRadius: 14, stroke: COLORS.amber[500], strokeWeight: 2, layout: 'vertical', mainAlign: 'center', crossAlign: 'center', padding: [8, 10, 8, 10], sizingH: 'fixed', sizingV: 'fixed' },
  });
  b.text({ parent: q2, text: 'Bahaya / Tak Aman?\nAmankan & Dekap 🛡️', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.amber[700], textAlign: 'center' } });

  b.button({
    parent: s8.sheetId,
    label: '✓ Alhamdulillah, Anak Sudah Tenang ➔',
    bg: COLORS.pine[600],
    fg: COLORS.white,
    width: 'fill',
    height: 48,
    radius: 16,
    fontSize: 12,
    registerTrigger: 's08:to:stabil-anak',
  });

  // =========================================================================
  // S09: P3K Genting — Mode Orang Tua Mau Meledak (Self-Regulation & 60s Breath)
  // =========================================================================
  const s9 = modalScreenShell(b, {
    name: 'S09 • P3K Kondisi Genting — Mode Ortu Mau Meledak (60s Breath)',
    x: 490,
    y: 0,
    title: '🚨 P3K Kondisi Genting',
    subtitle: '🧘 Mode Orang Tua',
    badgeBg: COLORS.terracotta[100],
    badgeFg: COLORS.terracotta[600],
    registerScreen: 's09-p3k-genting-ortu',
    closeTrigger: 's09:close',
  });

  const triage9 = b.frame({
    name: 'Dual Triage Switcher',
    parent: s9.sheetId,
    width: 354,
    height: 44,
    props: { fill: COLORS.sand[100], cornerRadius: 14, layout: 'horizontal', gap: 6, padding: [4, 4, 4, 4], sizingH: 'fill', sizingV: 'fixed' },
  });
  const t9Anak = b.frame({
    name: 'Tab Switch: Anak Mengamuk',
    parent: triage9,
    width: 170,
    height: 36,
    registerTrigger: 's09:switch:anak',
    props: { fill: '#00000000', cornerRadius: 10, layout: 'horizontal', mainAlign: 'center', crossAlign: 'center' },
  });
  b.text({ parent: t9Anak, text: '👶 Anak Mengamuk', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.basalt[500] } });

  const t9Ortu = b.frame({
    name: 'Tab Active: Saya Mau Meledak',
    parent: triage9,
    width: 170,
    height: 36,
    props: { fill: COLORS.white, cornerRadius: 10, layout: 'horizontal', mainAlign: 'center', crossAlign: 'center' },
  });
  b.text({ parent: t9Ortu, text: '🧘 Saya Mau Meledak', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.terracotta[600] } });

  const calm9 = b.frame({
    name: 'Calm Anchor Visual (Darul Mafasid)',
    parent: s9.sheetId,
    width: 354,
    height: 92,
    props: {
      fills: [{ type: 'linearGradient', stops: [COLORS.terracotta[900], COLORS.basalt[950]] }],
      cornerRadius: 20,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [12, 14, 12, 14],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({ parent: calm9, text: "🛡️ DAR'UL MAFASID • CEGAH BAHAYA & KEKERASAN FISIK", props: { fontSize: 9, fontStyle: 'Bold', fill: COLORS.terracotta[300] } });
  b.text({ parent: calm9, text: 'Lepas Kontak Fisik. Kunci Mulut.', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 16, fill: COLORS.sand[50] } });
  b.text({ parent: calm9, text: 'Amankan anak seketika • Diam adalah keselamatan (HR. Ahmad)', props: { fontSize: 10, fill: COLORS.sand[300] } });

  const stepsOrtu = [
    { num: '1 • HIFZHUN NAFS', col: COLORS.red[600], title: 'Amankan Anak & Lepas Kontak Fisik', desc: 'Letakkan di kasur/lantai aman, segera mundur 2-3 langkah' },
    { num: '2 • KUNCI LISAN', col: COLORS.terracotta[600], title: 'Puasa Lisan Mutlak (Kunci Mulut)', desc: 'Jangan bicara 1 kata pun. Tahan bentakan & doa buruk (HR. Ahmad)' },
    { num: '3 • SUNNAH FISIK', col: COLORS.terracotta[600], title: 'Ubah Posisi Fisik & Basuh Air Dingin', desc: 'Segera duduk/berbaring (HR. Abu Dawud 4782) & wudhu padamkan api' },
  ];
  for (const st of stepsOrtu) {
    const stCard = b.frame({
      name: `Step: ${st.title}`,
      parent: s9.sheetId,
      width: 354,
      height: 64,
      props: { fill: COLORS.sand[50], cornerRadius: 16, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [8, 12, 8, 12], sizingH: 'fill', sizingV: 'fixed' },
    });
    b.badge({ parent: stCard, text: st.num, bg: st.col, fg: COLORS.white, fontSize: 9 });
    b.text({ parent: stCard, text: `${st.title} — ${st.desc}`, width: 330, props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.basalt[900] } });
  }

  // Interactive Guided Breathing Box (60s)
  const breathBox = b.frame({
    name: 'Interactive Guided Breathing (Kalibrasi Nafas Nabawi 60s)',
    parent: s9.sheetId,
    width: 354,
    height: 196,
    props: {
      fill: COLORS.sand[100],
      cornerRadius: 20,
      stroke: COLORS.sand[200],
      strokeWeight: 1,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [12, 14, 12, 14],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({ parent: breathBox, text: '🌬️ Kalibrasi Nafas Nabawi (60 Detik) • Tarik 4s — Tahan 4s — Hembuskan 4s', width: 326, props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.terracotta[600], textAlign: 'center' } });
  const breathCircle = b.frame({
    name: 'Animated Breath Circle',
    parent: breathBox,
    width: 64,
    height: 64,
    props: {
      fills: [{ type: 'linearGradient', stops: [COLORS.terracotta[500], COLORS.amber[400]] }],
      cornerRadius: 999,
      layout: 'horizontal',
      mainAlign: 'center',
      crossAlign: 'center',
    },
  });
  b.text({ parent: breathCircle, text: 'Hening\n60s', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.white, textAlign: 'center' } });
  b.text({
    parent: breathBox,
    text: 'أَعُوْذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ',
    props: { fontFamily: 'Amiri', fontStyle: 'Regular', fontSize: 16, fill: COLORS.basalt[900] },
  });
  b.text({
    parent: breathBox,
    text: '"Aku berlindung kepada Allah dari setan yang terkutuk"',
    props: { fontSize: 10, fontStyle: 'Italic', fill: COLORS.basalt[600] },
  });

  b.button({
    parent: s9.sheetId,
    label: '🧘 Alhamdulillah, Hati Saya Sudah Tenang ➔',
    bg: COLORS.terracotta[600],
    fg: COLORS.white,
    width: 'fill',
    height: 48,
    radius: 16,
    fontSize: 12,
    registerTrigger: 's09:to:stabil-ortu',
  });

  // =========================================================================
  // S10: P3K Kondisi Stabil — Pemulihan Anak (Pasca-Reda & Munajat)
  // =========================================================================
  const s10 = modalScreenShell(b, {
    name: 'S10 • P3K Kondisi Stabil — Pemulihan Anak (Pasca-Reda)',
    x: 980,
    y: 0,
    title: '🟢 Kondisi Stabil • Pemulihan Anak',
    subtitle: '← SOP Darurat',
    badgeBg: COLORS.pine[50],
    badgeFg: COLORS.pine[600],
    registerScreen: 's10-p3k-stabil-anak',
    closeTrigger: 's10:close',
  });

  const win10 = b.frame({
    name: 'Apresiasi Kemenangan Batin (Kazhmul Ghaizh)',
    parent: s10.sheetId,
    width: 354,
    height: 82,
    props: { fill: COLORS.pine[50], cornerRadius: 18, stroke: COLORS.pine[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [12, 14, 12, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: win10, text: '✅ Masya Allah, Anda Berhasil Menahan Diri', props: { fontSize: 12, fontStyle: 'Bold', fill: COLORS.pine[800] } });
  b.text({ parent: win10, text: 'Badai emosi telah berlalu tanpa bentakan. Anda telah memenangkan pahala Kazhmul Ghaizh (menahan amarah) di sisi Allah.', width: 326, props: { fontSize: 10, fill: COLORS.pine[700], lineHeight: 15 } });

  const goldRule = b.frame({
    name: 'Kaidah Emas Terpenting SOTAB',
    parent: s10.sheetId,
    width: 354,
    height: 92,
    props: { fill: COLORS.amber[50], cornerRadius: 18, stroke: COLORS.amber[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [12, 14, 12, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: goldRule, text: '⚠️ KAIDAH EMAS: JANGAN DIBAHAS LAGI!', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.amber[700] } });
  b.text({ parent: goldRule, text: 'Setelah tantrum selesai, jangan diceramahi, jangan dihakimi, dan jangan diungkit lagi. Cukup tersenyum teduh, berikan segelas air putih hangat, dan peluk kembali anak Anda.', width: 326, props: { fontSize: 10, fill: COLORS.basalt[700], lineHeight: 15 } });

  const munajatCard = b.frame({
    name: "Munajat Penyerahan Didik (Imam Fudhail bin 'Iyadh)",
    parent: s10.sheetId,
    width: 354,
    height: 128,
    props: { fill: COLORS.white, cornerRadius: 18, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [12, 14, 12, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: munajatCard, text: "MUNAJAT PENYERAHAN DIDIK  •  Imam Fudhail bin 'Iyadh", props: { fontSize: 9, fontStyle: 'Bold', fill: COLORS.amber[600] } });
  b.text({
    parent: munajatCard,
    text: 'اللَّهُمَّ إِنِّيْ اجْتَهَدْتُ أَنْ أَؤدِّبَهُ فَلَمْ أَقْدِرْ عَلَى تَأَدِيْبِهِ فَأَدِّبْهُ أَنْتَ لِي',
    width: 326,
    props: { fontFamily: 'Amiri', fontSize: 16, fill: COLORS.basalt[900], textAlign: 'right' },
  });
  b.text({
    parent: munajatCard,
    text: '"Ya Allah, sesungguhnya aku telah berusaha mendidik anakku namun aku tidak berdaya, maka didiklah dia untukku."',
    width: 326,
    props: { fontSize: 10, fontStyle: 'Italic', fill: COLORS.basalt[600] },
  });

  const edu10 = b.frame({
    name: 'Accordion: Mengapa Tantrum Itu Disebut Indah?',
    parent: s10.sheetId,
    width: 354,
    height: 116,
    props: { fill: COLORS.sand[50], cornerRadius: 16, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [12, 14, 12, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: edu10, text: '▼ Mengapa Tantrum Itu Disebut Indah? (Ust. Abdul Kholiq)', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.basalt[800] } });
  b.text({
    parent: edu10,
    text: '• Bukan Gangguan Jiwa: Mekanisme fitrah otomatis agar anak tidak memendam racun emosi (< 10 th).\n• Mencegah Hutang Pengasuhan: Anak yang diterima emosinya saat balita terhindar dari pemberontakan pubertas.',
    width: 326,
    props: { fontSize: 10, fill: COLORS.basalt[600], lineHeight: 14 },
  });

  b.button({
    parent: s10.sheetId,
    label: 'Tutup & Lanjutkan Aktivitas',
    bg: COLORS.basalt[800],
    fg: COLORS.white,
    width: 'fill',
    height: 46,
    radius: 14,
    fontSize: 12,
    registerTrigger: 's10:done',
  });

  // =========================================================================
  // S11: P3K Kondisi Stabil — Pemulihan Jiwa Orang Tua (HALT & Doa Musa)
  // =========================================================================
  const s11 = modalScreenShell(b, {
    name: 'S11 • P3K Kondisi Stabil — Pemulihan Jiwa Orang Tua (HALT)',
    x: 1470,
    y: 0,
    title: '🟢 Kondisi Stabil • Pemulihan Ortu',
    subtitle: '← SOP Darurat',
    badgeBg: COLORS.terracotta[50],
    badgeFg: COLORS.terracotta[600],
    registerScreen: 's11-p3k-stabil-ortu',
    closeTrigger: 's11:close',
  });

  const win11 = b.frame({
    name: 'Apresiasi Kemenangan Menahan Amarah',
    parent: s11.sheetId,
    width: 354,
    height: 82,
    props: { fill: COLORS.pine[50], cornerRadius: 18, stroke: COLORS.pine[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [12, 14, 12, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: win11, text: '🎖️ Alhamdulillah, Anda Memenangkan Perang Melawan Nafsu', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.pine[800] } });
  b.text({ parent: win11, text: '"Bukanlah orang kuat itu yang menang bergulat, melainkan orang yang mampu menguasai dirinya saat marah." (HR. Bukhari no. 6114)', width: 326, props: { fontSize: 10, fill: COLORS.pine[700], lineHeight: 15 } });

  const haltCard = b.frame({
    name: 'Checklist Pemulihan Diri Orang Tua (HALT)',
    parent: s11.sheetId,
    width: 354,
    height: 118,
    props: { fill: COLORS.amber[50], cornerRadius: 18, stroke: COLORS.amber[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [12, 14, 12, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: haltCard, text: '🛡️ CHECKLIST PEMULIHAN DIRI ORANG TUA (HALT):', props: { fontSize: 11, fontStyle: 'Bold', fill: COLORS.amber[700] } });
  b.text({
    parent: haltCard,
    text: '💧 Minum 1 Gelas Air Hangat: Rehidrasi tubuh untuk menstabilkan kortisol.\n🛌 Cek Kebutuhan Fisik (HALT): Kurang tidur, lapar, atau sedang lelah?\n🤝 Minta Bantuan Pasangan: Titipkan anak 15-30 menit tanpa rasa bersalah.',
    width: 326,
    props: { fontSize: 10, fill: COLORS.basalt[700], lineHeight: 15 },
  });

  const musaCard = b.frame({
    name: 'Doa Kelapangan Dada (QS. Thaha: 25-26)',
    parent: s11.sheetId,
    width: 354,
    height: 112,
    props: { fill: COLORS.white, cornerRadius: 18, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [12, 14, 12, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: musaCard, text: 'DOA KELAPANGAN DADA  •  QS. Thaha: 25-26', props: { fontSize: 9, fontStyle: 'Bold', fill: COLORS.pine[600] } });
  b.text({
    parent: musaCard,
    text: 'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي',
    width: 326,
    props: { fontFamily: 'Amiri', fontSize: 18, fill: COLORS.basalt[900], textAlign: 'right' },
  });
  b.text({
    parent: musaCard,
    text: '"Ya Rabbku, lapangkanlah untukku dadaku, dan mudahkanlah untukku urusanku."',
    width: 326,
    props: { fontSize: 10, fontStyle: 'Italic', fill: COLORS.basalt[600] },
  });

  b.button({
    parent: s11.sheetId,
    label: 'Tutup & Lanjutkan Aktivitas',
    bg: COLORS.basalt[800],
    fg: COLORS.white,
    width: 'fill',
    height: 46,
    radius: 14,
    fontSize: 12,
    registerTrigger: 's11:done',
  });

  // =========================================================================
  // S12: Modal Walkie-Talkie Ruang Qalbu (PTT Active Recording Demo)
  // =========================================================================
  const s12 = modalScreenShell(b, {
    name: 'S12 • Modal: Walkie-Talkie Ruang Qalbu (PTT Voice Ephemeral)',
    x: 1960,
    y: 0,
    title: '🎙️ Walkie-Talkie Ruang Qalbu',
    subtitle: 'Ephemeral E2EE',
    badgeBg: COLORS.pine[50],
    badgeFg: COLORS.pine[600],
    registerScreen: 's12-modal-curhat-ptt',
    closeTrigger: 's12:close',
  });

  const pttCenter = b.frame({
    name: 'PTT Hero & Waveform Box',
    parent: s12.sheetId,
    width: 354,
    height: 260,
    props: { fill: COLORS.sand[50], cornerRadius: 24, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', crossAlign: 'center', padding: [24, 20, 24, 20], sizingH: 'fill', sizingV: 'fixed' },
  });
  const micCircle = b.frame({
    name: 'Mic Pulse Icon Circle',
    parent: pttCenter,
    width: 64,
    height: 64,
    props: { fill: COLORS.pine[50], cornerRadius: 999, stroke: COLORS.pine[500], strokeWeight: 2, layout: 'horizontal', mainAlign: 'center', crossAlign: 'center' },
  });
  b.text({ parent: micCircle, text: '🎙️', props: { fontSize: 24 } });
  b.text({ parent: pttCenter, text: 'Luapkan Isi Hatimu', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 18, fill: COLORS.basalt[900] } });
  b.text({
    parent: pttCenter,
    text: 'Bicaralah apa adanya. Suara Anda tidak akan disimpan di server mana pun (langsung dihancurkan seketika setelah transkrip lokal selesai).',
    width: 314,
    props: { fontSize: 11, fill: COLORS.basalt[500], textAlign: 'center', lineHeight: 16 },
  });
  b.badge({ parent: pttCenter, text: '▂ ▄ ▆ █ ▄ ▇ ▃   LIVING WAVEFORM ACTIVE', bg: COLORS.pine[100], fg: COLORS.pine[800], fontSize: 11, padding: [8, 16, 8, 16] });

  b.button({
    parent: s12.sheetId,
    label: '🎙️ Tahan untuk Bicara (Lepaskan untuk Selesai)',
    bg: COLORS.pine[600],
    fg: COLORS.white,
    width: 'fill',
    height: 52,
    radius: 16,
    fontSize: 13,
    registerTrigger: 's12:finish-ptt',
  });
  b.button({
    parent: s12.sheetId,
    label: 'Batalkan & Kembali ke Beranda',
    bg: COLORS.sand[100],
    fg: COLORS.basalt[600],
    width: 'fill',
    height: 42,
    radius: 14,
    fontSize: 11,
    registerTrigger: 's12:cancel',
  });

  // =========================================================================
  // S13: Full-Screen Mode Renungan (Tadabbur & Digital Clock Slideshow)
  // =========================================================================
  const s13 = b.mobileScreen({
    name: 'S13 • Full-Screen Mode Renungan (Tadabbur & Digital Clock)',
    x: 2450,
    y: 0,
    width: 430,
    height: 1120,
    dark: true,
    showDock: false,
    registerScreen: 's13-mode-renungan',
  });

  const renBg = b.frame({
    name: 'Serene Forest Meditative Canvas',
    parent: s13.bodyId,
    width: 390,
    height: 1040,
    props: {
      fills: [{ type: 'linearGradient', stops: ['#041B0E', '#092616', '#050806'] }],
      cornerRadius: 28,
      stroke: COLORS.pine[800],
      strokeWeight: 1,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [24, 20, 28, 20],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });

  const renTop = b.frame({
    name: 'Renungan Top Header',
    parent: renBg,
    width: 350,
    height: 36,
    props: { fill: '#00000000', layout: 'horizontal', mainAlign: 'spaceBetween', crossAlign: 'center', sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: renTop, text: '🟢 MODE RENUNGAN • TADABBUR QALBU', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.emerald[300] } });
  const renCloseBtn = b.frame({
    name: 'Btn Tutup Renungan',
    parent: renTop,
    width: 72,
    height: 30,
    registerTrigger: 's13:close',
    props: { fill: '#FFFFFF26', cornerRadius: 999, layout: 'horizontal', mainAlign: 'center', crossAlign: 'center' },
  });
  b.text({ parent: renCloseBtn, text: '✕ Tutup', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.white } });

  // Center Quote Slideshow Card
  const renQuoteCard = b.frame({
    name: 'Center Big Quote Slideshow (6 Quotes)',
    parent: renBg,
    width: 350,
    height: 360,
    props: {
      fill: '#00000066',
      cornerRadius: 24,
      stroke: '#FFFFFF26',
      strokeWeight: 1,
      layout: 'vertical',
      mainAlign: 'spaceBetween',
      crossAlign: 'center',
      padding: [28, 20, 28, 20],
      sizingH: 'fill',
      sizingV: 'fixed',
    },
  });
  b.text({ parent: renQuoteCard, text: '❝', props: { fontSize: 36, fontStyle: 'Bold', fill: COLORS.amber[400] } });
  b.text({
    parent: renQuoteCard,
    text: 'لَيْسَ الشَّدِيدُ بِالصُّرَعَةِ، إِنَّمَا الشَّدِيدُ الَّذِي يَمْلِكُ نَفْسَهُ عِنْدَ الْغَضَبِ',
    width: 310,
    props: { fontFamily: 'Amiri', fontSize: 22, fill: COLORS.amber[200], textAlign: 'center' },
  });
  b.text({
    parent: renQuoteCard,
    text: '“Bukanlah orang yang kuat itu yang pandai bergulat, melainkan orang yang mampu menahan dirinya ketika sedang marah.”',
    width: 310,
    props: { fontFamily: 'Merriweather', fontStyle: 'Italic', fontSize: 15, fill: COLORS.sand[50], textAlign: 'center', lineHeight: 22 },
  });
  b.text({
    parent: renQuoteCard,
    text: '— HR. BUKHARI NO. 6114 & MUSLIM NO. 2609',
    props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.emerald[300] },
  });
  b.badge({ parent: renQuoteCard, text: '◀   ●  ━━━  ●  ●  ●  ●   ▶', bg: '#FFFFFF1A', fg: COLORS.amber[300], fontSize: 11, padding: [6, 16, 6, 16] });

  // Bottom Digital Clock & Swipe-Up Exit
  const renBottom = b.frame({
    name: 'Real-Time Digital Clock & Hijri Date',
    parent: renBg,
    width: 350,
    height: 220,
    props: { fill: '#00000000', layout: 'vertical', mainAlign: 'spaceBetween', crossAlign: 'center', sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({
    parent: renBottom,
    text: '09:41:28',
    props: { fontSize: 44, fontStyle: 'Bold', fill: COLORS.sand[50] },
  });
  b.text({
    parent: renBottom,
    text: 'Rabu, 14 Oktober 2026 • 3 Rabiul Akhir 1448 H',
    props: { fontSize: 11, fontStyle: 'Medium', fill: COLORS.sand[300] },
  });
  b.text({
    parent: renBottom,
    text: '"Hati yang hening adalah tempat turunnya taufiq dan kesabaran."',
    props: { fontSize: 11, fontStyle: 'Italic', fill: COLORS.emerald[300] },
  });
  b.button({
    parent: renBottom,
    label: '↑ Geser ke Atas untuk Kembali ke Beranda',
    bg: '#FFFFFF26',
    fg: COLORS.white,
    width: 310,
    height: 42,
    radius: 999,
    fontSize: 11,
    registerTrigger: 's13:swipe-up',
  });

  // =========================================================================
  // ROW 2: UTILITY & CURRICULUM MODALS (S14 - S20)
  // =========================================================================

  // S14: Generator RPP Adab 1 Lembar
  const s14 = modalScreenShell(b, {
    name: 'S14 • Modal: Generator RPP Adab 1 Lembar (SOTAB)',
    x: 0,
    y: 1200,
    title: '📝 Generator RPP Adab 1 Lembar',
    subtitle: 'Standar SOTAB',
    badgeBg: COLORS.pine[50],
    badgeFg: COLORS.pine[600],
    registerScreen: 's14-modal-rpp',
    closeTrigger: 's14:close',
  });
  const rppInfo = b.frame({
    name: 'Format Standar Litbang SOTAB',
    parent: s14.sheetId,
    width: 354,
    height: 68,
    props: { fill: COLORS.pine[50], cornerRadius: 16, stroke: COLORS.pine[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [10, 12, 10, 12], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: rppInfo, text: 'FORMAT STANDAR LITBANG SOTAB:', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.pine[700] } });
  b.text({ parent: rppInfo, text: 'Menyusun respon KBM adab mikro & terukur per situasi nyata di kelas atau di rumah.', width: 330, props: { fontSize: 10, fill: COLORS.basalt[700] } });

  const rppFields = [
    { lbl: 'Fase Usia Target:', val: 'Fase Tamyiz (7–10 Tahun) • Usia 8 Th Zaid  ▼' },
    { lbl: 'Situasi Lapangan / Masalah Adab:', val: 'Anak mogok shalat maghrib karena bermain rakitan lego' },
    { lbl: 'Fokus Indikator Karakter (19 Butir):', val: '✓ Butir 04: Kepatuhan adab tanpa amarah (Kazhmul Ghaizh)\n✓ Butir 08: Penghormatan waktu ibadah syar’i' },
    { lbl: '3 Langkah Intervensi Nabawiyah:', val: '1. Dekati raga: Usap kepala, sentuhan rahmat < 1 m.\n2. Validasi minat: "Bagus sekali rakitanmu, simpan dulu 15 menit ya."\n3. Tautkan tauhid: "Allah mencintai ksatria yang shalat tepat waktu."' },
  ];
  for (const rf of rppFields) {
    const fBox = b.frame({
      name: rf.lbl,
      parent: s14.sheetId,
      width: 354,
      height: 82,
      props: { fill: COLORS.sand[50], cornerRadius: 14, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [10, 12, 10, 12], sizingH: 'fill', sizingV: 'fixed' },
    });
    b.text({ parent: fBox, text: rf.lbl, props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.basalt[800] } });
    b.text({ parent: fBox, text: rf.val, width: 330, props: { fontSize: 10, fill: COLORS.basalt[600], lineHeight: 14 } });
  }
  b.button({
    parent: s14.sheetId,
    label: '💾 Simpan RPP 1 Lembar & Cetak PDF',
    bg: COLORS.pine[600],
    fg: COLORS.white,
    width: 'fill',
    height: 46,
    radius: 14,
    fontSize: 12,
    registerTrigger: 's14:save',
  });

  // S15: Modul Adab Harian Mikro (Bab 3/5)
  const s15 = modalScreenShell(b, {
    name: 'S15 • Modal: Modul Adab Harian Mikro (Bab 3/5)',
    x: 490,
    y: 1200,
    title: '📘 Modul Adab Harian Mikro',
    subtitle: 'Progress 65%',
    badgeBg: COLORS.blue[50],
    badgeFg: COLORS.blue[600],
    registerScreen: 's15-modal-modul',
    closeTrigger: 's15:close',
  });
  const modHero = b.frame({
    name: 'Active Module Progress Card',
    parent: s15.sheetId,
    width: 354,
    height: 88,
    props: { fill: COLORS.blue[50], cornerRadius: 16, stroke: COLORS.blue[100], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [12, 14, 12, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: modHero, text: 'MODUL SEDANG BERJALAN:', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.blue[700] } });
  b.text({ parent: modHero, text: 'Membangun Kedekatan Kalbu Sebelum Koreksi (Bab 3 dari 5)', width: 326, props: { fontSize: 12, fontStyle: 'Bold', fill: COLORS.basalt[900] } });
  b.text({ parent: modHero, text: '█████████████░░░░░░░   Progress: 65% • Tersisa 8 Menit', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.blue[600] } });

  const chaps = [
    { title: 'Bab 1: Hakikat Hubungan Sebelum Aturan', status: 'Selesai ✓', active: false },
    { title: 'Bab 2: Anatomi Amigdala Anak Tamyiz', status: 'Selesai ✓', active: false },
    { title: 'Bab 3: Teknik Resonansi Suara Rendah', status: 'Sedang Aktif ●', active: true },
    { title: 'Bab 4: SOP Dialog Pasca Badai Marah', status: 'Terkunci 🔒', active: false },
    { title: 'Bab 5: Ikrar Ketaatan Tanpa Rasa Terpaksa', status: 'Terkunci 🔒', active: false },
  ];
  for (const ch of chaps) {
    const chRow = b.frame({
      name: ch.title,
      parent: s15.sheetId,
      width: 354,
      height: 46,
      props: {
        fill: ch.active ? COLORS.blue[50] : COLORS.sand[50],
        cornerRadius: 12,
        stroke: ch.active ? COLORS.blue[400] : COLORS.sand[200],
        strokeWeight: 1,
        layout: 'horizontal',
        mainAlign: 'spaceBetween',
        crossAlign: 'center',
        padding: [10, 12, 10, 12],
        sizingH: 'fill',
        sizingV: 'fixed',
      },
    });
    b.text({ parent: chRow, text: ch.title, props: { fontSize: 11, fontStyle: ch.active ? 'Bold' : 'Medium', fill: COLORS.basalt[900] } });
    b.text({ parent: chRow, text: ch.status, props: { fontSize: 10, fontStyle: 'Bold', fill: ch.active ? COLORS.blue[600] : COLORS.pine[600] } });
  }
  b.button({
    parent: s15.sheetId,
    label: '▶ Lanjutkan Bab 3 Sekarang',
    bg: COLORS.blue[600],
    fg: COLORS.white,
    width: 'fill',
    height: 46,
    radius: 14,
    fontSize: 12,
    registerTrigger: 's15:play',
  });

  // S16: Kumpulan Doa Penenang Hati & Amarah
  const s16 = modalScreenShell(b, {
    name: 'S16 • Modal: Kumpulan Doa Penenang Hati & Amarah',
    x: 980,
    y: 1200,
    title: '🤲 Kumpulan Doa Penenang Hati',
    subtitle: "Takhrij Syar'i",
    badgeBg: COLORS.amber[50],
    badgeFg: COLORS.amber[600],
    registerScreen: 's16-modal-doa',
    closeTrigger: 's16:close',
  });
  const doa1 = b.frame({
    name: 'Doa 1: Kelembutan Hati Keluarga (QS. Al-Furqan: 74)',
    parent: s16.sheetId,
    width: 354,
    height: 170,
    props: { fill: COLORS.amber[50], cornerRadius: 18, stroke: COLORS.amber[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [14, 14, 14, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: doa1, text: 'DOA KELEMBUTAN HATI KELUARGA  •  QS. Al-Furqan: 74', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.amber[700] } });
  b.text({
    parent: doa1,
    text: 'رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا',
    width: 326,
    props: { fontFamily: 'Amiri', fontSize: 18, fill: COLORS.basalt[900], textAlign: 'right' },
  });
  b.text({
    parent: doa1,
    text: '"Ya Tuhan kami, anugerahkanlah kepada kami pasangan kami dan keturunan kami sebagai penyenang hati (kami), dan jadikanlah kami pemimpin bagi orang-orang yang bertakwa."',
    width: 326,
    props: { fontSize: 10, fontStyle: 'Italic', fill: COLORS.basalt[700], lineHeight: 15 },
  });

  const doa2 = b.frame({
    name: 'Doa 2: Meredakan Gejolak Marah (HR. Bukhari & Muslim)',
    parent: s16.sheetId,
    width: 354,
    height: 150,
    props: { fill: COLORS.sand[50], cornerRadius: 18, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [14, 14, 14, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.text({ parent: doa2, text: 'DOA MEREDAKAN GEJOLAK MARAH  •  HR. Bukhari & Muslim', props: { fontSize: 10, fontStyle: 'Bold', fill: COLORS.pine[600] } });
  b.text({
    parent: doa2,
    text: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ',
    width: 326,
    props: { fontFamily: 'Amiri', fontSize: 18, fill: COLORS.basalt[900], textAlign: 'right' },
  });
  b.text({
    parent: doa2,
    text: '"Aku berlindung kepada Allah dari godaan setan yang terkutuk."\nSunnah: Ucapkan saat amarah memuncak, lalu ubah posisi duduk/berwudhu.',
    width: 326,
    props: { fontSize: 10, fill: COLORS.basalt[600], lineHeight: 15 },
  });

  b.button({
    parent: s16.sheetId,
    label: '📌 Sematkan ke Amalan Harian',
    bg: COLORS.amber[600],
    fg: COLORS.white,
    width: 'fill',
    height: 46,
    radius: 14,
    fontSize: 12,
    registerTrigger: 's16:pin',
  });

  // S17: Cermin Bakat Fitrah (TB-40)
  const s17 = modalScreenShell(b, {
    name: 'S17 • Modal: Cermin Bakat Fitrah TB-40 (6 Rumpun)',
    x: 1470,
    y: 1200,
    title: '🧭 Cermin Bakat Fitrah (TB-40)',
    subtitle: '6 Rumpun Fitrah',
    badgeBg: COLORS.terracotta[50],
    badgeFg: COLORS.terracotta[600],
    registerScreen: 's17-modal-tb40',
    closeTrigger: 's17:close',
  });
  b.text({
    parent: s17.sheetId,
    text: 'TB-40 adalah pemetaan 40 potensi fitrah bawaan (syakilah) yang terbagi dalam 6 rumpun kenabian:',
    width: 354,
    props: { fontSize: 11, fill: COLORS.basalt[600] },
  });
  const rumpunList = [
    { title: '1. Al-Qiyadah (Kepemimpinan & Inisiatif)', desc: 'Ketegasan visi, keberanian mengambil keputusan, dan tanggung jawab jamaah.', col: COLORS.terracotta[600] },
    { title: '2. Al-Fikr (Gaya Nalar & Analisa)', desc: 'Kedalaman tafakkur, pemecahan masalah terstruktur, dan hikmah ilmiah.', col: COLORS.pine[600] },
    { title: '3. Al-Idarah (Keteraturan & Kedisiplinan)', desc: 'Kerapian tata kelola, ketepatan waktu, dan penjagaan amanah sistem.', col: COLORS.amber[600] },
    { title: "4. Al-Ijtima'i (Empati & Hubungan Sosial)", desc: 'Kepekaan kalbu, kemampuan menyatukan hati, dan pelayanan umat.', col: COLORS.blue[600] },
    { title: "5. Ash-Shina'ah (Kriya, Fisik & Ketekunan)", desc: 'Ketangkasan tangan, ketahanan jasmani, dan karya nyata presisi.', col: COLORS.purple[600] },
    { title: '6. Al-Hifzh (Daya Simpan & Penjagaan)', desc: 'Kekuatan hafalan sanad/matan, ketelitian, dan penjagaan khazanah.', col: COLORS.emerald[600] },
  ];
  for (const rp of rumpunList) {
    const rpCard = b.frame({
      name: rp.title,
      parent: s17.sheetId,
      width: 354,
      height: 54,
      props: { fill: COLORS.sand[50], cornerRadius: 12, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [8, 12, 8, 12], sizingH: 'fill', sizingV: 'fixed' },
    });
    b.text({ parent: rpCard, text: rp.title, props: { fontSize: 11, fontStyle: 'Bold', fill: rp.col } });
    b.text({ parent: rpCard, text: rp.desc, width: 330, props: { fontSize: 9, fill: COLORS.basalt[600] } });
  }
  b.button({
    parent: s17.sheetId,
    label: 'Lihat Profil TB-40 Ananda Zaid ➔',
    bg: COLORS.terracotta[600],
    fg: COLORS.white,
    width: 'fill',
    height: 46,
    radius: 14,
    fontSize: 12,
    registerTrigger: 's17:to:profil',
  });

  // S18: Latihan Hening Qalbu (3 Menit Timer)
  const s18 = modalScreenShell(b, {
    name: 'S18 • Modal: Latihan Hening Qalbu (3 Menit Timer)',
    x: 1960,
    y: 1200,
    title: '🧘 Hening Sebelum Menegur',
    subtitle: 'SOP Kazhmul Ghaizh',
    badgeBg: COLORS.amber[50],
    badgeFg: COLORS.amber[600],
    registerScreen: 's18-modal-hening',
    closeTrigger: 's18:close',
  });
  const henBox = b.frame({
    name: '3-Minute Countdown Box',
    parent: s18.sheetId,
    width: 354,
    height: 240,
    props: { fill: COLORS.amber[50], cornerRadius: 24, stroke: COLORS.amber[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', crossAlign: 'center', padding: [24, 20, 24, 20], sizingH: 'fill', sizingV: 'fixed' },
  });
  const timerCircle = b.frame({
    name: 'Timer Circle 03:00',
    parent: henBox,
    width: 96,
    height: 96,
    props: { fill: COLORS.white, cornerRadius: 999, stroke: COLORS.amber[500], strokeWeight: 3, layout: 'horizontal', mainAlign: 'center', crossAlign: 'center' },
  });
  b.text({ parent: timerCircle, text: '03:00', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 24, fill: COLORS.amber[600] } });
  b.text({
    parent: henBox,
    text: 'Tarik nafas 4 detik, tahan 4 detik dalam zikir istighfar, hembuskan perlahan 6 detik. Tenangkan detak jantung Anda sebelum berbicara.',
    width: 314,
    props: { fontSize: 11, fill: COLORS.basalt[700], textAlign: 'center', lineHeight: 16 },
  });
  b.button({
    parent: s18.sheetId,
    label: '⏱ Mulai 3 Menit Hening',
    bg: COLORS.amber[600],
    fg: COLORS.white,
    width: 'fill',
    height: 48,
    radius: 16,
    fontSize: 12,
    registerTrigger: 's18:done',
  });

  // S19: Indeks 6 Pilar Fitrah Nabawiyah
  const s19 = modalScreenShell(b, {
    name: 'S19 • Modal: Indeks 6 Pilar Fitrah Nabawiyah',
    x: 2450,
    y: 1200,
    title: '🌳 6 Pilar Fitrah Nabawiyah',
    subtitle: '110 Rujukan',
    badgeBg: COLORS.pine[50],
    badgeFg: COLORS.pine[600],
    registerScreen: 's19-modal-pilar',
    closeTrigger: 's19:close',
  });
  const pilars = [
    { title: '1. Fitrah Keimanan (Tauhid & Rububiyyah)', desc: "Keterikatan kalbu dengan Allah Ta'ala tanpa paksaan sejak usia dini (QS. Ar-Rum: 30).", hi: true },
    { title: '2. Fitrah Belajar & Nalar', desc: 'Memelihara rasa ingin tahu, kecintaan pada kebenaran & adab sebelum ilmu.', hi: false },
    { title: '3. Fitrah Bakat & Kepemimpinan', desc: 'Syakilah TB-40, peran khalifah fil ardh, dan spesialisasi amal sholih.', hi: false },
    { title: '4. Fitrah Jasmani & Ketahanan', desc: 'Thaharah, gizi halal & thayyib, serta kebugaran fisik memikul beban ibadah.', hi: false },
    { title: '5. Fitrah Perkembangan Usia', desc: 'Thufulah (0–7), Tamyiz (7–10), Murahaqah (10–14), hingga Baligh penuh taklif.', hi: false },
    { title: '6. Fitrah Seksualitas & Peran Gender', desc: 'Kesiapan qawwamah untuk anak laki-laki & keibuan (ummu madrasah) untuk perempuan.', hi: false },
  ];
  for (const pl of pilars) {
    const pCard = b.frame({
      name: pl.title,
      parent: s19.sheetId,
      width: 354,
      height: 58,
      props: {
        fill: pl.hi ? COLORS.pine[50] : COLORS.sand[50],
        cornerRadius: 14,
        stroke: pl.hi ? COLORS.pine[300] : COLORS.sand[200],
        strokeWeight: 1,
        layout: 'vertical',
        mainAlign: 'spaceBetween',
        padding: [8, 12, 8, 12],
        sizingH: 'fill',
        sizingV: 'fixed',
      },
    });
    b.text({ parent: pCard, text: pl.title, props: { fontSize: 11, fontStyle: 'Bold', fill: pl.hi ? COLORS.pine[700] : COLORS.basalt[800] } });
    b.text({ parent: pCard, text: pl.desc, width: 330, props: { fontSize: 9, fill: COLORS.basalt[600] } });
  }
  b.button({
    parent: s19.sheetId,
    label: 'Tutup Panduan Pilar',
    bg: COLORS.pine[600],
    fg: COLORS.white,
    width: 'fill',
    height: 46,
    radius: 14,
    fontSize: 12,
    registerTrigger: 's19:done',
  });

  // S20: Modal Profil Tokoh Asatidzah & Profil Lembaga Mitra
  const s20 = modalScreenShell(b, {
    name: 'S20 • Modal: Profil Tokoh Asatidzah & Lembaga Mitra',
    x: 2940,
    y: 1200,
    title: '👤 Profil Tokoh & Lembaga Mitra',
    subtitle: 'Direktori Sanad',
    badgeBg: COLORS.purple[50],
    badgeFg: COLORS.purple[600],
    registerScreen: 's20-modal-tokoh-lembaga',
    closeTrigger: 's20:close',
  });
  const tkDetail = b.frame({
    name: 'Detail Tokoh: Ust. Abdul Kholiq, Lc., M.P.I.',
    parent: s20.sheetId,
    width: 354,
    height: 196,
    props: { fill: COLORS.sand[50], cornerRadius: 18, stroke: COLORS.sand[200], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [14, 14, 14, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.badge({ parent: tkDetail, text: 'DEWAN PEMBINA PKN & PENGASUH SKIS', bg: COLORS.pine[50], fg: COLORS.pine[600], fontSize: 9 });
  b.text({ parent: tkDetail, text: 'Ust. Abdul Kholiq, Lc., M.P.I.', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 15, fill: COLORS.basalt[900] } });
  b.text({
    parent: tkDetail,
    text: '• Fokus Keahlian: Manhaj Tarbiyah Nabawiyah, Fitrah Iman, & Pendidikan Kuttab\n• Karya: Buku "Tiga Bahasa Mendidik (Hati, Lisan, Tangan Terukur)"\n• Arsip Audio: Daurah Fitrah Iman (8 Sesi Audio)',
    width: 326,
    props: { fontSize: 10, fill: COLORS.basalt[700], lineHeight: 15 },
  });
  b.text({
    parent: tkDetail,
    text: '"Koneksi sebelum koreksi. Penuhi bejana cinta anak sebelum menegakkan aturan ibadah."',
    width: 326,
    props: { fontSize: 10, fontStyle: 'Italic', fill: COLORS.pine[700] },
  });

  const lmDetail = b.frame({
    name: 'Detail Lembaga: SKIS (Sekolah Karakter Insan Sholih)',
    parent: s20.sheetId,
    width: 354,
    height: 186,
    props: { fill: COLORS.purple[50], cornerRadius: 18, stroke: COLORS.purple[100], strokeWeight: 1, layout: 'vertical', mainAlign: 'spaceBetween', padding: [14, 14, 14, 14], sizingH: 'fill', sizingV: 'fixed' },
  });
  b.badge({ parent: lmDetail, text: 'SEKOLAH MODEL FULL-DAY ADAB • CIKARANG & BEKASI', bg: COLORS.white, fg: COLORS.purple[600], fontSize: 9 });
  b.text({ parent: lmDetail, text: 'SKIS (Sekolah Karakter Insan Sholih)', props: { fontFamily: 'Merriweather', fontStyle: 'Bold', fontSize: 14, fill: COLORS.basalt[900] } });
  b.text({
    parent: lmDetail,
    text: 'Lembaga percontohan pendidikan adab berbasis fitrah kenabian untuk jenjang TK & Kuttab. Memadukan tahsin Al-Qur’an, hadits adab, dan pembiasaan akhlak harian.\n• Program: Kuttab Full-Day, Daurah Guru Nasional, Magang Pendidik Adab\n• Kontak: admin@skis-cikarang.sch.id',
    width: 326,
    props: { fontSize: 10, fill: COLORS.basalt[700], lineHeight: 14 },
  });

  b.button({
    parent: s20.sheetId,
    label: 'Tutup & Kembali ke Direktori Wiki',
    bg: COLORS.purple[600],
    fg: COLORS.white,
    width: 'fill',
    height: 46,
    radius: 14,
    fontSize: 12,
    registerTrigger: 's20:done',
  });

  // =========================================================================
  // INTERACTIVE PROTOTYPE FLOWS & CONNECTIONS (PROTO.*)
  // =========================================================================
  b.cmd('proto.settings', {
    device: 'Custom size',
    width: 430,
    height: 1120,
    background: '#0B1310',
    responsive: true,
  });

  // Flow Starting Points
  if (b.screens['s01-beranda-nature']) {
    b.addFlow(b.screens['s01-beranda-nature'], 'Flow 1: Beranda (Nature Hero) & 5-Tab Navigation');
  }
  if (b.screens['s08-p3k-genting-anak']) {
    b.addFlow(b.screens['s08-p3k-genting-anak'], 'Flow 2: Smart P3K 2-Phase Crisis Triage (Anak & Ortu)');
  }
  if (b.screens['s13-mode-renungan']) {
    b.addFlow(b.screens['s13-mode-renungan'], 'Flow 3: Full-Screen Mode Renungan & Tadabbur Clock');
  }

  // Wire 5-Tab Bottom Dock Navigation across all 7 Main Screens
  const tabTargetMap = {
    beranda: b.screens['s01-beranda-nature'],
    event: b.screens['s04-event'],
    materi: b.screens['s05-materi'],
    curhat: b.screens['s06-curhat'],
    profil: b.screens['s07-profil'],
  };

  const mainScreenKeys = [
    's01-beranda-nature',
    's02-beranda-classic',
    's03-beranda-dark',
    's04-event',
    's05-materi',
    's06-curhat',
    's07-profil',
  ];

  for (const sKey of mainScreenKeys) {
    for (const [tabKey, targetScreenId] of Object.entries(tabTargetMap)) {
      const trigId = b.triggers[`${sKey}:tab:${tabKey}`];
      if (trigId && targetScreenId && b.screens[sKey] !== targetScreenId) {
        b.addInteraction({ fromId: trigId, toId: targetScreenId, transition: 'smartAnimate', durationMs: 250 });
      }
    }
  }

  // Wire Beranda Header Toggles (Nature ⇄ Classic, Light ⇄ Dark) & Triggers
  const wirePairs = [
    // Layout & Theme toggles
    ['s01-beranda-nature:toggle:layout', 's02-beranda-classic'],
    ['s02-beranda-classic:toggle:layout', 's01-beranda-nature'],
    ['s01-beranda-nature:toggle:theme', 's03-beranda-dark'],
    ['s02-beranda-classic:toggle:theme', 's03-beranda-dark'],
    ['s03-beranda-dark:toggle:theme', 's01-beranda-nature'],
    ['s03-beranda-dark:toggle:layout', 's02-beranda-classic'],
    ['s01-beranda-nature:open:profil-avatar', 's07-profil'],
    ['s03-beranda-dark:open:profil-avatar', 's07-profil'],

    // Mode Renungan Triggers (Pull-down & Hero Quote Card)
    ['s01-beranda-nature:open:renungan', 's13-mode-renungan'],
    ['s01-beranda-nature:open:renungan-pull', 's13-mode-renungan'],
    ['s02-beranda-classic:open:renungan', 's13-mode-renungan'],
    ['s03-beranda-dark:open:renungan', 's13-mode-renungan'],
    ['s13:close', 's01-beranda-nature'],
    ['s13:swipe-up', 's01-beranda-nature'],

    // P3K Crisis Triage Flow (Genting Anak ⇄ Genting Ortu ➔ Stabil Anak / Stabil Ortu ➔ Beranda)
    ['s01-beranda-nature:open:p3k', 's08-p3k-genting-anak'],
    ['s02-beranda-classic:open:p3k', 's08-p3k-genting-anak'],
    ['s03-beranda-dark:open:p3k', 's08-p3k-genting-anak'],
    ['s08:switch:ortu', 's09-p3k-genting-ortu'],
    ['s09:switch:anak', 's08-p3k-genting-anak'],
    ['s08:to:stabil-anak', 's10-p3k-stabil-anak'],
    ['s09:to:stabil-ortu', 's11-p3k-stabil-ortu'],
    ['s08:close', 's01-beranda-nature'],
    ['s09:close', 's01-beranda-nature'],
    ['s10:close', 's08-p3k-genting-anak'],
    ['s10:done', 's01-beranda-nature'],
    ['s11:close', 's09-p3k-genting-ortu'],
    ['s11:done', 's01-beranda-nature'],

    // Ruang Qalbu PTT Walkie-Talkie Modal
    ['s01-beranda-nature:open:curhat', 's12-modal-curhat-ptt'],
    ['s01-beranda-nature:open:curhat-ptt', 's12-modal-curhat-ptt'],
    ['s02-beranda-classic:open:curhat', 's12-modal-curhat-ptt'],
    ['s03-beranda-dark:open:curhat', 's12-modal-curhat-ptt'],
    ['s06-curhat:open:ptt', 's12-modal-curhat-ptt'],
    ['s06-curhat:open:doa', 's16-modal-doa'],
    ['s12:finish-ptt', 's06-curhat'],
    ['s12:cancel', 's01-beranda-nature'],
    ['s12:close', 's01-beranda-nature'],

    // Event Promotions on Beranda ➔ Event Tab
    ['s01-beranda-nature:open:event-all', 's04-event'],
    ['s01-beranda-nature:open:event-1', 's04-event'],
    ['s01-beranda-nature:open:event-2', 's04-event'],

    // Carousel & Utility Grid Modals
    ['s01-beranda-nature:open:rpp', 's14-modal-rpp'],
    ['s01-beranda-nature:open:modul', 's15-modal-modul'],
    ['s01-beranda-nature:open:modul-grid', 's15-modal-modul'],
    ['s01-beranda-nature:open:doa', 's16-modal-doa'],
    ['s01-beranda-nature:open:tb40', 's17-modal-tb40'],
    ['s01-beranda-nature:open:hening', 's18-modal-hening'],
    ['s01-beranda-nature:open:pustaka', 's05-materi'],
    ['s01-beranda-nature:open:kemitraan', 's05-materi'],

    // Wiki & Profil Triggers
    ['s05-materi:open:pilar', 's19-modal-pilar'],
    ['s05-materi:open:tokoh', 's20-modal-tokoh-lembaga'],
    ['s07-profil:open:tb40', 's17-modal-tb40'],

    // Modal Return Actions
    ['s14:close', 's01-beranda-nature'],
    ['s14:save', 's01-beranda-nature'],
    ['s15:close', 's01-beranda-nature'],
    ['s15:play', 's01-beranda-nature'],
    ['s16:close', 's01-beranda-nature'],
    ['s16:pin', 's01-beranda-nature'],
    ['s17:close', 's01-beranda-nature'],
    ['s17:to:profil', 's07-profil'],
    ['s18:close', 's01-beranda-nature'],
    ['s18:done', 's01-beranda-nature'],
    ['s19:close', 's05-materi'],
    ['s19:done', 's05-materi'],
    ['s20:close', 's05-materi'],
    ['s20:done', 's05-materi'],
  ];

  for (const [trigKey, destScreenKey] of wirePairs) {
    const fromId = b.triggers[trigKey];
    const toId = b.screens[destScreenKey];
    if (fromId && toId) {
      b.addInteraction({ fromId, toId, transition: 'smartAnimate', durationMs: 300 });
    }
  }
}
