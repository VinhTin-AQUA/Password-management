import 'package:password_management/core/constants/account_constanst.dart';

class AccountModel {
  String id = '';
  String appName = '';
  String userName = '';
  String password = '';
  String note = '';

  AccountModel({
    required this.id,
    required this.appName,
    required this.userName,
    required this.password,
    required this.note,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      appName: json['appName'],
      userName: json['userName'],
      password: json['password'],
      note: json['note'],
    );
  }
}

class AddAccountModel {
  String appName = '';
  String userName = '';
  String password = '';
  String confirmPassword = '';
  String note = '';

  AddAccountModel({
    required this.appName,
    required this.userName,
    required this.password,
    required this.confirmPassword,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      AccountConstanst.appNameCol: appName,
      AccountConstanst.userNameCol: userName,
      AccountConstanst.passwordCol: password,
      AccountConstanst.noteCol: note,
    };
  }
}
