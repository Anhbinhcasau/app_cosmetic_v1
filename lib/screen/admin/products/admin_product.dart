import 'dart:io';

import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/screen/admin/products/addproduct.dart';
import 'package:app_cosmetic/screen/admin/products/updateproduct.dart';
import 'package:app_cosmetic/screen/user/Product/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final productListViewModel = Provider.of<ProductListViewModel>(context);
    productListViewModel.getProductList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF13131A),
        title: const Text(
          'SẢN PHẨM',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateProductPage()));
              },
              icon: Icon(
                Icons.add_circle_outline,
                size: 40,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: SingleChildScrollView(
          child: Consumer<ProductListViewModel>(
            builder: (context, productProvider, child) => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                Product? product = productProvider.products[index];
                return InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           Pro(productId: product?.idPro ?? '')),
                    // );
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
                                      //height: 150.0,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(product.imageBase[0]),
                                      height: 150.0,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                              : Placeholder(), // Display a placeholder if the list is empty
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product?.name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product?.price != null
                                        ? '${_formatMoney(product!.price.toInt())}'
                                        : '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.grey.shade200.withOpacity(0.7),
                                      shape: BoxShape.circle,
                                    ),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12.0), // Bo góc nút
                                        ),
                                      ),
                                      child: Text(
                                        "Cập nhật",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdateProduct(
                                              productToEdit: product,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
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
          ),
        ),
      ),
    );
  }
   String _formatMoney(int amount) {
    final formatter = NumberFormat.decimalPattern('vi_VN');
    return formatter.format(amount);
  }
}
