import 'package:get/get.dart';
import 'package:password_management/core/config/supabase_postgre_env.dart';
import 'package:password_management/core/constants/contants.dart';
import 'package:password_management/core/utils/secure_storage_util.dart';
import 'package:password_management/presentation/viewmodels/google_controller.dart';

class InitialApp {
  static Future<bool> checkCreatePassword() async {
    bool isCreatePassword = await SecureStorageUtil.keyHasValue(
      passwordEncryptKey,
    );
    return isCreatePassword;
  }

  static void initControllers() {
    Get.put(GoogleController(), permanent: true);
  }

  static Future<void> initEnv() async {
    await SupabasePostgreEnv.init();
  }
}
