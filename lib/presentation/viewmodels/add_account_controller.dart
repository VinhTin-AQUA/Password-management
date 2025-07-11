import 'package:get/get.dart';
import 'package:password_management/core/common/error_model.dart';
import 'package:password_management/data/helpers/secure_storage_helper.dart';
import 'package:password_management/data/helpers/passcode_helper.dart';
import 'package:password_management/data/models/account_model.dart';
import 'package:password_management/data/supabase/account_repo.dart';

class AddAccountController extends GetxController {
  AddAccountModel addAccountModel = AddAccountModel(
    appName: '',
    note: '',
    password: '',
    confirmPassword: '',
    userName: '',
    userId: '',
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

  Future<AccountModel?> saveAccountModel() async {
    var key = await SecureStorageHelper.getValue(PasscodeHelper.passCodeKey);
    if (key == null) {
      return null;
    }
    AccountRepo accountRepo = AccountRepo();
    addAccountModel.encrypt(key);
    var json = await accountRepo.insert(addAccountModel.toJson());
    if (json == null) {
      return null;
    }
    var r = AccountModel.fromJson(json);
    r.decrypt(key);
    return r;
  }
}

class AddAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAccountController>(() => AddAccountController());
  }
}
