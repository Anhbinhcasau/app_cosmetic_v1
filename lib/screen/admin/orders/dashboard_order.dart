// dashboard_order.dart
import 'package:app_cosmetic/screen/admin/navbar_admin.dart';
import 'package:app_cosmetic/widgets/admin_widgets/orders/order.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/widgets/admin_widgets/orders/navbar_order.dart';


class DashboardOrder extends StatefulWidget {
  const DashboardOrder({super.key});

  @override
  State<DashboardOrder> createState() => _DashboardOrderState();
}

class _DashboardOrderState extends State<DashboardOrder> {
  int _selectedIndex = 0;

  final List<Widget> _orderScreens = [
    const OrderListScreen(status: 1), // Xác nhận
    const OrderListScreen(status: 2), // Giao hàng
    const OrderListScreen(status: 3), // Hoàn tất
    const OrderListScreen(status: 4), // Đơn hủy
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