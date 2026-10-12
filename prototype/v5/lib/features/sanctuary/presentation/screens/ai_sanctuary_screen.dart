import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

import '../../../../core/theme/theme_extensions.dart';

/// A local, scripted reflection space. No microphone or AI engine is started.
class AiSanctuaryScreen extends StatefulWidget {
  const AiSanctuaryScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<AiSanctuaryScreen> createState() => _AiSanctuaryScreenState();
}

class _AiSanctuaryScreenState extends State<AiSanctuaryScreen>
    with SingleTickerProviderStateMixin {
  static const _prayer =
      'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي';
  static const _translation =
      'Ya Tuhanku, lapangkanlah dadaku, dan mudahkanlah urusanku.';
  late final AnimationController _pulse;
  int _topic = 0;
  String? _copyFeedback;

  static const _dialogues = [
    (
      title: 'Saat rasa bersalah datang',
      opening: 'Lelah mengasuh itu nyata. Jika tadi suara Anda meninggi, beri diri ruang untuk tenang. Rasa menyesal dapat menjadi awal memperbaiki hubungan, bukan alasan untuk membenci diri.',
      reflection: 'Apa yang Anda rasakan sebelum marah: lelah, takut, atau kewalahan? Tidak perlu menjawab di aplikasi. Kenali kebutuhan Anda tanpa membenarkan tindakan yang menyakiti anak.',
      action: 'Saat Anda dan anak sudah tenang, dekati dengan lembut: “Tadi Ayah/Ibu berteriak. Itu tidak tepat. Maaf, ya. Mari kita coba lagi.” Tawarkan pelukan bila anak bersedia; jangan memaksanya.',
    ),
    (
      title: 'Merangkul anak yang sulit diajak bekerja sama',
      opening: 'Ketika anak menolak, Anda mungkin merasa tidak didengar. Ambil jeda sebelum memberi label “keras kepala”. Anak juga sedang belajar menyampaikan keinginan dan menghadapi batasan.',
      reflection: 'Turunkan posisi tubuh sejajar dengan anak. Dengarkan: “Kamu masih ingin bermain, ya?” Periksa apakah ia lapar, lelah, atau belum memahami permintaan Anda.',
      action: 'Sampaikan satu batasan yang jelas dengan suara tenang, lalu dua pilihan yang sama-sama dapat diterima: “Sekarang waktunya merapikan. Kamu mulai dari balok atau buku?” Tetap hadir; hindari ancaman dan pelukan paksa.',
    ),
    (
      title: "Latihan nafas thuma'ninah",
      opening: 'Anda boleh berhenti sejenak. Pastikan anak berada di tempat yang aman. Duduk nyaman dan kendurkan bahu; latihan ini tidak perlu dikerjakan dengan sempurna.',
      reflection: 'Tarik napas lembut melalui hidung, lalu keluarkan perlahan tanpa menahan napas. Ikuti ritme nyaman Anda selama beberapa kali. Tidak ada hitung mundur atau penilaian.',
      action: 'Rasakan kaki menyentuh lantai. Sebut dalam hati satu perasaan dan satu kebutuhan Anda. Jika pusing atau tidak nyaman, hentikan latihan dan bernapas biasa. Kembali pada anak ketika Anda siap berbicara lebih tenang.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final media = MediaQuery.of(context);
    final animate = !media.disableAnimations &&
        !media.accessibleNavigation &&
        TickerMode.of(context);
    if (animate) {
      if (!_pulse.isAnimating) _pulse.repeat(reverse: true);
    } else {
      _pulse.stop();
      _pulse.value = 0;
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  TextStyle _body(BuildContext context, {Color? color, double size = 14}) =>
      TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: size,
        height: 1.65,
        color: color ?? context.earthTree.textSecondary,
      );

  TextStyle _heading(BuildContext context, {double size = 22}) => TextStyle(
        fontFamily: 'Merriweather',
        fontSize: size,
        height: 1.4,
        fontWeight: FontWeight.w600,
        color: context.earthTree.textPrimary,
      );

  Future<void> _copyPrayer() async {
    try {
      await Clipboard.setData(const ClipboardData(
        text: '$_prayer\n$_translation\nQS. Thaha: 25–26',
      ));
      if (!mounted) return;
      setState(() => _copyFeedback = 'Doa dan terjemahan disalin ke clipboard.');
    } catch (_) {
      if (!mounted) return;
      setState(() => _copyFeedback =
          'Clipboard tidak tersedia. Pilih teks doa untuk menyalinnya secara manual.');
    }
  }

  void _openReflection() {
    var step = 0;
    const steps = [
      ('Beri ruang untuk rasa',
       'Pastikan anak aman. Duduk sejenak dan tanyakan dalam hati: “Apa yang sedang saya rasakan?” Anda tidak perlu mengetik atau berbicara ke perangkat.'),
      ('Kenali kebutuhan Anda',
       'Apakah Anda membutuhkan istirahat, bantuan, atau waktu untuk menenangkan diri? Pilih satu kebutuhan yang paling nyata. Jangan menyalahkan diri atau anak.'),
      ('Pilih langkah kecil',
       'Saat sudah tenang, pilih satu tindakan: meminta bantuan orang dewasa tepercaya, meminta maaf kepada anak, atau mendengarkan anak tanpa menyela. Anda boleh kembali ke doa setelah menutup panduan.'),
    ];
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.earthTree.surfaceContainerLow,
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, updateSheet) => SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Refleksi terpandu lokal', style: _heading(sheetContext)),
                const SizedBox(height: 12),
                Text(
                  'Mikrofon tidak dinyalakan. Tidak ada rekaman atau pengiriman data. Panduan ini adalah teks tetap, bukan respons AI.',
                  style: _body(sheetContext),
                ),
                const SizedBox(height: 24),
                Semantics(
                  liveRegion: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Langkah ${step + 1} dari 3',
                          style: _body(sheetContext,
                              color: sheetContext.earthTree.meadowCanopy)),
                      const SizedBox(height: 8),
                      Text(steps[step].$1,
                          style: _heading(sheetContext, size: 18)),
                      const SizedBox(height: 12),
                      Text(steps[step].$2, style: _body(sheetContext)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _button(
                  sheetContext,
                  step == 2 ? 'Selesai refleksi' : 'Lanjutkan refleksi',
                  () {
                    if (step == 2) {
                      Navigator.of(sheetContext).pop();
                    } else {
                      updateSheet(() => step++);
                    }
                  },
                ),
                const SizedBox(height: 8),
                _button(sheetContext, 'Tutup panduan',
                    () => Navigator.of(sheetContext).pop(), outline: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _reflectionChip(
          BuildContext context, String text, VoidCallback onPress) =>
      FButton.raw(
        style: FButtonStyle.ghost,
        onPress: onPress,
        child: Container(
          constraints: const BoxConstraints(minHeight: 48),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: context.earthTree.surfaceContainerLowest,
            border: Border.all(color: context.earthTree.tactileBorder),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(text,
              style: _body(context, color: context.earthTree.textPrimary, size: 13)),
        ),
      );

  Widget _button(BuildContext context, String text, VoidCallback onPress,
      {bool outline = false}) => FButton.raw(
        style: outline ? FButtonStyle.outline : FButtonStyle.secondary,
        onPress: onPress,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: _body(context,
                      color: outline
                          ? context.earthTree.textPrimary
                          : context.earthTree.onMeadowCanopy)),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final dialogue = _dialogues[_topic];
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.all(4),
          child: FButton.raw(
            style: FButtonStyle.ghost,
            onPress: widget.onBack ?? () => Navigator.of(context).maybePop(),
            child: SizedBox(
              width: 48,
              height: 48,
              child: Center(
                child: Semantics(
                  label: 'Kembali ke beranda',
                  child: iconoir.ArrowLeft(
                      width: 22, height: 22, color: colors.textPrimary),
                ),
              ),
            ),
          ),
        ),
        title: Text('Curhat Sanctuary', style: _heading(context, size: 18)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Teman Curhat Batin',
                      textAlign: TextAlign.center, style: _heading(context)),
                  const SizedBox(height: 8),
                  Text('Cermin Jiwa · Mir’ātul Qalb',
                      textAlign: TextAlign.center, style: _body(context)),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerLow,
                      border: Border.all(color: colors.tactileBorder),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('100% On-Device • Kerahasiaan Mutlak Terenkripsi',
                            style: _body(context,
                                color: colors.meadowCanopy, size: 13)),
                        const SizedBox(height: 8),
                        Text(
                          'Status di atas adalah tujuan desain. Prototipe ini tidak merekam suara atau mengirim data. Enkripsi dan mesin AI suara belum aktif; yang tersedia adalah panduan refleksi lokal.',
                          style: _body(context, size: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text('Barometer Nafs Al-Insan',
                      style: _heading(context, size: 18)),
                  const SizedBox(height: 8),
                  Text('Ilustrasi refleksi, bukan deteksi emosi atau penilaian jiwa.',
                      style: _body(context, size: 13)),
                  const SizedBox(height: 16),
                  Semantics(
                    label: 'Tiga tahap refleksi. Tahap ilustrasi aktif: Nafs Lawwamah, Alarm Hati Masih Hidup.',
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _gaugeStage(context, 'Ammarah', 'Amarah meluap', colors.error),
                        const SizedBox(width: 6),
                        _gaugeStage(context, 'Lawwamah', 'Penyesalan / gelisah', colors.nafsLawwamah, active: true),
                        const SizedBox(width: 6),
                        _gaugeStage(context, 'Muthma’innah', 'Ketenangan ridha', colors.meadowCanopy),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Nafs Lawwamah (Alarm Hati Masih Hidup)',
                      textAlign: TextAlign.center,
                      style: _body(context, color: colors.ancientBark)),
                  const SizedBox(height: 12),
                  Center(
                    child: SizedBox(
                      width: 208,
                      height: 208,
                      child: AnimatedBuilder(
                        animation: _pulse,
                        builder: (context, child) => Stack(
                          alignment: Alignment.center,
                          children: [
                            for (final diameter in [144.0, 184.0])
                              Container(
                                width: diameter + _pulse.value * 16,
                                height: diameter + _pulse.value * 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors.meadowCanopy.withValues(alpha: 0.035),
                                  border: Border.all(
                                    color: colors.meadowCanopy.withValues(alpha: 0.18 - _pulse.value * 0.06),
                                  ),
                                ),
                              ),
                            child!,
                          ],
                        ),
                        child: FButton.raw(
                          style: FButtonStyle.ghost,
                          onPress: _openReflection,
                          child: Semantics(
                            label: 'Buka refleksi terpandu lokal. Tidak merekam suara.',
                            child: Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.meadowCanopy,
                              ),
                              child: Center(
                                child: iconoir.Microphone(
                                  width: 42,
                                  height: 42,
                                  color: colors.onMeadowCanopy,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text('Ketuk untuk refleksi terpandu',
                      textAlign: TextAlign.center,
                      style: _body(context, color: colors.textPrimary)),
                  Text('Tanpa rekaman · Tanpa AI aktif',
                      textAlign: TextAlign.center, style: _body(context, size: 12)),
                  const SizedBox(height: 28),
                  Text('Pilih ruang refleksi', style: _heading(context, size: 18)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _reflectionChip(context,
                          'Bagaimana merangkul anak yang keras kepala?',
                          () => setState(() => _topic = 1)),
                      _reflectionChip(context, "Latihan nafas thuma'ninah",
                          () => setState(() => _topic = 2)),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Semantics(
                    liveRegion: true,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerLow,
                        border: Border.all(color: colors.tactileBorder),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dialogue.title, style: _heading(context, size: 20)),
                          const SizedBox(height: 8),
                          Text('Panduan lokal tersusun · Bukan respons AI',
                              style: _body(context, color: colors.ancientBark, size: 12)),
                          _reflectionSection(context, 'Dengarkan rasa', dialogue.opening),
                          _reflectionSection(context, 'Cermin jiwa', dialogue.reflection),
                          _reflectionSection(context, 'Langkah kecil', dialogue.action),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text('Doa penenteram hati', style: _heading(context, size: 20)),
                  const SizedBox(height: 20),
                  SelectableText(
                    _prayer,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 30,
                      height: 2,
                      color: colors.ancientBark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('“$_translation”',
                      textAlign: TextAlign.center, style: _body(context)),
                  const SizedBox(height: 8),
                  Text('QS. Thaha: 25–26',
                      textAlign: TextAlign.center,
                      style: _body(context, color: colors.meadowCanopy, size: 12)),
                  const SizedBox(height: 16),
                  _button(context, 'Salin doa dan terjemahan', _copyPrayer, outline: true),
                  if (_copyFeedback != null) ...[
                    const SizedBox(height: 12),
                    Semantics(
                      liveRegion: true,
                      child: Text(_copyFeedback!, style: _body(context, size: 13)),
                    ),
                  ],
                  const SizedBox(height: 28),
                  Divider(color: colors.tactileBorder),
                  const SizedBox(height: 12),
                  Text(
                    'Pendampingan adab dan edukasi karakter Islam, bukan diagnosis atau pengganti layanan psikologis maupun psikiatri klinis. Jika Anda atau anak tidak aman, utamakan keselamatan dan hubungi bantuan profesional atau layanan darurat setempat.',
                    style: _body(context, size: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gaugeStage(BuildContext context, String name, String description,
      Color color, {bool active = false}) => Expanded(
        child: Column(
          children: [
            Container(
              height: active ? 12 : 8,
              margin: EdgeInsets.only(top: active ? 0 : 2, bottom: active ? 0 : 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
                border: active
                    ? Border.all(color: context.earthTree.textPrimary, width: 2)
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            Text(name,
                textAlign: TextAlign.center,
                style: _body(context, color: context.earthTree.textPrimary, size: 11)
                    .copyWith(fontWeight: active ? FontWeight.w700 : FontWeight.w500)),
            Text(description,
                textAlign: TextAlign.center, style: _body(context, size: 11)),
          ],
        ),
      );

  Widget _reflectionSection(BuildContext context, String title, String text) =>
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: context.earthTree.tactileBorder),
            const SizedBox(height: 8),
            Text(title,
                style: _body(context, color: context.earthTree.meadowCanopy)
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(text, style: _body(context)),
          ],
        ),
      );
}
