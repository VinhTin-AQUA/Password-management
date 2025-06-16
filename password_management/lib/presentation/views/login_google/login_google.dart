import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/presentation/viewmodels/account_controller.dart';

class LoginGoogle extends StatefulWidget {
  const LoginGoogle({super.key});

  @override
  State<LoginGoogle> createState() => _LoginGoogleState();
}

class _LoginGoogleState extends State<LoginGoogle> {
  Future<void> _handleSignIn(AccountController builder) async {
    final check = await builder.loginGoogle();

    if (check == false) {
      return;
    }

    TRoutes.offAll(TRoutes.home);
    TRoutes.offAll(TRoutes.createPassword);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (builder) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/google.png', // đảm bảo có file này trong assets
                    height: 150,
                    width: 150,
                  ),
                  ElevatedButton.icon(
                    icon: Image.asset(
                      'assets/google.png', // đảm bảo có file này trong assets
                      height: 24,
                      width: 24,
                    ),
                    label: const Text('Login with Google'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () async {
                      await _handleSignIn(builder);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
