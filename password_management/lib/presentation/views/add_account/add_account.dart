import 'package:flutter/material.dart';
import 'package:password_management/core/config/supabase_postgre_env.dart';
import 'package:password_management/data/datasources/remote/supabase_manager.dart';
import 'package:password_management/data/models/account.dart';
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
  Future<void> _addAccount() async {
    
  }

  @override
  Widget build(BuildContext context) {
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
                  TextArea(
                    icon: Icons.edit_note,
                    maxLines: 5,
                    hintText: "Notes",
                    onChanged: (String value) {},
                  ),
                  const SizedBox(height: 10),
                  TButton(
                    onPressed: () {
                      _addAccount();
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
  }
}
