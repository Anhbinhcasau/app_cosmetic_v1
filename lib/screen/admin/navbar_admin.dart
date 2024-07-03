import 'package:app_cosmetic/screen/admin/characteristics.dart';
import 'package:app_cosmetic/screen/admin/dashboard.dart';
import 'package:app_cosmetic/screen/admin/products/admin_product.dart';
import 'package:app_cosmetic/screen/forgot_pass.dart';
import 'package:app_cosmetic/screen/admin/orders/dashboard_order.dart';
import 'package:app_cosmetic/screen/admin/users/dashboard_user.dart';
import 'package:flutter/material.dart';

class NavBarApp extends StatelessWidget {
  const NavBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardOrder(),
    Characteristics(),
    DashboardMenu(),
    ProductList(),
    UserListDB(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: 'Đơn Hàng',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.token),
                label: 'Đặc Tính',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Thống Kê',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.feedback),
                label: 'Bình Luận',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Người dùng',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.green[500],
            unselectedItemColor: Colors.grey[600],
            selectedIconTheme: const IconThemeData(size: 32),
            unselectedIconTheme: const IconThemeData(size: 25),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
