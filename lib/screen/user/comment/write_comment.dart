import 'dart:io';

import 'package:app_cosmetic/model/product/comment.dart';
import 'package:app_cosmetic/screen/user/Home/home.dart';
import 'package:app_cosmetic/screen/user/comment/comment.dart';
import 'package:app_cosmetic/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/screen/user/comment/comment_thank.dart';
import 'package:app_cosmetic/screen/user/comment/picker_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WriteComment extends StatefulWidget {
  final String idProduct;

  const WriteComment({super.key, required this.idProduct});

  @override
  State<WriteComment> createState() => _WriteCommentState();
}

class _WriteCommentState extends State<WriteComment> {
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  List<String> _selectedImages = [];

  String? userId;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    String currentDate = DateTime.now().toLocal().toString().split(' ')[0];

    try {
      Comment newComment = Comment(
        productId: widget.idProduct,
        userId: userId!,
        comment: _reviewController.text,
        rating: _rating,
        date: currentDate,
        images: _selectedImages,
      );

      final res = await ProductService.commentProduct(newComment);
      if (res == 'done') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã gửi comment')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CommentThank()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không thể viết comment')),
        );
      }
    } on Exception catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.startsWith('Exception: ')) {
        errorMessage =
            errorMessage.substring(11); // Remove 'Exception: ' from the message
      }

      // Hiển thị thông báo lỗi
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Lỗi!!!',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: Text('Trang chủ'),
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Viết đánh giá"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Chất lượng sản phẩm",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              PickerImage(onImagesSelected: (images) {
                setState(() {
                  _selectedImages = images;
                });
              }),
              SizedBox(height: 20),
              TextField(
                controller: _reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Nhập cảm nhận của bạn...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 52,
                margin: EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFFA2AA7B),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: _submitReview,
                  child: const Text(
                    'Gửi đánh giá',
                    style: TextStyle(fontSize: 22, color: Colors.white),
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
