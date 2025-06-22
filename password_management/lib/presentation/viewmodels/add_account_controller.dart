import 'package:get/get.dart';
import 'package:password_management/core/constants/account_constanst.dart';
import 'package:password_management/data/common/error_model.dart';
import 'package:password_management/data/datasources/remote/supabase_manager.dart';
import 'package:password_management/data/models/account_model.dart';

class AddAccountController extends GetxController {
  AddAccountModel addAccountModel = AddAccountModel(
    appName: '',
    note: '',
    password: '',
    confirmPassword: '',
    userName: '',
  );

  ErrorModel appNameError = ErrorModel();
  ErrorModel passwordError = ErrorModel();
  ErrorModel confirmPasswordError = ErrorModel();
  ErrorModel userNameError = ErrorModel();

  void updateAppName(String appName) {
    addAccountModel.appName = appName;
  }

  void updateUserName(String userName) {
    addAccountModel.userName = userName;
  }

  void updatePassword(String userName) {
    addAccountModel.password = userName;
  }

  void updateConfirmPassword(String userName) {
    addAccountModel.confirmPassword = userName;
  }

  void updateNote(String userName) {
    addAccountModel.note = userName;
  }

  bool _checkAppName() {
    if (addAccountModel.appName != '') {
      appNameError.errorMessage = '';
      appNameError.isValid = true;
      update();
      return true;
    }

    appNameError.errorMessage = 'App Name is not empty';
    appNameError.isValid = false;
    update();
    return false;
  }

  bool _checkUserName() {
    if (addAccountModel.userName != '') {
      userNameError.errorMessage = '';
      userNameError.isValid = true;
      update();
      return true;
    }

    userNameError.errorMessage = 'User Name is not empty';
    userNameError.isValid = false;
    update();
    return false;
  }

  bool _checkPassword() {
    if (addAccountModel.password != '') {
      passwordError.errorMessage = '';
      passwordError.isValid = true;
      update();
      return true;
    }

    passwordError.errorMessage = 'Password is not empty';
    passwordError.isValid = false;
    update();
    return false;
  }

  bool _checkConfirmPassword() {
    if (addAccountModel.confirmPassword == '') {
      confirmPasswordError.errorMessage = 'Confirm Password is not empty';
      confirmPasswordError.isValid = false;
      update();
      return false;
    } else if (addAccountModel.confirmPassword != addAccountModel.password) {
      confirmPasswordError.errorMessage = 'Confirm Password is not match';
      confirmPasswordError.isValid = false;
      update();
      return false;
    }
    confirmPasswordError.errorMessage = '';
    confirmPasswordError.isValid = true;
    update();
    return true;
  }

  bool checkValidData() {
    final checkAppName = _checkAppName();
    final checkUserName = _checkUserName();
    final checkPassword = _checkPassword();
    final checkConfirmPassword = _checkConfirmPassword();

    return checkAppName == true &&
        checkUserName == true &&
        checkPassword == true &&
        checkConfirmPassword == true;
  }

  Future<bool> saveAccountModel() async {
    final r = SupabaseManager.insert(
      AccountConstanst.tableName,
      addAccountModel.toJson(),
    );
    return r;
  }
}

class AddAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAccountController>(() => AddAccountController());
  }
}
