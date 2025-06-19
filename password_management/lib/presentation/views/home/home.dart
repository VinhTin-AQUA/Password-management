import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/presentation/viewmodels/google_controller.dart';
import 'package:password_management/presentation/views/home/widgets/item_password.dart';
import 'package:password_management/presentation/views/home/widgets/menu_bottom_bar.dart';
import 'package:password_management/presentation/views/home/widgets/t_search_bar.dart';
import 'package:password_management/presentation/views/home/widgets/user_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> mockSites = [
    'example.com',
    'flutter.dev',
    'github.com',
    'stackoverflow.com',
    'google.com',
    'example.com',
    'flutter.dev',
    'github.com',
    'stackoverflow.com',
    'google.com',
    'example.com',
    'flutter.dev',
    'github.com',
    'stackoverflow.com',
    'google.com',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GooleController>(
      builder: (builder) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  UserInfo(
                    name: builder.googleUserInfo.displayName,
                    photoUrl: builder.googleUserInfo.photoURL,
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 16),
                  TSearchBar(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: mockSites.length,
                      itemBuilder: (context, index) {
                        return ItemPassword(label: mockSites[index]);
                      },
                    ),
                  ),
                  MenuBottomBar(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}





