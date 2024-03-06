import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/nearest_tailors/presentation/screens/user_home_page.dart';
import 'package:mobile/features/authentication/user/presentation/screens/profile_page.dart';
import 'package:mobile/features/order/presentation/screens/user_order_page.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({super.key});

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  int _currentIndex = 0;
  List<Widget> pages = [
    const UserHomePage(),
    const UserOrdersPage(),
    const UserProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF000080),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30.sp,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 30.sp,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30.sp,
              ),
              label: ''),
        ],
      ),
    );
  }
}
