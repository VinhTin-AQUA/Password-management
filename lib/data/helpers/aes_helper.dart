import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart'; // for sha256

class AesHelper {
  AesHelper._();

  static String _genKey(String raw) {
    final base64Key = base64.encode(utf8.encode(raw));
    return base64Key.length >= 32
        ? base64Key.substring(0, 32)
        : base64Key.padRight(32, '0');
  }

  static IV _generateDeterministicIV(String seed) {
    final hash = sha256.convert(utf8.encode(seed)).bytes;
    final ivBytes = Uint8List.fromList(hash.sublist(0, 16));
    return IV(ivBytes);
  }

  static String encryptData(String plainText, String rawKey) {
    final iv = _generateDeterministicIV(_genKey(rawKey));
    final key = Key.fromUtf8(_genKey(rawKey));
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decryptData(String encryptedText, String rawKey) {
    final iv = _generateDeterministicIV(_genKey(rawKey));
    final key = Key.fromUtf8(_genKey(rawKey));

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}
