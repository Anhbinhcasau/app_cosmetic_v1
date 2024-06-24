import 'package:app_cosmetic/screen/dashboard.dart';
import 'package:app_cosmetic/screen/forgot_pass.dart';
import 'package:app_cosmetic/screen/order/dashboard_order.dart';
import 'package:app_cosmetic/screen/sign_in.dart';
import 'package:app_cosmetic/screen/user/dashboard_user.dart';
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
    LoginPage(),
    DashboardMenu(),
    ForgotPassPage(),
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
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.token),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.feedback),
                label: 'Comments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Users',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.green[800],
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
