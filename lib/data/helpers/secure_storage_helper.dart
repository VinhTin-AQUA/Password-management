import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  SecureStorageHelper._();

  // final LocalAuthentication _localAuth = LocalAuthentication();
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<bool> keyHasValue(key) async {
    String? password = await _secureStorage.read(key: key);
    return password != null;
  }

  static Future<void> saveValue(key, value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<void> clearValue(key) async {
    await _secureStorage.delete(key: key);
  }

  static Future<String?> getValue(String key) async {
    String? password = await _secureStorage.read(key: key);
    return password;
  }
}
