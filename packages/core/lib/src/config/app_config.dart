import 'package:core/src/enums/app_environment.dart';

class AppConfig {
  const AppConfig({required this.environment, required this.supabaseUrl, required this.supabaseAnonKey});

  final AppEnvironment environment;
  final String supabaseUrl;
  final String supabaseAnonKey;

  static const development = AppConfig(
    environment: AppEnvironment.development,
    supabaseUrl: 'http://127.0.0.1:54321',
    supabaseAnonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
  );

  static const production = AppConfig(
    environment: AppEnvironment.production,
    supabaseUrl: String.fromEnvironment('SUPABASE_URL'),
    supabaseAnonKey: String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  bool get isDevelopment => environment == AppEnvironment.development;
}
