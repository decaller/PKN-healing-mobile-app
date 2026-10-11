import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

import '../../../../core/theme/theme_extensions.dart';
import 'dalil_detail_screen.dart';

/// Panduan lapangan edukatif, tanpa diagnosis atau pencatatan klinis.
class P3kCrisisScreen extends StatefulWidget {
  const P3kCrisisScreen({super.key});

  @override
  State<P3kCrisisScreen> createState() => _P3kCrisisScreenState();
}

class _P3kCrisisScreenState extends State<P3kCrisisScreen> {
  static const _lead = <String>[
    'JANGAN membentak/mempermalukan anak di depan umum.',
    'Bawa ke tempat teduh, jongkok sejajar mata, bisikkan: “Ayah/Bunda di sini menemani. Ayah tahu kamu sedang sangat marah dan sesak. Menangislah dulu sampai dadamu lega.”',
    'Baru tegaskan aturan setelah napas teratur dan tangis reda.',
  ];
  static const _warning =
      'Dilarang keras memukul balita. Jangan memaksakan dekapan saat anak meronta; hal ini berisiko mencederai. Singkirkan benda berbahaya dan utamakan keselamatan anak.';
  static const _steps = <(String, String)>[
    (
      'Isolasi Sensorik',
      'Tenangkan diri dan berhenti berdebat. Jauhkan anak dari kerumunan, kebisingan, kaca, dan tepi tangga. Dampingi di tempat teduh yang aman tanpa tergesa-gesa.',
    ),
    (
      'Validasi Emosi',
      'Jongkok sejajar mata dan gunakan suara lembut. Akui perasaannya tanpa mengabulkan semua tuntutan: “Bunda tahu kamu sedih tidak dibelikan mainan ini.” Tetap jaga batasan, tanpa bentakan atau sogokan gawai.',
    ),
    (
      'Regulasi Bersama',
      'Temani anak bernapas perlahan; jangan memaksa tangis segera berhenti. Tawarkan dekapan bila anak bersedia. Setelah napas teratur dan tangis reda, tawarkan air minum lalu tegaskan aturan singkat dengan kasih sayang, tanpa mengungkit celaan lampau.',
    ),
  ];
  static const _disclaimer =
      'Materi ini merupakan edukasi karakter dan pendampingan adab Islam, bukan diagnosis atau pengganti intervensi psikiatri klinis. Jika keselamatan anak terancam, cari bantuan langsung dari layanan darurat atau tenaga profesional setempat.';

  final _sopKey = GlobalKey();
  bool _bookmarked = false;
  bool _copying = false;
  String? _feedback;

  void _toggleBookmark() {
    setState(() {
      _bookmarked = !_bookmarked;
      _feedback = _bookmarked
          ? 'SOP ditandai untuk sesi ini. Penanda belum disimpan permanen.'
          : 'Penanda SOP dihapus.';
    });
  }

  Future<void> _leave() async {
    final popped = await Navigator.of(context).maybePop();
    if (!popped && mounted) {
      setState(() => _feedback = 'Anda sudah berada di halaman awal.');
    }
  }

  Future<void> _copySop() async {
    setState(() => _copying = true);
    final text = StringBuffer()
      ..writeln('P3K Tantrum di Depan Umum')
      ..writeln('\nResep Lapangan 10 Detik (Lakukan Sekarang)');
    for (var i = 0; i < _lead.length; i++) {
      text.writeln('${i + 1}. ${_lead[i]}');
    }
    text
      ..writeln('\nBatasan Perlindungan Anak (Haram Dilanggar)')
      ..writeln(_warning)
      ..writeln('\nProtokol Bertahap (SOP Tindakan)');
    for (var i = 0; i < _steps.length; i++) {
      text
        ..writeln('${i + 1}. ${_steps[i].$1}')
        ..writeln(_steps[i].$2);
    }
    text
      ..writeln('\nRujukan: Modul Krisis Nabawiyah — SOP Tantrum Publik.')
      ..writeln('Panduan praktis; tidak memuat kutipan ayat atau hadits.')
      ..writeln('\n$_disclaimer');
    try {
      await Clipboard.setData(ClipboardData(text: text.toString()));
      if (!mounted) return;
      setState(() {
        _copying = false;
        _feedback =
            'SOP lengkap disalin ke clipboard. Tempelkan untuk membagikan.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _copying = false;
        _feedback =
            'SOP belum tersalin. Izinkan akses clipboard lalu coba lagi.';
      });
    }
  }

