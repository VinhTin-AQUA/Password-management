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
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red, // Màu con trỏ
          selectionColor: Colors.limeAccent[400], // Vùng bôi đen
          selectionHandleColor: Colors.red, // Nút tròn khi kéo bôi
        ),
      ),
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        );
      },
    );
  }
}
