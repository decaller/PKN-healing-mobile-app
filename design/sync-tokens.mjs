#!/usr/bin/env node
import { spawnSync } from 'node:child_process';
import { readFile, writeFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import path from 'node:path';

const root = fileURLToPath(new URL('../', import.meta.url));
const args = process.argv.slice(2);
const check = args.includes('--check');
if (args.some(arg => arg !== '--check')) {
  console.error('Usage: node design/sync-tokens.mjs [--check]');
  process.exit(2);
}
const colorNames = ['Background', 'Surface', 'TextPrimary', 'TextSecondary', 'Border', 'Primary', 'PrimarySoft', 'Pillar1', 'Pillar2', 'Pillar3', 'Pillar4', 'Pillar5', 'Pillar6', 'OnPrimary'];
const styleNames = ['Display', 'Heading', 'Subhead', 'Body', 'Caption', 'Arabic'];
const fail = message => { throw new Error(message); };
const unique = (items, label) => items.length === 1 ? items[0] : fail(`Expected exactly one ${label}; found ${items.length}`);
const dartString = value => `'${value.replaceAll('\\', '\\\\').replaceAll("'", "\\'").replaceAll('$', '\\$')}'`;
const lower = value => value[0].toLowerCase() + value.slice(1);
const number = value => Number.isInteger(value) ? `${value}.0` : `${value}`;

async function main() {
  const result = spawnSync('openpencil', ['eval', path.join(root, 'design/PKN_Healing_App_Design.fig'), '-c', 'return {collections:figma.getLocalVariableCollections(),variables:figma.getLocalVariables(),typography:figma.root.getPluginData("pknTypography")};', '--json'], { encoding: 'utf8', maxBuffer: 16 * 1024 * 1024 });
  if (result.error) fail(`Cannot invoke openpencil: ${result.error.message}`);
  if (result.status !== 0) fail(`openpencil eval failed (${result.status}): ${result.stderr.trim() || result.stdout.trim()}`);
  let source;
  try { source = JSON.parse(result.stdout); } catch { fail('openpencil eval did not return valid JSON'); }
  const collection = unique(source.collections.filter(c => c.name === 'PKN'), 'variable collection PKN');
  const modes = Object.fromEntries(['Light', 'Dark'].map(name => [name, unique(collection.modes.filter(m => m.name === name), `PKN mode ${name}`).modeId]));
  const colors = {};
  for (const name of colorNames) {
    const fullName = `Tokens/Color/${name}`;
    const variable = unique(source.variables.filter(v => v.collectionId === collection.id && v.name === fullName), `PKN variable ${fullName}`);
    if (variable.type !== 'COLOR') fail(`${fullName} must be COLOR; got ${variable.type}`);
    colors[name] = {};
    for (const [mode, id] of Object.entries(modes)) {
      const value = variable.valuesByMode[id];
      if (!value) fail(`Missing ${mode} value for ${fullName}`);
      for (const channel of ['r', 'g', 'b', 'a']) {
        if (!Number.isFinite(value[channel]) || value[channel] < 0 || value[channel] > 1) fail(`Invalid ${mode} ${fullName}.${channel}; expected RGBA channel in [0,1]`);
      }
      colors[name][mode] = `0x${['a', 'r', 'g', 'b'].map(c => Math.round(value[c] * 255).toString(16).padStart(2, '0')).join('').toUpperCase()}`;
    }
  }
  let typography;
  try { typography = JSON.parse(source.typography); } catch { fail('Missing or invalid root plugin data pknTypography JSON'); }
  if (typography.version !== 1 || !Array.isArray(typography.styles)) fail('pknTypography must contain version:1 and styles array');
  const styles = styleNames.map(name => {
    const style = unique(typography.styles.filter(s => s.name === name), `pknTypography style ${name}`);
    if (typeof style.fontFamily !== 'string' || !style.fontFamily.trim() || /[\r\n]/.test(style.fontFamily)) fail(`Invalid ${name}.fontFamily`);
    for (const key of ['fontSize', 'lineHeight', 'letterSpacing']) if (!Number.isFinite(style[key])) fail(`Invalid ${name}.${key}; expected finite number`);
    if (style.fontSize <= 0 || style.lineHeight <= 0) fail(`Invalid ${name} fontSize/lineHeight; expected positive values`);
    if (!Number.isInteger(style.fontWeight) || style.fontWeight < 100 || style.fontWeight > 900 || style.fontWeight % 100 !== 0) fail(`Invalid ${name}.fontWeight; expected 100..900 in steps of 100`);
    return style;
  });
  const palette = ['  // Generated from PKN_Healing_App_Design.fig; run node design/sync-tokens.mjs.'];
  for (const mode of ['Light', 'Dark']) for (const name of colorNames) palette.push(`  static const Color ${lower(mode)}${name} = Color(${colors[name][mode]});`);
  palette.push('', '  // Existing mode-independent APIs retain the Light design value.', '  static const Color brandPrimary = lightPrimary;');
  ['Mulai', 'Tumbuh', 'Bakat', 'Keluarga', 'Lembaga', 'Dalil'].forEach((name, i) => palette.push(`  static const Color pilar${name} = lightPillar${i + 1};`));
  const tokens = [
    '// Generated from root pknTypography in PKN_Healing_App_Design.fig.',
    'class PknTextToken {',
    '  const PknTextToken({required this.fontFamily, required this.fontSize,',
    '    required this.fontWeight, required this.lineHeight, required this.letterSpacing});',
    '  final String fontFamily;', '  final double fontSize;', '  final FontWeight fontWeight;', '  final double lineHeight;', '  final double letterSpacing;', '  double get height => lineHeight / fontSize;', '}', '',
    'class PknTypography {', '  PknTypography._();',
    ...styles.map(s => `  static const ${lower(s.name)} = PknTextToken(fontFamily: ${dartString(s.fontFamily)}, fontSize: ${number(s.fontSize)}, fontWeight: FontWeight.w${s.fontWeight}, lineHeight: ${number(s.lineHeight)}, letterSpacing: ${number(s.letterSpacing)});`), '}',
  ];
  const outputs = [
    ['lib/app/theme/color_palette.dart', '  // BEGIN GENERATED PKN COLORS', '  // END GENERATED PKN COLORS', palette.join('\n')],
    ['lib/app/theme/pkn_tokens.dart', '// BEGIN GENERATED PKN TYPOGRAPHY', '// END GENERATED PKN TYPOGRAPHY', tokens.join('\n')],
  ];
  const pending = [];
  for (const [file, start, end, body] of outputs) {
    const current = await readFile(path.join(root, file), 'utf8');
    const from = current.indexOf(start), to = current.indexOf(end);
    if (from < 0 || to < from || current.indexOf(start, from + 1) !== -1 || current.indexOf(end, to + 1) !== -1) fail(`Missing or duplicate generated markers in ${file}`);
    const expected = current.slice(0, from) + `${start}\n${body}\n` + current.slice(to);
    if (expected !== current) pending.push([file, expected]);
  }
  if (check && pending.length) fail(`Token drift: ${pending.map(([file]) => file).join(', ')}. Run node design/sync-tokens.mjs`);
  for (const [file, content] of pending) if (!check) await writeFile(path.join(root, file), content);
  console.log(check ? 'Design tokens match .fig source.' : `Synced design tokens (${pending.length} files changed).`);
}
main().catch(error => { console.error(`Token sync: ${error.message}`); process.exitCode = 1; });
