import 'package:app_cosmetic/model/cart.model.dart';
import 'package:app_cosmetic/screen/user/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/product/atribute.model.dart';
import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/services/cart_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToCartSheet extends StatefulWidget {
  final List<Attribute> attributes;
  final Product product;
  final String userId;

  const AddToCartSheet({
    Key? key,
    required this.attributes,
    required this.product,
    required this.userId,
  }) : super(key: key);

  @override
  State<AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  int _quantity = 1;
  late Attribute _selectedType;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.attributes.isNotEmpty) {
      _selectedType = widget.attributes[0];
      _selectedIndex = 0;
    } else {
      _selectedType =
          Attribute(name: 'Unknown', image: '', price: 0.0, quantity: 0);
      _selectedIndex = -1;
    }
  }

  Future<void> _addToCart() async {
    try {
      if (widget.userId.isEmpty) {
        throw Exception('User ID is null or empty');
      }

      final item = ItemCart(
        productId: widget.product.idPro!,
        quantity: _quantity,
        id: widget.product.attributes.indexOf(_selectedType),
        image: _selectedType.image,
        price: _selectedType.price,
        userId: widget.userId,
        typeProduct: _selectedType.name,
      );

      final cartService = CartService();
      final cart = await cartService.addToCart(item);

      if (cart != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int currentCount = prefs.getInt('cartItemCount') ?? 0;
        prefs.setInt('cartItemCount', currentCount + _quantity);

        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product to cart')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding product to cart: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 400, // Adjusted height to accommodate additional info
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: [
            Image.network(_selectedType.image, height: 100, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text(' ${_selectedType.price.toStringAsFixed(3)} VNĐ',
                  style: TextStyle(fontSize: 18, color: Colors.red)),
            ),
          ]),
          SizedBox(
            height: 20,
          ),
          Text('Kho: ${_selectedType.quantity}',
              style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Số lượng', style: TextStyle(fontSize: 18)),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() {
                          _quantity--;
                        });
                      }
                    },
                  ),
                  Text(_quantity.toString(), style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Loại sản phẩm', style: TextStyle(fontSize: 18)),
              DropdownButton<Attribute>(
                value: _selectedType,
                items: widget.attributes.map((Attribute attribute) {
                  return DropdownMenuItem<Attribute>(
                    value: attribute,
                    child: Text(
                      '${attribute.name}',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }).toList(),
                onChanged: (Attribute? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedType = newValue;
                      _selectedIndex = widget.attributes.indexOf(newValue);
                    });
                  }
                },
              ),
            ],
          ),
          Spacer(),
          Container(
            color: Colors.red[300],
            width: double.infinity,
            child: TextButton(
              onPressed: _addToCart,
              child: Text(
                'Thêm vào giỏ hàng',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
