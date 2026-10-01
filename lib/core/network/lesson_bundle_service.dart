import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/lessons/data/models/lesson_package.dart';

final lessonBundleServiceProvider = Provider<LessonBundleService>((ref) {
  return LessonBundleService();
});

class LessonBundleService {
  static const List<String> bundledLessonAssetPaths = [
    'assets/data/lessons/growth-01-cac-ltv.json',
    'assets/data/lessons/product-01-north-star.json',
  ];

  Future<LessonPackage?> loadLessonFromAsset(String assetPath) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return LessonPackage.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  Future<List<LessonPackage>> loadAllBundledLessons() async {
    final List<LessonPackage> loaded = [];
    for (final path in bundledLessonAssetPaths) {
      final lesson = await loadLessonFromAsset(path);
      if (lesson != null) {
        loaded.add(lesson);
      }
    }
    return loaded;
  }
}
