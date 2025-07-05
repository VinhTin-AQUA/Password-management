import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/data/helpers/logger.dart';
import 'package:password_management/data/helpers/secure_storage_helper.dart';
import 'package:password_management/data/helpers/passcode_helper.dart';
import 'package:password_management/data/helpers/supabase_helper.dart';
import 'package:password_management/presentation/viewmodels/setup_key_controller.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/loading_dialog.dart';
import 'package:password_management/presentation/widgets/logo.dart';
import 'package:password_management/presentation/widgets/password_input.dart';
import 'package:password_management/presentation/widgets/show_notice_dialog.dart';
import 'package:password_management/presentation/widgets/t_button.dart';

class SetupSupabaseKey extends StatefulWidget {
  const SetupSupabaseKey({super.key});

  @override
  State<SetupSupabaseKey> createState() => SsetupSupabaseKeyState();
}

class SsetupSupabaseKeyState extends State<SetupSupabaseKey> {
  late SetupKeyController setupKeyController;
  String? supabaseKeyErrorMessage;
  String? supabaseUrlErrorMessage;
  String? passcodeErrorMessage;
  String? confirmPasscodeErrorMessage;

  @override
  void initState() {
    super.initState();
    setupKeyController = Get.put(SetupKeyController());
  }

  @override
  void dispose() {
    Get.delete<SetupKeyController>();
    super.dispose();
  }

  bool checkSupabaseKey() {
    setState(() {
      if (setupKeyController.supabaseKey == "") {
        supabaseKeyErrorMessage = "Supabase key is not empty";
      } else {
        supabaseKeyErrorMessage = null;
      }
    });
    return supabaseKeyErrorMessage == null;
  }

  bool checkSupabaseUrl() {
    setState(() {
      if (setupKeyController.supabaseUrl == "") {
        supabaseUrlErrorMessage = "Supabase url is not empty";
      } else {
        supabaseUrlErrorMessage = null;
      }
    });
    return supabaseUrlErrorMessage == null;
  }

  bool checkPasscode() {
    setState(() {
      if (setupKeyController.passcode == "") {
        passcodeErrorMessage = "Passcode is not empty";
      } else if (setupKeyController.passcode.length < 6) {
        passcodeErrorMessage = "Passode is at least 6 characters";
      } else {
        passcodeErrorMessage = null;
      }
    });
    return passcodeErrorMessage == null;
  }

  bool checkConfirmPasscode() {
    setState(() {
      if (setupKeyController.passcode != setupKeyController.confirmPasscode) {
        confirmPasscodeErrorMessage = "Passcode is not match";
      } else {
        confirmPasscodeErrorMessage = null;
      }
    });
    return confirmPasscodeErrorMessage == null;
  }

  Future<void> setup() async {
    bool checkKey = checkSupabaseKey();
    bool checkUrl = checkSupabaseUrl();
    bool checkPass = checkPasscode();
    bool checkConfirmPass = checkConfirmPasscode();
    bool isValid = checkKey && checkUrl && checkPass && checkConfirmPass;

    if (isValid == false) {
      return;
    }

    LoadingDialog.show();
    String? message = await setupKeyController.initSupabase();
    LoadingDialog.hide();
    if (message == null) {
      await SecureStorageHelper.saveValue(
        SupabaseHelper.supabaseKey,
        setupKeyController.supabaseKey,
      );

      await SecureStorageHelper.saveValue(
        SupabaseHelper.supabaseUrl,
        setupKeyController.supabaseUrl,
      );

      await SecureStorageHelper.saveValue(
        PasscodeHelper.passCodeKey,
        setupKeyController.passcode,
      );

      Get.offAllNamed(TRoutes.loginApp);
    } else {
      if (mounted) {
        showNoticeDialog(
          context: context,
          title: "Error",
          message: message,
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
                        Logo(size: 90),
                        const SizedBox(height: 20),
                        const Text('Setup Key', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 40),
                        PasswordInputField(
                          hintText: 'SUPABASE KEY',
                          onChanged: (String value) {
                            setupKeyController.updateSupabaseKey(value);
                          },
                          labelText: "SUPABASE KEY",
                          errorText: supabaseKeyErrorMessage,
                        ),
                        const SizedBox(height: 20),
                        PasswordInputField(
                          hintText: 'SUPABASE URL',
                          onChanged: (String value) {
                            setupKeyController.updateSupabaseUrl(value);
                          },
                          labelText: "SUPABASE URL",
                          errorText: supabaseUrlErrorMessage,
                        ),
                        const SizedBox(height: 20),
                        PasswordInputField(
                          hintText: 'Passcode',
                          onChanged: (String value) {
                            setupKeyController.updatePasscode(value);
                          },
                          labelText: "Passcode",
                          errorText: passcodeErrorMessage,
                        ),
                        const SizedBox(height: 20),
                        PasswordInputField(
                          hintText: 'Confirm Passcode',
                          onChanged: (String value) {
                            setupKeyController.updateConfirmPasscode(value);
                          },
                          labelText: "Confirm Passcode",
                          errorText: confirmPasscodeErrorMessage,
                        ),
                        const SizedBox(height: 20),
                        TButton(
                          text: 'Setup',
                          onPressed: () async {
                            await setup();
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
