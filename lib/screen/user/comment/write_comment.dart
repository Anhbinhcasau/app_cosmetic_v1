import 'dart:io';

import 'package:app_cosmetic/model/product/comment.dart';
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

  void _submitReview() async {
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
      
      await ProductService.commentProduct(newComment);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CommentThank()),
      );
    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bạn đã bình luận sản phẩm này rồi.')),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
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
            PickerImage(onImagesSelected: (images) {
              setState(() {
                _selectedImages = images;
              });
            }),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
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
            ),
            Spacer(),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 40),
              decoration: BoxDecoration(
                color: const Color(0xFFA2AA7B),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 52,
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
    );
  }
}
