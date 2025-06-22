import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/presentation/viewmodels/excel_controller.dart';
import 'package:password_management/presentation/viewmodels/google_controller.dart';
import 'package:password_management/presentation/viewmodels/home_controller.dart';
import 'package:password_management/presentation/viewmodels/password_controller.dart';
import 'package:password_management/presentation/widgets/button_with_icon.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/show_notice_dialog.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late final ExcelController excelController;
  late final HomeController homeController;
  late final PasswordController passwordController;
  late final GoogleController googleController;

  @override
  void initState() {
    super.initState();
    excelController = Get.put(ExcelController());
    homeController = Get.find<HomeController>();
    googleController = Get.put(GoogleController());
    passwordController = Get.put(PasswordController());
  }

  @override
  void dispose() {
    Get.delete<ExcelController>();
    Get.delete<PasswordController>();
    super.dispose();
  }

  Future<void> exportExcel() async {
    var check = await excelController.exportExcel(
      homeController.originalAccounts,
    );

    if (check == false) {
      if (mounted) {
        showNoticeDialog(
          context: context,
          title: "Faild",
          message: "Something error",
          status: AlertStatus.error,
        );
      }
    } else {
      if (mounted) {
        showNoticeDialog(
          context: context,
          title: "Success",
          message: "Saved in Download",
          status: AlertStatus.success,
        );
      }
    }
  }

  Future<void> importExcel() async {}

  Future<void> logout() async {
    await googleController.signOut();
    await passwordController.logoutApp();
    Get.toNamed(TRoutes.loginGoole);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Header(),
                ButtonWithIcon(
                  icon: Icons.file_download,
                  text: 'Export excel',
                  onPressed: () async {
                    await exportExcel();
                  },
                ),
                // const SizedBox(height: 16),
                // ButtonWithIcon(
                //   icon: Icons.file_upload,
                //   text: 'Import excel',
                //   onPressed: () async {
                //     await importExcel();
                //   },
                // ),
                const SizedBox(height: 16),

                ButtonWithIcon(
                  icon: Icons.logout,
                  text: 'Logout',
                  onPressed: () async {
                    await logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
