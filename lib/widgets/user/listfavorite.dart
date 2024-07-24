import 'dart:io';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:app_cosmetic/screen/user/Product/product_view.dart';
import 'package:app_cosmetic/screen/user/Product/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/services/user_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProductsScreen extends StatefulWidget {
  FavoriteProductsScreen({super.key});

  @override
  _FavoriteProductsScreenState createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  Future<User?>? futureUser;
  String? userId;

  Future<void> _removeToFavorites(String userId, String productId) async {
    try {
      // Lấy đối tượng Product từ danh sách sản phẩm
      final product = context.read<ProductListViewModel>().products.firstWhere(
            (product) => product!.idPro == productId,
            orElse: () => throw Exception('Product not found'),
          );

      // Gọi dịch vụ để cập nhật danh sách yêu thích
      await UserServices.remove(userId, product!);

      // Cập nhật dữ liệu người dùng để làm mới danh sách yêu thích
      setState(() {
        futureUser = UserServices.getDetail(userId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Sản phẩm đã được xóa khỏi danh sách yêu thích!',
            style: TextStyle(color: Colors.red, fontSize: 15),
          ),
        ),
      );
    } catch (e) {
      print('Error removing from favorites: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Không thể xóa sản phẩm khỏi danh sách yêu thích.'),
        ),
      );
    }
  }

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
      if (userId != null) {
        futureUser = UserServices.getDetail(userId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sản phẩm yêu thích'),
      ),
      body: futureUser == null
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<User?>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Có lỗi xảy ra: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('Không có sản phẩm yêu thích'));
                } else {
                  User user = snapshot.data!;
                  List<Product> favoriteProducts = user.favorite;

                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: favoriteProducts.length,
                    itemBuilder: (context, index) {
                      Product product = favoriteProducts[index];
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
                                child: product.imageBase.isNotEmpty
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
                                          '${_formatMoney(product.price)} đ',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.red.shade400,
                                          ),
                                          onPressed: () {
                                            if (userId != null) {
                                              _removeToFavorites(
                                                  userId!, product.idPro!);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Text(
                                      product.brand,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color(0xFF66BB6A),
                                      ),
                                    ),
                                    Text(
                                      product.name,
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
                  );
                }
              },
            ),
    );
  }
}
