import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/presentation/viewmodels/passcode_controller.dart';
import 'package:password_management/presentation/widgets/t_button.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/logo.dart';
import 'package:password_management/presentation/widgets/password_input.dart';

class CreatePasscode extends StatefulWidget {
  const CreatePasscode({super.key});

  @override
  State<CreatePasscode> createState() => _CreatePasscodeState();
}

class _CreatePasscodeState extends State<CreatePasscode> {
  bool passValid = true;
  bool confirmPassValid = true;
  late final PasscodeController controller; // Khai báo controller

  @override
  void initState() {
    super.initState();
    controller = Get.put(PasscodeController());
  }

  @override
  void dispose() {
    Get.delete<PasscodeController>();
    super.dispose();
  }

  Future<void> _savePassword() async {
    // if (controller.passcode == "") {
    //   setState(() {
    //     passValid = false;
    //   });
    //   return;
    // }

    // if (controller.confirmPasscode != controller.passcode) {
    //   setState(() {
    //     confirmPassValid = false;
    //   });
    //   return;
    // }
    // setState(() {
    //   passValid = true;
    //   confirmPassValid = true;
    // });

    // LoadingDialog.show();
    // await SupabaseManager.insert(PasscodeContants.tableName, {
    //   PasscodeContants.passCodeCol: Get.find<PasscodeController>().passcode,
    //   PasscodeContants.userId: Get.find<GoogleController>().googleUserInfo.uid,
    // });

    // await controller.savePassword();
    // LoadingDialog.hide();

    Get.offAllNamed(TRoutes.home);
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
                        Logo(size: 150),
                        const SizedBox(height: 20),
                        const Text(
                          'Create a password',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 40),
                        PasswordInputField(
                          hintText: 'Input passcode',
                          onChanged: controller.updatePassword,
                          errorText: passValid ? null : 'Passcode is not empty',
                        ),
                        const SizedBox(height: 20),
                        PasswordInputField(
                          hintText: 'Confirm passcode',
                          onChanged: controller.updateConfirmPassword,
                          errorText:
                              confirmPassValid ? null : 'Passcode is not match',
                        ),
                        const SizedBox(height: 20),
                        TButton(
                          text: 'Create passcode',
                          onPressed: () {
                            _savePassword();
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
