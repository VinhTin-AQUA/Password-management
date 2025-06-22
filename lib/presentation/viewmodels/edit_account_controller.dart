import 'package:get/get.dart';
import 'package:password_management/core/constants/account_constanst.dart';
import 'package:password_management/core/utils/aes_util.dart';
import 'package:password_management/data/common/error_model.dart';
import 'package:password_management/data/datasources/remote/supabase_manager.dart';
import 'package:password_management/data/models/account_model.dart';
import 'package:password_management/presentation/viewmodels/google_controller.dart';

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

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  // 	super.onClose();
  // }

  Future<void> getData(String id) async {
    final googleControler = Get.find<GoogleController>();
    String myKey = googleControler.googleUserInfo.uid;
    final data = await SupabaseManager.findOneForUserById(
      AccountConstanst.tableName,
      id,
      myKey,
    );

    editAccountModel.update((val) {
      final r = EditAccountModel.fromJson(data);
      val?.appName = AesUtil.decryptData(r.appName, myKey);
      val?.userName = AesUtil.decryptData(r.userName, myKey);
      val?.password = AesUtil.decryptData(r.password, myKey);
      val?.confirmPassword = AesUtil.decryptData(r.password, myKey);
      val?.note = AesUtil.decryptData(r.note, myKey);
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

  Future<bool> updateAccountModel() async {
    String myKey = Get.find<GoogleController>().googleUserInfo.uid;
    final encryptData = {
      AccountConstanst.appNameCol: AesUtil.encryptData(
        editAccountModel.value.appName,
        myKey,
      ),
      AccountConstanst.userNameCol: AesUtil.encryptData(
        editAccountModel.value.userName,
        myKey,
      ),
      AccountConstanst.passwordCol: AesUtil.encryptData(
        editAccountModel.value.password,
        myKey,
      ),
      AccountConstanst.noteCol: AesUtil.encryptData(
        editAccountModel.value.note,
        myKey,
      ),
      AccountConstanst.userId: myKey,
    };

    print(encryptData);
    final check = await SupabaseManager.updateForUser(
      AccountConstanst.tableName,
      editAccountModel.value.id,
      myKey,
      encryptData,
    );
    return check;
  }
}
