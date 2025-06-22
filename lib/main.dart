import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:password_management/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
