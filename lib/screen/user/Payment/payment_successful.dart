import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/screen/user/Home/home.dart';
import 'package:app_cosmetic/screen/user/profile/process_oder.dart';
import 'package:app_cosmetic/screen/user/profile/profile_user.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentSuccessScreen(),
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () {
      //       // Xử lý khi nhấn nút quay lại
      //     },
      //   ),
      //   title: Text('Payment', style: TextStyle(color: Colors.black)),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 100,
          ),
          SizedBox(height: 20),
          Text(
            'Order Successful!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Thank you for your purchase.',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.text_notification,
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('View Order',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.text,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
