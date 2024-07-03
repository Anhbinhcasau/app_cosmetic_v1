import 'package:app_cosmetic/model/comment.model.dart';
import 'package:app_cosmetic/services/comment_service.dart';
import 'package:flutter/material.dart';


class CommentListViewModel extends ChangeNotifier {
  List<Comment?> comments = [];
  List<Comment> images=[];
  void fetchProductList() async {
    comments = await CommentService.fetchProductList();
    notifyListeners();
  }
}
