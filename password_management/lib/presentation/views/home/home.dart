import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/presentation/viewmodels/google_controller.dart';
import 'package:password_management/presentation/viewmodels/home_controller.dart';
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
  late final HomeController homeController;
  late final GoogleController googleController;

  @override
  void initState() {
    super.initState();
    homeController = Get.put(HomeController());
    googleController = Get.find<GoogleController>();
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              UserInfo(
                // name: googleController.googleUserInfo.displayName,
                // photoUrl: googleController.googleUserInfo.photoURL,
                name: '',
                photoUrl: '',
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              TSearchBar(),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: homeController.accounts.length,
                  itemBuilder: (context, index) {
                    return ItemPassword(
                      label: homeController.accounts[index].appName,
                    );
                  },
                ),
              ),
              MenuBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
