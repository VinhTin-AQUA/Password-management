import 'package:flutter/material.dart';

enum AlertStatus { success, error }

void showNoticeDialog({
  required BuildContext context,
  required String title,
  required String message,
  required AlertStatus status,
}) {
  final isSuccess = status == AlertStatus.success;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dialog',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation1, animation2) {
      return const SizedBox.shrink(); // Empty placeholder, actual content in transitionBuilder
    },
    transitionBuilder: (context, anim, _, __) {
      return Transform.scale(
        scale: anim.value,
        child: Opacity(
          opacity: anim.value,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 24,
            ),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSuccess ? Icons.check_circle : Icons.error,
                    size: 48,
                    color: isSuccess ? Colors.green : Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSuccess ? Colors.green : Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        'OK',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// if (mounted) {
//   showNoticeDialog(
//     context: context,
//     title: "Success",
//     message: "Add account successfully",
//     status: AlertStatus.success,
//   );
// }