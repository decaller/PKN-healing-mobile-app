// Design Tokens, SVG Icons, and FigCraft JSONL Builder for PKN Mobile v2

export const COLORS = {
  sand: {
    50: '#FDFBF7',
    100: '#F7F2E7',
    200: '#EEE5D1',
    300: '#E1D2B3',
    400: '#CFB990',
    500: '#B89D70',
    600: '#9E8156',
  },
  basalt: {
    50: '#F6F6F6',
    100: '#E7E7E7',
    400: '#8E8E88',
    500: '#6E6E68',
    600: '#52524E',
    700: '#3E3E3B',
    800: '#2B2B28',
    900: '#1C1C17',
    950: '#12120E',
  },
  pine: {
    50: '#EDF9F0',
    100: '#D5F2DC',
    200: '#AEE5BC',
    300: '#77D191',
    400: '#3FB363',
    500: '#1B8A43',
    600: '#006D30',
    700: '#005826',
    800: '#00461F',
    900: '#003517',
    950: '#052412',
  },
  terracotta: {
    50: '#FDF3EE',
    100: '#FBE3D6',
    300: '#F2A985',
    400: '#E07A47',
    500: '#C05621',
    600: '#9C4114',
    700: '#7C320E',
    800: '#5E250A',
    900: '#421906',
    950: '#2A0F03',
  },
  amber: {
    50: '#FFFBEB',
    100: '#FEF3C7',
    200: '#FDE68A',
    300: '#FCD34D',
    400: '#FBBF24',
    500: '#D97706',
    600: '#B45309',
    700: '#92400E',
    900: '#451A03',
    950: '#290F02',
  },
  blue: {
    50: '#EFF6FF',
    100: '#DBEAFE',
    400: '#60A5FA',
    500: '#3B82F6',
    600: '#2563EB',
    700: '#1D4ED8',
    950: '#172554',
  },
  purple: {
    50: '#FAF5FF',
    100: '#F3E8FF',
    400: '#C084FC',
    600: '#9333EA',
    950: '#3B0764',
  },
  red: {
    50: '#FEF2F2',
    100: '#FEE2E2',
    200: '#FECACA',
    400: '#F87171',
    500: '#EF4444',
    600: '#DC2626',
    700: '#B91C1C',
    950: '#450A0A',
  },
  emerald: {
    50: '#ECFDF5',
    300: '#6EE7B7',
    400: '#34D399',
    600: '#059669',
    700: '#047857',
    950: '#022C22',
  },
  white: '#FFFFFF',
  black: '#000000',
};

export const ICONS = {
  home: 'M3 10.5L12 3l9 7.5V20a1 1 0 0 1-1 1h-5v-6h-6v6H4a1 1 0 0 1-1-1v-9.5z',
  calendar: 'M4 5h16a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V6a1 1 0 0 1 1-1zm0 4h16M8 3v4M16 3v4',
  book: 'M4 19.5A2.5 2.5 0 0 1 6.5 17H20M4 19.5A2.5 2.5 0 0 0 6.5 22H20V2H6.5A2.5 2.5 0 0 0 4 4.5v15z',
  heart: 'M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z',
  user: 'M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zm0 2c-4.42 0-8 2.24-8 5v1h16v-1c0-2.76-3.58-5-8-5z',
  search: 'M11 19a8 8 0 1 0 0-16 8 8 0 0 0 0 16zm10 2l-4.35-4.35',
  mic: 'M12 14a3 3 0 0 0 3-3V5a3 3 0 0 0-6 0v6a3 3 0 0 0 3 3zm5-3a5 5 0 0 1-10 0M12 19v3m-4 0h8',
  alert: 'M12 2L1 21h22L12 2zm0 7v5m0 4h.01',
  spa: 'M12 3c-4 4-7 8-7 12a7 7 0 0 0 14 0c0-4-3-8-7-12z',
  check: 'M20 6L9 17l-5-5',
  lock: 'M5 11h14a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-7a2 2 0 0 1 2-2zm3 0V7a4 4 0 1 1 8 0v4',
  moon: 'M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z',
  sun: 'M12 17a5 5 0 1 0 0-10 5 5 0 0 0 0 10zm0-15v2m0 16v2M4.93 4.93l1.41 1.41m11.32 11.32l1.41 1.41M2 12h2m16 0h2M4.93 19.07l1.41-1.41M17.66 6.34l1.41-1.41',
  arrowRight: 'M5 12h14m-6-6l6 6-6 6',
  arrowDown: 'M12 5v14m-6-6l6 6 6-6',
  arrowUp: 'M12 19V5m-6 6l6-6 6 6',
  close: 'M18 6L6 18M6 6l12 12',
  tree: 'M12 2L5 12h4l-3 8h12l-3-8h4L12 2zm0 18v3',
  wave: 'M4 12v2m4-6v10m4-14v18m4-12v6m4-4v2',
  clock: 'M12 22a10 10 0 1 0 0-20 10 10 0 0 0 0 20zm0-14v4l3 3',
  doc: 'M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8l-6-6zm-2 10h6m-6 4h6M14 2v6h6',
  shield: 'M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z',
};

