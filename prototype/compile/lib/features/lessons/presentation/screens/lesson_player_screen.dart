import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../../../../core/theme/earth_tree_colors.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../data/models/lesson_models.dart';

class LessonPlayerScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonPlayerScreen({super.key, required this.lesson});

  @override
  State<LessonPlayerScreen> createState() => _LessonPlayerScreenState();
}

class _LessonPlayerScreenState extends State<LessonPlayerScreen> {
  int _currentIndex = 0;
  int? _selectedChoice;
  bool? _selectedPoll;
  String? _selectedFillBlank;
  bool _showExplanation = false;

  void _nextCard() {
    if (_currentIndex < widget.lesson.cards.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedChoice = null;
        _selectedPoll = null;
        _selectedFillBlank = null;
        _showExplanation = false;
      });
    } else {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    final colors = context.earthTree;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.surface,
        title: Text(
          'Alhamdulillah Selesai!',
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Ayah/Bunda telah menyelesaikan modul "${widget.lesson.title}". Semoga ilmu adab ini menjadi berkah bagi keluarga.',
          style: TextStyle(color: colors.textSecondary, height: 1.5),
        ),
        actions: [
          FButton(
            child: const Text('Kembali ke Menu Belajar'),
            onPress: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final card = widget.lesson.cards[_currentIndex];
    final progress = (_currentIndex + 1) / widget.lesson.cards.length;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.lesson.title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: colors.tactileBorder.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(colors.meadowCanopy),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Langkah ${_currentIndex + 1} dari ${widget.lesson.cards.length}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                card.stepHeadline,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildCardContent(card, colors),
                ),
              ),
              const SizedBox(height: 16),
              FButton(
                child: Text(
                  _currentIndex == widget.lesson.cards.length - 1
                      ? 'Selesaikan Modul'
                      : 'Lanjutkan',
                ),
                onPress: _nextCard,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent(LessonStepCard card, EarthTreeColors colors) {
    switch (card) {
      case TextInsightCard c:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.contentMarkdown,
              style: TextStyle(
                fontSize: 15,
                height: 1.7,
                color: colors.textPrimary,
              ),
            ),
            if (c.keyTakeaway != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.meadowCanopy.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colors.meadowCanopy.withOpacity(0.25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kaidah Kunci (Takeaway)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: colors.meadowCanopy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      c.keyTakeaway!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );

      case MultipleChoiceCard c:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.question,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(c.options.length, (idx) {
              final isSelected = _selectedChoice == idx;
              final isCorrect = idx == c.correctIndex;
              Color borderCol = colors.tactileBorder;
              Color bgCol = colors.surface;

              if (_showExplanation) {
                if (isCorrect) {
                  borderCol = colors.meadowCanopy;
                  bgCol = colors.meadowCanopy.withOpacity(0.12);
                } else if (isSelected) {
                  borderCol = colors.error;
                  bgCol = colors.error.withOpacity(0.1);
                }
              } else if (isSelected) {
                borderCol = colors.celestialSky;
                bgCol = colors.celestialSky.withOpacity(0.08);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: bgCol,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderCol, width: isSelected ? 1.5 : 1),
                ),
                child: ListTile(
                  title: Text(
                    c.options[idx],
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.textPrimary,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedChoice = idx;
                      _showExplanation = true;
                    });
                  },
                ),
              );
            }),
            if (_showExplanation) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colors.tactileBorder.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  c.explanation,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        );

      case SwipePollCard c:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.statement,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FButton(
                    style: _selectedPoll == true
                        ? FButtonStyle.primary
                        : FButtonStyle.secondary,
                    child: const Text('Setuju'),
                    onPress: () => setState(() => _selectedPoll = true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FButton(
                    style: _selectedPoll == false
                        ? FButtonStyle.primary
                        : FButtonStyle.secondary,
                    child: const Text('Kurang Tepat'),
                    onPress: () => setState(() => _selectedPoll = false),
                  ),
                ),
              ],
            ),
            if (_selectedPoll != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.tactileBorder.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  _selectedPoll == true ? c.agreeFeedback : c.disagreeFeedback,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ],
        );

      case FillInBlankCard c:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: colors.textPrimary,
                ),
                children: [
                  TextSpan(text: '${c.sentenceBefore} '),
                  TextSpan(
                    text: _selectedFillBlank ?? ' [ ............ ] ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _selectedFillBlank == c.blankExpected
                          ? colors.meadowCanopy
                          : colors.celestialSky,
                    ),
                  ),
                  TextSpan(text: ' ${c.sentenceAfter}'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Pilih Kata Kunci:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: c.wordBank.map((word) {
                final isSel = _selectedFillBlank == word;
                return ChoiceChip(
                  label: Text(word),
                  selected: isSel,
                  selectedColor: colors.celestialSky,
                  labelStyle: TextStyle(
                    color: isSel ? Colors.white : colors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: colors.tactileBorder.withOpacity(0.15),
                  onSelected: (_) {
                    setState(() {
                      _selectedFillBlank = word;
                      _showExplanation = true;
                    });
                  },
                );
              }).toList(),
            ),
            if (_showExplanation) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colors.tactileBorder.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  c.explanation,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        );
    }
  }
}
