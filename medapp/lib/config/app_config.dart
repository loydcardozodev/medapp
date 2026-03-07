import 'package:logging/logging.dart';

enum AppFlavor { firebase, development }

class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.apiBaseUrl,
    required this.logLevel,
  });

  final AppFlavor flavor;
  final String apiBaseUrl;
  final Level logLevel;

  // derived from flavor, no need for separate field
  bool get isDevelopment => flavor == AppFlavor.development;
  bool get useFirebase => flavor == AppFlavor.firebase;

  static const firebase = AppConfig(
    flavor: AppFlavor.firebase,
    apiBaseUrl: 'https://your-project.firebaseapp.com',
    logLevel: Level.INFO,
  );

  static const development = AppConfig(
    flavor: AppFlavor.development,
    apiBaseUrl: 'http://localhost:8080',
    logLevel: Level.ALL,
  );

  // ── App Info ─────────────────────────────────────
  static const String appName = 'My App';
  static const String appVersion = '1.0.0';

  // ── API ──────────────────────────────────────────
  static const String baseUrl = 'https://api.example.com';
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 15000;

  // ── Storage Keys ─────────────────────────────────
  static const String tokenKey = 'auth_token';
  static const String refreshKey = 'refresh_token';
  static const String themeKey = 'app_theme';
  static const String localeKey = 'app_locale';

  // ── Pagination ───────────────────────────────────
  static const int defaultPageSize = 20;

  // ── Feature Flags ────────────────────────────────
  static const bool enableAnalytics = true;
  static const bool enableCrashReport = true;
  static const bool maintenanceMode = false;
}
