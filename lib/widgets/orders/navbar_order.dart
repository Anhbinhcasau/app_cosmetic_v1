// navbar_order.dart
import 'package:flutter/material.dart';

class NavbarOrder extends StatefulWidget {
  final ValueChanged<int> onSelectedButtonChanged;

  const NavbarOrder({required this.onSelectedButtonChanged, super.key});

  @override
  State<NavbarOrder> createState() => _NavbarOrderState();
}

class _NavbarOrderState extends State<NavbarOrder> {
  int _selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF13131A),
          title: const Text(
            '# ĐƠN HÀNG',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildElevatedButton(0, Icons.schedule, 'Xác nhận', Colors.blue),
            _buildElevatedButton(1, Icons.local_shipping, 'Giao hàng', Colors.amber),
            _buildElevatedButton(2, Icons.verified, 'Hoàn tất', Colors.green),
            _buildElevatedButton(3, Icons.cancel, 'Đơn hủy', Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _buildElevatedButton(int index, IconData icon, String text, Color color) {
    bool isSelected = _selectedButtonIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedButtonIndex = index;
        });
        widget.onSelectedButtonChanged(index);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          if (isSelected) ...[
            const SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }
}