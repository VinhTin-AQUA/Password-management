import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:password_management/app.dart';
import 'package:password_management/data/helpers/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    Logger.reportError(details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    Logger.reportError(error, stack);
    return true; // Ngăn ứng dụng crash
  };

  runApp(const MyApp());
}
