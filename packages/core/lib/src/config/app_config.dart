enum AppEnvironment { development, production }

class AppConfig {
  const AppConfig({required this.environment, required this.supabaseUrl, required this.supabaseAnonKey});

  final AppEnvironment environment;
  final String supabaseUrl;
  final String supabaseAnonKey;

  static const development = AppConfig(
    environment: AppEnvironment.development,
    supabaseUrl: 'http://127.0.0.1:54321',
    supabaseAnonKey: 'local-dummy-key-for-development',
  );

  // Production config should be injected or loaded securely.
  // For now we assume a placeholder or build-time replacement.
  static const production = AppConfig(
    environment: AppEnvironment.production,
    supabaseUrl: String.fromEnvironment('SUPABASE_URL'),
    supabaseAnonKey: String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  bool get isDevelopment => environment == AppEnvironment.development;
}
