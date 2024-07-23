import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/screen/admin/brands/brand.dart';
import 'package:app_cosmetic/screen/admin/categories/category.dart';
import 'package:app_cosmetic/screen/admin/dashboard.dart';
import 'package:app_cosmetic/screen/admin/users/user.dart';
import 'package:app_cosmetic/screen/admin/voucher/voucher.dart';
import 'package:app_cosmetic/screen/admin/products/admin_product.dart';
import 'package:app_cosmetic/screen/admin/orders/dashboard_order.dart';
import 'package:app_cosmetic/widgets/navbar_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? userId;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    DashboardMenu(),
    ListBrand(),
    ListCategory(),
    DashboardOrder(),
    ProductList(),
    ListUser(),
    VoucherManagementScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  Future<void> _logOutUser() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');

    if (userId != null && userId!.isNotEmpty) {
      await prefs.remove('userId');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle listTileStyle = TextStyle(fontSize: 25);

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
                'ADMIN',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Thống Kê', style: listTileStyle),
              selected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.token),
              title: const Text('Nhãn hàng', style: listTileStyle),
              selected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.view_in_ar_sharp),
              title: const Text('Danh mục', style: listTileStyle),
              selected: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Đơn hàng', style: listTileStyle),
              selected: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              leading: const Icon(Icons.api_outlined),
              title: const Text('Sản phẩm', style: listTileStyle),
              selected: _selectedIndex == 4,
              onTap: () => _onItemTapped(4),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Người dùng', style: listTileStyle),
              selected: _selectedIndex == 5,
              onTap: () => _onItemTapped(5),
            ),
            ListTile(
              leading: const Icon(Icons.redeem),
              title: const Text('Quản lý giảm giá', style: listTileStyle),
              selected: _selectedIndex == 6,
              onTap: () => _onItemTapped(6),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất', style: listTileStyle),
              onTap: () => _logOutUser(),
            ),
          ],
        ),
      ),
    );
  }
}