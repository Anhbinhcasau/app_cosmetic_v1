import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/screen/user/Product/product_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String _formatMoney(double amount) {
    final formatter = NumberFormat.decimalPattern('vi_VN');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final productListViewModel = Provider.of<ProductListViewModel>(context);
    productListViewModel.getProductList();

    return SizedBox(
      height: 330.0, // Adjust the height to fit the products
      child: Consumer<ProductListViewModel>(
        builder: (context, productProvider, child) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productProvider.products.length,
          itemBuilder: (context, index) {
            Product? product = productProvider.products[index];
            bool isFavorite = false; // Default value for favorite state

            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        child: product!.imageBase.isNotEmpty
                            ? product.imageBase[0].startsWith('http')
                                ? Image.network(
                                    product.imageBase[0],
                                    width: 200,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(product.imageBase[0]),
                                    width: 200,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  )
                            : Placeholder(), // Display a placeholder if the image URL is empty
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red.shade400,
                            ),
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                              // Add to favorites action
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: 200, // Adjust the width to match the parent width
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product?.name ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product?.price != null
                                    ? '${_formatMoney(product!.price)} đ'
                                    : '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  // Add to cart action
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
