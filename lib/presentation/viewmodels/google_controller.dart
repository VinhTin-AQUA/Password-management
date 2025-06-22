import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_management/data/models/firebase_user_info.dart';
import 'package:password_management/data/models/google_user_info.dart';
import 'package:password_management/data/providers/google_signin_provider.dart';
import 'package:get/get.dart';

class GoogleController extends GetxController {
  FirebaseUserInfo firebaseUserInfo = FirebaseUserInfo();
  GoogleUserInfo googleUserInfo = GoogleUserInfo();

  @override
  void onInit() {
    super.onInit();
    _initAccount(); // Hàm bạn muốn chạy sau khi controller được khởi tạo
  }

  Future<void> _initAccount() async {
    var isLoginGoole = GoogleSignInProvider.signedIn();
    if (isLoginGoole == false) {
      return;
    }

    final user = GoogleSignInProvider.getCurrentUser();
    if (user == null) {
      return;
    }

    initInfo(user);
  }

  Future<User?> loginGoogle() async {
    var user = await GoogleSignInProvider.signInWithGoogle();
    if (user == null) {
      return null;
    }
    return user;
  }

  void initInfo(User user) {
    firebaseUserInfo.displayName = user.displayName ?? "Error";
    firebaseUserInfo.email = user.email ?? "Error";
    firebaseUserInfo.emailVerified = user.emailVerified;
    firebaseUserInfo.isAnonymous = user.isAnonymous;
    firebaseUserInfo.phoneNumber = user.phoneNumber ?? "Error";
    firebaseUserInfo.photoURL = user.photoURL ?? "Error";
    firebaseUserInfo.uid = user.uid;
    firebaseUserInfo.refreshToken = user.refreshToken ?? "Error";
    firebaseUserInfo.tenantId = user.tenantId ?? "Error";

    final googleProvider = user.providerData[0];
    googleUserInfo.displayName = googleProvider.displayName ?? "Error";
    googleUserInfo.email = googleProvider.email ?? "Error";
    googleUserInfo.phoneNumber = googleProvider.phoneNumber ?? "Error";
    googleUserInfo.photoURL = googleProvider.photoURL ?? "Error";
    googleUserInfo.providerId = googleProvider.providerId;
    googleUserInfo.uid = googleProvider.uid ?? "Error";

    update();
  }

  Future<void> signOut() async {
    await GoogleSignInProvider.signOut();
  }
}
