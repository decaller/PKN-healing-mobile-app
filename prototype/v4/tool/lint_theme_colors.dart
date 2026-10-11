import 'dart:io';

/// Linter Otomatis untuk Theme & Color Tokens (Earth-Tree System)
///
/// Aturan:
/// 1. [HARDCODED_FOREGROUND]: Hindari Colors.white / Colors.black pada Text/Icon di widget UI.
///    Gunakan token dinamis seperti colors.textPrimary, colors.onCelestialSky, dll.
/// 2. [TOKEN_MISMATCH]: Jangan memasangkan container background (*Container) dengan
///    on* base token (misal meadowCanopyContainer dengan onMeadowCanopy).
///    Gunakan onMeadowCanopyContainer.
/// 3. [RAW_HEX_IN_UI]: Hindari instansiasi Color(0xFF...) langsung di file widget UI.
///    Gunakan token dari context.earthTree.
/// 4. [STATIC_THEME_ACCESS]: Hindari EarthTreeColors.light/dark di dalam widget build.
///    Gunakan context.earthTree.
void main(List<String> args) {
  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    stderr.writeln('Error: Direktori lib/ tidak ditemukan. Jalankan dari folder prototype/v4.');
    exit(1);
  }

  stdout.writeln('🔍 Menjalankan Earth-Tree Color Linter...\n');

  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  int totalViolations = 0;
  final violationsByFile = <String, List<LintViolation>>{};

  for (final file in dartFiles) {
    // Lewatkan definisi tema utama di lib/core/theme/ dan theme.dart
    final relPath = file.path.replaceAll('\\', '/');
    if (relPath.contains('lib/core/theme/earth_tree_colors.dart') ||
        relPath.contains('lib/core/theme/earth_tree_forui.dart') ||
        relPath.contains('lib/app/theme.dart')) {
      continue;
    }

    final lines = file.readAsLinesSync();
    final fileViolations = <LintViolation>[];

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final lineNum = i + 1;

      // Cek Rule 1: HARDCODED_FOREGROUND (Colors.white / Colors.black langsung pada Icon/Text)
      if (_hasHardcodedForeground(line)) {
        fileViolations.add(LintViolation(
          rule: 'HARDCODED_FOREGROUND',
          message: 'Ditemukan hardcoded Colors.white/black pada foreground text/icon.',
          suggestion: 'Gunakan colors.on* yang sesuai atau colors.textPrimary.',
          file: relPath,
          line: lineNum,
          lineSnippet: line.trim(),
        ));
      }

      // Cek Rule 2: RAW_HEX_IN_UI (Color(0xFF...) bukan shadow)
      if (_hasRawHexColor(line)) {
        fileViolations.add(LintViolation(
          rule: 'RAW_HEX_IN_UI',
          message: 'Ditemukan Color(0x...) langsung di UI widget alih-alih token tema.',
          suggestion: 'Gunakan token context.earthTree.* agar dinamis saat tema berganti.',
          file: relPath,
          line: lineNum,
          lineSnippet: line.trim(),
        ));
      }

      // Cek Rule 3: STATIC_THEME_ACCESS
      if (line.contains('EarthTreeColors.light') || line.contains('EarthTreeColors.dark')) {
        // Abaikan provider/extension fallback
        if (!relPath.contains('theme_extensions.dart')) {
          fileViolations.add(LintViolation(
            rule: 'STATIC_THEME_ACCESS',
            message: 'Akses statis ke EarthTreeColors.light/dark.',
            suggestion: 'Gunakan context.earthTree.',
            file: relPath,
            line: lineNum,
            lineSnippet: line.trim(),
          ));
        }
      }
    }

    // Cek Rule 4: TOKEN_MISMATCH (analisis multiline dalam file)
    final fileContent = lines.join('\n');
    final mismatchViolations = _checkTokenMismatches(relPath, lines, fileContent);
    fileViolations.addAll(mismatchViolations);

    if (fileViolations.isNotEmpty) {
      violationsByFile[relPath] = fileViolations;
      totalViolations += fileViolations.length;
    }
  }

  // Tampilkan Hasil
  if (totalViolations == 0) {
    stdout.writeln('✅ SEMPURNA! 0 pelanggaran warna tema ditemukan di seluruh codebase.');
    exit(0);
  } else {
    stdout.writeln('⚠️ Ditemukan $totalViolations potensi masalah tema warna:\n');
    for (final entry in violationsByFile.entries) {
      stdout.writeln('📄 ${entry.key}:');
      for (final v in entry.value) {
        stdout.writeln('   Baris ${v.line} [${v.rule}]: ${v.message}');
        stdout.writeln('   > ${v.lineSnippet}');
        stdout.writeln('   💡 Solusi: ${v.suggestion}\n');
      }
    }
    // Keluar dengan status non-zero jika diminta argumen --strict
    if (args.contains('--strict')) {
      exit(1);
    }
  }
}

