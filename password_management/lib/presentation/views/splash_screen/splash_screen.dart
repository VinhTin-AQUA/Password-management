import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/presentation/views/create_passcode/create_passcode.dart';
import 'package:password_management/presentation/views/home/home.dart';
import 'package:password_management/presentation/views/login_google/login_google.dart';
import 'package:password_management/presentation/views/splash_screen/initial_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final results = await Future.wait([
      InitialApp.checkCreatePasscode(), // Trả về Future<bool>
      InitialApp.checkLoginGoogle(), // Trả về Future<void> hoặc một giá trị
    ]);

    var isLoginGoole = results[0]; //là kết quả từ checkUserToken()
    var isCreatePasscode = results[1]; //là kết quả từ loadAppConfig()

    await Future.wait([]);

    WidgetsBinding.instance.performReassemble();
    if (isLoginGoole == false) {
      Get.offAll(
        () => LoginGoogle(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
      return;
    }

    if (isCreatePasscode == false) {
      Get.offAll(
        () => CreatePasscode(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
      return;
    }

    Get.offAll(
      () => Home(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 100),
            const SizedBox(height: 20),
            CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text('initializing'.tr), // Sử dụng localization
          ],
        ),
      ),
    );
  }
}
