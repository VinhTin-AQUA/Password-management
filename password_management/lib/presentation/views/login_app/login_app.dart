import 'package:flutter/material.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/logo.dart';
import 'package:password_management/presentation/widgets/password_input.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
           const SizedBox(height: 40),
                  Header(),
                  const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Logo(size: 150,),
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: PasswordInput(
                              hintText: 'Input your password',
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement login logic here using _passwordController.text
                              print("Login with password: ");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue.shade300,
                              padding: EdgeInsets.symmetric(
                                horizontal: 80,
                                vertical: 15,
                              ),
                              textStyle: TextStyle(fontSize: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text('Login'),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Or', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Implement fingerprint authentication logic here
                            print("Authenticate with fingerprint");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue.shade300,
                            padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                            textStyle: TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.fingerprint),
                              SizedBox(width: 8),
                              Text('Biometric'),
                            ],
                          ),
                        ),
                      ],
                    ),
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
