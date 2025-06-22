import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showDeleteDialog({
  required Future<void> Function()? onConfirm,
  String title = 'Confirm',
  String message = 'Are you sure you want to delete this item?',
  String cancelText = 'Cancel',
  String confirmText = 'Delete',
}) {
  return Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Text(message),
      actions: [
        
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.red, // Màu viền
                width: 2, // Độ dày viền
              ),
            ),
          ),
          onPressed: () => Get.back(),
          child: Text(cancelText, style: TextStyle(color: Colors.red)),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () async {
            Get.back(); // Đóng dialog
            if (onConfirm != null) {
              await onConfirm();
            }
          },
          child: Text(confirmText, style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
