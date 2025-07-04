import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:password_management/core/config/supabase_postgre_env.dart';
import 'package:password_management/core/constants/contants.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/core/utils/secure_storage_util.dart';
import 'package:password_management/data/supabase/authentication_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  void _initGetXControllers() {
    
  }

  Future<void> _initSupabase() async {
    await SupabasePostgreEnv.init();

    await Supabase.initialize(
      url: SupabasePostgreEnv.supabaseUrl,
      anonKey: SupabasePostgreEnv.supabaseKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
  }

  Future<void> _initmediaStorePlus() async {
    if (Platform.isAndroid) {
      await MediaStore.ensureInitialized();
      MediaStore.appFolder = "MediaStorePlugin";
    }
  }

  Future<void> _initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    _initGetXControllers();

    await Future.wait([_initSupabase(), _initmediaStorePlus()]);

    // var isLoginGoole = GoogleSignInProvider.signedIn();
    // if (isLoginGoole == false) {
    //   Get.offAllNamed(TRoutes.loginGoole);
    //   return;
    // }

    var isCreatePassword = AuthenticationRepo.logedIn();
    if (isCreatePassword == null) {
      Get.offAllNamed(TRoutes.signup);
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
