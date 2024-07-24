import 'dart:io';

import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:app_cosmetic/screen/user/Product/product_view.dart';
import 'package:app_cosmetic/screen/user/Product/productdetail.dart';
import 'package:app_cosmetic/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late String? userId;
  late Product product;
  bool isFavorite = false; // Thêm trạng thái yêu thích

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  String _formatMoney(double amount) {
    final formatter = NumberFormat.decimalPattern('vi_VN');
    return formatter.format(amount);
  }

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
      print('User ID from SharedPreferences: $userId');
    });
  }

  Future<void> _addToFavorites(String userId, String productId) async {
    try {
      // Lấy đối tượng Product từ danh sách sản phẩm
      final product = context.read<ProductListViewModel>().products.firstWhere(
            (product) => product!.idPro == productId,
            orElse: () => throw Exception('Product not found'),
          );

      // Gọi dịch vụ để cập nhật danh sách yêu thích
      await UserServices.updateFavorite(userId, product!);

      setState(() {
        isFavorite = !isFavorite; // Cập nhật trạng thái yêu thích
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Sản phẩm  đã được thêm vào danh sách yêu thích!',
            style: TextStyle(color: Colors.red, fontSize: 15),
          ),
        ),
      );
    } catch (e) {
      print('Error adding to favorites: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Không thể thêm sản phẩm vào danh sách yêu thích.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final productListViewModel = Provider.of<ProductListViewModel>(context);
    productListViewModel.getProductList();

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: SizedBox(
          child: Consumer<ProductListViewModel>(
            builder: (context, productProvider, child) => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                mainAxisExtent: 320,
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
                            ProductDetail(productId: product?.idPro ?? ''),
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
                              ? product!.imageBase[0].startsWith('http')
                                  ? Image.network(
                                      product!.imageBase[0],
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(product!.imageBase[0]),
                                      height: 150.0,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                              : Placeholder(),
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
                                        ? '${_formatMoney(product!.price)} đ'
                                        : '',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      //Icons.favorite,
                                      Icons.favorite_border,
                                      color: Colors.red.shade400,
                                    ),
                                    onPressed: () {
                                      if (userId != null) {
                                        _addToFavorites(
                                            userId!, product!.idPro!);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                product?.brand ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF66BB6A),
                                ),
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
