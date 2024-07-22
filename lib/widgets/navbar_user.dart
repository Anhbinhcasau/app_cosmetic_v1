import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/screen/user/voucher/voucher_user.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/screen/user/Product/product_user.dart';
import 'package:app_cosmetic/screen/user/Home/home.dart';
import 'package:app_cosmetic/screen/user/profile/profile_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  int _selectedIndex = 0;
  String? id;
  late List<Widget> _pages = [
    HomePage(),
    CouponsScreen(),
    ProductList_User(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void getId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
        id =prefs.getString('userId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey[600],
        selectedIconTheme: const IconThemeData(size: 32),
        unselectedIconTheme: const IconThemeData(size: 25),
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Coupon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
