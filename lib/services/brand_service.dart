import 'dart:convert';
import 'package:app_cosmetic/model/brand.model.dart';
import 'package:flutter/services.dart' show rootBundle;


class BrandService {
  Future<List<Brand>> fetchBrands() async {
    try {
      // Đọc nội dung của tệp từ tài nguyên nội bộ
      final response = await rootBundle.loadString('assets/brand.js');
      
      // Giải mã dữ liệu JSON
      List<dynamic> data = json.decode(response);
      
      // Chuyển đổi dữ liệu thành danh sách các đối tượng Order
      List<Brand> brands = data.map((item) => Brand.fromJson(item)).toList();
      
      return brands;
    } catch (e) {
      throw Exception('Failed to load : $e');
    }
  }
}