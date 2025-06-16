import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/presentation/views/add_account/add_account.dart';
import 'package:password_management/presentation/views/create_passcode/create_password.dart';
import 'package:password_management/presentation/views/home/home.dart';
import 'package:password_management/presentation/views/login_app/login_app.dart';
import 'package:password_management/presentation/views/login_google/login_google.dart';
import 'package:password_management/presentation/views/settings/settings.dart';
import 'package:password_management/presentation/views/splash_screen/splash_screen.dart';

class TRoutes {
  static const home = '/';
  static const addAccount = '/add-account';
  static const loginApp = "/login-app";
  static const settings = "/settings";
  static const createPassword = "/create-password";
  static const loginGoole = "/login-goole";
  static const splashScreen = "/splash-screen";

  static String getInitialRoute() {
    return splashScreen;
  }

  static List<GetPage<dynamic>> generateRoute() => [
    GetPage(
      name: TRoutes.splashScreen,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    ),
    GetPage(
      name: TRoutes.home,
      page: () => Home(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    ),
    GetPage(
      name: TRoutes.addAccount,
      page: () => AddAccount(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    ),
    GetPage(
      name: TRoutes.loginApp,
      page: () => LoginApp(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    ),
    GetPage(
      name: TRoutes.settings,
      page: () => Settings(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    ),
    GetPage(
      name: TRoutes.createPassword,
      page: () => CreatePassword(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    ),
    GetPage(
      name: TRoutes.loginGoole,
      page: () => LoginGoogle(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    ),
  ];

  static void offAll(String routeName) {
    switch (routeName) {
      case home:
        Get.offAll(
          () => Home(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
        break;
      case loginGoole:
        Get.offAll(
          () => LoginGoogle(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
        break;
      case createPassword:
        Get.offAll(
          () => CreatePassword(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
        break;
      default:
    }
  }
}
