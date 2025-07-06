import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/presentation/viewmodels/add_account_controller.dart';
import 'package:password_management/presentation/views/add_account/add_account.dart';
import 'package:password_management/presentation/views/change_passcode/change_passcode.dart';
import 'package:password_management/presentation/views/edit_account/edit_account.dart';
import 'package:password_management/presentation/views/home/home.dart';
import 'package:password_management/presentation/views/login_app/login_app.dart';
import 'package:password_management/presentation/views/settings/settings.dart';
import 'package:password_management/presentation/views/setup_supabase_key/setup_supabase_key.dart';
import 'package:password_management/presentation/views/splash_screen/splash_screen.dart';

class TRoutes {
  static const home = '/';
  static const addAccount = '/add-account';
  static const loginApp = "/login-app";
  static const settings = "/settings";
  static const splashScreen = "/splash-screen";
  static const editAccount = "/edit-account";
  static const setupSupabaseKey = "/setup-supabase-key";
  static const changePasscode = "/change-passcode";

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
      binding: AddAccountBinding(),
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
      name: TRoutes.editAccount,
      page: () => EditAccount(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    ),
    GetPage(
      name: TRoutes.setupSupabaseKey,
      page: () => SetupSupabaseKey(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    ),
    GetPage(
      name: TRoutes.changePasscode,
      page: () => ChangePasscode(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    ),
  ];
}
