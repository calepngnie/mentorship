class AppConfig {
  static const String appName = 'MentorMatch';
  static const String appVersion = '1.0.0';

  // Firebase Config
  static const String firebaseProjectId = 'mentor-match-app';

  // API Endpoints
  static const String baseUrl = 'https://api.mentormatch.com';
  static const String linkedInApiUrl = 'https://api.linkedin.com/v2';

  // Modules
  static const List<String> modules = [
    'education',
    'professional',
    'entrepreneurship',
    'personal_development'
  ];

  // Security
  static const int sessionTimeoutMinutes = 30;
  static const bool enableBiometricAuth = true;

  // Payment
  static const String stripePublishableKey = 'pk_test_...';
}
