import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/core/utils/secure_storage_util.dart';
import 'package:password_management/data/helpers/passcode_helper.dart';
import 'package:password_management/presentation/viewmodels/login_controller.dart';
import 'package:password_management/presentation/widgets/t_button.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/logo.dart';
import 'package:password_management/presentation/widgets/password_input.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  bool validPasscode = true;
  String? passCode;
  late final LoginController loginController;

  @override
  void initState() {
    super.initState();
    loginController = Get.put(LoginController());
    _init();
  }

  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }

  Future<void> _init() async {
    passCode = await SecureStorageUtil.getValue(PasscodeHelper.passCodeKey);
  }

  Future<void> _login() async {
    setState(() {
      if (passCode == null || passCode != loginController.passcode) {
        validPasscode = false;
      } else {
        validPasscode = true;
        Get.offAllNamed(TRoutes.home);
      }
    });
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
                        const Text('Login APP', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 40),
                        PasswordInputField(
                          hintText: 'Input Passcode',
                          onChanged: (String value) {
                            loginController.updatePasscode(value);
                          },
                          errorText:
                              validPasscode == true ? null : "Invalid passcode",
                        ),
                        const SizedBox(height: 20),
                        TButton(
                          text: 'Login',
                          onPressed: () async {
                            await _login();
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
