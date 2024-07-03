import 'package:app_cosmetic/screen/admin/comment/comment_thank.dart';
import 'package:app_cosmetic/screen/admin/comment/picker_image.dart';
import 'package:app_cosmetic/screen/productdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteComment extends StatefulWidget {
  const WriteComment({super.key});

  @override
  State<WriteComment> createState() => _WriteCommentState();
}

class _WriteCommentState extends State<WriteComment> {
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
            Text(
              "Chất lượng sản phẩm ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.center,
              child: RatingBar.builder(
                initialRating: 3.5,
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
                  print(rating);
                },
              ),
            ),
            PickerImage(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CommentThank()),
                  );
                },
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
