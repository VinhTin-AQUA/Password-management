import 'package:get/get.dart';
import 'package:password_management/core/constants/contants.dart';
import 'package:password_management/core/utils/secure_storage_util.dart';
import 'package:password_management/presentation/viewmodels/account_controller.dart';

class InitialApp {
  static Future<bool> checkCreatePassword() async {
    bool isCreatePassword = await SecureStorageUtil.keyHasValue(
      passwordEncryptKey,
    );
    return isCreatePassword;
  }

  static Future<void> initControllers() async {
    Get.put(AccountController(), permanent: true);
  }
}
