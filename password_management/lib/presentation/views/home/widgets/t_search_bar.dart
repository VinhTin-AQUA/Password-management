import 'package:flutter/material.dart';

class TSearchBar extends StatelessWidget {
  const TSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide(color: Colors.black38, width: 1.5),
        ),
      ),
      style: TextStyle(color: Colors.black),
    );
  }
}
