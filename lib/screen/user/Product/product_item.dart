// Import các thư viện cần thiết, ví dụ như:
import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/screen/user/Product/product_view.dart';
import 'package:app_cosmetic/screen/user/Product/productdetail.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final productListViewModel = Provider.of<ProductListViewModel>(context);
    productListViewModel.getProductList();

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: SizedBox(
          // height: 1000,
          child: Consumer<ProductListViewModel>(
            builder: (context, productProvider, child) => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                mainAxisExtent: 300,
              ),
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                Product? product = productProvider.products[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetail(productId: product?.idPro ?? '')),
                    );
                  },
                  child: Container(
                    //height: 1000,
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
                                      //height: 130.0,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(product.imageBase[0]),
                                      height: 150.0,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                             : Placeholder(),  // Display a placeholder if the list is empty
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.grey.shade200.withOpacity(0.7),
                                      shape: BoxShape.circle,
                                    ),
                                    // child: IconButton(
                                    //   icon: const Icon(
                                    //     Icons.shopping_bag_outlined,
                                    //     color: Colors.black,
                                    //   ),
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ShoppingCartPage(),
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
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
}
