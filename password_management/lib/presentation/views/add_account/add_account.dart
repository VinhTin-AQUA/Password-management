import 'package:flutter/material.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/password_input.dart';
import 'package:password_management/presentation/widgets/text_input.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const SizedBox(height: 40),
                  Header(),
                  const SizedBox(height: 20),
                  TextInput(
                    icon: Icons.apps,
                    maxLines: 1,
                    hintText: "App name",
                    onChanged: (String value) {},
                  ),
                  const SizedBox(height: 10),
                  TextInput(
                    icon: Icons.account_circle,
                    maxLines: 1,
                    hintText: "User name",
                    onChanged: (String value) {},
                  ),
                  const SizedBox(height: 10),
                  PasswordInputField(
                    icon: Icons.password,
                    hintText: "Password",
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 10),
                  PasswordInputField(
                    icon: Icons.password,
                    hintText: "Confirm Password",
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 10),
                  TextInput(
                    icon: Icons.edit_note,
                    maxLines: 5,
                    hintText: "Notes",
                    onChanged: (String value) {},
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      '+',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
