import 'package:local_auth/local_auth.dart';

class LocalAuthHelper {
  LocalAuthHelper._();

  static final LocalAuthentication _localAuth = LocalAuthentication();

  static Future<bool> checkBiometrics() async {
    bool canAuthenticate = await _localAuth.canCheckBiometrics;
    if (canAuthenticate) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> authenticateWithBiometrics() async {
    bool isAuthenticated = await _localAuth.authenticate(
      localizedReason: 'Using FINGERPRINT',
      options: AuthenticationOptions(biometricOnly: true),
    );

    return isAuthenticated;
  }
}
