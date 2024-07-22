import 'dart:convert';
import 'dart:io';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/product/comment.dart';
import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<Product>> fetchProducts() async {
    // Đọc nội dung của tệp từ tài nguyên nội bộ

    var url = Uri.parse("${Api.DB_URI}/product/list");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // Giải mã dữ liệu JSON
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);

      // If the server did return a 200 OK response,
      // then parse the JSON.
      return body.map((e) => Product.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load product');
    }
  }

  Future<Product> getProductDetail(String id) async {
    var url = Uri.parse("${Api.DB_URI}/product/$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final product = Product.fromJson(data);
      print(product.material);
      return product;
    } else {
      throw Exception('Failed to load product');
    }
  }

  static Future<Product> createProduct(Product product) async {
    print(product.material);
    try {
      var url = Uri.parse("${Api.DB_URI}/product");
      Map<String, dynamic> productJson = product.productJson();
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(productJson));
      if (response.statusCode == 201) {
        // If the server returns a created response, parse the JSON
        return Product.fromJson(jsonDecode(response.body));
      } else {
        // If the server does not return a created response, throw an exception
        throw Exception(
            'Failed to create product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create product. Error: $e');
    }
  }

  static Future<Product> updateProduct(Product product) async {
    print(product.material);
    try {
      var url = Uri.parse("${Api.DB_URI}/product/updateProduct");
      Map<String, dynamic> productJson = product.productJson();
      final response = await http.put(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(productJson));
      if (response.statusCode == 200) {
        // If the server returns a created response, parse the JSON
        return Product.fromJson(jsonDecode(response.body));
      } else {
        // If the server does not return a created response, throw an exception
        throw Exception(
            'Failed to update product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to update product. Error: $e');
      throw Exception('Failed to update product. Error: $e');
    }
  }

  static Future<void> deleteProduct(String productId) async {
    try {
      var url = Uri.parse("${Api.DB_URI}/product/$productId");

      final response =
          await http.delete(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        // Nếu máy chủ trả về mã trạng thái 200 (OK), không cần phân tích JSON
        print('Product deleted successfully.');
      } else {
        // Nếu máy chủ không trả về mã trạng thái 200, ném ngoại lệ
        throw Exception(
            'Failed to delete product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to delete product. Error: $e');
      throw Exception('Failed to delete product. Error: $e');
    }
  }
  static Future<void> commentProduct(Comment comment) async {
    try {
      var url = Uri.parse("${Api.DB_URI}/product/comment");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(comment.toJson()),
      );

      if (response.statusCode == 200) {
        print('Comment posted successfully.');
      } else {
        throw Exception(
            'Failed to comment product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to post comment. Error: $e');
    }
  }
}
