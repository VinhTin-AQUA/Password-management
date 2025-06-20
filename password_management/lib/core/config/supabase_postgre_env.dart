import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabasePostgreEnv {
  static late final String supabasePostgrePassword;

  static Future<void> init() async {
    await dotenv.load(fileName: ".env");

    supabasePostgrePassword = dotenv.env['SUPABASE_POSTGRE_PASSWORD'] ?? '';

    // Validate
    if (supabasePostgrePassword.isEmpty) {
      throw Exception("Missing required environment variables");
    }
  }
}
