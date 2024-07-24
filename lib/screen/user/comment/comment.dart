import 'dart:io';

import 'package:app_cosmetic/model/product/comment.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:app_cosmetic/screen/user/comment/write_comment.dart';
import 'package:app_cosmetic/services/user_service.dart';
import 'package:app_cosmetic/widgets/comment/rating_star.dart';
import 'package:flutter/material.dart';

class CommentList extends StatefulWidget {
  final List<Comment> comments;
  final String? idProduct;
  final String? idUser;

  const CommentList(
      {super.key,
      required this.comments,
      required this.idProduct,
      required this.idUser});

  @override
  State<CommentList> createState() => _CommentListState();
}

double _calculateAverageRating(List<Comment> comments) {
  if (comments.isEmpty) return 0.0;
  double totalRating = comments.fold(0, (sum, comment) => sum + comment.rating);
  return totalRating / comments.length;
}

class _CommentListState extends State<CommentList> {
  Map<String, String> userNames = {};

  Future<void> _fetchUserNames() async {
    for (var comment in widget.comments) {
      if (!userNames.containsKey(comment.userId)) {
        User? user = await UserServices.getDetail(comment.userId);
        if (user != null) {
          setState(() {
            userNames[comment.userId] = user.userName;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserNames();

    ;
  }

  @override
  Widget build(BuildContext context) {
    double averageRating = _calculateAverageRating(widget.comments);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Đánh giá',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  '${averageRating.toStringAsFixed(1)}/5',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: RatingStar(initialRating: averageRating),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tất cả(${widget.comments.length})',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Icon(Icons.filter_alt_outlined),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WriteComment(idProduct: widget.idProduct!)),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green[400], // foreground text
                side: BorderSide(color: Color.fromARGB(255, 112, 154, 49)),
                fixedSize: Size(300, 50),
              ),
              child: const Text(
                "Viết đánh giá",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: widget.comments.length,
              itemBuilder: (context, index) {
                Comment comment = widget.comments[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              userNames[widget.idUser].toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              ' ${comment.date}',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        RatingStar(initialRating: comment.rating),
                        SizedBox(height: 10),
                        Text(
                          '${comment.comment}',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 5),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 100, // Set a fixed height for the GridView
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: comment.images.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 5,
                            ),
                            itemBuilder: (context, imageIndex) {
                              final imagePath = comment.images![imageIndex];
                              return imagePath.startsWith('http')
                                  ? Image.network(
                                      imagePath,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(imagePath),
                                      fit: BoxFit.cover,
                                    );
                            },
                          ),
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
    );
  }
}
