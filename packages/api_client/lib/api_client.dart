import 'package:core/core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

export 'src/auth/auth_provider.dart';
export 'src/auth/auth_service.dart';
export 'src/repositories/user_repository.dart';

class ApiClient {
  static Future<void> initialize(AppConfig config) async {
    await Supabase.initialize(url: config.supabaseUrl, anonKey: config.supabaseAnonKey, debug: config.isDevelopment);
  }

  static SupabaseClient get client => Supabase.instance.client;
}
