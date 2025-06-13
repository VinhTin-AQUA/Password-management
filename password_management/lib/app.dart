import 'package:flutter/material.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Password Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: TRoutes.getInitialRoute(),
      getPages: TRoutes.generateRoute(),
    );
  }
}

