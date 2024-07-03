import 'package:flutter/material.dart';

class NavbarCharacteristics extends StatefulWidget {
  final ValueChanged<int> onSelectedButtonChanged;

  const NavbarCharacteristics({required this.onSelectedButtonChanged, Key? key})
      : super(key: key);

  @override
  State<NavbarCharacteristics> createState() => _NavbarCharacteristicsState();
}

class _NavbarCharacteristicsState extends State<NavbarCharacteristics> {
  int _selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF13131A),
          title: const Text(
            '# ĐẶC TÍNH',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildElevatedButton(0, Icons.bookmark, 'Nhãn Hàng', Colors.white, Color(0xFFA2AA7B)),
            _buildElevatedButton(1, Icons.category_sharp, 'Danh Mục', Colors.white, Color(0xFFA2AA7B)),
          ],
        ),
      ],
    );
  }

  Widget _buildElevatedButton(int index, IconData icon, String text, Color selectedColor, Color defaultColor) {
    bool isSelected = _selectedButtonIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedButtonIndex = index;
        });
        widget.onSelectedButtonChanged(index);
      },
      style: ButtonStyle(
        backgroundColor: isSelected ? MaterialStateProperty.all<Color?>(Color(0xFFA2AA7B)) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? selectedColor : defaultColor,
            size: 30,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: isSelected ? selectedColor : defaultColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}