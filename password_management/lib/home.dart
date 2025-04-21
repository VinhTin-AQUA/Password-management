import 'package:flutter/material.dart';
import 'package:password_management/add_account.dart';
import 'package:password_management/list_account.dart';
import 'package:password_management/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    ListAccount(),
    AddAccount(),
    SettingsPage(),
  ];

  void navigate(int index) {
    setState(() {
      if (index != 1) {
        _selectedIndex = index;
      }
    });

    // Điều hướng đến trang tương ứng khi người dùng chọn một mục
    switch (index) {
      case 1:
        // Điều hướng tới AddPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddAccount()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Password Management',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
        ),
        backgroundColor: Colors.red.shade400,
        elevation: 1, //
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_app_bar.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff6200ee),
          unselectedItemColor: const Color(0xff757575),
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            navigate(index);
          },
          items: _navBarItems),
    );
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.add_box_outlined),
    activeIcon: Icon(Icons.add_box_rounded),
    label: 'Add',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings_outlined),
    activeIcon: Icon(Icons.settings_rounded),
    label: 'Settings',
  ),
];
