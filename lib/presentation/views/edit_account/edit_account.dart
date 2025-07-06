import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/data/helpers/logger.dart';
import 'package:password_management/data/helpers/passcode_helper.dart';
import 'package:password_management/data/helpers/secure_storage_helper.dart';
import 'package:password_management/presentation/viewmodels/edit_account_controller.dart';
import 'package:password_management/presentation/viewmodels/home_controller.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/loading_dialog.dart';
import 'package:password_management/presentation/widgets/show_notice_dialog.dart';
import 'package:password_management/presentation/widgets/password_input.dart';
import 'package:password_management/presentation/widgets/t_button.dart';
import 'package:password_management/presentation/widgets/text_area.dart';
import 'package:password_management/presentation/widgets/text_input.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final editAccountController = Get.put(EditAccountController());
  late String id;

  @override
  void initState() {
    super.initState();
    id = Get.arguments as String;
    editAccountController.getData(id);
  }

  @override
  void dispose() {
    Get.delete<EditAccountController>();
    super.dispose();
  }

  Future<void> _updateAccount() async {
    final checkError = editAccountController.checkValidData();
    if (checkError == false) {
      return;
    }

    LoadingDialog.show();
    var key = await SecureStorageHelper.getValue(PasscodeHelper.passCodeKey);
    if (key == null) {
      throw Exception("Key is null");
    }
    var r = await editAccountController.updateAccountModel(key);
    LoadingDialog.hide();

    if (r == true) {
      if (mounted) {
        showNoticeDialog(
          context: context,
          title: "Done",
          message: "Update account successfully",
          status: AlertStatus.success,
        );
      }

      final homeController = Get.find<HomeController>();
      homeController.updateElement(
        id,
        editAccountController.editAccountModel.value.toJson(),
      );
    } else {
      if (mounted) {
        showNoticeDialog(
          context: context,
          title: "Failed",
          message: "Something error",
          status: AlertStatus.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Header(),
                  Obx(() {
                    if (editAccountController.editAccountModel.value.appName ==
                        '') {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextInput(
                          icon: Icons.apps,
                          maxLines: 1,
                          hintText: "App name",
                          labelText: 'App name',
                          value:
                              editAccountController
                                  .editAccountModel
                                  .value
                                  .appName,
                          onChanged: (String value) {
                            editAccountController.updateAppName(value);
                          },
                          errorText:
                              editAccountController
                                          .appNameError
                                          .value
                                          .isValid ==
                                      false
                                  ? editAccountController
                                      .appNameError
                                      .value
                                      .errorMessage
                                  : null,
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          icon: Icons.account_circle,
                          maxLines: 1,
                          hintText: "User name",
                          labelText: 'User name',
                          value:
                              editAccountController
                                  .editAccountModel
                                  .value
                                  .userName,
                          onChanged: (String value) {
                            editAccountController.updateUserName(value);
                          },
                          errorText:
                              editAccountController
                                          .userNameError
                                          .value
                                          .isValid ==
                                      false
                                  ? editAccountController
                                      .userNameError
                                      .value
                                      .errorMessage
                                  : null,
                        ),
                        const SizedBox(height: 10),
                        PasswordInputField(
                          icon: Icons.password,
                          hintText: "Password",
                          labelText: 'Password',
                          value:
                              editAccountController
                                  .editAccountModel
                                  .value
                                  .password,
                          onChanged: (String value) {
                            editAccountController.updatePassword(value);
                          },
                          errorText:
                              editAccountController
                                          .passwordError
                                          .value
                                          .isValid ==
                                      false
                                  ? editAccountController
                                      .passwordError
                                      .value
                                      .errorMessage
                                  : null,
                        ),
                        const SizedBox(height: 10),
                        PasswordInputField(
                          icon: Icons.password,
                          hintText: "Confirm Password",
                          labelText: 'Confirm Password',
                          value:
                              editAccountController
                                  .editAccountModel
                                  .value
                                  .confirmPassword,
                          onChanged: (String value) {
                            editAccountController.updateConfirmPassword(value);
                          },
                          errorText:
                              editAccountController
                                          .confirmPasswordError
                                          .value
                                          .isValid ==
                                      false
                                  ? editAccountController
                                      .confirmPasswordError
                                      .value
                                      .errorMessage
                                  : null,
                        ),
                        const SizedBox(height: 10),
                        TextArea(
                          icon: Icons.edit_note,
                          maxLines: 5,
                          hintText: "Notes",
                          labelText: 'Notes',
                          value:
                              editAccountController.editAccountModel.value.note,
                          onChanged: (String value) {
                            editAccountController.updateNote(value);
                          },
                        ),
                        const SizedBox(height: 10),
                        TButton(
                          onPressed: () {
                            _updateAccount();
                          },
                          text: "✏️",
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
