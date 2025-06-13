import 'package:flutter/material.dart';

class InputInput extends StatelessWidget {
  final IconData icon;
  final int maxLines;
  final String hintText;

  const InputInput({
    super.key,
    required this.icon,
    this.maxLines = 1,
    this.hintText = '',
  });

  @override
  Widget build(BuildContext context) {
    // Nếu maxLines = 1 thì căn giữa icon theo chiều dọc
    if (maxLines == 1) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon),
          ),
          Expanded(
            child: TextField(
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
    } else {
      // Nếu maxLines > 1 thì icon ở góc trên bên trái
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 12.0),
            child: Icon(icon),
          ),
          Expanded(
            child: TextField(
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
    }
  }
}
