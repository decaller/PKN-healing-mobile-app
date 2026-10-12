import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../core/theme/earth_tree_theme.dart';

class PreChatView extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSend;
  final VoidCallback onSelectVoiceTab;

  const PreChatView({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onSelectVoiceTab,
  });

  @override
  State<PreChatView> createState() => _PreChatViewState();
}

class _PreChatViewState extends State<PreChatView> {
  final FocusNode _focusNode = FocusNode();

  void _applyPrompt(String prompt) {
    widget.controller.text = prompt;
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildGroundingBanner(),
          const SizedBox(height: 16),
          _buildInputChamber(),
          const SizedBox(height: 20),
          _buildGuidanceStones(),
          const SizedBox(height: 20),
          _buildFaqSection(),
          const SizedBox(height: 20),
          _buildCalmingFooter(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildGroundingBanner() {
    return Container(
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: EarthTreeColors.secondaryFixed.withValues(alpha: 0.35),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const iconoir.Leaf(
              color: EarthTreeColors.secondary,
              width: 22,
              height: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahlan wa Sahlan, Abu Hafi.',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontFamily: EarthTreeTheme.fontSerif,
                        fontWeight: FontWeight.w700,
                        color: EarthTreeColors.onSurface,
                        fontSize: 20,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Apa yang sedang membebani ruang batin pengasuhan hari ini?',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: EarthTreeColors.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const iconoir.Lock(
                      color: EarthTreeColors.secondary,
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Privasi Amanah 100% On-Device • Zero Cloud Leak',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: EarthTreeColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputChamber() {
    return Container(
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: EarthTreeColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            maxLines: 4,
            style: const TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 15,
              color: EarthTreeColors.onSurface,
            ),
            decoration: const InputDecoration(
              hintText: 'Tuliskan unek-unek, kegelisahan, atau pertanyaan adab...',
              hintStyle: TextStyle(
                fontFamily: EarthTreeTheme.fontSans,
                fontSize: 14,
                color: Color(0x803F4850),
              ),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    tooltip: 'Mode Walkie-Talkie',
                    onPressed: widget.onSelectVoiceTab,
                    icon: const iconoir.Microphone(
                      color: EarthTreeColors.onSurfaceVariant,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Lampirkan Catatan',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Catatan aman tersimpan lokal di perangkat.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const iconoir.Attachment(
                      color: EarthTreeColors.onSurfaceVariant,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Pilih Hadits & Dalil Salaf',
                    onPressed: () {
                      _applyPrompt(
                        'Tolong carikan hadits dan panduan ulama mengenai adab shalat anak usia tamyiz.',
                      );
                    },
                    icon: const iconoir.Book(
                      color: EarthTreeColors.tertiary,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: EarthTreeColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onPressed: () {
                  final text = widget.controller.text.trim();
                  if (text.isNotEmpty) {
                    widget.onSend(text);
                  }
                },
                icon: const iconoir.Send(
                  color: Colors.white,
                  width: 16,
                  height: 16,
                ),
                label: const Text(
                  'Kirim',
                  style: TextStyle(
                    fontFamily: EarthTreeTheme.fontSans,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuidanceStones() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PIJAKAN PERMULAAN',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    color: EarthTreeColors.onSurfaceVariant,
                  ),
            ),
            Text(
              'Pilih panduan ringkas',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: EarthTreeColors.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildStoneButton(
          title: 'Ide Aktivitas',
          subtitle: 'Stimulasi fitrah bermain anak sesuai usia',
          prompt:
              'Berikan ide aktivitas stimulasi fitrah bermain anak sesuai tahapan usianya secara syar’i dan bermakna sore ini...',
          iconColor: EarthTreeColors.secondaryFixed,
          iconWidget: const iconoir.Cube(
            color: EarthTreeColors.onSecondaryFixed,
            width: 20,
            height: 20,
          ),
        ),
        const SizedBox(height: 8),
        _buildStoneButton(
          title: 'Ide RPP Rumah',
          subtitle: 'Perencanaan kurikulum keluarga thoyyib',
          prompt:
              'Tolong buatkan dokumen RPP Adab Harian untuk Zaid (8 tahun, Fase Tamyiz) yang menolak mandi dan shalat saat asyik bermain sore hari. Buatkan jadwal, kalimat afirmasi nabawiyah, dan ceklis adabnya.',
          iconColor: EarthTreeColors.primaryFixed,
          iconWidget: const iconoir.Calendar(
            color: EarthTreeColors.primary,
            width: 20,
            height: 20,
          ),
        ),
        const SizedBox(height: 8),
        _buildStoneButton(
          title: 'Refleksi Diri',
          subtitle: 'Muhasabah amarah & tazkiyatun nafs orang tua',
          prompt:
              'Saya merasa kalbu sedang sempit dan mudah marah kepada anak saat lelah bekerja. Bantu pandu muhasabah tazkiyatun nafs yang menenteramkan...',
          iconColor: EarthTreeColors.tertiaryFixed,
          iconWidget: const iconoir.Heart(
            color: EarthTreeColors.tertiary,
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildStoneButton({
    required String title,
    required String subtitle,
    required String prompt,
    required Color iconColor,
    required Widget iconWidget,
  }) {
    return Material(
      color: EarthTreeColors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _applyPrompt(prompt),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: iconWidget,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: EarthTreeTheme.fontSans,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: EarthTreeColors.onSurface,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: EarthTreeTheme.fontSans,
                        fontSize: 13,
                        color: EarthTreeColors.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const iconoir.NavArrowRight(
                color: EarthTreeColors.outlineVariant,
                width: 18,
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqSection() {
    final faqs = [
      {
        'q': 'Anak 8 tahun menolak shalat Maghrib karena asyik bermain gadget, bagaimana kalimat pertama yang harus diucapkan?',
        'cat': 'schedule',
      },
      {
        'q': 'Bagaimana menenangkan dada yang bergemuruh dan amarah yang hampir meledak saat anak membantah?',
        'cat': 'heart',
      },
      {
        'q': 'Cara membedakan bakat kritis (Al-Fathanah) dengan sifat membangkang pada anak Tamyiz?',
        'cat': 'brain',
      },
      {
        'q': 'SOP 10 detik saat anak tantrum histeris di supermarket depan umum?',
        'cat': 'alert',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const iconoir.ChatBubble(
              color: EarthTreeColors.tertiary,
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 6),
            Text(
              'Pertanyaan yang Sering Ditanyakan',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontFamily: EarthTreeTheme.fontSerif,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: EarthTreeColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: EarthTreeColors.outlineVariant.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            children: List.generate(faqs.length, (index) {
              final faq = faqs[index];
              return InkWell(
                borderRadius: index == 0
                    ? const BorderRadius.vertical(top: Radius.circular(14))
                    : (index == faqs.length - 1
                        ? const BorderRadius.vertical(bottom: Radius.circular(14))
                        : BorderRadius.zero),
                onTap: () => _applyPrompt(faq['q']!),
                child: Container(
                  decoration: BoxDecoration(
                    border: index < faqs.length - 1
                        ? Border(
                            bottom: BorderSide(
                              color: EarthTreeColors.outlineVariant.withValues(alpha: 0.2),
                            ),
                          )
                        : null,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Row(
                    children: [
                      const iconoir.Clock(
                        color: EarthTreeColors.secondary,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          faq['q']!,
                          style: const TextStyle(
                            fontFamily: EarthTreeTheme.fontSans,
                            fontSize: 13,
                            color: EarthTreeColors.onSurface,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const iconoir.NavArrowRight(
                        color: EarthTreeColors.outline,
                        width: 16,
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildCalmingFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const iconoir.Spark(
          color: EarthTreeColors.secondary,
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            'Berpikir jernih, bernapas dalam, bertawakkal kepada Allah.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: EarthTreeColors.onSurfaceVariant.withValues(alpha: 0.8),
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
