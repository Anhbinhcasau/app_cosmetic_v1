import 'package:app_cosmetic/screen/user/cart/cart.dart';
import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'The Ordinary',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingCartPage()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ProfileScreen()),
            // );
          },
        ),
      ],
    );
  }
}
