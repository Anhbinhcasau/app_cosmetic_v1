// product_service.dart
import 'dart:convert';
import 'package:app_cosmetic/model/comment.model.dart';
import 'package:flutter/services.dart' show rootBundle;


class CommentService {
  static Future<List<Comment>> fetchProductList() async {
    // Đọc nội dung của tệp từ tài nguyên nội bộ
    final response = await rootBundle.loadString('assets/comment.js');

    // Giải mã dữ liệu JSON
    List<dynamic> data = json.decode(response);

    // Chuyển đổi dữ liệu thành danh sách các đối tượng Product
    return data.map((item) => Comment.fromJson(item)).toList();
  }
}
