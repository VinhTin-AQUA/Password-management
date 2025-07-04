import 'package:get/get.dart';
import 'package:password_management/core/constants/contants.dart';
import 'package:password_management/core/utils/secure_storage_util.dart';

class PasscodeController extends GetxController {
  String passcode = "";
  String confirmPasscode = "";

  void updatePassword(password) {
    passcode = password;
  }

  void updateConfirmPassword(confirmPassword) {
    confirmPasscode = confirmPassword;
  }

  bool checkConfirm() {
    return passcode == confirmPasscode;
  }

  Future<void> savePassword() async {
    await SecureStorageUtil.saveValue(passwordEncryptKey, passcode);
    passcode = "";
    confirmPasscode = "";
  }

  Future<bool> loginApp() async {
    final passwordSaved = await SecureStorageUtil.getValue(passwordEncryptKey);
    if (passwordSaved != passcode) {
      return false;
    }
    return true;
  }

  Future<void> logoutApp() async {
    await SecureStorageUtil.clearValue(passwordEncryptKey);
  }
}
