import 'package:app_cosmetic/widgets/admin_widgets/comment/comment_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_cosmetic/model/comment.model.dart';
import 'package:app_cosmetic/screen/user/comment/write_comment.dart';
import 'package:app_cosmetic/widgets/admin_widgets/comment/rating_star.dart';

class CommentList extends StatefulWidget {
  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    final commentListViewModel = Provider.of<CommentListViewModel>(context);
    commentListViewModel.fetchProductList();

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
                  '4.0/5',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: RatingStar(initialRating: 4),
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
                  'Tất cả(3)',
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
                  MaterialPageRoute(builder: (context) => WriteComment()),
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
            child: Consumer<CommentListViewModel>(
              builder: (context, value, child) => ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: value.comments.length,
                itemBuilder: (context, index) {
                  Comment? comment = value.comments[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingStar(initialRating: comment?.rating ?? 0),
                          SizedBox(height: 5),
                          Text('Comment: ${comment?.comment}'),
                          SizedBox(height: 5),
                          Text('Date: ${comment?.date}'),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 100, // Set a fixed height for the GridView
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: comment?.image.length ?? 0,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 5,
                              ),
                              itemBuilder: (context, imageIndex) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Image.network(
                                    comment?.image[imageIndex] ?? '',
                                    fit: BoxFit.cover,
                                  ),
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
          ),
        ],
      ),
    );
  }
}
