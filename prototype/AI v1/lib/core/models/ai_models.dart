class DalilCallout {
  final String arabicText;
  final String translation;
  final String source;
  final String explanation;

  const DalilCallout({
    required this.arabicText,
    required this.translation,
    required this.source,
    required this.explanation,
  });
}

class RppScheduleItem {
  final String time;
  final String activity;
  final String adabFocus;

  const RppScheduleItem({
    required this.time,
    required this.activity,
    required this.adabFocus,
  });
}

class RppDocument {
  final String title;
  final String subtitle;
  final String targetChild;
  final String phase;
  final String version;
  final List<RppScheduleItem> schedule;
  final List<String> affirmations;
  final List<String> checklist;

  const RppDocument({
    required this.title,
    required this.subtitle,
    required this.targetChild,
    required this.phase,
    required this.version,
    required this.schedule,
    required this.affirmations,
    required this.checklist,
  });
}

enum MessageRole { user, assistant, system }

class ChatMessage {
  final String id;
  final MessageRole role;
  final String content;
  final DateTime timestamp;
  final String? modelName;
  final int? latencyMs;
  final double? tokensPerSec;
  final int? ttftMs;
  final DalilCallout? dalil;
  final RppDocument? document;
  final bool isStreaming;

  ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
    this.modelName,
    this.latencyMs,
    this.tokensPerSec,
    this.ttftMs,
    this.dalil,
    this.document,
    this.isStreaming = false,
  });

  ChatMessage copyWith({
    String? content,
    bool? isStreaming,
    int? latencyMs,
    double? tokensPerSec,
    int? ttftMs,
    DalilCallout? dalil,
    RppDocument? document,
  }) {
    return ChatMessage(
      id: id,
      role: role,
      content: content ?? this.content,
      timestamp: timestamp,
      modelName: modelName,
      latencyMs: latencyMs ?? this.latencyMs,
      tokensPerSec: tokensPerSec ?? this.tokensPerSec,
      ttftMs: ttftMs ?? this.ttftMs,
      dalil: dalil ?? this.dalil,
      document: document ?? this.document,
      isStreaming: isStreaming ?? this.isStreaming,
    );
  }
}

class ModelOption {
  final String id;
  final String name;
  final String badge;
  final String description;
  final String size;
  final String speedRating;
  final bool isLiteRT;

  const ModelOption({
    required this.id,
    required this.name,
    required this.badge,
    required this.description,
    required this.size,
    required this.speedRating,
    this.isLiteRT = false,
  });
}

class BenchmarkResult {
  final String modelId;
  final String modelName;
  final String category;
  final String promptTitle;
  final int promptTokens;
  final int completionTokens;
  final int ttftMs;
  final int evalDurationMs;
  final int promptEvalDurationMs;
  final double tokensPerSec;
  final double promptTokensPerSec;
  final int memoryMb;
  final bool isSimulation;
  final DateTime timestamp;
  final String sampleOutput;

  const BenchmarkResult({
    required this.modelId,
    required this.modelName,
    required this.category,
    required this.promptTitle,
    required this.promptTokens,
    required this.completionTokens,
    required this.ttftMs,
    required this.evalDurationMs,
    required this.promptEvalDurationMs,
    required this.tokensPerSec,
    required this.promptTokensPerSec,
    required this.memoryMb,
    required this.isSimulation,
    required this.timestamp,
    required this.sampleOutput,
  });

  int get totalDurationMs => ttftMs + evalDurationMs;
}
