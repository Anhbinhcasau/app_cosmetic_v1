import 'package:app_cosmetic/model/category.model.dart';
import 'package:app_cosmetic/services/category_service.dart';
import 'package:flutter/material.dart';


class CategoryListViewModel extends ChangeNotifier {
  List<Category?> categories = [];
  CategoryService _categoriesService = CategoryService();

  Future<void> fetchCategoriesList() async {
    try {
      categories = await _categoriesService.fetchCategorys();
      notifyListeners();
    } catch (e) {
      print('Error fetching orders: $e');
      // Xử lý lỗi nếu cần thiết
    }
  }
}