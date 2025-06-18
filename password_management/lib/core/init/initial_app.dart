import 'package:get/get.dart';
import 'package:password_management/core/constants/contants.dart';
import 'package:password_management/core/utils/secure_storage_util.dart';
import 'package:password_management/presentation/viewmodels/google_controller.dart';
import 'package:password_management/presentation/viewmodels/password_controller.dart';

class InitialApp {
  static Future<bool> checkCreatePassword() async {
    bool isCreatePassword = await SecureStorageUtil.keyHasValue(
      passwordEncryptKey,
    );
    return isCreatePassword;
  }

  static Future<void> initControllers() async {
    Get.put(GooleController(), permanent: true);
    Get.put(PasswordController(), permanent: true);
  }
}
