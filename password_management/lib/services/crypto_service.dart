import 'package:encrypt/encrypt.dart' as encrypt;

class CryptoService {
  static final secret = '256_bits_key';
  static final key = encrypt.Key.fromUtf8(secret);
  static final iv = encrypt.IV.fromBase64('128_bits_key');

  // encrypt
  static String encryptField(String value) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(value, iv: iv);
    return encrypted.base64;
  }

  // decrypt
  static String decryptField(String encryptedValue) {
    try {
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final decrypted = encrypter.decrypt64(encryptedValue, iv: iv);
      return decrypted;
    } catch (e) {
      return '';
    }
  }
}
