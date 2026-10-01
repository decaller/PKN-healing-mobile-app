class RoutePaths {
  RoutePaths._();

  static const String onboarding = '/onboarding';
  static const String activationalInsight = '/activational-insight';
  static const String feed = '/feed';
  static const String lessons = '/lessons';
  static const String lessonPlayer = '/lessons/:id';
  static const String profile = '/profile';

  static String lessonDetails(String id) => '/lessons/$id';
}
