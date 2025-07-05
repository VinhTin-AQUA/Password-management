import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/core/router/routes.dart';
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
  // late final PasscodeController passwordController;
  // late final BiometricController biometricController;

  @override
  void initState() {
    super.initState();
    // passwordController = Get.put(PasscodeController());
    // biometricController = Get.put(BiometricController());
  }

  @override
  void dispose() {
    // Get.delete<PasscodeController>();
    super.dispose();
  }

  Future<void> _login() async {
    
    setState(() {
      
    });
   
   
    setState(() {
      validPassword = false;
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
                        Logo(size: 150),
                        const SizedBox(height: 20),
                        const Text('Login APP', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 40),
                        PasswordInputField(
                          hintText: 'Input password',
                          onChanged: (String value) {},
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
