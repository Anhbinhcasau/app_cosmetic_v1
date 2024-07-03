import 'dart:convert';
import 'package:app_cosmetic/model/category.model.dart';
import 'package:flutter/services.dart' show rootBundle;


class CategoryService {
  Future<List<Category>> fetchCategorys() async {
    try {
      // Đọc nội dung của tệp từ tài nguyên nội bộ
      final response = await rootBundle.loadString('assets/category.js');
      
      // Giải mã dữ liệu JSON
      List<dynamic> data = json.decode(response);
      
      // Chuyển đổi dữ liệu thành danh sách các đối tượng Order
      List<Category> categories = data.map((item) => Category.fromJson(item)).toList();
      
      return categories;
    } catch (e) {
      throw Exception('Failed to load : $e');
    }
  }
}