import 'dart:io';
import 'package:app_cosmetic/screen/user/Product/product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/screen/user/Product/productdetail.dart';

class Productlistbrand extends StatelessWidget {
  final String brandName;

  const Productlistbrand({super.key, required this.brandName});

  @override
  Widget build(BuildContext context) {
    final productListViewModel = Provider.of<ProductListViewModel>(context);
    productListViewModel.getProductList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Thương hiệu $brandName'),
      ),
      body: Consumer<ProductListViewModel>(
        builder: (context, productProvider, child) {
          // Filter products by brand
          final filteredProducts = productProvider.products
              .where((product) => product!.brand == brandName)
              .toList();

          if (filteredProducts.isEmpty) {
            return Center(
              child: Text('No products found for this brand.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                mainAxisExtent: 300,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                Product? product = filteredProducts[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetail(productId: product.idPro ?? ''),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: product!.imageBase.isNotEmpty
                              ? product.imageBase[0].startsWith('http')
                                  ? Image.network(
                                      product.imageBase[0],
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(product.imageBase[0]),
                                      height: 150.0,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                              : const Placeholder(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product?.price != null
                                        ? '${product!.price.toStringAsFixed(3)} đ'
                                        : '',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Đã bán ${product.quantity.toString()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text(
                                product?.brand ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF66BB6A)),
                              ),
                              Text(
                                product?.name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
