import 'package:flutter/material.dart';
import 'package:password_management/presentation/widgets/show_delete_dialog.dart';

class AccountItem extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Future<void> Function()? onDelete;

  const AccountItem({
    super.key,
    required this.label,
    this.onTap,
    this.onDelete,
  });

  void onSelected(String value) {
    switch (value) {
      case 'delete':
        showDeleteDialog(
          onConfirm: () async {
            if (onDelete != null) {
              await onDelete!();
            }
          },
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.only(left: 16, right: 8),
          visualDensity: VisualDensity(vertical: 0.5),
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
              onSelected(item);
            },
            icon: Icon(Icons.more_vert, color: Colors.grey[600], size: 22),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 8,
            itemBuilder:
                (BuildContext context) => [
                  // PopupMenuItem<String>(
                  //   value: 'edit',
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.edit, color: Colors.black54, size: 20),
                  //       SizedBox(width: 10),
                  //       Text('Edit'),
                  //     ],
                  //   ),
                  // ),
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
