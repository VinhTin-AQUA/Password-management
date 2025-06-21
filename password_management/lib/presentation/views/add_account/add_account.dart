import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/presentation/viewmodels/add_account_controller.dart';
import 'package:password_management/presentation/widgets/notice_modal.dart';
import 'package:password_management/presentation/widgets/t_button.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/password_input.dart';
import 'package:password_management/presentation/widgets/text_area.dart';
import 'package:password_management/presentation/widgets/text_input.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  Future<void> _addAccount(AddAccountController builder) async {
    final checkError = builder.checkValidData();

    if (checkError == false) {
      return;
    }

    var r = await builder.saveAccountModel();
    if (r == true) {
      if (mounted) {
        showCustomDialog(
          context: context,
          title: "Success",
          message: "Add account successfully",
          status: AlertStatus.success,
        );
      }
    } else {
      if (mounted) {
        showCustomDialog(
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
    return GetBuilder<AddAccountController>(
      builder: (builder) {
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
                      TextInput(
                        icon: Icons.apps,
                        maxLines: 1,
                        hintText: "App name",
                        onChanged: (String value) {
                          builder.updateAppName(value);
                        },
                        errorText:
                            builder.appNameError.isValid == false
                                ? builder.appNameError.errorMessage
                                : null,
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        icon: Icons.account_circle,
                        maxLines: 1,
                        hintText: "User name",
                        onChanged: (String value) {
                          builder.updateUserName(value);
                        },
                        errorText:
                            builder.userNameError.isValid == false
                                ? builder.userNameError.errorMessage
                                : null,
                      ),
                      const SizedBox(height: 10),
                      PasswordInputField(
                        icon: Icons.password,
                        hintText: "Password",
                        onChanged: (String value) {
                          builder.updatePassword(value);
                        },
                        errorText:
                            builder.passwordError.isValid == false
                                ? builder.passwordError.errorMessage
                                : null,
                      ),
                      const SizedBox(height: 10),
                      PasswordInputField(
                        icon: Icons.password,
                        hintText: "Confirm Password",
                        onChanged: (String value) {
                          builder.updateConfirmPassword(value);
                        },
                        errorText:
                            builder.confirmPasswordError.isValid == false
                                ? builder.confirmPasswordError.errorMessage
                                : null,
                      ),
                      const SizedBox(height: 10),
                      TextArea(
                        icon: Icons.edit_note,
                        maxLines: 5,
                        hintText: "Notes",
                        onChanged: (String value) {
                          builder.updateNote(value);
                        },
                      ),
                      const SizedBox(height: 10),
                      TButton(
                        onPressed: () {
                          _addAccount(builder);
                        },
                        text: "+",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
