import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main()');
});

final storageServiceProvider = Provider<StorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return StorageService(prefs);
});

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static const String _keyOnboardingCompleted = 'onboarding_completed';
  static const String _keyBookmarkedIds = 'bookmarked_idea_ids';
  static const String _keyCompletedLessonIds = 'completed_lesson_ids';
  static const String _keyUserRole = 'user_role';
  static const String _keyUserFocus = 'user_focus';

  bool get isOnboardingCompleted => _prefs.getBool(_keyOnboardingCompleted) ?? false;

  Future<void> setOnboardingCompleted(bool value) async {
    await _prefs.setBool(_keyOnboardingCompleted, value);
  }

  Set<String> getBookmarkedIds() {
    final list = _prefs.getStringList(_keyBookmarkedIds) ?? [];
    return list.toSet();
  }

  Future<void> toggleBookmark(String ideaId) async {
    final current = getBookmarkedIds();
    if (current.contains(ideaId)) {
      current.remove(ideaId);
    } else {
      current.add(ideaId);
    }
    await _prefs.setStringList(_keyBookmarkedIds, current.toList());
  }

  Set<String> getCompletedLessonIds() {
    final list = _prefs.getStringList(_keyCompletedLessonIds) ?? [];
    return list.toSet();
  }

  Future<void> markLessonCompleted(String lessonId) async {
    final current = getCompletedLessonIds();
    current.add(lessonId);
    await _prefs.setStringList(_keyCompletedLessonIds, current.toList());
  }

  String? getUserRole() => _prefs.getString(_keyUserRole);
  Future<void> setUserRole(String role) => _prefs.setString(_keyUserRole, role);

  String? getUserFocus() => _prefs.getString(_keyUserFocus);
  Future<void> setUserFocus(String focus) => _prefs.setString(_keyUserFocus, focus);
}
