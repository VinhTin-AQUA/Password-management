import 'package:password_management/core/constants/contants.dart';
import 'package:password_management/core/utils/secure_storage_util.dart';

class InitialApp {
  static Future<bool> checkLoginGoogle() async {
    bool isLoginGoole = await SecureStorageUtil.keyHasValue(googleId);
    return isLoginGoole;
  }

  static Future<bool> checkCreatePasscode() async {
    bool isCreatePasscode = await SecureStorageUtil.keyHasValue(
      passCodeEncryptKey,
    );
    return isCreatePasscode;
  }
}
