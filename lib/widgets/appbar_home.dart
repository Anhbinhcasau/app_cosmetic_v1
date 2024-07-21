import 'package:app_cosmetic/screen/user/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  _AppBarHomeState createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  String? userId;
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    _getUserId();
    _getCartItemCount();
  }

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  Future<void> _getCartItemCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cartItemCount = prefs.getInt('cartItemCount') ?? 0;
    });
  }

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
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Spacer(),
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShoppingCartPage(
                            userId: userId ?? '',
                          )),
                );
              },
            ),
            if (cartItemCount > 0)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$cartItemCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
