import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String name;
  final String photoUrl;
  const UserInfo({super.key, required this.name, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
            photoUrl, // URL ảnh đại diện
          ),
          backgroundColor: Colors.grey[300],
          // child: Icon(Icons.person, color: Colors.white),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