bool _hasHardcodedForeground(String line) {
  // Abaikan komentar
  if (line.trim().startsWith('//') || line.contains('ignore_theme_linter')) return false;

  // Abaikan jika menggunakan alpha/withValues (overlay scrim/foto)
  if (line.contains('withValues') || line.contains('withOpacity')) return false;
  // Abaikan Colors.transparent
  if (line.contains('Colors.transparent')) return false;

  // Pola Colors.white atau Colors.black pada iconoir atau Text style
  final isWhiteOrBlack = RegExp(r'\bColors\.(white|black)\b').hasMatch(line);
  if (!isWhiteOrBlack) return false;

  // Cek apakah dipakai pada icon atau text style
  final isForegroundContext = RegExp(r'(color:\s*Colors\.(white|black)|tagTextColor:\s*Colors\.(white|black))').hasMatch(line);
  return isForegroundContext;
}

bool _hasRawHexColor(String line) {
  if (line.trim().startsWith('//') || line.contains('ignore_theme_linter')) return false;

  // Abaikan jika ini shadow alpha rendah (misal: 0x0A2C2825, 0x082C2825, 0x1F000000, 0x062C2825)
  if (RegExp(r'Color\(\s*0x0[0-9A-Fa-f]').hasMatch(line) ||
      RegExp(r'Color\(\s*0x1[0-9A-Fa-f]').hasMatch(line) ||
      RegExp(r'Color\(\s*0x2[0-9A-Fa-f]').hasMatch(line)) {
    return false;
  }

  // Cek hex padat Color(0xFF...)
  return RegExp(r'Color\(\s*0xFF[0-9A-Fa-f]{6}\s*\)').hasMatch(line);
}

List<LintViolation> _checkTokenMismatches(String filePath, List<String> lines, String content) {
  final violations = <LintViolation>[];

  // Cari pasangan tagColor: *Container dan tagTextColor: on* (bukan on*Container)
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];

    // Misal: tagColor: colors.meadowCanopyContainer dengan tagTextColor: colors.onMeadowCanopy
    if (line.contains('tagColor: colors.meadowCanopyContainer') ||
        line.contains('tagColor: colors.ancientBarkContainer') ||
        line.contains('tagColor: colors.celestialSkyContainer')) {
      // Periksa 3 baris setelahnya
      for (var j = 1; j <= 3 && (i + j) < lines.length; j++) {
        final nextLine = lines[i + j];
        if (nextLine.contains('tagTextColor: colors.onMeadowCanopy') &&
            !nextLine.contains('Container')) {
          violations.add(LintViolation(
            rule: 'TOKEN_MISMATCH',
            message: 'meadowCanopyContainer dipasangkan dengan onMeadowCanopy.',
            suggestion: 'Gunakan colors.onMeadowCanopyContainer untuk kontras sempurna di kedua mode.',
            file: filePath,
            line: i + j + 1,
            lineSnippet: nextLine.trim(),
          ));
        } else if (nextLine.contains('tagTextColor: colors.onAncientBark') &&
            !nextLine.contains('Container')) {
          violations.add(LintViolation(
            rule: 'TOKEN_MISMATCH',
            message: 'ancientBarkContainer dipasangkan dengan onAncientBark.',
            suggestion: 'Gunakan colors.onAncientBarkContainer untuk kontras sempurna di kedua mode.',
            file: filePath,
            line: i + j + 1,
            lineSnippet: nextLine.trim(),
          ));
        } else if (nextLine.contains('tagTextColor: colors.onCelestialSky') &&
            !nextLine.contains('Container')) {
          violations.add(LintViolation(
            rule: 'TOKEN_MISMATCH',
            message: 'celestialSkyContainer dipasangkan dengan onCelestialSky.',
            suggestion: 'Gunakan colors.onCelestialSkyContainer untuk kontras sempurna di kedua mode.',
            file: filePath,
            line: i + j + 1,
            lineSnippet: nextLine.trim(),
          ));
        }
      }
    }
  }

  return violations;
}

class LintViolation {
  final String rule;
  final String message;
  final String suggestion;
  final String file;
  final int line;
  final String lineSnippet;

  LintViolation({
    required this.rule,
    required this.message,
    required this.suggestion,
    required this.file,
    required this.line,
    required this.lineSnippet,
  });
}
