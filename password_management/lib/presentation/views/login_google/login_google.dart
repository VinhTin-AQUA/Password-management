import 'package:flutter/material.dart';
import 'package:password_management/data/providers/google_signin_provider.dart';

class LoginGoogle extends StatefulWidget {
  const LoginGoogle({super.key});

  @override
  State<LoginGoogle> createState() => _LoginGoogleState();
}

class _LoginGoogleState extends State<LoginGoogle> {
  Future<void> _handleSignIn() async {
    final user = await GoogleSignInProvider.signInWithGoogle();
    print(user);
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
