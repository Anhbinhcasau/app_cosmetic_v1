import 'dart:convert';
import 'dart:io';
import 'package:app_cosmetic/data/config.app.dart';
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
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to load product');
    }
  }

  static Future<Product> createProduct(Product product) async {
    print(product.name);
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

}
