import 'dart:convert';
import 'package:app_cosmetic/screen/admin/brands/brand_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/brand.model.dart';

class BrandService {
  static Future<List<Brand>> fetchBrandList() async {
    try {
      final response = await http.get(Uri.parse('${Api.DB_URI}/brand'));

      if (response.statusCode == 200) {
        // Parse JSON response
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Brand> brands =
            jsonResponse.map((item) => Brand.fromJson(item)).toList();

        print('done $brands');
        return brands;
      } else {
        print('Failed to load brand list: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception while fetching brand list: $e');
      return [];
    }
  }

  static Future<Brand?> createBrand(String name, String image) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/brand'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'image': image}),
    );

    if (response.statusCode == 201) {
      return Brand.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to create brand: ${response.statusCode}');
      return null;
    }
  }

  static Future<Brand?> fetchBrandById(String id) async {
    final response = await http.get(Uri.parse('${Api.DB_URI}/brand/$id'));

    if (response.statusCode == 200) {
      return Brand.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load brand: ${response.statusCode}');
      return null;
    }
  }

  static Future<bool> deleteBrand(String id) async {
    final response = await http.delete(Uri.parse('${Api.DB_URI}/brand/$id'));

    return response.statusCode == 200;
  }

  static Future<Brand?> updateBrand(
      String id, String name, String imagePath) async {
    final response = await http.put(
      Uri.parse('${Api.DB_URI}/brand/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'image': imagePath,
      }),
    );

    if (response.statusCode == 200) {
      return Brand.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to update brand. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  }
}
