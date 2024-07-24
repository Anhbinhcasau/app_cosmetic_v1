import 'package:app_cosmetic/data/config.app.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/product/product.model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'CHI TIẾT SẢN PHẨM',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Image.network(product.imageBase.first), // Assuming imageBase is a list
            const SizedBox(height: 10),
            Text(
              'Giá: ${product.price}đ',
              style: const TextStyle(fontSize: 17, color: AppColors.textHint),
            ),
            const SizedBox(height: 10),
            Text(
              'Số lượng: ${product.quantity}',
              style: const TextStyle(fontSize: 17, color: AppColors.textHint),
            ),
            // Add more product details here
          ],
        ),
      ),
    );
  }
}