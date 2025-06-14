import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final IconData? icon;
  final String hintText;

  const PasswordInput({super.key, this.icon, this.hintText = ''});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center, // chỉ có 1 dòng
      children: [
        if (widget.icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(widget.icon),
          ),
        Expanded(
          child: TextField(
            obscureText: _obscureText,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _toggleVisibility,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
