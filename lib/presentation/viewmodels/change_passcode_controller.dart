import 'package:get/get.dart';

class ChangePasscodeController extends GetxController {
  String oldPasscode = "";
  String newPasscode = "";
  String confirmPasscode = "";

  void updateOldPasscode(String value) {
    oldPasscode = value;
  }

  void updatePasscode(String value) {
    newPasscode = value;
  }

  void updateConfirmPasscode(String value) {
    confirmPasscode = value;
  }
}
