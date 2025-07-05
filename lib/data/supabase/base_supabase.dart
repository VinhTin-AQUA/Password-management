import 'dart:async';

import 'package:password_management/data/helpers/account_helper.dart';
import 'package:password_management/data/helpers/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static final SupabaseClient _client = Supabase.instance.client;

  static SupabaseClient get client => _client;

  static bool isSupabaseInitialized() {
    try {
      Supabase.instance.client;
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> initSupabase(
    String supabaseUrl,
    String supabaseKey,
  ) async {
    try {
      if (isSupabaseInitialized()) {
        await Supabase.instance.dispose();
      }

      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseKey,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce,
        ),
      );
      await Supabase.instance.client.from(AccountHelper.tableName).select();

      return null;
    } catch (e, s) {
      Logger.reportError(e, s);
      return "Key or Url is not valid.";
    }
  }
}

class BaseSupabase {
  static SupabaseClient get client => SupabaseManager.client;
}
