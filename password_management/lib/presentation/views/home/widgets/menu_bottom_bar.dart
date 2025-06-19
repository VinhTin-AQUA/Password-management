import 'package:flutter/material.dart';
import 'package:password_management/core/router/routes.dart';

class MenuBottomBar extends StatelessWidget {
  const MenuBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuItemData> menuItems = [
      MenuItemData(icon: Icons.home, onPressed: () => {}),
      MenuItemData(icon: Icons.add, onPressed: () => TRoutes.to(TRoutes.addAccount)),
      MenuItemData(icon: Icons.settings, onPressed: () => TRoutes.to(TRoutes.settings)),
    ];

    return Container(
      // margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            menuItems.map((item) {
              return IconButton(
                icon: Icon(item.icon, color: Colors.white, size: 24),
                onPressed: item.onPressed,
              );
            }).toList(),
      ),
    );
  }
}

class MenuItemData {
  final IconData icon;
  final VoidCallback onPressed;

  MenuItemData({required this.icon, required this.onPressed});
}
