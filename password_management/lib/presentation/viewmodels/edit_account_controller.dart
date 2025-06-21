import 'package:get/get.dart';
import 'package:password_management/core/constants/account_constanst.dart';
import 'package:password_management/data/common/error_model.dart';
import 'package:password_management/data/datasources/remote/supabase_manager.dart';
import 'package:password_management/data/models/account_model.dart';

class EditAccountController extends GetxController {
  var editAccountModel = Rx<EditAccountModel>(
    EditAccountModel(
      appName: '',
      note: '',
      password: '',
      userName: '',
      id: '',
      confirmPassword: '',
    ),
  );

  var appNameError = Rx<ErrorModel>(ErrorModel());
  var passwordError = Rx<ErrorModel>(ErrorModel());
  var confirmPasswordError = Rx<ErrorModel>(ErrorModel());
  var userNameError = Rx<ErrorModel>(ErrorModel());

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  // 	super.onClose();
  // }

  Future<void> getData(String id) async {
    final data = await SupabaseManager.getById(AccountConstanst.tableName, id);
    editAccountModel.update((val) {
      final r = EditAccountModel.fromJson(data);
      val?.appName = r.appName;
      val?.userName = r.userName;
      val?.password = r.password;
      val?.confirmPassword = r.password;
      val?.note = r.note;
      val?.id = r.id;
    });
  }

  void updateAppName(String appName) {
    editAccountModel.value.appName = appName;
  }

  void updateUserName(String userName) {
    editAccountModel.value.userName = userName;
  }

  void updatePassword(String password) {
    editAccountModel.value.password = password;
  }

  void updateConfirmPassword(String confirmPassword) {
    editAccountModel.value.confirmPassword = confirmPassword;
  }

  void updateNote(String note) {
    editAccountModel.value.note = note;
  }

  bool _checkAppName() {
    if (editAccountModel.value.appName != '') {
      appNameError.value.errorMessage = '';
      appNameError.value.isValid = true;
      return true;
    }

    appNameError.value.errorMessage = 'App Name is not empty';
    appNameError.value.isValid = false;
    return false;
  }

  bool _checkUserName() {
    if (editAccountModel.value.userName != '') {
      userNameError.value.errorMessage = '';
      userNameError.value.isValid = true;
      return true;
    }

    userNameError.value.errorMessage = 'User Name is not empty';
    userNameError.value.isValid = false;
    return false;
  }

  bool _checkPassword() {
    if (editAccountModel.value.password != '') {
      passwordError.value.errorMessage = '';
      passwordError.value.isValid = true;
      return true;
    }

    passwordError.value.errorMessage = 'Password is not empty';
    passwordError.value.isValid = false;
    return false;
  }

  bool _checkConfirmPassword() {
    if (editAccountModel.value.confirmPassword == '') {
      confirmPasswordError.value.errorMessage = 'Confirm Password is not empty';
      confirmPasswordError.value.isValid = false;
      return false;
    } else if (editAccountModel.value.confirmPassword !=
        editAccountModel.value.password) {
      confirmPasswordError.value.errorMessage = 'Confirm Password is not match';
      confirmPasswordError.value.isValid = false;
      return false;
    }
    confirmPasswordError.value.errorMessage = '';
    confirmPasswordError.value.isValid = true;
    return true;
  }

  bool checkValidData() {
    return _checkAppName() == true &&
        _checkUserName() == true &&
        _checkPassword() == true &&
        _checkConfirmPassword() == true;
  }

  Future<bool> updateAccountModel() async {
    return true;
  }
}
