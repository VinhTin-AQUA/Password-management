import 'package:get/get.dart';
import 'package:password_management/core/constants/contants.dart';
import 'package:password_management/core/utils/secure_storage_util.dart';

class CreatePasswordController extends GetxController {
  String password = "";
  String confirmPassword = "";

  void updatePassword(password) {
    this.password = password;
  }

  void updateConfirmPassword(confirmPassword) {
    this.confirmPassword = confirmPassword;
  }

  bool checkConfirm() {
    return password == confirmPassword;
  }

  Future<void> savePassword() async {
    SecureStorageUtil.savePassword(passwordEncryptKey, password);
  }
}
