import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog {
  static bool _isDialogOpen = false;

  static void show() {
    if (!_isDialogOpen) {
      _isDialogOpen = true;
      Get.dialog(
        PopScope(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              width: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  static void hide() {
    if (_isDialogOpen) {
      _isDialogOpen = false;
      Get.back(); // đóng dialog
    }
  }
}
