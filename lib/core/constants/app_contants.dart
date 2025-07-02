class AppConstants {
  // App Information
  static const String appName = 'Vivao';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String languageKey = 'language';

  // Durations
  static const Duration splashDuration = Duration(seconds: 0);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration snackbarDuration = Duration(seconds: 3);

  // Limits
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxDescriptionLength = 500;
  static const int minPasswordLength = 6;
}
