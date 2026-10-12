import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

import '../../../../core/theme/theme_extensions.dart';

/// Episode previews and save slots are local to this screen session.
class SerialDetailEpisodeScreen extends StatefulWidget {
  const SerialDetailEpisodeScreen({super.key});

  @override
  State<SerialDetailEpisodeScreen> createState() => _SerialDetailEpisodeScreenState();
}

class _SerialDetailEpisodeScreenState extends State<SerialDetailEpisodeScreen> {
  static const _title = 'Serial 01: Badai Emosi di Meja Makan';
  static const _quote =
      '“Ketika piring terlempar dan Zaid menolak beranjak shalat maghrib, seorang ayah diuji antara menegakkan wibawa kepemimpinan (Al-Qiyadah) atau merengkuh hati anak yang sedang terluka (Al-Fashahah). Setiap keputusanmu membentuk iklim adab rumah tanggamu.”';
  static const _episodes = <(String, String, String)>[
    ('Pintu Maghrib Zaid', '6 menit', 'Menjelang maghrib, Zaid masih terpaku pada kegiatannya. Ayah mendekat dan menyamakan tinggi pandangan sebelum mengajak beranjak. Jeda untuk mendengarkan menjadi pintu pertama menuju dialog yang tenang.'),
    ('Piring Terhempas', '8 menit', 'Piring terhempas di ujung meja dan suasana makan menegang. Utamakan keselamatan, jauhkan pecahan, lalu beri ruang untuk menenangkan diri. Batas perilaku disampaikan tanpa mempermalukan Zaid.'),
    ('Suara Hati di Balik Bentakan', '7 menit', 'Di balik suara yang meninggi, Zaid membawa lelah dan luka dari sekolah. Duduk bersama tanpa menghakimi. Dengarkan ceritanya sampai tuntas sebelum memberi nasihat, sambil menjaga batas bicara yang santun.'),
    ('Rekonsiliasi & Islah Maghrib', '10 menit', 'Ayah dan Zaid merajut kembali ikatan melalui permintaan maaf, perbaikan tindakan, dan ajakan shalat bersama. Episode ini terkunci sampai alur sebelumnya tersedia.'),
  ];
  bool _bookmarked = false;
  bool _copying = false;
  int _activeSlot = 1;
  int _slotCount = 1;
  String? _feedback;

