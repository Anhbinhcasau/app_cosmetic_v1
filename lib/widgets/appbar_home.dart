import 'package:app_cosmetic/model/cart.model.dart';
import 'package:app_cosmetic/screen/user/cart/cart.dart';
import 'package:app_cosmetic/services/cart_service.dart';
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
  CartService cartService = CartService();

  @override
  void initState() {
    super.initState();
    _loadUserIdAndCart();
  }

  Future<void> _loadUserIdAndCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final newUserId = prefs.getString('userId');

    if (newUserId != userId) {
      setState(() {
        userId = newUserId;
      });

      if (userId != null) {
        await _updateCartItemCount();
      }
    }
  }

  Future<void> _updateCartItemCount() async {
    if (userId == null) return;

    try {
      Cart? cart = await cartService.getCartByUserId(userId!);
      setState(() {
        cartItemCount =
            cart?.itemsCart.length ?? 0; // Đếm số lượng sản phẩm trong giỏ hàng
      });
    } catch (e) {
      print('Error fetching cart: $e');
    }
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
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartPage(),
                  ),
                );
                // Refresh the cart item count when returning from the ShoppingCartPage
                await _updateCartItemCount();
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
