enum TaskCategory {
  relasiHati,
  mujahadahDiri,
  targetBelajar,
}

enum SoulResonance {
  muthmainnah,
  lawwamah,
  ammarah,
}

enum ChildResponse {
  lembut,
  mulaiLunak,
  menolak,
}

class DailyTaskItem {
  final String id;
  final String title;
  final String description;
  final TaskCategory category;
  final bool isCompleted;
  final SoulResonance? resonance;
  final ChildResponse? childResponse;
  final String? qualityLabel;
  final String? wikiLink;
  final String? tag;
  final String? timeLabel;

  const DailyTaskItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.isCompleted = false,
    this.resonance,
    this.childResponse,
    this.qualityLabel,
    this.wikiLink,
    this.tag,
    this.timeLabel,
  });

  DailyTaskItem copyWith({
    String? id,
    String? title,
    String? description,
    TaskCategory? category,
    bool? isCompleted,
    SoulResonance? resonance,
    ChildResponse? childResponse,
    String? qualityLabel,
    String? wikiLink,
    String? tag,
    String? timeLabel,
  }) {
    return DailyTaskItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      resonance: resonance ?? this.resonance,
      childResponse: childResponse ?? this.childResponse,
      qualityLabel: qualityLabel ?? this.qualityLabel,
      wikiLink: wikiLink ?? this.wikiLink,
      tag: tag ?? this.tag,
      timeLabel: timeLabel ?? this.timeLabel,
    );
  }
}
