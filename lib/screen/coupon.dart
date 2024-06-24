import 'package:app_cosmetic/screen/home.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CouponsScreen(),
    );
  }
}

class CouponsScreen extends StatefulWidget {
  @override
  _CouponsScreenState createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  final List<Map<String, String>> coupons = [
    {
      'code': 'WELCOME200',
      'condition': 'Add items worth \$2 more to unlock',
      'offer': 'Get 50% OFF'
    },
    {
      'code': 'CASHBACK12',
      'condition': 'Add items worth \$2 more to unlock',
      'offer': 'Up to \$12.00 cashback'
    },
    {
      'code': 'FEST2COST',
      'condition': 'Add items worth \$28 more to unlock',
      'offer': 'Get 50% OFF for Combo'
    },
    {
      'code': 'WELCOME2000',
      'condition': 'Add items worth \$2 more to unlock',
      'offer': 'Get 50% OFF'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coupon'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Best offers for you',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: coupons.length,
                itemBuilder: (context, index) {
                  final coupon = coupons[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coupon['code']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            coupon['condition']!,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            coupon['offer']!,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Handle copy code button press
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.brown,
                              backgroundColor: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              minimumSize: Size(double.infinity, 40),
                            ),
                            child: Text('COPY CODE'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
