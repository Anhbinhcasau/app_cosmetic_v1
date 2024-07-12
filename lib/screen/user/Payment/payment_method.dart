import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/screen/user/Payment/payment_successful.dart';
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
    {'type': 'Cash', 'icon': Icons.paid},
  ];

  String selectedMethod = 'Credit & Debit Card';

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
            ...paymentMethods.map((method) => RadioListTile<String>(
                  value: method['type'],
                  groupValue: selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedMethod = value!;
                    });
                  },
                  title: Text(method['type']),
                  secondary: Icon(method['icon']),
                )),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentSuccessScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Confirm Payment',
                  style: TextStyle(fontSize: 16, color: AppColors.text),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
