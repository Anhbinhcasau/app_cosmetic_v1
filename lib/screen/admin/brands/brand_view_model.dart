import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/brand.model.dart';
import 'package:app_cosmetic/screen/brand/brand_service.dart';

class BrandListViewModel extends ChangeNotifier {
  List<Brand?> brands = [];

  // Fetch brands list asynchronously
   Future<void> fetchBrandsList() async {
    try {
      brands = await BrandService.fetchBrandList();
      notifyListeners(); 
    } catch (e) {
      print('Error fetching brands: $e');
    }
  }

  // Create a new brand asynchronously
  Future<void> createBrands(String name, String imagePath) async {
    try {

      if (imagePath.isEmpty) {
        print('Failed to upload image');
        return; 
      }
      final newBrand = await BrandService.createBrand(name, imagePath);

      if (newBrand != null) {
        brands.add(newBrand);
        notifyListeners();
        print('Brand created successfully');
      } else {
        print('Failed to create brand');
      }
    } catch (e) {
      print('Error creating brand: $e');
    }
  }

  // Update a brand asynchronously
  void setBrands(List<Brand?> brandList) {
    brands = brandList;
    notifyListeners();
  }

  Future<void> updateBrands(String id, String name, String imagePath) async {
    try {
      final updatedBrand = await BrandService.updateBrand(id, name, imagePath);

      if (updatedBrand != null) {
        int index = brands.indexWhere((brand) => brand?.id == id);
        if (index != -1) {
          brands[index] = updatedBrand;
          notifyListeners(); 
          print('Brand updated successfully');
        } else {
          print('Brand not found in the list');
        }
      } else {
        print('Failed to update brand');
      }
    } catch (e) {
      print('Error updating brand: $e');
      // Handle error if needed
    }
  }

  // Delete a brand asynchronously
  Future<bool> deleteBrand(String id) async {
    try {
      final isDeleted = await BrandService.deleteBrand(id);

      if (isDeleted) {
        brands.removeWhere((brand) => brand?.id == id);
        notifyListeners(); 
        print('Brand deleted successfully');
      } else {
        print('Failed to delete brand');
      }
      return isDeleted;
    } catch (e) {
      print('Error deleting brand: $e');
      return false;
    }
  }
}