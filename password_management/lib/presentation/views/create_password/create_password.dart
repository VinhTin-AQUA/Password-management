import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/presentation/viewmodels/password_controller.dart';
import 'package:password_management/presentation/widgets/t_button.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/logo.dart';
import 'package:password_management/presentation/widgets/password_input.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  bool passValid = true;
  bool confirmPassValid = true;
  late final PasswordController controller; // Khai báo controller

  @override
  void initState() {
    super.initState();
    controller = Get.put(PasswordController());
  }

  @override
  void dispose() {
    Get.delete<PasswordController>();
    super.dispose();
  }

  Future<void> _savePassword() async {
    if (controller.password == "") {
      setState(() {
        passValid = false;
      });
      return;
    }

    if (controller.confirmPassword != controller.password) {
      setState(() {
        confirmPassValid = false;
      });
      return;
    }
    setState(() {
      passValid = true;
      confirmPassValid = true;
    });
    await controller.savePassword();
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
                          hintText: 'Input password',
                          onChanged: controller.updatePassword,
                          errorText: passValid ? null : 'Password is not empty',
                        ),
                        const SizedBox(height: 20),
                        PasswordInputField(
                          hintText: 'Confirm password',
                          onChanged: controller.updateConfirmPassword,
                          errorText:
                              confirmPassValid ? null : 'Password is not match',
                        ),
                        const SizedBox(height: 20),
                        TButton(
                          text: 'Create password',
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
