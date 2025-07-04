import 'package:password_management/data/supabase/base_supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationRepo extends BaseSupabase {
  Future<bool> signUp(String email, String password) async {
    final response = await BaseSupabase.client.auth.signUp(email: email, password: password);
    return response.user != null;
  }

  Future<User?> signIn(String email, String password) async {
    final response = await BaseSupabase.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user;
  }

  static User? logedIn() {
    final user = BaseSupabase.client.auth.currentUser;
    return user;
  }

  Future<void> logout() async {
    await BaseSupabase.client.auth.signOut();
  }
}
