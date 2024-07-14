import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/product/atribute.model.dart';
import 'package:app_cosmetic/model/product/product.model.dart';

class AddToCartSheet extends StatefulWidget {
  final List<Attribute> attributes;

  const AddToCartSheet({super.key, required this.attributes});

  @override
  State<AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  int _quantity = 1;
  late Attribute _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.attributes.isNotEmpty
        ? widget.attributes[0]
        : Attribute(name: 'Unknown', image: '', price: 0.0, quantity: 0);
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
              child: Text(' ${_selectedType.price.toStringAsFixed(3)}    VNĐ',
                  style: TextStyle(fontSize: 18, color: Colors.red)),
            ),
          ]),
          SizedBox(
            height: 20,
          ),
          SizedBox(height: 10),
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
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          if (_quantity > 1) _quantity--;
                        });
                      });
                    },
                  ),
                  Text(_quantity.toString(), style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _quantity++;
                        });
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  });
                },
              ),
            ],
          ),
          Spacer(),
          Container(
            color: Colors.red[300],
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                // Handle add to cart here
                Navigator.pop(context);
              },
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
