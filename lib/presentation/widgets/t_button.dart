import 'package:flutter/material.dart';

class TButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        label: Align(
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(), textAlign: TextAlign.center),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          overlayColor: Colors.amber
        ),
      ),
    );
  }
}
