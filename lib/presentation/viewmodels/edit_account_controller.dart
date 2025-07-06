import 'package:get/get.dart';
import 'package:password_management/core/common/error_model.dart';
import 'package:password_management/data/helpers/secure_storage_helper.dart';
import 'package:password_management/data/helpers/passcode_helper.dart';
import 'package:password_management/data/models/account_model.dart';
import 'package:password_management/data/supabase/account_repo.dart';

class EditAccountController extends GetxController {
  var editAccountModel = Rx<EditAccountModel>(
    EditAccountModel(
      appName: '',
      note: '',
      password: '',
      userName: '',
      id: '',
      confirmPassword: '',
      userId: '',
    ),
  );

  var appNameError = Rx<ErrorModel>(ErrorModel());
  var passwordError = Rx<ErrorModel>(ErrorModel());
  var confirmPasswordError = Rx<ErrorModel>(ErrorModel());
  var userNameError = Rx<ErrorModel>(ErrorModel());
  late AccountRepo accountRepo;

  @override
  void onInit() {
    super.onInit();
    accountRepo = AccountRepo();
  }

  // @override
  // void onClose() {
  // 	super.onClose();
  // }

  Future<void> getData(String id) async {
    var key = await SecureStorageHelper.getValue(PasscodeHelper.passCodeKey);
    if (key == null) {
      return;
    }
    final data = await accountRepo.findOneById(id);

    editAccountModel.update((val) {
      final r = EditAccountModel.fromJson(data);
      r.decrypt(key);
      val?.appName = r.appName;
      val?.userName = r.userName;
      val?.password = r.password;
      val?.confirmPassword = r.password;
      val?.note = r.note;
      val?.id = r.id;
      val?.userId = r.userId;
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
      appNameError.value =
          ErrorModel()
            ..errorMessage = ''
            ..isValid = true;
      return true;
    }

    appNameError.value =
        ErrorModel()
          ..errorMessage = 'App Name is not empty'
          ..isValid = false;

    return false;
  }

  bool _checkUserName() {
    if (editAccountModel.value.userName != '') {
      userNameError.value =
          ErrorModel()
            ..errorMessage = ''
            ..isValid = true;
      return true;
    }
    userNameError.value =
        ErrorModel()
          ..errorMessage = 'User Name is not empty'
          ..isValid = false;
    return false;
  }

  bool _checkPassword() {
    if (editAccountModel.value.password != '') {
      passwordError.value =
          ErrorModel()
            ..errorMessage = ''
            ..isValid = true;
      return true;
    }
    passwordError.value =
        ErrorModel()
          ..errorMessage = 'Password is not empty'
          ..isValid = false;
    return false;
  }

  bool _checkConfirmPassword() {
    if (editAccountModel.value.confirmPassword == '') {
      confirmPasswordError.value =
          ErrorModel()
            ..errorMessage = 'Confirm Password is not empty'
            ..isValid = false;
      return false;
    } else if (editAccountModel.value.confirmPassword !=
        editAccountModel.value.password) {
      confirmPasswordError.value =
          ErrorModel()
            ..errorMessage = 'Confirm Password is not match'
            ..isValid = false;
      return false;
    }
    confirmPasswordError.value =
        ErrorModel()
          ..errorMessage = ''
          ..isValid = true;
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

  Future<bool> updateAccountModel(String key) async {
    editAccountModel.value.encrypt(key);
    final check = await accountRepo.update(
      editAccountModel.value.id,
      editAccountModel.toJson(),
    );
    editAccountModel.value.decrypt(key);
    editAccountModel.refresh();
    return check;
  }
}
