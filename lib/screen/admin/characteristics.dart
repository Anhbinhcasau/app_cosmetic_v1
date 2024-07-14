// dashboard_order.dart

import 'package:app_cosmetic/screen/admin/brands/brand.dart';
import 'package:app_cosmetic/screen/admin/categories/category.dart';
import 'package:app_cosmetic/widgets/admin_widgets/navbar_characteristics.dart';
import 'package:flutter/material.dart';

class Characteristics extends StatefulWidget {
  const Characteristics({super.key});

  @override
  State<Characteristics> createState() => CharacteristicsState();
}

class CharacteristicsState extends State<Characteristics> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ListBrand(),
    const ListCategory(),
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
          NavbarCharacteristics(
              onSelectedButtonChanged: _onSelectedButtonChanged),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
