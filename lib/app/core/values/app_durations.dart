class AppDurations {
  // Animation durations
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration slower = Duration(milliseconds: 800);
  static const Duration slowest = Duration(milliseconds: 1200);

  // Specific animations
  static const Duration buttonPress = Duration(milliseconds: 100);
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration heroAnimation = Duration(milliseconds: 1500);
  static const Duration skillAnimation = Duration(milliseconds: 1200);
  static const Duration projectAnimation = Duration(milliseconds: 1000);

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration snackbarDuration = Duration(seconds: 4);
  static const Duration loadingMinimum = Duration(milliseconds: 500);
}
