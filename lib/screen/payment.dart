import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  List<dynamic> paymentMethods = [
    {'type': 'Credit & Debit Card', 'icon': Icons.credit_card},
    {'type': 'Paypal', 'icon': Icons.paypal},
    {'type': 'Apple Pay', 'icon': Icons.apple},
    {'type': 'Google Pay', 'icon': Icons.apple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...paymentMethods.map((method) => ListTile(
                  leading: Icon(method['icon']),
                  title: Text(method['type']),
                  trailing: method['type'] == 'Credit & Debit Card'
                      ? IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            // Xử lý thêm thẻ tín dụng/ghi nợ
                          },
                        )
                      : null,
                )),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Xử lý xác nhận thanh toán
              },
              child: Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
