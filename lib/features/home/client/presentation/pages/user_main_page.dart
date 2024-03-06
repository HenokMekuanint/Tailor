import 'package:flutter/material.dart';

import 'package:mobile/features/authentication/user/presentation/screens/profile_page.dart';
import 'package:mobile/features/nearest_tailors/presentation/screens/user_home_page.dart';
import 'package:mobile/features/order/presentation/screens/user_order_page.dart';
import 'package:mobile/injection/injection_container.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  final prefManager = sl<SharedPrefManager>();
  int _currentIndex = 0;
  List<Widget> pages = [
    const UserOrdersPage(),
    const UserHomePage(),
    const UserProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFF000080),
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
        ),
      ),
    );
  }
}
