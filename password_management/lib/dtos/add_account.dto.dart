import 'package:password_management/services/crypto_service.dart';

class AddAccountDto {
  String appName;
  String userName;
  String password;
  String note;

  AddAccountDto(
      {required this.appName,
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
  factory AddAccountDto.fromEncryptedJson(Map<String, dynamic> json) {
    final d = AddAccountDto(
      appName: json['appName'],
      userName: CryptoService.decryptField(json['userName']),
      password: CryptoService.decryptField(json['password']),
      note: json['note'],
    );

    return d;
  }

  // Phương thức factory để tạo đối tượng User từ dữ liệu Firebase
  factory AddAccountDto.fromFirestore(Map<String, dynamic> data) {
    return AddAccountDto(
        appName: data['appName'] ?? '',
        userName: data['userName'] ?? '',
        password: data['password'] ?? '',
        note: data['note'] ?? '');
  }
}
