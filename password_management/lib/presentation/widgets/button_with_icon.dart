import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback onPressed;

  const ButtonWithIcon({
    super.key,
    this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: TextStyle(), textAlign: TextAlign.center),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
