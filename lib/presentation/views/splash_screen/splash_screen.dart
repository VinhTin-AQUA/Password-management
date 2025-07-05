import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/presentation/viewmodels/splash_controller.dart';

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
    WidgetsFlutterBinding.ensureInitialized();
    SplashController.initGetXControllers();
    await Future.wait([SplashController.initmediaStorePlus()]);

    var isCreatePassword = await SplashController.isInit();
    if (isCreatePassword == false) {
      Get.offAllNamed(TRoutes.setupSupabaseKey);
      return;
    }

    WidgetsBinding.instance.performReassemble();
    Get.offAllNamed(TRoutes.loginApp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
