import 'package:app_cosmetic/model/brand.model.dart';
import 'package:app_cosmetic/services/brand_service.dart';
import 'package:flutter/material.dart';


class BrandListViewModel extends ChangeNotifier {
  List<Brand?> brands = [];
  BrandService _brandsService = BrandService();

  Future<void> fetchBrandsList() async {
    try {
      brands = await _brandsService.fetchBrands();
      notifyListeners();
    } catch (e) {
      print('Error fetching orders: $e');
      // Xử lý lỗi nếu cần thiết
    }
  }
}