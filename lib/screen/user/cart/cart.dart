import 'dart:convert';
import 'package:app_cosmetic/model/cart.model.dart';
import 'package:app_cosmetic/screen/user/checkout/checkout.dart';
import 'package:app_cosmetic/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartPage extends StatefulWidget {
  final String userId;

  ShoppingCartPage({super.key, required this.userId});

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late CartService _cartService;
  Cart? _cart;
  String idCart = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _cartService = CartService();
    _loadCart();
  }

  Future<void> _loadCart() async {
    try {
      final cart = await _cartService.getCartByUserId(widget.userId);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idCart = prefs.getString('_id');
      if (cart != null) {
        setState(() {
          _cart = cart;
          _loading = false;
          this.idCart = idCart ?? '';
        });
      } else {
        print('Cart not found for user ${widget.userId}');
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      print('Error loading cart: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _updateQuantity(int index, int newQuantity) async {
    setState(() {
      _cart!.itemsCart[index].quantity = newQuantity;
    });

    try {
      final response = await _cartService.updateItemInCart({
        'productId': _cart!.itemsCart[index].productId,
        'quantity': newQuantity,
      });

      if (response != null) {
        setState(() {
          _cart = response;
        });
      } else {
        print('Failed to update item quantity');
      }
    } catch (e) {
      print('Error updating item quantity: $e');
    }
  }

  Future<void> _deleteItem(Map<String, dynamic> product) async {
    try {
      await _cartService.deleteItemCart(widget.userId, idCart, product);
      // Refresh cart items or update UI as needed
      setState(() {
        _cart!.itemsCart.removeWhere((item) =>
            item.productId == product['productId'] && item.id == product['id']);
      });
    } catch (e) {
      // Handle error
      print('Failed to delete item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart : ${widget.userId}'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _cart == null || _cart!.itemsCart.isEmpty
              ? Center(child: Text('Giỏ hàng trống'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _cart!.itemsCart.length,
                        itemBuilder: (context, index) {
                          final item = _cart!.itemsCart[index];
                          return Card(
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  item.image,
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              title: Text(item.typeProduct),
                              subtitle: Text('Price: \$${item.price}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      if (item.quantity > 1) {
                                        _updateQuantity(
                                            index, item.quantity - 1);
                                      }
                                    },
                                  ),
                                  Text('${item.quantity}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      _updateQuantity(index, item.quantity + 1);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      _deleteItem({
                                        'productId': item.productId,
                                        'id': item.id,
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Promo Code',
                              suffixIcon: ElevatedButton(
                                onPressed: () {},
                                child: Text('Apply'),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                              'Sub-Total: \$${_cart!.totalPriceCart.toStringAsFixed(2)}'),
                          SizedBox(height: 10),
                          Text(
                            'Total Cost: \$${_cart!.totalPriceCart.toStringAsFixed(2)}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutPage(
                                          userId: widget.userId,
                                          cart: _cart!,
                                        )),
                              );
                            },
                            child: Text('Proceed to Checkout'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
