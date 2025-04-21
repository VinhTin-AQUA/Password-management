import 'package:password_management/services/crypto_service.dart';

class AccountDto {
  String id;
  String appName;
  String userName;
  String password;
  String note;

  AccountDto(
      {required this.id,
      required this.appName,
      required this.userName,
      required this.password,
      required this.note});

  // Mã hóa dữ liệu khi chuyển sang JSON
  Map<String, dynamic> toEncryptedJson() {
    return {
      'appName': appName,
      'userName': CryptoService.encryptField(userName),
      'password': CryptoService.encryptField(password),
      'note': note,
    };
  }

  // Giải mã dữ liệu từ JSON
  factory AccountDto.fromEncryptedJson(Map<String, dynamic> json) {
    final d = AccountDto(
      id: json['id'],
      appName: json['appName'],
      userName: CryptoService.decryptField(json['userName']),
      password: CryptoService.decryptField(json['password']),
      note: json['note'],
    );

    return d;
  }

  // Phương thức factory để tạo đối tượng User từ dữ liệu Firebase
  factory AccountDto.fromFirestore(Map<String, dynamic> data) {
    return AccountDto(
        id: data['id'] ?? '',
        appName: data['appName'] ?? '',
        userName: data['userName'] ?? '',
        password: data['password'] ?? '',
        note: data['note'] ?? '');
  }
}
