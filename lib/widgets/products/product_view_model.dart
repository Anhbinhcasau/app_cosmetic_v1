// product_view_model.dart
import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/product.model.dart';
import 'package:app_cosmetic/services/product_service.dart';

class ProductListViewModel extends ChangeNotifier {
  List<Product?> products = [];

  void fetchProductList() async {
    products = await ProductService.fetchProductList();
    notifyListeners();
  }
}