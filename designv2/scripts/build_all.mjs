import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { execFileSync } from 'node:child_process';
import { FigCraftBuilder } from './design_tokens.mjs';
import { buildSystemAndComponentsPages } from './pages_system_and_components.mjs';
import { buildMainScreensPage } from './pages_main_screens.mjs';
import { buildModalsAndFlowsPage } from './pages_modals_and_flows.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT_DIR = path.resolve(__dirname, '..');
const EXPORTS_DIR = path.join(ROOT_DIR, 'exports');
fs.mkdirSync(EXPORTS_DIR, { recursive: true });

console.log('1. Building PKN Mobile v2 command graph...');
const builder = new FigCraftBuilder();
buildSystemAndComponentsPages(builder);
buildMainScreensPage(builder);
buildModalsAndFlowsPage(builder);

const jsonlPath = path.join(ROOT_DIR, 'pkn-mobile-v2-commands.jsonl');
fs.writeFileSync(jsonlPath, builder.toJSONL(), 'utf8');
console.log(`   Wrote ${builder.commands.length} commands (${builder.nextNodeId - 1} nodes, ${Object.keys(builder.screens).length} screens) to ${jsonlPath}`);

const figcraftPath = path.join(ROOT_DIR, 'pkn-mobile-v2.figcraft');
const figPath = path.join(ROOT_DIR, 'pkn-mobile-v2.fig');

console.log('2. Executing figcraft-cli run to generate pkn-mobile-v2.figcraft...');
const runOut = execFileSync('/home/deck/.local/bin/figcraft-cli', ['run', jsonlPath, '--out', figcraftPath], {
  encoding: 'utf8',
  maxBuffer: 50 * 1024 * 1024,
});
const lines = runOut.trim().split('\n');
const errors = lines.filter((l) => l.includes('"ok":false'));
console.log(`   figcraft-cli run completed: ${lines.length} output lines, ${errors.length} errors.`);
if (errors.length > 0) {
  console.error('   First 5 errors:', errors.slice(0, 5));
}

console.log('3. Exporting pkn-mobile-v2.fig from FigCraft...');
execFileSync('/home/deck/.local/bin/figcraft-cli', ['export', figcraftPath, '-o', figPath, '--format', 'fig'], {
  encoding: 'utf8',
});

console.log('4. Enriching pkn-mobile-v2.fig with native Kiwi Multi-Mode Variable Collections via openpencil-cli eval...');
const openPencilEvalCode = `
  const col = figma.createVariableCollection("Earth-Tree Theme");
  const lightModeId = col.modes[0].modeId;
  figma.graph.renameMode(col.id, lightModeId, "Light (Warm Sand)");
  const darkModeId = figma.graph.createMode(col.id, "Dark (Tahajjud)");

  const hexToRgba = (hex) => {
    const h = hex.replace('#', '');
    return {
      r: parseInt(h.slice(0, 2), 16) / 255,
      g: parseInt(h.slice(2, 4), 16) / 255,
      b: parseInt(h.slice(4, 6), 16) / 255,
      a: 1
    };
  };

  const colorTokens = [
    ["bg/canvas", "#FDFBF7", "#12120E"],
    ["bg/surface-card", "#FFFFFF", "#1C1C17"],
    ["bg/surface-subtle", "#F7F2E7", "#2B2B28"],
    ["bg/dock-frosted", "#FFFFFF", "#1C1C17"],
    ["text/primary", "#1C1C17", "#FDFBF7"],
    ["text/secondary", "#52524E", "#E1D2B3"],
    ["text/muted", "#8E8E88", "#CFB990"],
    ["border/subtle", "#EEE5D1", "#2B2B28"],
    ["brand/pine-50", "#EDF9F0", "#052412"],
    ["brand/pine-500", "#1B8A43", "#3FB363"],
    ["brand/pine-600", "#006D30", "#1B8A43"],
    ["brand/pine-700", "#005826", "#006D30"],
    ["crisis/terracotta-500", "#C05621", "#E07A47"],
    ["crisis/terracotta-600", "#9C4114", "#C05621"],
    ["crisis/red-600", "#DC2626", "#EF4444"],
    ["accent/amber-300", "#FCD34D", "#FBBF24"],
    ["accent/amber-500", "#D97706", "#F59E0B"],
    ["accent/amber-600", "#B45309", "#D97706"]
  ];

  for (const [name, lightHex, darkHex] of colorTokens) {
    const v = figma.createVariable(name, "COLOR", col.id, hexToRgba(lightHex));
    figma.setVariableValue(v.id, darkModeId, hexToRgba(darkHex));
  }

  const numCol = figma.createVariableCollection("Layout & Radius Tokens");
  const numModeId = numCol.modes[0].modeId;
  figma.graph.renameMode(numCol.id, numModeId, "Mobile 430px");
  const numTokens = [
    ["radius/sm", 12],
    ["radius/md", 16],
    ["radius/lg", 24],
    ["radius/sheet", 32],
    ["radius/device", 44],
    ["space/page-padding", 20],
    ["space/card-gap", 12],
    ["space/section-gap", 16]
  ];
  for (const [name, val] of numTokens) {
    figma.createVariable(name, "FLOAT", numCol.id, val);
  }

  return {
    pages: figma.root.children.map(p => ({ name: p.name, topLevelFrames: p.children.length })),
    collections: figma.getLocalVariableCollections().length,
    variables: figma.getLocalVariables().length
  };
`;

const evalOut = execFileSync('/home/deck/.local/bin/openpencil-cli', ['eval', figPath, '-w', '-c', openPencilEvalCode, '--json'], {
  encoding: 'utf8',
});
console.log('   openpencil-cli eval result:\n', evalOut.trim());

console.log('5. Exporting CSS Design Tokens via openpencil-cli tokens...');
const cssTokens = execFileSync('/home/deck/.local/bin/openpencil-cli', ['tokens', figPath], { encoding: 'utf8' });
fs.writeFileSync(path.join(EXPORTS_DIR, 'pkn-mobile-v2-tokens.css'), cssTokens, 'utf8');

console.log('6. Rendering high-resolution page previews & PDF handoff via figcraft-cli...');
const pageRenders = [
  ['00 - Cover & Architecture', '00-cover-architecture.png'],
  ['01 - Design System & Tokens', '01-design-system-tokens.png'],
  ['02 - Component Library', '02-component-library.png'],
  ['03 - Main App Screens (Light & Dark)', '03-main-app-screens.png'],
  ['04 - Interactive Modals & Flows', '04-interactive-modals-flows.png'],
];

for (const [pageName, fileName] of pageRenders) {
  const outPng = path.join(EXPORTS_DIR, fileName);
  const res = execFileSync('/home/deck/.local/bin/figcraft-cli', ['render', figcraftPath, '-o', outPng, '--scale', '1', '--page', pageName], {
    encoding: 'utf8',
  });
  console.log('   Rendered:', res.trim());
}

const pdfPath = path.join(EXPORTS_DIR, 'pkn-mobile-v2-handoff.pdf');
execFileSync('/home/deck/.local/bin/figcraft-cli', ['export', figcraftPath, '-o', pdfPath, '--format', 'pdf'], {
  encoding: 'utf8',
});
console.log('   Exported vector PDF:', pdfPath);

console.log('Done!');
