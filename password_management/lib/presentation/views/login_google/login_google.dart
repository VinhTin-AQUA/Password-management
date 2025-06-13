import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_management/presentation/views/home/home.dart';

class LoginGoogle extends StatefulWidget {
  const LoginGoogle({super.key});

  @override
  State<LoginGoogle> createState() => _LoginGoogleState();
}

class _LoginGoogleState extends State<LoginGoogle> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        // Đăng nhập thành công
        print('Đăng nhập thành công: ${account.email}');
        // Chuyển màn hình sau khi đăng nhập
        Get.offAll(
          () => Home(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      } else {
        print('Người dùng đã huỷ đăng nhập');
      }
    } catch (error) {
      print('Lỗi đăng nhập: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: _handleSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
