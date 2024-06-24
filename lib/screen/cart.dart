import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCartPage(),
    );
  }
}

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<Map<String, dynamic>> cartItems = [
    {'name': 'Brown Jacket', 'size': 'XL', 'price': 83.98, 'quantity': 1},
    {'name': 'Brown Suite', 'size': 'L', 'price': 120.0, 'quantity': 1},
    {'name': 'Brown Jacket', 'size': 'XL', 'price': 83.97, 'quantity': 1},
  ];

  double deliveryFee = 25.0;
  double discount = 35.0;

  void updateQuantity(int index, int newQuantity) {
    setState(() {
      cartItems[index]['quantity'] = newQuantity;
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  double get subTotal {
    return cartItems.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  double get totalCost {
    return subTotal + deliveryFee - discount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(
                      'https://product.hstatic.net/1000006063/product/bthe_2e4d05fa682a48e186a60839f42bd311_1024x1024.jpg',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                    title: Text(cartItems[index]['name']),
                    subtitle: Text('Size: ${cartItems[index]['size']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (cartItems[index]['quantity'] > 1) {
                              updateQuantity(
                                  index, cartItems[index]['quantity'] - 1);
                            }
                          },
                        ),
                        Text('${cartItems[index]['quantity']}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            updateQuantity(
                                index, cartItems[index]['quantity'] + 1);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeItem(index);
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
                Text('Sub-Total: \$${subTotal.toStringAsFixed(2)}'),
                Text('Delivery Fee: \$${deliveryFee.toStringAsFixed(2)}'),
                Text('Discount: \$${discount.toStringAsFixed(2)}'),
                SizedBox(height: 10),
                Text(
                  'Total Cost: \$${totalCost.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
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
