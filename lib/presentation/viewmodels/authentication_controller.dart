import 'package:get/get.dart';
import 'package:password_management/data/supabase/authentication_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationController extends GetxController {
  String email = "";
  String password = "";
  String confirmPassword = "";
  AuthenticationRepo authenticationRepo = AuthenticationRepo();

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void updateEmail(String email) {
    this.email = email;
  }

  void updatePassword(String password) {
    this.password = password;
  }

  void updateConfirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
  }

  Future<bool> signup() async {
    var r = await authenticationRepo.signUp(email, password);
    return r;
  }

  Future<User?> login() async {
    var r = await authenticationRepo.signIn(email, password);
    return r;
  }
}
