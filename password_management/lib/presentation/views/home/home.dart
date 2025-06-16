import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_management/presentation/viewmodels/account_controller.dart';

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
  ];

  final List<MenuItem> menuItems = [
    MenuItem(icon: Icons.home, onPressed: () => print('Home')),
    MenuItem(icon: Icons.add, onPressed: () => print('Add')),
    MenuItem(icon: Icons.settings, onPressed: () => print('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (builder) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    builder.googleUserInfo.displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: mockSites.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.grey[300],
                          child: ListTile(
                            leading: const Icon(Icons.lock),
                            title: Text(mockSites[index]),
                            trailing: PopupMenuButton<String>(
                              onSelected: (String item) {
                                print('Selected: $item');
                              },
                              itemBuilder:
                                  (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                        const PopupMenuItem<String>(
                                          value: 'edit',
                                          child: Text('Edit'),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'delete',
                                          child: Text('Delete'),
                                        ),
                                      ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                          menuItems.map((item) {
                            return IconButton(
                              icon: Icon(item.icon, color: Colors.white),
                              onPressed: item.onPressed,
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MenuItem {
  final IconData icon;
  final VoidCallback onPressed;

  MenuItem({required this.icon, required this.onPressed});
}
