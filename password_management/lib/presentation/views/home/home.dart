import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/presentation/viewmodels/google_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> mockSites = [
    'example.com',
    'flutter.dev',
    'github.com',
    'stackoverflow.com',
    'google.com',
    'example.com',
    'flutter.dev',
    'github.com',
    'stackoverflow.com',
    'google.com',
    'example.com',
    'flutter.dev',
    'github.com',
    'stackoverflow.com',
    'google.com',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GooleController>(
      builder: (builder) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  UserInfoBar(
                    name: builder.googleUserInfo.displayName,
                    photoUrl: builder.googleUserInfo.photoURL,
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 16),
                  SearchBar(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: mockSites.length,
                      itemBuilder: (context, index) {
                        return ItemData(label: mockSites[index]);
                      },
                    ),
                  ),
                  MenuBottomBar(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MenuItemData {
  final IconData icon;
  final VoidCallback onPressed;

  MenuItemData({required this.icon, required this.onPressed});
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

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

class MenuBottomBar extends StatelessWidget {
  const MenuBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuItemData> menuItems = [
      MenuItemData(icon: Icons.home, onPressed: () => print('Home')),
      MenuItemData(icon: Icons.add, onPressed: () => print('Add')),
      MenuItemData(icon: Icons.settings, onPressed: () => print('Settings')),
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

class ItemData extends StatelessWidget {
  final String label;

  const ItemData({super.key, required this.label});

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

class UserInfoBar extends StatelessWidget {
  final String name;
  final String photoUrl;
  const UserInfoBar({super.key, required this.name, required this.photoUrl});

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
          child: Icon(Icons.person, color: Colors.white),
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
