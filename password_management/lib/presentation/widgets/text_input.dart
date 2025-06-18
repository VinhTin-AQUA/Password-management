import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final IconData? icon;
  final String hintText;
  final String? errorText; // ➕ Thêm thuộc tính báo lỗi
  final int maxLines;

  const TextInput({
    super.key,
    required this.onChanged,
    this.icon,
    this.hintText = '',
    this.errorText,
    this.maxLines = 1,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _obscureText = true;
  final _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _isFocused ? Colors.black : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          if (_isFocused)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          else
            BoxShadow(
              color: Colors.grey.shade400.withValues(alpha: 0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            if (widget.icon != null) Icon(widget.icon),
            if (widget.icon != null) const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _controller,
                obscureText: _obscureText,
                focusNode: _focusNode, 
                keyboardType: TextInputType.visiblePassword,
                inputFormatters: [
                  // Cho phép tất cả ký tự ASCII (bao gồm cả ký tự chưa được composed)
                  FilteringTextInputFormatter.allow(RegExp(r'[\x00-\x7F]')),
                ],
                onChanged: (value) {
                  widget.onChanged(value);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  errorText: widget.errorText,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
