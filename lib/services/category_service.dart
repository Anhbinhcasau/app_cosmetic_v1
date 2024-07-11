import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/category.model.dart';
import 'package:app_cosmetic/widgets/admin_widgets/categories/category_view_model.dart';
import 'package:http/http.dart' as http;


class CategoryService {
  static Future<List<Category>> fetchCategoryList() async {
    CategoryListViewModel categoryListViewModel = CategoryListViewModel();
    try {
      final response = await http.get(Uri.parse('${Api.DB_URI}/category'));

      if (response.statusCode == 200) {
        // Parse JSON response
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Category> category =
            jsonResponse.map((item) => Category.fromJson(item)).toList();

        // Update the brand list in BrandListViewModel
        categoryListViewModel.categories = category;
        categoryListViewModel.notifyListeners(); 

        print('done $category');
        return category;
      } else {
        print('Failed to load category list: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception while fetching category list: $e');
      return [];
    }
  }

  static Future<Category?> createCategory(String name, String image) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/category'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'logo': image}),
    );

    if (response.statusCode == 201) {
      return Category.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to create category: ${response.statusCode}');
      return null;
    }
  }

  static Future<Category?> fetchCategoryById(String id) async {
    final response = await http.get(Uri.parse('${Api.DB_URI}/category/$id'));

    if (response.statusCode == 200) {
      return Category.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load category: ${response.statusCode}');
      return null;
    }
  }

  static Future<bool> deleteCategory(String id) async {
    final response = await http.delete(Uri.parse('${Api.DB_URI}/category/$id'));

    return response.statusCode == 200;
  }

  static Future<Category?> updateCategory(String id, String name, String imagePath) async {

    final response = await http.put(
      Uri.parse('${Api.DB_URI}/category/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'logo': imagePath,
      }),
    );

    if (response.statusCode == 200) {
      return Category.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to update category. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  }
}