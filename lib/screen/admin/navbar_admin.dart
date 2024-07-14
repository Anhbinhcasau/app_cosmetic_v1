import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/screen/admin/brands/brand.dart';
import 'package:app_cosmetic/screen/admin/categories/category.dart';
import 'package:app_cosmetic/screen/admin/characteristics.dart';
import 'package:app_cosmetic/screen/admin/dashboard.dart';
import 'package:app_cosmetic/screen/user/profile/forgot_pass.dart';
import 'package:app_cosmetic/screen/admin/products/admin_product.dart';
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
    DashboardMenu(),
    ListBrand(),
    ListCategory(),
    DashboardOrder(),
    ProductList(),
    ForgotPassPage(),
    //UserListDB(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ADMIN'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Text(
                'Chưa bít để gì hết trơn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Thống Kê'),
              selected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.token),
              title: const Text('Nhãn hàng'),
              selected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.token),
              title: const Text('Danh mục'),
              selected: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Đơn hàng'),
              selected: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Sản phẩm'),
              selected: _selectedIndex == 4,
              onTap: () => _onItemTapped(4),
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Bình Luận'),
              selected: _selectedIndex == 5,
              onTap: () => _onItemTapped(5),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Người dùng'),
              selected: _selectedIndex == 6,
              onTap: () => _onItemTapped(6),
            ),
          ],
        ),
      ),
    );
  }
}
