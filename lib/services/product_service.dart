// product_service.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:app_cosmetic/model/product.model.dart';

class ProductService {
  static Future<List<Product>> fetchProductList() async {
    // Đọc nội dung của tệp từ tài nguyên nội bộ
    final response = await rootBundle.loadString('assets/product.js');
    
    // Giải mã dữ liệu JSON
    List<dynamic> data = json.decode(response);
    
    // Chuyển đổi dữ liệu thành danh sách các đối tượng Product
    return data.map((item) => Product.fromJson(item)).toList();
  }
}