export class FigCraftBuilder {
  constructor() {
    this.commands = [];
    // Initial page in FigCraft is ID 1
    this.nextNodeId = 2;
    this.screens = {};
    this.triggers = {};
    this.components = {};
  }

  cmd(command, params = {}) {
    this.commands.push({ command, params });
  }

  renameInitialPage(name, bgColor = '#0F172A') {
    this.cmd('page.rename', { name });
    this.cmd('page.setBackground', { color: bgColor });
    return 1;
  }

  addPage(name, bgColor = '#0F172A') {
    const id = this.nextNodeId++;
    this.cmd('page.add', { name });
    this.cmd('page.setBackground', { id, color: bgColor });
    return id;
  }

  selectPage(id) {
    this.cmd('page.select', { id });
  }

  frame({ name, parent, x = 0, y = 0, width = 390, height = 100, props = {}, registerScreen = null, registerTrigger = null }) {
    const id = this.nextNodeId++;
    const params = {
      type: 'frame',
      name,
      x,
      y,
      width,
      height,
      props: {
        clip: false,
        ...props,
      },
      select: false,
    };
    if (parent !== undefined && parent !== null) {
      params.parent = parent;
    }
    this.cmd('node.create', params);
    if (registerScreen) this.screens[registerScreen] = id;
    if (registerTrigger) this.triggers[registerTrigger] = id;
    return id;
  }

  component({ name, parent, x = 0, y = 0, width = 200, height = 80, props = {}, registerComponent = null }) {
    const id = this.nextNodeId++;
    const params = {
      type: 'component',
      name,
      x,
      y,
      width,
      height,
      props: {
        clip: false,
        ...props,
      },
      select: false,
    };
    if (parent !== undefined && parent !== null) {
      params.parent = parent;
    }
    this.cmd('node.create', params);
    if (registerComponent) this.components[registerComponent] = id;
    return id;
  }

  rect({ name = 'Rect', parent, x = 0, y = 0, width = 100, height = 100, props = {} }) {
    const id = this.nextNodeId++;
    const params = {
      type: 'rectangle',
      name,
      x,
      y,
      width,
      height,
      props,
      select: false,
    };
    if (parent !== undefined && parent !== null) params.parent = parent;
    this.cmd('node.create', params);
    return id;
  }

  ellipse({ name = 'Circle', parent, x = 0, y = 0, width = 40, height = 40, props = {} }) {
    const id = this.nextNodeId++;
    const params = {
      type: 'ellipse',
      name,
      x,
      y,
      width,
      height,
      props,
      select: false,
    };
    if (parent !== undefined && parent !== null) params.parent = parent;
    this.cmd('node.create', params);
    return id;
  }

  text({ name, parent, text, x = 0, y = 0, width, props = {} }) {
    const id = this.nextNodeId++;
    const cleanText = String(text ?? '');
    const params = {
      type: 'text',
      name: name || cleanText.slice(0, 28) || 'Text',
      text: cleanText,
      x,
      y,
      props: {
        fontFamily: 'Plus Jakarta Sans',
        fontStyle: 'Regular',
        fontSize: 12,
        fill: COLORS.basalt[900],
        textAutoResize: width ? 'height' : 'widthAndHeight',
        ...props,
      },
      select: false,
    };
    if (width !== undefined) params.width = width;
    if (parent !== undefined && parent !== null) params.parent = parent;
    this.cmd('node.create', params);
    return id;
  }

