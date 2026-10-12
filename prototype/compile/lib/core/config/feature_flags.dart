import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Konfigurasi Modular Feature Flags untuk PKN Healing Mobile App.
/// Setiap modul dapat dihidup-matikan secara independen tanpa menyebabkan
/// runtime error, crash, atau layout break di seluruh aplikasi.
class FeatureFlagsConfig {
  final bool enableCurhatAi;
  final bool enableWalkieTalkie;
  final bool enableDailyTask;
  final bool enableRelationsProgress;
  final bool enableEvents;
  final bool enableKnowledgeWiki;
  final bool enablePrimerLessons;
  final bool enableP3kCrisis;
  final bool enableChartsTestbed;
  final bool enableStories;

  const FeatureFlagsConfig({
    this.enableCurhatAi = true,
    this.enableWalkieTalkie = true,
    this.enableDailyTask = true,
    this.enableRelationsProgress = true,
    this.enableEvents = true,
    this.enableKnowledgeWiki = true,
    this.enablePrimerLessons = true,
    this.enableP3kCrisis = true,
    this.enableChartsTestbed = true,
    this.enableStories = true,
  });

  /// Preset: Seluruh modul aktif (Full Capability)
  factory FeatureFlagsConfig.allEnabled() => const FeatureFlagsConfig();

  /// Preset: Minimal Core (Hanya Beranda & Bantuan Darurat)
  factory FeatureFlagsConfig.minimalCore() => const FeatureFlagsConfig(
        enableCurhatAi: false,
        enableWalkieTalkie: false,
        enableDailyTask: false,
        enableRelationsProgress: false,
        enableEvents: false,
        enableKnowledgeWiki: false,
        enablePrimerLessons: false,
        enableP3kCrisis: true,
        enableChartsTestbed: false,
        enableStories: false,
      );

  /// Preset: AI & Voice Focused (Teman Curhat & Ruang Qalbu)
  factory FeatureFlagsConfig.aiFocused() => const FeatureFlagsConfig(
        enableCurhatAi: true,
        enableWalkieTalkie: true,
        enableDailyTask: false,
        enableRelationsProgress: false,
        enableEvents: false,
        enableKnowledgeWiki: false,
        enablePrimerLessons: false,
        enableP3kCrisis: true,
        enableChartsTestbed: false,
        enableStories: false,
      );

  /// Preset: Belajar & Literasi (Wiki, Micro-Learning & Agenda)
  factory FeatureFlagsConfig.learningFocused() => const FeatureFlagsConfig(
        enableCurhatAi: false,
        enableWalkieTalkie: false,
        enableDailyTask: false,
        enableRelationsProgress: false,
        enableEvents: true,
        enableKnowledgeWiki: true,
        enablePrimerLessons: true,
        enableP3kCrisis: true,
        enableChartsTestbed: false,
        enableStories: true,
      );

  /// Preset: Parenting & Adab Tracker (Tugas Harian, Mizan, Relasi)
  factory FeatureFlagsConfig.parentingAdabFocused() => const FeatureFlagsConfig(
        enableCurhatAi: false,
        enableWalkieTalkie: false,
        enableDailyTask: true,
        enableRelationsProgress: true,
        enableEvents: false,
        enableKnowledgeWiki: false,
        enablePrimerLessons: false,
        enableP3kCrisis: true,
        enableChartsTestbed: true,
        enableStories: true,
      );

  FeatureFlagsConfig copyWith({
    bool? enableCurhatAi,
    bool? enableWalkieTalkie,
    bool? enableDailyTask,
    bool? enableRelationsProgress,
    bool? enableEvents,
    bool? enableKnowledgeWiki,
    bool? enablePrimerLessons,
    bool? enableP3kCrisis,
    bool? enableChartsTestbed,
    bool? enableStories,
  }) {
    return FeatureFlagsConfig(
      enableCurhatAi: enableCurhatAi ?? this.enableCurhatAi,
      enableWalkieTalkie: enableWalkieTalkie ?? this.enableWalkieTalkie,
      enableDailyTask: enableDailyTask ?? this.enableDailyTask,
      enableRelationsProgress:
          enableRelationsProgress ?? this.enableRelationsProgress,
      enableEvents: enableEvents ?? this.enableEvents,
      enableKnowledgeWiki: enableKnowledgeWiki ?? this.enableKnowledgeWiki,
      enablePrimerLessons: enablePrimerLessons ?? this.enablePrimerLessons,
      enableP3kCrisis: enableP3kCrisis ?? this.enableP3kCrisis,
      enableChartsTestbed: enableChartsTestbed ?? this.enableChartsTestbed,
      enableStories: enableStories ?? this.enableStories,
    );
  }

