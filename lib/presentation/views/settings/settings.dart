import 'package:flutter/material.dart';
import 'package:password_management/presentation/widgets/button_with_icon.dart';
import 'package:password_management/presentation/widgets/header.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                  onPressed: () {
                    // Handle export excel
                  },
                ),
                const SizedBox(height: 16),
                ButtonWithIcon(
                  icon: Icons.file_upload,
                  text: 'Import excel',
                  onPressed: () {
                    // Handle import excel
                  },
                ),
                const SizedBox(height: 16),

                ButtonWithIcon(
                  icon: Icons.logout,
                  text: 'Logout',
                  onPressed: () {
                    // Handle logout
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
