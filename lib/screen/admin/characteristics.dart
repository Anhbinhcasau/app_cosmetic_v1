// dashboard_order.dart
import 'package:app_cosmetic/screen/admin/brands/dashboard_brand.dart';
import 'package:app_cosmetic/screen/admin/categories/dashboard_category.dart';
import 'package:app_cosmetic/widgets/admin_widgets/navbar_characteristics.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/widgets/admin_widgets/orders/navbar_order.dart';


class Characteristics extends StatefulWidget {
  const Characteristics({super.key});

  @override
  State<Characteristics> createState() => CharacteristicsState();
}

class CharacteristicsState extends State<Characteristics> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardBrand(),
    const DashboardCategory(), 
  ];

  void _onSelectedButtonChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavbarCharacteristics(onSelectedButtonChanged: _onSelectedButtonChanged),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}