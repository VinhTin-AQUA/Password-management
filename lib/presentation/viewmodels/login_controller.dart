import 'package:get/get.dart';

class LoginController extends GetxController {
  String passcode = "";

  void updatePasscode(String value) {
    passcode = value;
  }
}
