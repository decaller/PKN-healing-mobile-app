class PknComparison {
  final String commonPractice; // 🔴 Kebiasaan Umum
  final String pknApproach; // ✅ Pendekatan Karakter Nabawiyah

  const PknComparison({
    required this.commonPractice,
    required this.pknApproach,
  });
}

class IdeaCard {
  final String id;
  final String title;
  final String coreThesis;
  final String realWorldExample;
  final String category;
  final List<String> tags;
  final String sourceName;
  final int readTimeMinutes;
  final bool isBookmarked;

  // PKN Cognitive Architecture additions
  final String? leadTlDr; // Primacy Rule: 10-Second Solution
  final List<PknComparison>? comparisons; // 🔴 Kebiasaan Umum vs ✅ Pendekatan PKN
  final String? syariGuardrails; // [!warning] Batas Toleransi Syar'i
  final String? practicalRecipe; // [!tip] Resep Praktis Lapangan
  final List<String>? actionChecklist; // Recency Rule: Action Checklist
  final String? doaOrMuhasabah; // Recency Rule: Doa / Muhasabah
  final String? pilarMoc; // 6 Pilar MOC (e.g. P1..P6)
  final String? targetRole; // e.g. 'Ayah', 'Ibu', 'Guru', 'Santri', 'Dewasa'

  const IdeaCard({
    required this.id,
    required this.title,
    required this.coreThesis,
    required this.realWorldExample,
    required this.category,
    required this.tags,
    required this.sourceName,
    this.readTimeMinutes = 2,
    this.isBookmarked = false,
    this.leadTlDr,
    this.comparisons,
    this.syariGuardrails,
    this.practicalRecipe,
    this.actionChecklist,
    this.doaOrMuhasabah,
    this.pilarMoc,
    this.targetRole,
  });

  IdeaCard copyWith({
    String? id,
    String? title,
    String? coreThesis,
    String? realWorldExample,
    String? category,
    List<String>? tags,
    String? sourceName,
    int? readTimeMinutes,
    bool? isBookmarked,
    String? leadTlDr,
    List<PknComparison>? comparisons,
    String? syariGuardrails,
    String? practicalRecipe,
    List<String>? actionChecklist,
    String? doaOrMuhasabah,
    String? pilarMoc,
    String? targetRole,
  }) {
    return IdeaCard(
      id: id ?? this.id,
      title: title ?? this.title,
      coreThesis: coreThesis ?? this.coreThesis,
      realWorldExample: realWorldExample ?? this.realWorldExample,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      sourceName: sourceName ?? this.sourceName,
      readTimeMinutes: readTimeMinutes ?? this.readTimeMinutes,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      leadTlDr: leadTlDr ?? this.leadTlDr,
      comparisons: comparisons ?? this.comparisons,
      syariGuardrails: syariGuardrails ?? this.syariGuardrails,
      practicalRecipe: practicalRecipe ?? this.practicalRecipe,
      actionChecklist: actionChecklist ?? this.actionChecklist,
      doaOrMuhasabah: doaOrMuhasabah ?? this.doaOrMuhasabah,
      pilarMoc: pilarMoc ?? this.pilarMoc,
      targetRole: targetRole ?? this.targetRole,
    );
  }
}
