import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/core/router/routes.dart';
import 'package:password_management/data/helpers/passcode_helper.dart';
import 'package:password_management/data/helpers/secure_storage_helper.dart';
import 'package:password_management/data/helpers/supabase_helper.dart';
import 'package:password_management/presentation/viewmodels/excel_controller.dart';
import 'package:password_management/presentation/viewmodels/home_controller.dart';
import 'package:password_management/presentation/widgets/button_with_icon.dart';
import 'package:password_management/presentation/widgets/header.dart';
import 'package:password_management/presentation/widgets/loading_dialog.dart';
import 'package:password_management/presentation/widgets/show_notice_dialog.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late final ExcelController excelController;
  late final HomeController homeController;

  @override
  void initState() {
    super.initState();
    excelController = Get.put(ExcelController());
    homeController = Get.find<HomeController>();
  }

  @override
  void dispose() {
    Get.delete<ExcelController>();
    super.dispose();
  }

  Future<void> exportExcel() async {
    LoadingDialog.show();
    var check = await excelController.exportExcel(
      homeController.originalAccounts,
    );
    LoadingDialog.hide();

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
          title: "Done",
          message: "Saved in Downloads",
          status: AlertStatus.success,
        );
      }
    }
  }

  Future<void> importExcel() async {}

  Future<void> logout() async {
    await SecureStorageHelper.clearValue(PasscodeHelper.passCodeKey);
    await SecureStorageHelper.clearValue(SupabaseHelper.supabaseKey);
    await SecureStorageHelper.clearValue(SupabaseHelper.supabaseUrl);
    Get.offAllNamed(TRoutes.setupSupabaseKey);
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
                const SizedBox(height: 16),
                ButtonWithIcon(
                  icon: Icons.password_rounded,
                  text: 'Change Passcode',
                  onPressed: () {
                    Get.toNamed(TRoutes.changePasscode);
                  },
                ),
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
