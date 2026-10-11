import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

import '../../../../core/theme/theme_extensions.dart';

/// Telaah edukatif: disiplin ibadah bertahap dengan perlindungan anak.
class DalilDetailScreen extends StatefulWidget {
  const DalilDetailScreen({super.key});

  @override
  State<DalilDetailScreen> createState() => _DalilDetailScreenState();
}

class _DalilDetailScreenState extends State<DalilDetailScreen> {
  static const _matan =
      'مُرُوا أَوْلَادَكُمْ بِالصَّلَاةِ وَهُمْ أَبْنَاءُ سَبْعِ سِنِينَ، وَاضْرِبُوهُمْ عَلَيْهَا وَهُمْ أَبْنَاءُ عَشْرٍ، وَفَرِّقُوا بَيْنَهُمْ فِي الْمَضَاجِعِ';
  static const _translation =
      '“Perintahkanlah anak-anakmu mendirikan shalat ketika mereka berusia tujuh tahun, dan pukullah mereka (dengan pukulan mendidik) karena meninggalkannya ketika mereka berusia sepuluh tahun, serta pisahkanlah tempat tidur di antara mereka.”';
  static const _reference =
      'HR. Abu Dawud No. 495 dan Ahmad No. 6689 • Hasan Shahih';
  static const _title =
      'Telaah Dalil & Fiqih Tarbiyah: Kedisiplinan Ibadah Usia 10 Tahun';
  bool _bookmarked = false;
  bool _copying = false;
  String? _feedback;

  void _bookmark() {
    setState(() {
      _bookmarked = !_bookmarked;
      _feedback = _bookmarked
          ? 'Dalil ditandai untuk sesi ini. Penanda belum disimpan permanen.'
          : 'Penanda dalil dihapus.';
    });
  }

  Future<void> _copy({bool forSharing = false}) async {
    setState(() => _copying = true);
    try {
      await Clipboard.setData(ClipboardData(
        text: '$_title\n\n$_matan\n\n$_translation\n\n$_reference\n\n'
            'Catatan: bukan izin memukul balita atau melampiaskan amarah. '
            'Utamakan keselamatan anak (hifzhun nafs); dilarang mengenai wajah atau melukai.',
      ));
      if (!mounted) return;
      setState(() {
        _copying = false;
        _feedback = forSharing
            ? 'Teks dalil dan terjemahan disalin untuk dibagikan. Tempelkan di aplikasi tujuan.'
            : 'Matan hadits, terjemahan, dan rujukan disalin ke clipboard.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _copying = false;
        _feedback = 'Teks belum tersalin. Izinkan akses clipboard lalu coba lagi.';
      });
    }
  }

  Future<void> _leave() async {
    final popped = await Navigator.of(context).maybePop();
    if (!popped && mounted) {
      setState(() => _feedback = 'Tidak ada halaman SOP sebelumnya untuk dikembalikan.');
    }
  }

  Widget _headerAction(String label, Widget icon, VoidCallback? onPress,
      {bool? toggled}) {
    return Semantics(
      label: label,
      toggled: toggled,
      child: Tooltip(
        message: label,
        child: SizedBox(
          width: 48,
          height: 48,
          child: FButton.raw(onPress: onPress, child: icon),
        ),
      ),
    );
  }

