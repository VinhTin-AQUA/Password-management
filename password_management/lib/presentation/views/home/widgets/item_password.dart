import 'package:flutter/material.dart';

class ItemPassword extends StatelessWidget {
  final String label;

  const ItemPassword({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1), // ⬅ tăng thêm độ cao
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 16, right: 8),
          visualDensity: VisualDensity(
            vertical: 0.5,
          ), // ⬅ hoặc bỏ nếu dùng padding trên
          leading: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.lock, color: Colors.black54),
          ),
          title: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (String item) {
              print('Selected: $item');
            },
            icon: Icon(Icons.more_vert, color: Colors.grey[600], size: 22),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 8,
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.black54, size: 20),
                        SizedBox(width: 10),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
          ),
        ),
      ),
    );
  }
}
