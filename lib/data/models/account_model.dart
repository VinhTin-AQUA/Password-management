import 'package:password_management/core/utils/aes_util.dart';
import 'package:password_management/data/helpers/account_helper.dart';

class AccountModel {
  String id = '';
  String appName = '';
  String userName = '';
  String password = '';
  String note = '';
  String userId = '';

  AccountModel({
    required this.id,
    required this.appName,
    required this.userName,
    required this.password,
    required this.note,
    required this.userId,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json[AccountHelper.idCol] ?? "",
      appName: json[AccountHelper.appNameCol] ?? "",
      userName: json[AccountHelper.userNameCol] ?? "",
      password: json[AccountHelper.passwordCol] ?? "",
      note: json[AccountHelper.noteCol] ?? "",
      userId: json[AccountHelper.userId] ?? "",
    );
  }

  void decrypt(String key) {
    appName = AesUtil.decryptData(appName, key);
    userName = AesUtil.decryptData(userName, key);
    password = AesUtil.decryptData(password, key);

    if (note != "") {
      note = AesUtil.decryptData(note, key);
    }
  }
}

class AddAccountModel {
  String appName = '';
  String userName = '';
  String password = '';
  String confirmPassword = '';
  String note = '';
  String userId = '';

  AddAccountModel({
    required this.appName,
    required this.userName,
    required this.password,
    required this.confirmPassword,
    required this.note,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      AccountHelper.appNameCol: appName,
      AccountHelper.userNameCol: userName,
      AccountHelper.passwordCol: password,
      AccountHelper.noteCol: note,
      AccountHelper.userId: userId,
    };
  }

  void encrypt(String key) {
    appName = AesUtil.encryptData(appName, key);
    userName = AesUtil.encryptData(userName, key);
    password = AesUtil.encryptData(password, key);

    if (note != "") {
      note = AesUtil.encryptData(note, key);
    }
  }

  void decrypt(String key) {
    appName = AesUtil.decryptData(appName, key);
    userName = AesUtil.decryptData(userName, key);
    password = AesUtil.decryptData(password, key);

    if (note != "") {
      note = AesUtil.decryptData(note, key);
    }
  }
}

class EditAccountModel {
  String id = '';
  String appName = '';
  String userName = '';
  String password = '';
  String confirmPassword = '';
  String note = '';
  String userId = '';

  EditAccountModel({
    required this.id,
    required this.appName,
    required this.userName,
    required this.password,
    required this.confirmPassword,
    required this.note,
    required this.userId,
  });

  factory EditAccountModel.fromJson(Map<String, dynamic> json) {
    // {id: 648f4463-5975-420d-8248-02ba79d5e53c, appname: Google, username: aba, password: aba, note: hahaha}
    return EditAccountModel(
      id: json[AccountHelper.idCol] ?? "",
      appName: json[AccountHelper.appNameCol] ?? "",
      userName: json[AccountHelper.userNameCol] ?? "",
      password: json[AccountHelper.passwordCol] ?? "",
      confirmPassword: json[AccountHelper.passwordCol] ?? "",
      note: json[AccountHelper.noteCol] ?? "",
      userId: json[AccountHelper.userId] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AccountHelper.idCol: id,
      AccountHelper.appNameCol: appName,
      AccountHelper.userNameCol: userName,
      AccountHelper.passwordCol: password,
      AccountHelper.noteCol: note,
      AccountHelper.userId: userId,
    };
  }
}
