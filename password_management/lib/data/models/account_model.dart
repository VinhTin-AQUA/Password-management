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
      id: json[AccountConstanst.idCol] ?? "",
      appName: json[AccountConstanst.appNameCol] ?? "",
      userName: json[AccountConstanst.userNameCol] ?? "",
      password: json[AccountConstanst.passwordCol] ?? "",
      note: json[AccountConstanst.noteCol] ?? "",
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

class EditAccountModel {
  String id = '';
  String appName = '';
  String userName = '';
  String password = '';
  String confirmPassword = '';
  String note = '';

  EditAccountModel({
    required this.id,
    required this.appName,
    required this.userName,
    required this.password,
    required this.confirmPassword,
    required this.note,
  });

  factory EditAccountModel.fromJson(Map<String, dynamic> json) {
    // {id: 648f4463-5975-420d-8248-02ba79d5e53c, appname: Google, username: aba, password: aba, note: hahaha}
    return EditAccountModel(
      id: json[AccountConstanst.idCol] ?? "",
      appName: json[AccountConstanst.appNameCol] ?? "",
      userName: json[AccountConstanst.userNameCol] ?? "",
      password: json[AccountConstanst.passwordCol] ?? "",
      confirmPassword: json[AccountConstanst.passwordCol] ?? "",
      note: json[AccountConstanst.noteCol] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AccountConstanst.idCol: id,
      AccountConstanst.appNameCol: appName,
      AccountConstanst.userNameCol: userName,
      AccountConstanst.passwordCol: password,
      AccountConstanst.noteCol: note,
    };
  }
}