  Widget _button(String label, Widget icon, VoidCallback? onPress) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: FButton.raw(
        onPress: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 10),
              Flexible(child: Text(label, textAlign: TextAlign.center)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(BuildContext context, String title, String body,
      {bool warning = false}) {
    final colors = context.earthTree;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: warning ? colors.error.withValues(alpha: 0.06) : colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: warning ? colors.error : colors.tactileBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.textTheme.titleMedium?.copyWith(
            color: warning ? colors.error : colors.meadowCanopy,
            fontWeight: FontWeight.w700,
          )),
          const SizedBox(height: 10),
          Text(body, style: context.textTheme.bodyMedium),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  _headerAction('Kembali', iconoir.ArrowLeft(color: colors.textPrimary), _leave),
                  Expanded(child: Text('Telaah Dalil', style: context.textTheme.titleMedium)),
                  _headerAction(
                    _bookmarked ? 'Hapus penanda dalil' : 'Tandai dalil',
                    _bookmarked ? iconoir.Check(color: colors.meadowCanopy) : iconoir.Bookmark(color: colors.textPrimary),
                    _bookmark,
                    toggled: _bookmarked,
                  ),
                  _headerAction('Bagikan dalil', iconoir.ShareAndroid(color: colors.textPrimary),
                    _copying ? null : () => _copy(forSharing: true)),
                ],
              ),
            ),
            if (_feedback != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Semantics(
                  liveRegion: true,
                  child: Text(_feedback!, style: context.textTheme.bodySmall?.copyWith(color: colors.textPrimary)),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 680),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('PILAR 6 • KHAZANAH DALIL & TAKHRIJ', style: context.textTheme.labelMedium?.copyWith(
                            color: colors.ancientBark, fontWeight: FontWeight.w700,
                          )),
                          const SizedBox(height: 12),
                          Text(_title, style: context.textTheme.headlineLarge),
                          const SizedBox(height: 10),
                          Text('Fiqih tarbiyah & perlindungan hak fitrah anak', style: context.textTheme.bodyMedium?.copyWith(color: colors.textSecondary)),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: colors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: colors.tactileBorder),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('MATAN HADITS', style: context.textTheme.labelMedium?.copyWith(color: colors.ancientBark)),
                                const SizedBox(height: 16),
                                SelectableText(_matan, textDirection: TextDirection.rtl, textAlign: TextAlign.right,
                                  style: TextStyle(fontFamily: 'Amiri', fontSize: 28, height: 2, color: colors.ancientBark)),
                                const SizedBox(height: 20),
                                Divider(height: 1, color: colors.tactileBorder),
                                const SizedBox(height: 20),
                                Text('TERJEMAHAN', style: context.textTheme.labelMedium?.copyWith(color: colors.textSecondary)),
                                const SizedBox(height: 10),
                                SelectableText(_translation, style: context.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _card(context, 'Takhrij & Derajat Hadits', '$_reference\n\nDisahihkan Syaikh Al-Albani dalam Shahih Sunan Abi Dawud.'),
                          const SizedBox(height: 28),
                          Text('Kaidah Tarbiyah Bertahap', style: context.textTheme.headlineSmall),
                          const SizedBox(height: 16),
                          _card(context, 'Usia 7: Tamyiz & Cinta Ibadah',
                            'Saat anak memasuki usia tamyiz, mulai ajak shalat dengan kehangatan, keteladanan, dan pendampingan. Tumbuhkan cinta kepada ibadah, bukan rasa takut kepada orang tua. Rentang usia 7–10 tahun adalah masa pembiasaan yang bertahap dan konsisten.'),
                          const SizedBox(height: 16),
                          _card(context, 'Usia 10: Belajar Tanggung Jawab',
                            'Setelah pembiasaan dan pengajaran, usia 10 tahun menjadi tahap penguatan tanggung jawab ibadah. Jelaskan aturan dengan tenang, dampingi pelaksanaannya, dan tegaskan batas secara mendidik. Angka usia bukan alasan untuk mengabaikan kesiapan dan keselamatan anak.'),
                          const SizedBox(height: 16),
                          _card(context, 'Pukulan Tarbiyah, Bukan Pelampiasan Amarah',
                            'Makna disiplin dalam hadits dibatasi ghairu mubarrih: tidak melukai, tidak mencederai, dan bukan pelampiasan amarah. Dilarang mengenai wajah. Hifzhun nafs (penjagaan jiwa dan keselamatan) harus diutamakan. Hadits ini bukan izin memukul balita, membentak, atau menghukum anak saat tantrum. Saat emosi memuncak, kembali ke SOP krisis dan utamakan pendampingan tanpa kekerasan.', warning: true),
                          const SizedBox(height: 16),
                          _card(context, 'Pisah Tempat Tidur: Penjagaan Fitrah Seksualitas',
                            'Pisahkan tempat tidur anak sebagai pendidikan batas tubuh, privasi, dan adab. Penjagaan fitrah seksualitas dilakukan dengan penjelasan sesuai usia dan tetap menjaga rasa aman serta kasih sayang, bukan mempermalukan anak.'),
                          const SizedBox(height: 24),
                          _button('Kembali ke SOP Krisis', iconoir.ArrowLeft(color: colors.textPrimary), _leave),
                          const SizedBox(height: 12),
                          _button(_copying ? 'Menyalin Matan…' : 'Salin Matan Hadits', iconoir.Copy(color: colors.textPrimary), _copying ? null : () => _copy()),
                          const SizedBox(height: 24),
                          Text('Telaah ini merupakan edukasi adab dan tarbiyah, bukan pengganti pertolongan profesional. Jika keselamatan anak terancam, cari bantuan langsung dari layanan darurat atau tenaga profesional setempat.', style: context.textTheme.bodySmall?.copyWith(color: colors.textSecondary)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
