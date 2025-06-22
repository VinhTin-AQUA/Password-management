import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/presentation/viewmodels/biometric_controller.dart';
import 'package:password_management/presentation/viewmodels/password_controller.dart';
import 'package:password_management/presentation/widgets/show_notice_dialog.dart';
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
  bool validPassword = true;
  late final PasswordController passwordController;
  late final BiometricController biometricController;

  @override
  void initState() {
    super.initState();
    passwordController = Get.put(PasswordController());
    biometricController = Get.put(BiometricController());
  }

  @override
  void dispose() {
    Get.delete<PasswordController>();
    super.dispose();
  }

  Future<void> _login() async {
    final check = await passwordController.loginApp();
    setState(() {
      validPassword = true;
    });
    if (check == true) {
      Get.offAllNamed(TRoutes.home);
      return;
    }
    setState(() {
      validPassword = false;
    });
  }

  Future<void> _loginWithBiometric() async {
    final checkBiometrics = await biometricController.checkBiometrics();
    if (checkBiometrics == false) {
      if (mounted) {
        showNoticeDialog(
          context: context,
          title: "Failed",
          message: "Biometric is not supported.",
          status: AlertStatus.error,
        );
      }
      return;
    }

    final r = await biometricController.authenticateWithBiometrics();
    if (r == false) {
      if (mounted) {
        showNoticeDialog(
          context: context,
          title: "Failed",
          message: "Login failed. Try again.",
          status: AlertStatus.error,
        );
      }
      return;
    }

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
                        const Text('Login APP', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 40),
                        PasswordInputField(
                          hintText: 'Input password',
                          onChanged: passwordController.updatePassword,
                          errorText:
                              validPassword == true ? null : "Invalid Password",
                        ),
                        const SizedBox(height: 20),
                        TButton(
                          text: 'Login',
                          onPressed: () async {
                            await _login();
                          },
                        ),
                        const SizedBox(height: 10),
                        TextButton.icon(
                          onPressed: () async {
                            await _loginWithBiometric();
                          },
                          icon: Icon(Icons.fingerprint, size: 28),
                          label: Text(
                            "Login with Fingerprint",
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
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
