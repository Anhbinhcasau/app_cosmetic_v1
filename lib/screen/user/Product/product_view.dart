import 'package:app_cosmetic/model/comment.model.dart';
import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/services/comment_service.dart';
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



  //  Future<Product> getProductDetail(String id) async {
  //   try {
  //     Product? product = await ProductService.getProductDetail(id);
  //     if (product != null) {
  //       _product = product;
  //       notifyListeners();
  //     } else {
  //       // Handle the case when the product is null.
  //       throw Exception('Product not found');
  //     }
  //   } catch (e) {
  //     // Handle any errors that occur during the fetch.
  //     print('Failed to load product: $e');
  //   }
  // }
}
