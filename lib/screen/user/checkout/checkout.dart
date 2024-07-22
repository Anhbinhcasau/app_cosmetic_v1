import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/screen/user/Payment/payment_successful.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/cart.model.dart';
import 'package:app_cosmetic/model/checkout.model.dart';
import 'package:app_cosmetic/services/checkout_service.dart';
import 'package:app_cosmetic/screen/user/Payment/payment_method.dart';

class CheckoutPage extends StatefulWidget {
  final Cart cart;
  final String userId;

  const CheckoutPage({super.key, required this.cart, required this.userId});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  late String fullName;
  late String phone;
  late String email;
  late String address;
  late CheckoutService _checkoutService;

  @override
  void initState() {
    super.initState();
    _checkoutService = CheckoutService();
  }

  void _confirmPayment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final checkout = Checkout(
        cartId: widget.cart.cartId!,
        userId: widget.userId,
        totalPrice: widget.cart.totalPriceCart,
        fullName: fullName,
        phoneNumber: phone,
        email: email,
        address: address,
      );

      try {
        await _checkoutService.checkoutOrder(checkout);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaymentSuccessScreen()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order placed successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to place order')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your full name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                          onSaved: (value) => fullName = value!,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Phone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your phone number',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          onSaved: (value) => phone = value!,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          onSaved: (value) => email = value!,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Address',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your address',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                          onSaved: (value) => address = value!,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _confirmPayment,
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
      ),
    );
  }
}
