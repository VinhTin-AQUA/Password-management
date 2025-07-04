import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:password_management/core/utils/string_util.dart';
import 'package:password_management/presentation/viewmodels/authentication_controller.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/logo.dart';
import 'package:password_management/presentation/widgets/password_input.dart';
import 'package:password_management/presentation/widgets/t_button.dart';
import 'package:password_management/presentation/widgets/text_input.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool passValid = true;
  bool confirmPassValid = true;
  bool isValidEmail = true;
  late AuthenticationController authenticationController;

  @override
  void initState() {
    super.initState();
    authenticationController = Get.put(AuthenticationController());
  }

  @override
  void dispose() {
    Get.delete<AuthenticationController>();
    super.dispose();
  }

  bool checkValid() {
    print(StringUtil.isValidEmail(authenticationController.email));
    print("object");

    setState(() {
      isValidEmail =
          authenticationController.email != "" &&
          StringUtil.isValidEmail(authenticationController.email);
    });

    setState(() {
      passValid = authenticationController.password != "";
    });

    setState(() {
      confirmPassValid =
          authenticationController.password ==
          authenticationController.confirmPassword;
    });

    return isValidEmail && passValid && confirmPassValid;
  }

  void signup() {
    bool valid = checkValid();

    if (valid == false) {
      return;
    }

    print(authenticationController.email);
    print(authenticationController.password);
    print(authenticationController.confirmPassword);
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
                        const Text('Signup', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 40),
                        TextInput(
                          icon: Icons.apps,
                          maxLines: 1,
                          hintText: "Email",
                          labelText: 'Email',
                          onChanged: (String value) {
                            authenticationController.updateEmail(value);
                          },
                          errorText: isValidEmail ? null : "Email is invalid",
                        ),
                        PasswordInputField(
                          hintText: 'Password',
                          onChanged: (value) {
                            authenticationController.updatePassword(value);
                          },
                          labelText: 'Password',
                          errorText: passValid ? null : 'Password is not empty',
                        ),
                        const SizedBox(height: 20),
                        PasswordInputField(
                          hintText: 'Confirm password',
                          labelText: 'Confirm password',
                          onChanged: (value) {
                            authenticationController.updateConfirmPassword(
                              value,
                            );
                          },
                          errorText:
                              confirmPassValid ? null : 'Password is not match',
                        ),
                        const SizedBox(height: 20),
                        TButton(
                          text: 'Signup',
                          onPressed: () {
                            signup();
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
