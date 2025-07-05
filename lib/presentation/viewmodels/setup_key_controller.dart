import 'package:get/get.dart';
import 'package:password_management/data/supabase/base_supabase.dart';

class SetupKeyController extends GetxController {
  String supabaseUrl = "";
  String supabaseKey = "";
  String passcode = "";
  String confirmPasscode = "";

  void updateSupabaseUrl(String value) {
    supabaseUrl = value;
  }

  void updateSupabaseKey(String value) {
    supabaseKey = value;
  }

  void updatePasscode(String value) {
    passcode = value;
  }

  void updateConfirmPasscode(String value) {
    confirmPasscode = value;
  }

  Future<String?> initSupabase() async {
    String? message = await SupabaseManager.initSupabase(
      supabaseUrl,
      supabaseKey,
    );
    return message;
  }
}
