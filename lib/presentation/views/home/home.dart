import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/presentation/viewmodels/home_controller.dart';
import 'package:password_management/presentation/views/home/widgets/account_item.dart';
import 'package:password_management/presentation/views/home/widgets/menu_bottom_bar.dart';
import 'package:password_management/presentation/views/home/widgets/t_search_bar.dart';
import 'package:password_management/presentation/views/home/widgets/user_info.dart';
import 'package:password_management/presentation/widgets/loading_dialog.dart';
import 'package:password_management/presentation/widgets/show_notice_dialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.put(HomeController());
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

  Future<void> onDeleteAccount(String id) async {
    LoadingDialog.show();
    final r = await homeController.deleteElement(id);
    LoadingDialog.hide();

    if (r == true) {
      if (mounted) {
        showNoticeDialog(
          context: context,
          title: "Success",
          message: "Delete successfully",
          status: AlertStatus.success,
        );
      }
    } else {
      if (mounted) {
        showNoticeDialog(
          context: context,
          title: "Failed",
          message: "Something error",
          status: AlertStatus.error,
        );
      }
    }
  }

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
                name: "AA",
                photoUrl: "AA",
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              TSearchBar(
                onChanged: (value) {
                  homeController.onSearcChange(value);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (homeController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: homeController.accounts.length,
                    itemBuilder: (context, index) {
                      return AccountItem(
                        label: homeController.accounts[index].appName,
                        onDelete: () async {
                          await onDeleteAccount(
                            homeController.accounts[index].id,
                          );
                        },
                        onTap: () {
                          Get.toNamed(
                            TRoutes.editAccount,
                            arguments: homeController.accounts[index].id,
                          );
                        },
                      );
                    },
                  );
                }),
              ),
              MenuBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
