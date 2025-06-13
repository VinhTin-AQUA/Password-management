import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtil {
  SecureStorageUtil._();

  // final LocalAuthentication _localAuth = LocalAuthentication();
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<bool> keyHasValue(key) async {
    String? password = await _secureStorage.read(key: key);
    return password != null;
  }

  static Future<void> savePassword(key, value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<void> clearValue(key) async {
    await _secureStorage.delete(key: key);
  }
}
