import 'package:flutter/material.dart';

class AlertDialogHelper {
  static void showAlertDialog(BuildContext context,
      {required String title,
      required String message,
      String confirmButtonText = "OK",
      required Color color}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          backgroundColor: color,
          actions: <Widget>[
            TextButton(
              child: Text(confirmButtonText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// 
void showSuccessDialog(BuildContext context, String title, String message) {
  AlertDialogHelper.showAlertDialog(context,
      title: title, message: message, color: Colors.greenAccent);
}

void showErrorDialog(BuildContext context, String title, String message) {
  AlertDialogHelper.showAlertDialog(context,
      title: title, message: message, color: Colors.redAccent);
}
