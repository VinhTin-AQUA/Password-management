import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/presentation/views/add_account/add_account.dart';
import 'package:password_management/presentation/views/create_passcode/create_passcode.dart';
import 'package:password_management/presentation/views/home/home.dart';
import 'package:password_management/presentation/views/login_app/login_app.dart';
import 'package:password_management/presentation/views/settings/settings.dart';

class TRoutes {
  static const home = '/';
  static const addAccount = '/add-account';
  static const loginApp = "/login-app";
  static const settings = "/settings";
  static const createPassword = "/create-password";

  static String getInitialRoute() {
    return createPassword;
  }

  static List<GetPage<dynamic>> generateRoute() => [
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
      page: () => CreatePasscode(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    ),
  ];
}
