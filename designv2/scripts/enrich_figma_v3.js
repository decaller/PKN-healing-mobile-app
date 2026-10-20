// OpenPencil script to enrich PKN Mobile Figma with Daily Practical Tips v3 & Upgraded P3K
(async () => {
  console.log('Loading fonts...');
  await figma.loadFontAsync({ family: 'Inter', style: 'Regular' });
  await figma.loadFontAsync({ family: 'Inter', style: 'Bold' });
  await figma.loadFontAsync({ family: 'Plus Jakarta Sans', style: 'Regular' });
  await figma.loadFontAsync({ family: 'Plus Jakarta Sans', style: 'Bold' });
  await figma.loadFontAsync({ family: 'Merriweather', style: 'Bold' });
  await figma.loadFontAsync({ family: 'Merriweather', style: 'Regular' });

  // Color & Paint Helpers
  const hexToRgb = (hex) => {
    const h = hex.replace('#', '');
    return {
      r: parseInt(h.slice(0, 2), 16) / 255,
      g: parseInt(h.slice(2, 4), 16) / 255,
      b: parseInt(h.slice(4, 6), 16) / 255,
    };
  };

  const solid = (hex, opacity = 1) => [{ type: 'SOLID', color: hexToRgb(hex), opacity }];

  // Precision node creation helpers ensuring explicit local coordinates
  const addFrame = (parent, {
    name = 'Frame',
    x = 0, y = 0,
    width = 100, height = 100,
    fill = null, radius = 0,
    stroke = null, strokeWeight = 1,
    layout = 'NONE', gap = 0, pad = [0, 0, 0, 0],
    align = 'MIN', crossAlign = 'MIN'
  } = {}) => {
    const f = figma.createFrame();
    f.name = name;
    f.resize(width, height);
    if (radius > 0) f.cornerRadius = radius;
    if (fill) f.fills = Array.isArray(fill) ? fill : solid(fill);
    else f.fills = [];
    if (stroke) {
      f.strokes = Array.isArray(stroke) ? stroke : solid(stroke);
      f.strokeWeight = strokeWeight;
    }
    if (layout === 'VERTICAL' || layout === 'HORIZONTAL') {
      f.layoutMode = layout;
      f.itemSpacing = gap;
      f.paddingTop = pad[0];
      f.paddingRight = pad[1];
      f.paddingBottom = pad[2];
      f.paddingLeft = pad[3];
      f.primaryAxisAlignItems = align;
      f.counterAxisAlignItems = crossAlign;
    }
    parent.appendChild(f);
    // Explicit local position after append
    f.x = x;
    f.y = y;
    return f;
  };

  const addText = (parent, {
    name = null,
    text = '',
    font = 'Plus Jakarta Sans',
    style = 'Regular',
    size = 12,
    fill = '#1C1C17',
    x = 0, y = 0,
    width = null,
    align = 'LEFT'
  } = {}) => {
    const t = figma.createText();
    t.name = name || (text.slice(0, 24) + '...');
    t.fontName = { family: font, style };
    t.fontSize = size;
    t.characters = text;
    t.fills = solid(fill);
    t.textAlignHorizontal = align;
    if (width) {
      t.textAutoResize = 'HEIGHT';
      t.resize(width, t.height);
    } else {
      t.textAutoResize = 'WIDTH_AND_HEIGHT';
    }
    parent.appendChild(t);
    // Explicit local position after append
    t.x = x;
    t.y = y;
    return t;
  };

  const addBadge = (parent, textStr, bgHex, fgHex, x = 0, y = 0, size = 9) => {
    const padH = 8;
    const estCharW = size * 0.6;
    const badgeW = Math.round(textStr.length * estCharW + padH * 2);
    const badgeH = Math.round(size + 11);
    const b = addFrame(parent, {
      name: `Badge: ${textStr}`,
      x, y,
      width: badgeW, height: badgeH,
      radius: 999, fill: bgHex,
      layout: 'HORIZONTAL', pad: [3, padH, 3, padH],
      align: 'CENTER', crossAlign: 'CENTER'
    });
    addText(b, {
      name: textStr,
      text: textStr,
      style: 'Bold',
      size,
      fill: fgHex,
      x: padH, y: 3
    });
    return b;
  };

  // =========================================================================
  // STEP 1: UPDATE HOMESCREENS (S01, S02, S03) IN PAGE 03
  // =========================================================================
  console.log('1. Updating Page 03 homescreens...');
  const p3 = figma.root.children.find(p => p.name.includes('03'));
  if (p3) {
    for (const screen of p3.children) {
      if (screen.name.includes('S01') || screen.name.includes('S02') || screen.name.includes('S03')) {
        function findCard2(node) {
          if (node.name && node.name.includes('Action Card 2')) return node;
          if (node.children) {
            for (const ch of node.children) {
              const res = findCard2(ch);
              if (res) return res;
            }
          }
          return null;
        }

        const card2 = findCard2(screen);
        if (card2) {
          card2.name = 'Action Card 2: Tips Praktis 3 Menit';
          if (card2.children[0] && card2.children[0].children && card2.children[0].children[0]) {
            card2.children[0].name = 'Badge: ⚡ 7 KLUSTER • 9 SOLUSI';
            card2.children[0].children[0].characters = '⚡ 7 KLUSTER • 9 SOLUSI';
          }
          if (card2.children[1]) {
            card2.children[1].name = 'Tips Praktis 3 Menit';
            card2.children[1].characters = 'Tips Praktis 3 Menit\nSOP & Script Kalimat Siap Pakai';
          }
        }
      }
    }
  }

  // =========================================================================
  // STEP 2: LOCATE PAGE 04 & BASE SAMPLES FOR CLONING
  // =========================================================================
  console.log('2. Preparing Page 04 screens...');
  const p4 = figma.root.children.find(p => p.name.includes('04'));
  if (!p4) throw new Error('Page 04 not found');

  const s20 = p4.children.find(c => c.name.includes('S20')) || p4.children[p4.children.length - 1];
  const sampleBar = s20.children[0];
  const sampleCont = s20.children[1];
  const sampleScrim = sampleCont.children[0];
  const sampleSheet = sampleCont.children[1];
  const sampleHdr = sampleSheet.children[0];

  const createModalShell = ({ name, x, y, title, subtitle, badgeBg = '#EDF9F0', badgeFg = '#006D30' }) => {
    // Screen Container Frame
    const screen = addFrame(p4, {
      name, x, y, width: 430, height: 1120,
      radius: 44, fill: '#12120E', stroke: '#3E3E3B', strokeWeight: 8
    });

    // Top Status Bar (Cloned with notch and icons)
    const barClone = sampleBar.clone();
    screen.appendChild(barClone);
    barClone.x = 8;
    barClone.y = 8;

    // Content Container
    const cont = addFrame(screen, {
      name: 'Content Container', x: 8, y: 48, width: 414, height: 1080
    });

    // Modal Backdrop Scrim
    const scrimClone = sampleScrim.clone();
    cont.appendChild(scrimClone);
    scrimClone.x = 20;
    scrimClone.y = 12;
    scrimClone.children[0].characters = subtitle;

    // Bottom Sheet (White Surface)
    const sheet = addFrame(cont, {
      name: `Bottom Sheet: ${title}`,
      x: 20, y: 64, width: 374, height: 990,
      radius: 28, fill: '#FFFFFF', stroke: '#EEE5D1', strokeWeight: 1,
      layout: 'VERTICAL', gap: 10, pad: [18, 19, 18, 19]
    });

    // Modal Sheet Header
    const hdrClone = sampleHdr.clone();
    sheet.appendChild(hdrClone);
    hdrClone.x = 19;
    hdrClone.y = 18;
    hdrClone.resize(336, 38);
    hdrClone.children[0].characters = title;
    hdrClone.children[1].name = `Badge: ${subtitle}`;
    hdrClone.children[1].fills = solid(badgeBg);
    hdrClone.children[1].children[0].characters = subtitle;
    hdrClone.children[1].children[0].fills = solid(badgeFg);

    return { screen, sheet };
  };

  // =========================================================================
  // STEP 3: SCREEN S21 — P3K MODE GURU & KELAS GADUH (< 3 MENIT)
  // =========================================================================
  console.log('3. Building S21...');
  {
    const { sheet } = createModalShell({
      name: 'S21 • P3K Kondisi Genting — Mode Guru & Kelas Gaduh (< 3 Menit)',
      x: 2940, y: 0,
      title: '🚨 P3K Kondisi Genting',
      subtitle: '🏫 Mode Guru / Kelas',
      badgeBg: '#EEF2FF', badgeFg: '#4338CA'
    });

    let cy = 18 + 38 + 10; // 66

    // 1. Safety Guardrail Banner
    const banner = addFrame(sheet, {
      name: '🛡️ Safety Guardrail Banner (Hifzhun Nafs)',
      x: 19, y: cy, width: 336, height: 42,
      radius: 12, fill: '#FEF2F2', stroke: '#FECACA', strokeWeight: 1,
      layout: 'VERTICAL', pad: [5, 10, 5, 10], gap: 2
    });
    addText(banner, { text: '🛡️ KESELAMATAN & ADAB KELAS:', style: 'Bold', size: 9, fill: '#DC2626', x: 10, y: 5 });
    addText(banner, {
      text: 'Bila ada perkelahian fisik antar-siswa, segera pisahkan ke jarak aman. Tahan amarah & jangan lakukan hukuman kolektif zalim.',
      size: 8.5, fill: '#991B1B', width: 316, x: 10, y: 18
    });
    cy += 42 + 8;

    // 2. Triple Triage Switcher
    const tabs = addFrame(sheet, {
      name: 'Triple Triage Switcher',
      x: 19, y: cy, width: 336, height: 36,
      radius: 14, fill: '#F7F2E7', layout: 'HORIZONTAL', gap: 4, pad: [3, 4, 3, 4],
      crossAlign: 'CENTER'
    });
    addBadge(tabs, '👶 Anak', '#00000000', '#6E6E68', 4, 4, 9.5);
    addBadge(tabs, '🧘 Ortu Burnout', '#00000000', '#6E6E68', 84, 4, 9.5);
    addBadge(tabs, '🏫 Guru/Kelas', '#FFFFFF', '#4338CA', 204, 4, 9.5);
    cy += 36 + 10;

    // 3. Calm Anchor Visual Card
    const anchor = addFrame(sheet, {
      name: 'Anchor: Keheningan Berwibawa (Silent Authority)',
      x: 19, y: cy, width: 336, height: 96,
      radius: 18, fill: '#1E1B4B', stroke: '#312E81', strokeWeight: 1,
      layout: 'VERTICAL', align: 'CENTER', crossAlign: 'CENTER', pad: [10, 12, 10, 12], gap: 4
    });
    addText(anchor, {
      text: '🏫 DE-ESKALASI KELAS • WIBAWA HEBAT TANPA TERIAKAN',
      style: 'Bold', size: 8, fill: '#A5B4FC', x: 12, y: 10, align: 'CENTER', width: 312
    });
    addText(anchor, {
      text: 'Keheningan Berwibawa (Silent Authority)',
      font: 'Merriweather', style: 'Bold', size: 13.5, fill: '#FFFFFF', x: 12, y: 28, align: 'CENTER', width: 312
    });
    addText(anchor, {
      text: 'Tahan bentakan & gebrak meja • Sentuh frekuensi hati murid',
      size: 9, fill: '#C7D2FE', x: 12, y: 58, align: 'CENTER', width: 312
    });
    cy += 96 + 10;

    // 4. 3 Step Cards
    const steps = [
      ['1', 'Keheningan Berwibawa 30 Detik', 'Wibawa Awal', 'Berdiri tegak di tengah depan kelas, tatap murid dengan senyuman teduh tanpa suara.'],
      ['2', 'Gestur Satu Telapak Tangan', 'Sinyal Fokus', 'Angkat tangan ke atas sebagai kode hening hingga murid saling mengingatkan temannya.'],
      ['3', 'Apersepsi Suara Berbisik / Sirah', 'Sentuh Qalbu', 'Bicara dengan nada desah rendah menceritakan cuplikan rahasia kisah Umar bin Khattab ra.']
    ];
    for (const [num, title, tag, desc] of steps) {
      const stepCard = addFrame(sheet, {
        name: `Step ${num}: ${title}`,
        x: 19, y: cy, width: 336, height: 64,
        radius: 14, fill: '#F8FAFC', stroke: '#E2E8F0', strokeWeight: 1
      });
      // Num Circle
      const numCircle = addFrame(stepCard, {
        name: `Num ${num}`, x: 10, y: 16, width: 30, height: 30,
        radius: 999, fill: '#4338CA', layout: 'HORIZONTAL', align: 'CENTER', crossAlign: 'CENTER'
      });
      addText(numCircle, { text: num, style: 'Bold', size: 12, fill: '#FFFFFF', x: 11, y: 7 });

      // Title & Tag
      addText(stepCard, { text: title, style: 'Bold', size: 10.5, fill: '#0F172A', x: 48, y: 12 });
      addBadge(stepCard, tag, '#EEF2FF', '#4338CA', 244, 8, 8);

      // Desc
      addText(stepCard, { text: desc, size: 9, fill: '#64748B', x: 48, y: 30, width: 276 });
      cy += 64 + 8;
    }
    cy += 2;

    // 5. Deep link button
    const deepBtn = addFrame(sheet, {
      name: 'Btn: 📖 Buka Tips Lengkap: Kasus 7 (De-eskalasi Kelas Gaduh) ➔',
      x: 19, y: cy, width: 336, height: 38,
      radius: 14, fill: '#EEF2FF', stroke: '#C7D2FE', strokeWeight: 1,
      layout: 'HORIZONTAL', align: 'CENTER', crossAlign: 'CENTER', pad: [8, 12, 8, 12]
    });
    addText(deepBtn, {
      text: '📖 Buka Tips Lengkap: Kasus 7 (De-eskalasi Kelas Gaduh) ➔',
      style: 'Bold', size: 10, fill: '#4338CA', x: 14, y: 11, align: 'CENTER', width: 308
    });
    cy += 38 + 10;

    // 6. Action Button
    const actionBtn = addFrame(sheet, {
      name: 'Btn: 🎓 Alhamdulillah, Kelas Sudah Tenang & Fokus ➔',
      x: 19, y: cy, width: 336, height: 44,
      radius: 16, fill: '#4338CA',
      layout: 'HORIZONTAL', align: 'CENTER', crossAlign: 'CENTER', pad: [10, 14, 10, 14]
    });
    addText(actionBtn, {
      text: '🎓 Alhamdulillah, Kelas Sudah Tenang & Fokus ➔',
      style: 'Bold', size: 11, fill: '#FFFFFF', x: 12, y: 13, align: 'CENTER', width: 312
    });
  }

  // =========================================================================
  // STEP 4: SCREEN S22 — P3K KONDISI STABIL GURU & KELAS
  // =========================================================================
  console.log('4. Building S22...');
  {
    const { sheet } = createModalShell({
      name: 'S22 • P3K Kondisi Stabil — Wibawa Kelas Berhasil (Pasca-Reda Guru)',
      x: 3430, y: 1200,
      title: 'Kondisi Stabil • Pemulihan Guru',
      subtitle: '🏫 Kelas Tenang',
      badgeBg: '#EEF2FF', badgeFg: '#4338CA'
    });

    let cy = 18 + 38 + 10; // 66

    // Card 1 Apresiasi
    const card1 = addFrame(sheet, {
      name: 'Apresiasi Wibawa Guru',
      x: 19, y: cy, width: 336, height: 86,
      radius: 16, fill: '#EEF2FF', stroke: '#C7D2FE', strokeWeight: 1,
      pad: [10, 12, 10, 12]
    });
    addText(card1, {
      text: '✓ Masya Allah, Wibawa Kelas Berhasil Ditegakkan',
      style: 'Bold', size: 11, fill: '#312E81', x: 12, y: 10, width: 312
    });
    addText(card1, {
      text: 'Anda telah mengendalikan kelas tanpa amarah dan tanpa kekerasan verbal. Keteladanan sabar Anda adalah kurikulum adab terbaik bagi murid.',
      size: 9.5, fill: '#4338CA', x: 12, y: 32, width: 312
    });
    cy += 86 + 10;

    // Card 2 Kaidah Adab
    const card2 = addFrame(sheet, {
      name: 'Kaidah Emas: Sentuh Hati Sebelum Pikiran',
      x: 19, y: cy, width: 336, height: 104,
      radius: 16, fill: '#FFFBEB', stroke: '#FDE68A', strokeWeight: 1,
      pad: [10, 12, 10, 12]
    });
    addText(card2, {
      text: '💡 KAIDAH ADAB: SENTUH HATI SEBELUM PIKIRAN',
      style: 'Bold', size: 10.5, fill: '#B45309', x: 12, y: 10, width: 312
    });
    addText(card2, {
      text: 'Anak-anak belajar dari guru yang mereka cintai. Jangan langsung membuka buku teks secara kaku. Luangkan 2 menit apersepsi emosional atau cerita sirah shahabat sebelum masuk materi rumus.',
      size: 9.5, fill: '#92400E', x: 12, y: 30, width: 312
    });
    cy += 104 + 10;

    // Card 3 Doa Kelapangan Dada
    const card3 = addFrame(sheet, {
      name: 'Doa Kelapangan Dada (QS. Thaha: 25-28)',
      x: 19, y: cy, width: 336, height: 110,
      radius: 16, fill: '#F7F2E7', stroke: '#EEE5D1', strokeWeight: 1,
      pad: [10, 12, 10, 12]
    });
    addText(card3, {
      text: 'DOA KELAPANGAN DADA & HIKMAH • QS. THAHA: 25-28',
      style: 'Bold', size: 9, fill: '#6E6E68', x: 12, y: 10, width: 312
    });
    addText(card3, {
      text: 'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي',
      font: 'Merriweather', style: 'Bold', size: 13, fill: '#1C1C17', x: 12, y: 30, width: 312
    });
    addText(card3, {
      text: '"Ya Rabb-ku, lapangkanlah untukku dadaku, dan mudahkanlah untukku urusanku, dan lepaskanlah kekakuan dari lidahku..."',
      size: 9, fill: '#52524E', x: 12, y: 62, width: 312
    });
    cy += 110 + 10;

    // Card 4 Tindak Lanjut
    const card4 = addFrame(sheet, {
      name: 'Rencana Tindak Lanjut Kelas',
      x: 19, y: cy, width: 336, height: 76,
      radius: 14, fill: '#F8FAFC', stroke: '#E2E8F0', strokeWeight: 1,
      pad: [8, 12, 8, 12]
    });
    addText(card4, {
      text: '📅 RENCANA TINDAK LANJUT KELAS',
      style: 'Bold', size: 9, fill: '#312E81', x: 12, y: 8, width: 312
    });
    addText(card4, {
      text: '• Sisipkan variasi peregangan / gerak kinestetik tiap 20 menit.\n• Berikan apresiasi spesifik pada murid yang tadinya paling gaduh.',
      size: 9, fill: '#475569', x: 12, y: 26, width: 312
    });
    cy += 76 + 12;

    // Button Tutup
    const closeBtn = addFrame(sheet, {
      name: 'Btn: Tutup & Lanjutkan Pembelajaran',
      x: 19, y: cy, width: 336, height: 42,
      radius: 14, fill: '#1E1B4B',
      layout: 'HORIZONTAL', align: 'CENTER', crossAlign: 'CENTER'
    });
    addText(closeBtn, {
      text: 'Tutup & Lanjutkan Pembelajaran',
      style: 'Bold', size: 11, fill: '#FFFFFF', x: 12, y: 12, align: 'CENTER', width: 312
    });
  }

  // =========================================================================
  // STEP 5: SCREEN S23 — KATALOG TIPS PRAKTIS HARIAN (7 KLUSTER • 9 KASUS)
  // =========================================================================
  console.log('5. Building S23...');
  {
    const { sheet } = createModalShell({
      name: 'S23 • Modal: Katalog Tips Praktis Harian (7 Kluster • 9 Solusi 3 Menit)',
      x: 3430, y: 0,
      title: 'Tips Praktis Keseharian',
      subtitle: '⚡ 7 Kluster • 9 Solusi',
      badgeBg: '#EDF9F0', badgeFg: '#006D30'
    });

    let cy = 18 + 38 + 10; // 66

    // Search Bar
    const search = addFrame(sheet, {
      name: 'Search Bar Frame',
      x: 19, y: cy, width: 336, height: 38,
      radius: 12, fill: '#F7F2E7', stroke: '#EEE5D1', strokeWeight: 1
    });
    addText(search, { text: '🔍', size: 12, fill: '#6E6E68', x: 10, y: 10 });
    addText(search, {
      text: 'Cari: tantrum, gadget, shalat, burnout, gaduh...',
      size: 10, fill: '#8E8E88', x: 30, y: 11, width: 290
    });
    cy += 38 + 8;

    // Filter Chips Row
    const filterRow = addFrame(sheet, {
      name: 'Filter Chips Row',
      x: 19, y: cy, width: 336, height: 28,
      layout: 'HORIZONTAL', gap: 6, crossAlign: 'CENTER'
    });
    addBadge(filterRow, 'Semua (9)', '#006D30', '#FFFFFF', 0, 0, 9);
    addBadge(filterRow, '👶 Anak (4)', '#F7F2E7', '#52524E', 76, 0, 9);
    addBadge(filterRow, '🧘 Jiwa (2)', '#F7F2E7', '#52524E', 154, 0, 9);
    addBadge(filterRow, '🏫 Guru (3)', '#F7F2E7', '#52524E', 230, 0, 9);
    cy += 28 + 8;

    // Status Row
    const statusRow = addFrame(sheet, {
      name: 'Status Row',
      x: 19, y: cy, width: 336, height: 16
    });
    addText(statusRow, { text: 'Menampilkan 9 solusi praktis', size: 9, fill: '#8E8E88', x: 0, y: 0 });
    addText(statusRow, { text: '• Format 6 Elemen Baku', style: 'Bold', size: 9, fill: '#006D30', x: 180, y: 0 });
    cy += 16 + 8;

    // Protocol Cards in Catalog
    const catalogCards = [
      {
        num: 'Kasus 3',
        title: 'Balita Tantrum Guling di Lantai',
        cluster: 'Kluster 1: Anak & Balita',
        time: '< 3 Menit',
        desc: 'SOP 3 tahap: Hentikan ceramah seketika, amankan fisik balita, gunakan validasi emosi pendek & pelukan erat.',
        btnText: 'Buka Cetak Biru 6 Elemen ➔',
        borderCol: '#D5F2DC',
        btnBg: '#006D30',
        btnFg: '#FFFFFF'
      },
      {
        num: 'Kasus 7',
        title: 'Murid Berisik & Kelas Gaduh',
        cluster: 'Kluster 4: Sekolah & Guru',
        time: '< 3 Menit',
        desc: 'Silent Authority: diam 30s senyum wibawa, satu telapak tangan terbuka, ganti bentakan dengan sirah rahasia.',
        btnText: 'Buka Cetak Biru 6 Elemen ➔',
        borderCol: '#C7D2FE',
        btnBg: '#4338CA',
        btnFg: '#FFFFFF'
      },
      {
        num: 'Kasus 1',
        title: 'Ibu Kelelahan Emosional (Burnout)',
        cluster: 'Kluster 2: Diri & Jiwa',
        time: '3 Menit',
        desc: 'Lepas kontak visual 60s, tarik napas zikir Ya Hayyu Ya Qayyum, basuh tengkuk air dingin (Sunnah padamkan amarah).',
        btnText: 'Buka Cetak Biru ➔',
        borderCol: '#F2D4C4',
        btnBg: '#9C4114',
        btnFg: '#FFFFFF'
      },
      {
        num: 'Kasus 4',
        title: 'Anak Mogok Shalat & Asyik Gadget',
        cluster: 'Kluster 3: Ibadah & Fitrah',
        time: '3 Menit',
        desc: 'Sentuh pundak kanan dengan kasih sayang, validasi serunya game, lalu gandeng lembut ajak wudhu bersama.',
        btnText: 'Buka Cetak Biru ➔',
        borderCol: '#EEE5D1',
        btnBg: '#2B2B28',
        btnFg: '#FFFFFF'
      }
    ];

    for (const c of catalogCards) {
      const card = addFrame(sheet, {
        name: `Card: ${c.num} — ${c.title}`,
        x: 19, y: cy, width: 336, height: 98,
        radius: 14, fill: '#FFFFFF', stroke: c.borderCol, strokeWeight: 1
      });
      // Top row: Cluster & Time
      addText(card, { text: `${c.num} • ${c.cluster}`, style: 'Bold', size: 8.5, fill: '#6E6E68', x: 10, y: 8 });
      addBadge(card, c.time, '#F7F2E7', '#1C1C17', 260, 6, 8);

      // Title
      addText(card, { text: c.title, style: 'Bold', size: 10.5, fill: '#1C1C17', x: 10, y: 24, width: 316 });

      // Desc
      addText(card, { text: c.desc, size: 8.5, fill: '#52524E', x: 10, y: 42, width: 316 });

      // Action mini btn
      const miniBtn = addFrame(card, {
        name: `Btn: ${c.btnText}`,
        x: 10, y: 68, width: 316, height: 22,
        radius: 7, fill: c.btnBg,
        layout: 'HORIZONTAL', align: 'CENTER', crossAlign: 'CENTER'
      });
      addText(miniBtn, { text: c.btnText, style: 'Bold', size: 9, fill: c.btnFg, x: 10, y: 4, align: 'CENTER', width: 296 });

      cy += 98 + 8;
    }
    cy += 2;

    // Bottom info badge
    const infoCard = addFrame(sheet, {
      name: 'Sanad Info Box',
      x: 19, y: cy, width: 336, height: 38,
      radius: 12, fill: '#EDF9F0', stroke: '#D5F2DC', strokeWeight: 1,
      layout: 'HORIZONTAL', pad: [8, 12, 8, 12], crossAlign: 'CENTER'
    });
    addText(infoCard, {
      text: '✓ 9 SOP ini disarikan berdasar kajian parenting nabawiyah SKIS & rujukan syar\'i.',
      size: 8.5, fill: '#006D30', x: 10, y: 10, width: 316
    });
  }

  // =========================================================================
  // STEP 6: SCREEN S24 — DETAIL CETAK BIRU 6 ELEMEN (KASUS 3: TANTRUM BALITA)
  // =========================================================================
  console.log('6. Building S24...');
  {
    const { sheet } = createModalShell({
      name: 'S24 • Modal: Detail Cetak Biru 6 Elemen (Kasus 3: Tantrum Balita)',
      x: 3920, y: 0,
      title: 'Kasus 3: Tantrum Balita',
      subtitle: '⚡ SOP 6 Elemen Baku',
      badgeBg: '#EDF9F0', badgeFg: '#006D30'
    });

    let cy = 18 + 38 + 10; // 66

    // Hero banner
    const hero = addFrame(sheet, {
      name: 'Hero: Kasus 3 Tantrum',
      x: 19, y: cy, width: 336, height: 52,
      radius: 14, fill: '#006D30',
      pad: [8, 12, 8, 12]
    });
    addText(hero, {
      text: 'KASUS 3: BALITA TANTRUM DI TEMPAT UMUM',
      style: 'Bold', size: 10.5, fill: '#FFFFFF', x: 12, y: 8, width: 312
    });
    addText(hero, {
      text: 'Kluster 1: Anak & Balita • Durasi Respon: < 3 Menit',
      size: 9, fill: '#AEE5BC', x: 12, y: 28, width: 312
    });
    cy += 52 + 8;

    // 6 Sections
    const sections = [
      {
        tag: '🔍 1. IDENTIFIKASI PEMICU',
        body: 'Overstimulasi sensori/lelah/lapar, belum mampu verbalisasi rasa. BUKAN karena anak nakal.',
        bg: '#F7F2E7', border: '#EEE5D1', fg: '#1C1C17', tagCol: '#6E6E68', h: 48
      },
      {
        tag: '🛡️ 2. SAFETY & KESELAMATAN (HIFZHUN NAFS)',
        body: 'Jauhkan benda keras/tajam. Duduk sejajar lantai. Pindahkan ke sudut tenang tanpa sorotan mata publik.',
        bg: '#FEF2F2', border: '#FECACA', fg: '#991B1B', tagCol: '#DC2626', h: 48
      },
      {
        tag: '💡 3. MINDSET & KAIDAH SYAR\'I (KASHMUL GHAIZH)',
        body: 'Diam adalah keselamatan (HR. Ahmad). Menahan bentakan saat marah membuka ampunan Allah.',
        bg: '#F7F2E7', border: '#EEE5D1', fg: '#1C1C17', tagCol: '#006D30', h: 48
      },
      {
        tag: '⏱️ 4. PROTOKOL 3 MENIT BERTAHAP',
        body: '• 0-30s: Hening total, jangan ceramah saat otak emosi anak membara.\n• 30-90s: Peluk erat bila aman, usap punggung berirama tenang.\n• 90-180s: Berikan minum air putih hangat, tunggu napas teratur.',
        bg: '#FFFFFF', border: '#EEE5D1', fg: '#1C1C17', tagCol: '#006D30', h: 72
      },
      {
        tag: '🗣️ 5. KALIMAT SIAP PAKAI (SCRIPT DIALOG)',
        body: '"Bunda tahu adek lagi kesal sekali ya. Bunda ada di sini jagain adek. Kita peluk dulu sampai adek tenang ya sayang..."',
        bg: '#1C1C17', border: '#3E3E3B', fg: '#FDFBF7', tagCol: '#AEE5BC', h: 76
      },
      {
        tag: '📅 6. TINDAK LANJUT SEPEKAN (TADARRUJ)',
        body: 'Latih anak menamai emosi saat tenang. Buat kartu ekspresi wajah & puji saat ia mampu bilang "adek sedih".',
        bg: '#F7F2E7', border: '#EEE5D1', fg: '#1C1C17', tagCol: '#006D30', h: 52
      }
    ];

    for (const s of sections) {
      const box = addFrame(sheet, {
        name: s.tag,
        x: 19, y: cy, width: 336, height: s.h,
        radius: 12, fill: s.bg, stroke: s.border, strokeWeight: 1,
        pad: [6, 10, 6, 10]
      });
      addText(box, { text: s.tag, style: 'Bold', size: 8.5, fill: s.tagCol, x: 10, y: 6, width: 316 });
      addText(box, { text: s.body, size: 8.5, fill: s.fg, x: 10, y: 20, width: 316 });
      cy += s.h + 6;
    }
    cy += 2;

    // Action Bar
    const actBar = addFrame(sheet, {
      name: 'Action Bar',
      x: 19, y: cy, width: 336, height: 40
    });
    const pracBtn = addFrame(actBar, {
      name: 'Btn: Tandai Dipraktikkan',
      x: 0, y: 0, width: 236, height: 40,
      radius: 12, fill: '#006D30',
      layout: 'HORIZONTAL', align: 'CENTER', crossAlign: 'CENTER'
    });
    addText(pracBtn, { text: '✓ Tandai Sudah Dipraktikkan', style: 'Bold', size: 10, fill: '#FFFFFF', x: 10, y: 12, align: 'CENTER', width: 216 });

    const backBtn = addFrame(actBar, {
      name: 'Btn: Katalog',
      x: 244, y: 0, width: 92, height: 40,
      radius: 12, fill: '#F7F2E7',
      layout: 'HORIZONTAL', align: 'CENTER', crossAlign: 'CENTER'
    });
    addText(backBtn, { text: 'Katalog', style: 'Bold', size: 10, fill: '#1C1C17', x: 10, y: 12, align: 'CENTER', width: 72 });
  }

  // =========================================================================
  // STEP 7: SCREEN S25 — DETAIL CETAK BIRU 6 ELEMEN (KASUS 7: KELAS GADUH)
  // =========================================================================
  console.log('7. Building S25...');
  {
    const { sheet } = createModalShell({
      name: 'S25 • Modal: Detail Cetak Biru 6 Elemen (Kasus 7: Murid Berisik & Kelas Gaduh)',
      x: 3920, y: 1200,
      title: 'Kasus 7: Kelas Gaduh',
      subtitle: '⚡ SOP 6 Elemen Baku',
      badgeBg: '#EEF2FF', badgeFg: '#4338CA'
    });

    let cy = 18 + 38 + 10; // 66

    // Hero banner
    const hero = addFrame(sheet, {
      name: 'Hero: Kasus 7 Kelas Gaduh',
      x: 19, y: cy, width: 336, height: 52,
      radius: 14, fill: '#4338CA',
      pad: [8, 12, 8, 12]
    });
    addText(hero, {
      text: 'KASUS 7: KELAS GADUH & HILANG KONSENTRASI',
      style: 'Bold', size: 10.5, fill: '#FFFFFF', x: 12, y: 8, width: 312
    });
    addText(hero, {
      text: 'Kluster 4: Sekolah & Guru • Durasi Respon: < 3 Menit',
      size: 9, fill: '#C7D2FE', x: 12, y: 28, width: 312
    });
    cy += 52 + 8;

    // 6 Sections
    const sections = [
      {
        tag: '🔍 1. IDENTIFIKASI PEMICU',
        body: 'Gaya belajar pasif > 20 menit, energi kinestetik terpendam, kejenuhan kognitif materi satu arah.',
        bg: '#EEF2FF', border: '#C7D2FE', fg: '#1E1B4B', tagCol: '#4338CA', h: 48
      },
      {
        tag: '🛡️ 2. SAFETY & ADAB KELAS',
        body: 'Jangan melempar spidol atau gebrak meja. Pisahkan perselisihan fisik segera ke ruang BK/koridor aman.',
        bg: '#FEF2F2', border: '#FECACA', fg: '#991B1B', tagCol: '#DC2626', h: 48
      },
      {
        tag: '💡 3. MINDSET & KAIDAH NABAWIYAH',
        body: 'Sentuh qalbu sebelum menyuapi akal. Guru yang tenang memancarkan wibawa nubuwah (Al-Waqar).',
        bg: '#EEF2FF', border: '#C7D2FE', fg: '#1E1B4B', tagCol: '#4338CA', h: 48
      },
      {
        tag: '⏱️ 4. PROTOKOL 3 MENIT DE-ESKALASI',
        body: '• 0-30s: Hening berwibawa di depan kelas, tegak dan tersenyum tenang.\n• 30-90s: Angkat satu telapak tangan terbuka hingga seluruh kelas hening.\n• 90-180s: Buka apersepsi berbisik sirah shahabat Umar bin Khattab ra.',
        bg: '#FFFFFF', border: '#E2E8F0', fg: '#0F172A', tagCol: '#4338CA', h: 72
      },
      {
        tag: '🗣️ 5. KALIMAT SIAP PAKAI (SCRIPT DIALOG)',
        body: '"Anak-anakku yang sholih, Ustadz bangga dengan semangat kalian. Namun di kelas ini ada hak telinga yang ingin ilmu... mari dengar rahasia Umar bin Khattab ra."',
        bg: '#1E1B4B', border: '#312E81', fg: '#E0E7FF', tagCol: '#A5B4FC', h: 76
      },
      {
        tag: '📅 6. TINDAK LANJUT SEPEKAN (TADARRUJ)',
        body: 'Sisipkan variasi peregangan tiap 15m. Susun piagam kesepakatan adab kelas bersama di awal pekan.',
        bg: '#EEF2FF', border: '#C7D2FE', fg: '#1E1B4B', tagCol: '#4338CA', h: 52
      }
    ];

    for (const s of sections) {
      const box = addFrame(sheet, {
        name: s.tag,
        x: 19, y: cy, width: 336, height: s.h,
        radius: 12, fill: s.bg, stroke: s.border, strokeWeight: 1,
        pad: [6, 10, 6, 10]
      });
      addText(box, { text: s.tag, style: 'Bold', size: 8.5, fill: s.tagCol, x: 10, y: 6, width: 316 });
      addText(box, { text: s.body, size: 8.5, fill: s.fg, x: 10, y: 20, width: 316 });
      cy += s.h + 6;
    }
    cy += 2;

    // Action Bar
    const actBar = addFrame(sheet, {
      name: 'Action Bar',
      x: 19, y: cy, width: 336, height: 40
    });
    const pracBtn = addFrame(actBar, {
      name: 'Btn: Tandai Dipraktikkan',
      x: 0, y: 0, width: 236, height: 40,
      radius: 12, fill: '#4338CA',
      layout: 'HORIZONTAL', align: 'CENTER', crossAlign: 'CENTER'
    });
    addText(pracBtn, { text: '✓ Tandai Sudah Dipraktikkan', style: 'Bold', size: 10, fill: '#FFFFFF', x: 10, y: 12, align: 'CENTER', width: 216 });

    const backBtn = addFrame(actBar, {
      name: 'Btn: Katalog',
      x: 244, y: 0, width: 92, height: 40,
      radius: 12, fill: '#F7F2E7',
      layout: 'HORIZONTAL', align: 'CENTER', crossAlign: 'CENTER'
    });
    addText(backBtn, { text: 'Katalog', style: 'Bold', size: 10, fill: '#1C1C17', x: 10, y: 12, align: 'CENTER', width: 72 });
  }

  // =========================================================================
  // STEP 8: UPDATE COVER & ARCHITECTURE TEXT IN PAGE 00
  // =========================================================================
  console.log('8. Updating Page 00 cover text...');
  const p0 = figma.root.children.find(p => p.name.includes('00'));
  if (p0) {
    function findAndReplaceText(node, predicate, newText) {
      if (node.type === 'TEXT' && predicate(node.characters)) {
        node.characters = newText;
        return true;
      }
      if (node.children) {
        for (const ch of node.children) {
          if (findAndReplaceText(ch, predicate, newText)) return true;
        }
      }
      return false;
    }

    findAndReplaceText(p0, t => t.includes('INTERACTIVE SCREENS'), '25 INTERACTIVE SCREENS • 5 PAGES • LIGHT & TAHAJJUD');
    findAndReplaceText(p0, t => t.includes('PAGE 04 (13 SCREENS)'), 'PAGE 04 (18 SCREENS)');
    findAndReplaceText(p0, t => t.includes('Screen Matrix:'), 'Screen Matrix (25 Screens): S01 Beranda (Nature) • S02 Beranda (Classic) • S03 Beranda (Dark) • S04 Event • S05 Materi/Wiki • S06 Curhat • S07 Profil • S08 P3K Anak (Genting) • S09 P3K Ortu (Genting) • S10 P3K Anak (Stabil) • S11 P3K Ortu (Stabil) • S12 PTT Walkie-Talkie • S13 Mode Renungan • S14 RPP 1 Lembar • S15 Modul Harian • S16 Doa Penenang • S17 TB-40 • S18 Hening 3m • S19 6 Pilar Fitrah • S20 Profil Tokoh • S21 P3K Guru Genting • S22 P3K Guru Stabil • S23 Katalog Tips Praktis (9 Kasus) • S24 Cetak Biru Kasus 3 (Tantrum) • S25 Cetak Biru Kasus 7 (Kelas Gaduh)');
  }

  console.log('Figma enrichment completed successfully!');
  console.log('Page 04 screens count:', p4.children.length);
  console.log('Page 04 screens:', p4.children.map(c => c.name));
  return {
    success: true,
    page03Screens: p3 ? p3.children.length : 0,
    page04Screens: p4 ? p4.children.length : 0,
    totalNodes: figma.root.children.reduce((acc, p) => acc + p.children.length, 0)
  };
})();