  icon({ name = 'Icon', parent, path = ICONS.home, size = 20, color = COLORS.pine[600], strokeWeight = 2 }) {
    const id = this.nextNodeId++;
    const params = {
      type: 'vector',
      name,
      parent,
      path,
      width: size,
      height: size,
      props: {
        stroke: color,
        strokeWeight,
        strokeCap: 'round',
        strokeJoin: 'round',
      },
      select: false,
    };
    this.cmd('node.create', params);
    return id;
  }

  badge({ parent, text, bg = COLORS.pine[50], fg = COLORS.pine[600], fontSize = 10, padding = [4, 10, 4, 10], radius = 999 }) {
    const bId = this.frame({
      name: `Badge: ${text}`,
      parent,
      width: 80,
      height: 22,
      props: {
        fill: bg,
        cornerRadius: radius,
        layout: 'horizontal',
        mainAlign: 'center',
        crossAlign: 'center',
        padding,
        sizingH: 'hug',
        sizingV: 'hug',
      },
    });
    this.text({
      parent: bId,
      text,
      props: {
        fontSize,
        fontStyle: 'Bold',
        fill: fg,
      },
    });
    return bId;
  }

  button({ parent, label, bg = COLORS.pine[600], fg = COLORS.white, width = 350, height = 44, radius = 14, fontSize = 12, registerTrigger = null, stroke = null }) {
    const btnProps = {
      fill: bg,
      cornerRadius: radius,
      layout: 'horizontal',
      mainAlign: 'center',
      crossAlign: 'center',
      gap: 8,
      padding: [12, 16, 12, 16],
      sizingH: width === 'fill' ? 'fill' : 'fixed',
      sizingV: 'fixed',
    };
    if (stroke) {
      btnProps.stroke = stroke;
      btnProps.strokeWeight = 1;
    }
    const id = this.frame({
      name: `Btn: ${label}`,
      parent,
      width: width === 'fill' ? 350 : width,
      height,
      props: btnProps,
      registerTrigger,
    });
    this.text({
      parent: id,
      text: label,
      props: {
        fontSize,
        fontStyle: 'Bold',
        fill: fg,
      },
    });
    return id;
  }

