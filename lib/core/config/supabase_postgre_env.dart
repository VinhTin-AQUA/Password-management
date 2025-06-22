import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabasePostgreEnv {
  static late final String supabasePostgrePassword;
  static late final String supabaseUrl;
  static late final String supabaseKey;

  static Future<void> init() async {
    await dotenv.load(fileName: ".env");

    supabasePostgrePassword = dotenv.env['SUPABASE_POSTGRE_PASSWORD'] ?? '';
    supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
    supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';

    // Validate
    if (supabasePostgrePassword.isEmpty ||
        supabaseUrl.isEmpty ||
        supabaseKey.isEmpty) {
      throw Exception("Missing required environment variables");
    }
  }
}
