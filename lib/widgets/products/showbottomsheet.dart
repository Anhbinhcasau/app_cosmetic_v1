import 'package:flutter/material.dart';

class AddToCartSheet extends StatefulWidget {
  const AddToCartSheet({super.key});

  @override
  State<AddToCartSheet> createState() => _AddToCartSheetState();
}

class _AddToCartSheetState extends State<AddToCartSheet> {
  int _quantity = 1;
  String _selectedType = 'Loại 1';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Loại sản phẩm', style: TextStyle(fontSize: 18)),
              DropdownButton<String>(
                value: _selectedType,
                items:
                    <String>['Loại 1', 'Loại 2', 'Loại 3'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
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
            width: 500,
            child: TextButton(
              onPressed: () {
                // Xử lý thêm vào giỏ hàng ở đây
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