  Map<String, bool> toMap() => {
        'enableCurhatAi': enableCurhatAi,
        'enableWalkieTalkie': enableWalkieTalkie,
        'enableDailyTask': enableDailyTask,
        'enableRelationsProgress': enableRelationsProgress,
        'enableEvents': enableEvents,
        'enableKnowledgeWiki': enableKnowledgeWiki,
        'enablePrimerLessons': enablePrimerLessons,
        'enableP3kCrisis': enableP3kCrisis,
        'enableChartsTestbed': enableChartsTestbed,
        'enableStories': enableStories,
      };

  factory FeatureFlagsConfig.fromMap(Map<String, dynamic> map) {
    return FeatureFlagsConfig(
      enableCurhatAi: map['enableCurhatAi'] as bool? ?? true,
      enableWalkieTalkie: map['enableWalkieTalkie'] as bool? ?? true,
      enableDailyTask: map['enableDailyTask'] as bool? ?? true,
      enableRelationsProgress: map['enableRelationsProgress'] as bool? ?? true,
      enableEvents: map['enableEvents'] as bool? ?? true,
      enableKnowledgeWiki: map['enableKnowledgeWiki'] as bool? ?? true,
      enablePrimerLessons: map['enablePrimerLessons'] as bool? ?? true,
      enableP3kCrisis: map['enableP3kCrisis'] as bool? ?? true,
      enableChartsTestbed: map['enableChartsTestbed'] as bool? ?? true,
      enableStories: map['enableStories'] as bool? ?? true,
    );
  }

  int get enabledCount => toMap().values.where((v) => v).length;
  int get totalCount => toMap().length;
}

/// Notifier untuk reaktif state Feature Flags di Riverpod
class FeatureFlagsNotifier extends StateNotifier<FeatureFlagsConfig> {
  static const _prefPrefix = 'pkn_feature_flag_';

  FeatureFlagsNotifier([FeatureFlagsConfig? initial])
      : super(initial ?? const FeatureFlagsConfig()) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final map = <String, dynamic>{};
      for (final key in state.toMap().keys) {
        if (prefs.containsKey('$_prefPrefix$key')) {
          map[key] = prefs.getBool('$_prefPrefix$key');
        }
      }
      if (map.isNotEmpty) {
        state = FeatureFlagsConfig.fromMap(map);
      }
    } catch (_) {
      // Graceful fallback to default configuration if storage is unavailable
    }
  }

  Future<void> toggleFlag(String flagKey) async {
    final currentMap = Map<String, dynamic>.from(state.toMap());
    if (currentMap.containsKey(flagKey)) {
      final updated = !(currentMap[flagKey] as bool);
      currentMap[flagKey] = updated;
      state = FeatureFlagsConfig.fromMap(currentMap);
      _persistFlag(flagKey, updated);
    }
  }

  Future<void> setFlag(String flagKey, bool value) async {
    final currentMap = Map<String, dynamic>.from(state.toMap());
    currentMap[flagKey] = value;
    state = FeatureFlagsConfig.fromMap(currentMap);
    _persistFlag(flagKey, value);
  }

  Future<void> applyPreset(FeatureFlagsConfig preset) async {
    state = preset;
    try {
      final prefs = await SharedPreferences.getInstance();
      for (final entry in preset.toMap().entries) {
        await prefs.setBool('$_prefPrefix${entry.key}', entry.value);
      }
    } catch (_) {}
  }

  Future<void> _persistFlag(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('$_prefPrefix$key', value);
    } catch (_) {}
  }

  Future<void> resetAll() async {
    state = const FeatureFlagsConfig();
    try {
      final prefs = await SharedPreferences.getInstance();
      for (final key in state.toMap().keys) {
        await prefs.remove('$_prefPrefix$key');
      }
    } catch (_) {}
  }
}

final featureFlagsProvider =
    StateNotifierProvider<FeatureFlagsNotifier, FeatureFlagsConfig>((ref) {
  return FeatureFlagsNotifier();
});
