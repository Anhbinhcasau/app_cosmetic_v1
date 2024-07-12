import 'package:app_cosmetic/screen/user/Product/productdetail.dart';
import 'package:flutter/material.dart';

class CommentThank extends StatefulWidget {
  const CommentThank({super.key});

  @override
  State<CommentThank> createState() => _CommentThankState();
}

class _CommentThankState extends State<CommentThank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Color(0xFFA2AA7B),
          title: Text(
        'Đánh giá ',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Text(
              textAlign: TextAlign.center,
              "Cảm ơn bạn đã sử dụng dịch vụ này ",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Image.asset(
            'assets/thank_you.png',
            width: 100,
            height: 100,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 30, right: 30, top: 80),
            decoration: BoxDecoration(
              color: const Color(0xFFA2AA7B),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 52,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductDetail()),
                );
              },
              child: const Text(
                'Trang chủ',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