  Widget _button(String label, VoidCallback? onPress, {Widget? icon}) =>
      ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: FButton.raw(
          onPress: onPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (icon != null) ...[icon, const SizedBox(width: 8)],
              Flexible(child: Text(label, textAlign: TextAlign.center)),
            ]),
          ),
        ),
      );

  Future<void> _share() async {
    setState(() => _copying = true);
    try {
      await Clipboard.setData(const ClipboardData(
        text: '$_title\nKisah Interaktif Nabawi — referensi tema: Luqman.\n4 episode tentang ketenangan, dialog, dan adab keluarga.\nMateri edukasi karakter, bukan layanan klinis.',
      ));
      if (!mounted) return;
      setState(() => _feedback = 'Teks serial disalin untuk dibagikan. Tempelkan di aplikasi pilihan Anda.');
    } catch (_) {
      if (!mounted) return;
      setState(() => _feedback = 'Teks belum tersalin. Izinkan akses clipboard lalu coba lagi.');
    } finally {
      if (mounted) setState(() => _copying = false);
    }
  }

  void _newSave() {
    setState(() {
      _slotCount++;
      _activeSlot = _slotCount;
      _feedback = 'Slot $_activeSlot dibuat untuk sesi ini. Slot belum disimpan permanen; alur baru dimulai dari Episode 1.';
    });
    _openEpisode(0);
  }

  void _openEpisode(int index) {
    final episode = _episodes[index];
    Navigator.of(context).push<void>(MaterialPageRoute<void>(
      builder: (context) => Scaffold(
        backgroundColor: context.earthTree.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _button('Kembali ke Daftar Episode', () => Navigator.of(context).pop(), icon: iconoir.ArrowLeft()),
              const SizedBox(height: 28),
              Text('EPISODE ${index + 1} • PRATINJAU NARASI', style: context.textTheme.labelSmall?.copyWith(color: context.earthTree.ancientBark)),
              const SizedBox(height: 10),
              Text(episode.$1, style: context.textTheme.headlineLarge),
              const SizedBox(height: 20),
              Text(episode.$3, style: context.textTheme.bodyLarge?.copyWith(height: 1.8)),
              const SizedBox(height: 24),
              Text('Slot $_activeSlot • Abu Zaid - Ayah Lembut\nPratinjau lokal. Runtime pilihan dan penyimpanan kemajuan episode belum tersedia; membuka narasi tidak mengubah status selesai.', style: context.textTheme.bodySmall?.copyWith(color: context.earthTree.textSecondary)),
            ]),
          ),
        ),
      ),
    ));
  }

  Widget _badge(String text, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
    child: Text(text, style: context.textTheme.labelSmall?.copyWith(color: color)),
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: _button('Kembali', () => Navigator.of(context).maybePop(), icon: iconoir.ArrowLeft())),
                    const SizedBox(width: 8),
                    Semantics(
                      toggled: _bookmarked,
                      label: _bookmarked ? 'Hapus bookmark serial' : 'Bookmark serial',
                      child: SizedBox(width: 48, height: 48, child: FButton.raw(onPress: () => setState(() {
                        _bookmarked = !_bookmarked;
                        _feedback = _bookmarked ? 'Serial ditandai untuk sesi ini. Penanda belum disimpan permanen.' : 'Penanda serial dihapus.';
                      }), child: _bookmarked ? iconoir.Check(color: colors.meadowCanopy) : iconoir.Bookmark(color: colors.textPrimary))),
                    ),
                    const SizedBox(width: 8),
                    Semantics(label: 'Bagikan serial', child: SizedBox(width: 48, height: 48, child: FButton.raw(onPress: _copying ? null : _share, child: iconoir.ShareAndroid(color: colors.textPrimary)))),
                  ]),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: colors.surfaceContainerLow,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Semantics(
                          label: 'Ilustrasi meja makan temaram menjelang maghrib',
                          image: true,
                          child: Container(
                            height: 220,
                            width: double.infinity,
                            decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [colors.ancientBarkContainer, colors.surfaceContainerLowest, colors.surfaceContainerLow])),
                            child: Stack(children: [
                              Positioned(right: 28, top: 36, child: Container(width: 75, height: 110, decoration: BoxDecoration(color: colors.nafsLawwamah.withValues(alpha: 0.18), border: Border.all(color: colors.ancientBark.withValues(alpha: 0.25), width: 5), borderRadius: BorderRadius.circular(40)))),
                              Positioned(left: 25, right: 25, bottom: 24, child: Container(height: 48, decoration: BoxDecoration(color: colors.ancientBark.withValues(alpha: 0.35), borderRadius: BorderRadius.circular(60)))),
                              Positioned(left: 55, bottom: 40, child: Container(width: 65, height: 22, decoration: BoxDecoration(color: colors.surfaceContainerHighest, border: Border.all(color: colors.ancientBark), borderRadius: BorderRadius.circular(50)))),
                              Positioned(left: 16, right: 16, top: 16, child: Wrap(spacing: 8, runSpacing: 8, children: [_badge('Kisah Interaktif Nabawi', colors.meadowCanopy), _badge('Ref: Luqman', colors.ancientBark)])),
                            ]),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('MODUL PARENTING KARAKTER', style: context.textTheme.labelSmall?.copyWith(color: colors.ancientBark, letterSpacing: 1.2)),
                          const SizedBox(height: 8),
                          Text(_title, style: context.textTheme.headlineLarge),
                          const SizedBox(height: 16),
                          Wrap(spacing: 6, runSpacing: 8, children: [_badge('4 Episode Lengkap', colors.celestialSky), _badge('Fase Tamyiz: 9 Thn', colors.ancientBark), _badge("Bakat: Syajaa'ah & Rifq", colors.meadowCanopy)]),
                          const SizedBox(height: 20),
                          Text(_quote, style: context.textTheme.bodyMedium?.copyWith(fontFamily: 'Merriweather', fontStyle: FontStyle.italic, height: 1.8, color: colors.textSecondary)),
                          const SizedBox(height: 10),
                          Text('Narasi edukatif; bukan kutipan ayat atau hadits.', style: context.textTheme.labelSmall?.copyWith(color: colors.textMuted)),
                        ])),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Save Hub', style: context.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  SizedBox(width: double.infinity, child: _button(_activeSlot == 1 ? 'Lanjutkan Episode Terakhir (Ep. 3)' : 'Mulai Episode 1 • Slot $_activeSlot', () => _openEpisode(_activeSlot == 1 ? 2 : 0), icon: iconoir.Play())),
                  const SizedBox(height: 8),
                  SizedBox(width: double.infinity, child: _button('Buat Save Baru', _slotCount < 4 ? _newSave : null, icon: iconoir.Plus())),
                  const SizedBox(height: 12),
                  Text('Slot Aktif: Slot $_activeSlot (Abu Zaid - Ayah Lembut)', style: context.textTheme.bodySmall),
                  const SizedBox(height: 5),
                  Text('Tersedia ${4 - _slotCount} Slot Baru • Slot sesi, tidak persisten', style: context.textTheme.labelSmall?.copyWith(color: colors.textMuted)),
                  if (_feedback != null) ...[
                    const SizedBox(height: 12),
                    Semantics(liveRegion: true, child: Text(_feedback!, style: context.textTheme.bodySmall?.copyWith(color: colors.meadowCanopy))),
                  ],
                  const SizedBox(height: 12),
                  Text('Status episode di bawah adalah contoh desain. Tombol membuka narasi lokal, bukan runtime pilihan; kemajuan tidak disimulasikan.', style: context.textTheme.bodySmall?.copyWith(color: colors.textSecondary)),
                  const SizedBox(height: 28),
                  Text('Daftar Episode Serial', style: context.textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text('Pilih alur skenario atau baca ulang narasi', style: context.textTheme.bodySmall?.copyWith(color: colors.textMuted)),
                  const SizedBox(height: 16),
                  for (var i = 0; i < _episodes.length; i++) _episodeCard(i),
                  const SizedBox(height: 16),
                  Text('Catatan Pendamping Nabawiyah', style: context.textTheme.titleMedium?.copyWith(color: colors.ancientBark)),
                  const SizedBox(height: 8),
                  Text('Ujian terberat seorang pendidik bukanlah saat anak patuh, melainkan saat anak mengekspresikan luka melalui kemarahan. Utamakan ketenangan sebelum kalimat nasihat diucapkan.', style: context.textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  Text('Materi edukasi karakter dan pendampingan adab Islam, bukan diagnosis atau pengganti intervensi psikiatri klinis.', style: context.textTheme.bodySmall?.copyWith(color: colors.textMuted)),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _episodeCard(int index) {
    final colors = context.earthTree;
    final episode = _episodes[index];
    final active = index == 2;
    final locked = index == 3;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: active ? colors.surfaceContainerHigh : colors.surfaceContainer, borderRadius: BorderRadius.circular(16), border: Border.all(color: active ? colors.meadowCanopy : colors.tactileBorder)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(spacing: 8, runSpacing: 8, children: [
          _badge(locked ? 'TERKUNCI' : active ? 'SEDANG BERJALAN' : 'SELESAI', locked ? colors.textMuted : active ? colors.meadowCanopy : colors.ancientBark),
          _badge(episode.$2, colors.textSecondary),
        ]),
        const SizedBox(height: 12),
        Text('Episode 0${index + 1}: ${episode.$1}', style: context.textTheme.titleLarge?.copyWith(color: locked ? colors.textMuted : colors.textPrimary)),
        const SizedBox(height: 8),
        Text(episode.$3, style: context.textTheme.bodySmall?.copyWith(color: colors.textSecondary, height: 1.7)),
        const SizedBox(height: 14),
        SizedBox(width: double.infinity, child: _button(locked ? 'Terkunci • Selesaikan Episode 3' : active ? 'Buka Narasi Episode' : 'Baca Ulang Episode', locked ? null : () => _openEpisode(index), icon: locked ? iconoir.Lock() : iconoir.Play())),
      ]),
    );
  }
}
