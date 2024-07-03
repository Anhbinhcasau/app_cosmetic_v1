import 'dart:convert';
import 'package:app_cosmetic/model/product.model.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProductService {
  static Future<List<Product>> fetchProducts() async {
    try {
      // Đọc nội dung của tệp từ tài nguyên nội bộ
      final response = await rootBundle.loadString('assets/product.js');

      // Giải mã dữ liệu JSON
      List<dynamic> data = json.decode(response);

      // Chuyển đổi dữ liệu thành danh sách các đối tượng Order
      List<Product> products =
          data.map((item) => Product.fromJson(item)).toList();

      return products;
    } catch (e) {
      throw Exception('Failed to load : $e');
    }
  }
}
