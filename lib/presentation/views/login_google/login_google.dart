import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/presentation/viewmodels/google_controller.dart';
import 'package:password_management/presentation/widgets/loading_dialog.dart';
import 'package:password_management/presentation/widgets/show_notice_dialog.dart';

class LoginGoogle extends StatefulWidget {
  const LoginGoogle({super.key});

  @override
  State<LoginGoogle> createState() => _LoginGoogleState();
}

class _LoginGoogleState extends State<LoginGoogle> {
  Future<void> _handleSignIn(GoogleController builder) async {
    LoadingDialog.show();
    final user = await builder.loginGoogle();
    LoadingDialog.hide();
    
    if (user == null) {
      if (mounted) {
        showNoticeDialog(
          context: context,
          title: "Login failed",
          message: "Try again",
          status: AlertStatus.error,
        );
      }
      return;
    }

    builder.initInfo(user);
    Get.offAllNamed(TRoutes.createPassword);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoogleController>(
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