  // Mobile Device Shell helper (430x932 with Top Status Bar and Floating Frosted Bottom Dock)
  mobileScreen({
    name,
    x = 0,
    y = 0,
    width = 430,
    height = 1320,
    dark = false,
    activeTab = 'beranda',
    registerScreen = null,
    showDock = true,
  }) {
    const surfaceBg = dark ? COLORS.basalt[950] : COLORS.sand[50];
    const borderCol = dark ? COLORS.basalt[700] : COLORS.basalt[800];
    const textCol = dark ? COLORS.sand[100] : COLORS.basalt[900];

    const rootId = this.frame({
      name,
      x,
      y,
      width,
      height,
      registerScreen,
      props: {
        fill: surfaceBg,
        cornerRadius: 44,
        stroke: borderCol,
        strokeWeight: 8,
        clip: true,
        layout: 'vertical',
        gap: 0,
        padding: [0, 0, 0, 0],
        sizingH: 'fixed',
        sizingV: 'fixed',
        effects: [
          {
            type: 'dropShadow',
            color: '#00000045',
            offsetX: 0,
            offsetY: 20,
            radius: 48,
            spread: 0,
          },
        ],
      },
    });

    // Status Bar (430 x 40)
    const statusId = this.frame({
      name: 'Top Status Bar',
      parent: rootId,
      width: 430,
      height: 40,
      props: {
        fill: surfaceBg,
        layout: 'horizontal',
        mainAlign: 'spaceBetween',
        crossAlign: 'center',
        padding: [10, 24, 8, 24],
        sizingH: 'fill',
        sizingV: 'fixed',
      },
    });
    this.text({
      name: 'Time',
      parent: statusId,
      text: '09:41',
      props: { fontSize: 12, fontStyle: 'Bold', fill: textCol },
    });
    this.frame({
      name: 'Dynamic Island Notch',
      parent: statusId,
      width: 96,
      height: 16,
      props: { fill: COLORS.basalt[800], cornerRadius: 999 },
    });
    this.text({
      name: 'Status Icons',
      parent: statusId,
      text: '5G • WiFi • 100%',
      props: { fontSize: 11, fontStyle: 'SemiBold', fill: textCol },
    });

    // Scrollable Body Container
    const bodyHeight = showDock ? height - 116 : height - 40;
    const bodyId = this.frame({
      name: 'Content Container',
      parent: rootId,
      width: 430,
      height: bodyHeight,
      props: {
        fill: surfaceBg,
        layout: 'vertical',
        gap: 16,
        padding: [12, 20, 20, 20],
        sizingH: 'fill',
        sizingV: 'fixed',
        clip: true,
      },
    });

    // Floating Frosted Acrylic Bottom Dock (5 Tabs — Jakob's Law)
    let dockTabs = {};
    if (showDock) {
      const dockWrapperId = this.frame({
        name: 'Dock Area Wrapper',
        parent: rootId,
        width: 430,
        height: 76,
        props: {
          fill: surfaceBg,
          layout: 'horizontal',
          mainAlign: 'center',
          crossAlign: 'center',
          padding: [6, 16, 10, 16],
          sizingH: 'fill',
          sizingV: 'fixed',
        },
      });

      const dockId = this.frame({
        name: 'Floating Frosted Acrylic Dock (5 Tabs)',
        parent: dockWrapperId,
        width: 398,
        height: 60,
        props: {
          fill: dark ? COLORS.basalt[900] : COLORS.white,
          cornerRadius: 24,
          stroke: dark ? COLORS.basalt[800] : COLORS.sand[200],
          strokeWeight: 1,
          layout: 'horizontal',
          mainAlign: 'spaceBetween',
          crossAlign: 'center',
          padding: [6, 12, 6, 12],
          sizingH: 'fill',
          sizingV: 'fixed',
          effects: [
            {
              type: 'dropShadow',
              color: '#00000020',
              offsetX: 0,
              offsetY: 8,
              radius: 24,
              spread: 0,
            },
          ],
        },
      });

      const tabItems = [
        { key: 'beranda', label: 'Beranda', icon: '⌂' },
        { key: 'event', label: 'Event', icon: '📅' },
        { key: 'materi', label: 'Materi', icon: '📖' },
        { key: 'curhat', label: 'Curhat', icon: '♥' },
        { key: 'profil', label: 'Profil', icon: '👤' },
      ];

      for (const t of tabItems) {
        const isActive = t.key === activeTab;
        const activeCol = dark ? COLORS.pine[400] : COLORS.pine[600];
        const inactiveCol = dark ? COLORS.sand[400] : COLORS.basalt[400];
        const tabBtnId = this.frame({
          name: `Tab: ${t.label}`,
          parent: dockId,
          width: 70,
          height: 46,
          registerTrigger: registerScreen ? `${registerScreen}:tab:${t.key}` : null,
          props: {
            fill: isActive ? (dark ? COLORS.pine[950] : COLORS.pine[50]) : (dark ? COLORS.basalt[900] : COLORS.white),
            cornerRadius: 14,
            layout: 'vertical',
            mainAlign: 'center',
            crossAlign: 'center',
            gap: 2,
            padding: [4, 6, 4, 6],
            sizingH: 'fixed',
            sizingV: 'fixed',
          },
        });
        this.text({
          parent: tabBtnId,
          text: `${t.icon} ${t.label}`,
          props: {
            fontSize: 10,
            fontStyle: isActive ? 'Bold' : 'Medium',
            fill: isActive ? activeCol : inactiveCol,
          },
        });
        dockTabs[t.key] = tabBtnId;
      }
    }

    return { rootId, bodyId, dockTabs };
  }

  addFlow(startFrameId, name) {
    this.cmd('proto.flow.add', { start: startFrameId, name });
  }

  addInteraction({ fromId, toId, trigger = 'onClick', actionType = 'navigate', transition = 'smartAnimate', durationMs = 300 }) {
    if (!fromId || !toId) return;
    this.cmd('proto.interaction.add', {
      id: fromId,
      trigger: { type: trigger },
      action: { type: actionType, dest: toId },
      transition: { type: transition },
      durationMs,
      easing: 'easeInOut',
    });
  }

  toJSONL() {
    return this.commands.map((c) => JSON.stringify(c)).join('\n') + '\n';
  }
}
