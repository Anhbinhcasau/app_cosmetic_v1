import 'package:app_cosmetic/model/category.model.dart';
import 'package:app_cosmetic/services/category_service.dart';
import 'package:flutter/material.dart';


class CategoryListViewModel extends ChangeNotifier {
  List<Category?> categories = [];
  
  // Fetch brands list asynchronously
  Future<void> getCategoriesList() async {
    try {
      categories = await CategoryService.fetchCategoryList();
      notifyListeners(); 
    } catch (e) {
      print('Error fetching category: $e');
    }
  }

  // Create a new brand asynchronously
  Future<void> addCategories(String name, String imagePath) async {
    try {

      if (imagePath.isEmpty) {
        print('Failed to upload image');
        return; 
      }
      final newCategory = await CategoryService.createCategory(name, imagePath);

      if (newCategory != null) {
        categories.add(newCategory);
        notifyListeners();
        print('Category created successfully');
      } else {
        print('Failed to create category');
      }
    } catch (e) {
      print('Error creating category: $e');
    }
  }

  // Update a brand asynchronously
  void setCategories(List<Category?> categoryList) {
    categories = categoryList;
    notifyListeners();
  }

  Future<void> editCategories(String id, String name, String imagePath) async {
    try {
      final updatedCategory = await CategoryService.updateCategory(id, name, imagePath);

      if (updatedCategory != null) {
        int index = categories.indexWhere((cate) => cate?.id == id);
        if (index != -1) {
          categories[index] = updatedCategory;
          notifyListeners(); 
          print('Category updated successfully');
        } else {
          print('Category not found in the list');
        }
      } else {
        print('Failed to update category');
      }
    } catch (e) {
      print('Error updating category: $e');
      // Handle error if needed
    }
  }

  // Delete a brand asynchronously
  Future<bool> deleteCategory(String id) async {
    try {
      final isDeleted = await CategoryService.deleteCategory(id);

      if (isDeleted) {
        categories.removeWhere((cate) => cate?.id == id);
        notifyListeners(); 
        print('category deleted successfully');
      } else {
        print('Failed to delete category');
      }
      return isDeleted;
    } catch (e) {
      print('Error deleting category: $e');
      return false;
    }
  }
}