  void _startSop() {
    final target = _sopKey.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 250),
      alignment: 0.05,
    );
  }

  void _showReference() {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => const DalilDetailScreen()),
    );
  }

  Widget _button(String label, VoidCallback? onPress) => ConstrainedBox(
    constraints: const BoxConstraints(minHeight: 48),
    child: FButton.raw(
      onPress: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SizedBox(
          width: double.infinity,
          child: Text(label, textAlign: TextAlign.center, softWrap: true),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          tooltip: 'Kembali',
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          onPressed: _leave,
          icon: iconoir.ArrowLeft(color: colors.textPrimary),
        ),
        title: Text(
          'Detail Rujukan',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleMedium,
        ),
        actions: [
          Semantics(
            toggled: _bookmarked,
            child: IconButton(
              tooltip: _bookmarked ? 'Hapus penanda SOP' : 'Tandai SOP',
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              onPressed: _toggleBookmark,
              icon: _bookmarked
                  ? iconoir.Check(color: colors.meadowCanopy)
                  : iconoir.Bookmark(color: colors.textPrimary),
            ),
          ),
          IconButton(
            tooltip: 'Bagikan SOP',
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            onPressed: _copying ? null : _copySop,
            icon: iconoir.ShareAndroid(color: colors.textPrimary),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'RESEP P3K • BACA 10 DETIK',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: colors.meadowCanopy,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Anak Mengamuk (Tantrum) di Depan Umum',
                      style: context.textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'SOP tindakan & kalimat penenteram',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerLow,
                        border: Border(
                          left: BorderSide(color: colors.meadowCanopy, width: 4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Resep Lapangan 10 Detik (Lakukan Sekarang)',
                            style: context.textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          for (var i = 0; i < _lead.length; i++)
                            _numbered(context, i + 1, _lead[i]),
                          const SizedBox(height: 4),
                          _button('Lakukan Sekarang', _startSop),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colors.error.withValues(alpha: 0.06),
                        border: Border(
                          left: BorderSide(color: colors.error, width: 4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          iconoir.Shield(color: colors.error, width: 24, height: 24),
                          const SizedBox(height: 10),
                          Text(
                            'Batasan Perlindungan Anak (Haram Dilanggar)',
                            style: context.textTheme.headlineSmall?.copyWith(
                              color: colors.error,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(_warning, style: context.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Protokol Bertahap (SOP Tindakan)',
                      key: _sopKey,
                      style: context.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ikuti keadaan anak, bukan hitungan waktu.',
                      style: context.textTheme.bodySmall,
                    ),
                    for (var i = 0; i < _steps.length; i++) ...[
                      const SizedBox(height: 24),
                      Text(
                        'LANGKAH ${i + 1}',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: colors.ancientBark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_steps[i].$1, style: context.textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Text(_steps[i].$2, style: context.textTheme.bodyMedium),
                      const SizedBox(height: 24),
                      Divider(height: 1, color: colors.tactileBorder),
                    ],
                    const SizedBox(height: 24),
                    _button(_copying ? 'Menyalin SOP…' : 'Bagikan SOP',
                        _copying ? null : _copySop),
                    const SizedBox(height: 12),
                    _button('Selesai', _leave),
                    if (_feedback != null) ...[
                      const SizedBox(height: 16),
                      Semantics(
                        liveRegion: true,
                        child: Text(
                          _feedback!,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    Text('CATATAN & RUJUKAN', style: context.textTheme.labelMedium),
                    const SizedBox(height: 8),
                    Text(
                      'Modul Krisis Nabawiyah • SOP Tantrum Publik\nTelaah kedisiplinan ibadah usia 10 tahun tersedia sebagai konteks tarbiyah, bukan izin memukul balita atau anak saat tantrum.',
                      style: context.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    _button('Detail Rujukan', _showReference),
                    const SizedBox(height: 16),
                    Text(_disclaimer, style: context.textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _numbered(BuildContext context, int number, String text) {
    final colors = context.earthTree;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.meadowCanopy,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: context.textTheme.labelLarge?.copyWith(
                color: colors.onMeadowCanopy,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: context.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
