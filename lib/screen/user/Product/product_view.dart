
import 'package:app_cosmetic/model/product/product.model.dart';

import 'package:app_cosmetic/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductListViewModel extends ChangeNotifier {
  List<Product?> products = [];
  Product? _product;

  Product? get product => _product;

   void  getProductList() async {
    try {
      products = await ProductService.fetchProducts();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }




}
