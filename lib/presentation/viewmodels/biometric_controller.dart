import 'package:get/get.dart';
import 'package:password_management/core/utils/local_auth_util.dart';

class BiometricController extends GetxController {

  Future<bool> checkBiometrics() async {
    final r = await LocalAuthUtil.checkBiometrics();
    return r;
  }

  Future<bool> authenticateWithBiometrics() async {
    final r = await LocalAuthUtil.authenticateWithBiometrics();
    return r;
  }
}
