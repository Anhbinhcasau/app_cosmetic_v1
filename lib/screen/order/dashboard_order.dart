import 'package:app_cosmetic/screen/order/navbar_order.dart';
import 'package:app_cosmetic/screen/products/dashboard_product.dart';
import 'package:app_cosmetic/widgets/products/product.dart';
import 'package:app_cosmetic/widgets/user/user.dart';
import 'package:flutter/material.dart';


class DashboardOrder extends StatefulWidget {
  const DashboardOrder({super.key});

  @override
  State<DashboardOrder> createState() => _DashboardOrderState();
}

class _DashboardOrderState extends State<DashboardOrder> {
  int _selectedIndex = 0;

  final List<Widget> _orderScreens = [
    ProductList(),
    ListUser(),
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
          NavbarOrder(onSelectedButtonChanged: _onSelectedButtonChanged),
          Expanded(
            child: _orderScreens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}