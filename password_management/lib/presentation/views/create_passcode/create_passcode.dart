import 'package:flutter/material.dart';
import 'package:password_management/presentation/widgets/button.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/logo.dart';
import 'package:password_management/presentation/widgets/password_input.dart';

class CreatePasscode extends StatefulWidget {
  const CreatePasscode({super.key});

  @override
  State<CreatePasscode> createState() => _CreatePasscodeState();
}

class _CreatePasscodeState extends State<CreatePasscode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Header(),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
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
                        'Create a passcode',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 40),
                      PasswordInput(
                        hintText: 'Enter passcode',
                      ),
                      const SizedBox(height: 20),
                      PasswordInput(
                        hintText: 'Enter passcode',
                      ),
                      const SizedBox(height: 20),
                      Button(
                        text: 'Create Passcode',
                        onPressed: () => {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
