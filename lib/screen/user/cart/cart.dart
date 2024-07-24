import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/cart.model.dart';
import 'package:app_cosmetic/model/voucher.model.dart';
import 'package:app_cosmetic/screen/user/checkout/checkout.dart';
import 'package:app_cosmetic/services/cart_service.dart';
import 'package:app_cosmetic/services/product_service.dart';
import 'package:app_cosmetic/services/voucher_service.dart';
import 'package:app_cosmetic/widgets/navbar_user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late CartService _cartService;
  late VoucherService _voucherService;
  Cart? _cart;
  String idCart = '';
  bool _loading = true;
  String? userId;
  late ProductService product;
  @override
  void initState() {
    super.initState();
    _cartService = CartService();
    _voucherService = VoucherService();
    _loadCart();
  }

  String _formatMoney(int amount) {
    final formatter = NumberFormat.decimalPattern('vi_VN');
    return formatter.format(amount);
  }

  Future<void> _loadCart() async {
    try {
      SharedPreferences prefss = await SharedPreferences.getInstance();
      userId = prefss.getString('userId');
      final cart = await _cartService.getCartByUserId(userId!);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idCart = prefs.getString('_id');
      if (cart != null) {
        setState(() {
          _cart = cart;
          _loading = false;
          this.idCart = idCart ?? '';
        });
      } else {
        print('Cart not found for user $userId');
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
    final productId = product['productId'];
    final id = product['id'];

    if (productId == null ||
        productId.isEmpty ||
        !RegExp(r'^[0-9a-fA-F]{24}$').hasMatch(productId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid productId')),
      );
      return;
    }

    final validId = id != null && id is int && id >= 0 ? id : -1;

    try {
      await _cartService.deleteItemCart(userId!, idCart, {
        'productId': productId,
        'id': validId,
      });

      setState(() {
        _cart!.itemsCart.removeWhere(
          (item) => item.productId == productId && item.id == validId,
        );
      });

      // Update the cart item count in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int currentCount = prefs.getInt('cartItemCount') ?? 0;
      prefs.setInt('cartItemCount', currentCount - 1);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Giỏ hàng'),
        centerTitle: true,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _cart == null || _cart!.itemsCart.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hãy thêm sản phẩm nhé!!!',
                      style: TextStyle(fontSize: 25, color: Colors.amber),
                    ),
                    SizedBox(height: 20),
                    Center(
                        child: InkWell(
                      child: Image.asset('assets/mt.jpg'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ),
                        );
                      },
                    )),
                  ],
                )
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
                              subtitle: Text(
                                  'Giá: ${_formatMoney(item.price.toInt() * item.quantity)}đ'),
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
                                  Text(item.quantity.toString()),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      _updateQuantity(index, item.quantity + 1);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      final item = _cart!.itemsCart[index];
                                      if (item.productId.isNotEmpty) {
                                        _deleteItem({
                                          'productId': item.productId,
                                          'id': item.id,
                                        });
                                      } else {
                                        print(
                                            'Invalid productId for item ${item.id}');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Invalid productId for item')),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                userId: userId!,
                                cart: _cart!,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Đặt hàng',
                          style: TextStyle(fontSize: 20, color: AppColors.text),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          minimumSize: Size(double.infinity, 30),
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}
