import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/data/helpers/secure_storage_helper.dart';
import 'package:password_management/data/helpers/passcode_helper.dart';
import 'package:password_management/presentation/viewmodels/change_passcode_controller.dart';
import 'package:password_management/presentation/viewmodels/home_controller.dart';
import 'package:password_management/presentation/viewmodels/setup_key_controller.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/loading_dialog.dart';
import 'package:password_management/presentation/widgets/password_input.dart';
import 'package:password_management/presentation/widgets/show_notice_dialog.dart';
import 'package:password_management/presentation/widgets/t_button.dart';

class ChangePasscode extends StatefulWidget {
  const ChangePasscode({super.key});

  @override
  State<ChangePasscode> createState() => ChangePasscodeState();
}

class ChangePasscodeState extends State<ChangePasscode> {
  late ChangePasscodeController changePasscodeController;
  late HomeController homeController;
  // String? supabaseKeyErrorMessage;
  // String? supabaseUrlErrorMessage;
  String? oldPasscodeErrorMessage;
  String? passcodeErrorMessage;
  String? confirmPasscodeErrorMessage;
  String? oldPassCode;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    Get.delete<SetupKeyController>();
    super.dispose();
  }

  Future<void> _init() async {
    changePasscodeController = Get.put(ChangePasscodeController());
    homeController = Get.find<HomeController>();
    oldPassCode = await SecureStorageHelper.getValue(
      PasscodeHelper.passCodeKey,
    );
  }

  bool checkOldPasscode() {
    setState(() {
      if (changePasscodeController.oldPasscode == "") {
        oldPasscodeErrorMessage = "Old passcode is incorrect";
      } else if (changePasscodeController.oldPasscode != oldPassCode) {
        oldPasscodeErrorMessage = "Old passcode is incorrect";
      } else {
        oldPasscodeErrorMessage = null;
      }
    });

    return oldPasscodeErrorMessage == null;
  }

  bool checkNewPasscode() {
    setState(() {
      if (changePasscodeController.newPasscode == "") {
        passcodeErrorMessage = "Passcode is not empty";
      } else if (changePasscodeController.newPasscode.length < 6) {
        passcodeErrorMessage = "Passode is at least 6 characters";
      } else {
        passcodeErrorMessage = null;
      }
    });
    return passcodeErrorMessage == null;
  }

  bool checkConfirmNewPasscode() {
    setState(() {
      if (changePasscodeController.newPasscode !=
          changePasscodeController.confirmPasscode) {
        confirmPasscodeErrorMessage = "Passcode is not match";
      } else {
        confirmPasscodeErrorMessage = null;
      }
    });
    return confirmPasscodeErrorMessage == null;
  }

  Future<void> changePasscode() async {
    bool checkOldPass = checkOldPasscode();
    bool checkNewPass = checkNewPasscode();
    bool checkConfirmNewPass = checkConfirmNewPasscode();
    bool isValid = checkOldPass && checkNewPass && checkConfirmNewPass;

    if (isValid == false) {
      return;
    }

    LoadingDialog.show();
    await homeController.reEncrypt(changePasscodeController.newPasscode);
    await SecureStorageHelper.saveValue(
      PasscodeHelper.passCodeKey,
      changePasscodeController.newPasscode,
    );
    LoadingDialog.hide();

    if (mounted) {
      showNoticeDialog(
        context: context,
        title: "Done",
        message: "Change Successfully",
        status: AlertStatus.success,
      );
    }

    // await SecureStorageHelper.saveValue(
    //   PasscodeHelper.passCodeKey,
    //   setupKeyController.passcode,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Header(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Change Passcode',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40),
                        PasswordInputField(
                          hintText: 'Ole Passcode',
                          onChanged: (String value) {
                            changePasscodeController.updateOldPasscode(value);
                          },
                          labelText: "Old Passcode",
                          errorText: oldPasscodeErrorMessage,
                        ),
                        const SizedBox(height: 20),
                        PasswordInputField(
                          hintText: 'Passcode',
                          onChanged: (String value) {
                            changePasscodeController.updatePasscode(value);
                          },
                          labelText: "Passcode",
                          errorText: passcodeErrorMessage,
                        ),
                        const SizedBox(height: 20),
                        PasswordInputField(
                          hintText: 'Confirm Passcode',
                          onChanged: (String value) {
                            changePasscodeController.updateConfirmPasscode(
                              value,
                            );
                          },
                          labelText: "Confirm Passcode",
                          errorText: confirmPasscodeErrorMessage,
                        ),
                        const SizedBox(height: 20),
                        TButton(
                          text: 'Change',
                          onPressed: () async {
                            await changePasscode();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
