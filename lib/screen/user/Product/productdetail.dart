import 'dart:convert';
import 'dart:io';
import 'package:app_cosmetic/model/cart.model.dart';
import 'package:app_cosmetic/model/product/atribute.model.dart';
import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/screen/user/Product/product_view.dart';
import 'package:app_cosmetic/screen/user/comment/comment.dart';
import 'package:app_cosmetic/screen/user/cart/cart.dart';
import 'package:app_cosmetic/screen/user/checkout/checkout.dart';
import 'package:app_cosmetic/services/cart_service.dart';
import 'package:app_cosmetic/services/product_service.dart';
import 'package:app_cosmetic/widgets/appbar_home.dart';
import 'package:app_cosmetic/widgets/products/decription_text.dart';
import 'package:app_cosmetic/widgets/products/product_card.dart';
import 'package:app_cosmetic/widgets/products/showbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetail extends StatefulWidget {
  final String productId;
  String? userId; // Thêm userId

  ProductDetail({super.key, required this.productId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late Future<Product> products;
  late Product product;
  String? userId;
  late Attribute attribute;
  @override
  void initState() {
    super.initState();
    _getUserId();
    products = ProductService().getProductDetail(widget.productId);
  }

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
      print('User ID from SharedPreferences: $userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarHome(),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          FutureBuilder<Product>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                product = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageSlideshow(
                      height: 300,
                      autoPlayInterval: null,
                      indicatorColor: Colors.blue,
                      onPageChanged: (value) {
                        debugPrint('Page changed: $value');
                      },
                      isLoop: false,
                      children: product.imageBase.map((imagePath) {
                        return imagePath.startsWith('http')
                            ? Image.network(
                                imagePath,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(imagePath),
                                fit: BoxFit.cover,
                              );
                      }).toList(),
                    ),
                    Text(
                      product.price.toStringAsFixed(3),
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "4.9/5.0",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        Text(
                          "Đã bán 50",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    Divider(),
                    const Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: Colors.green,
                        ),
                        Text(
                          "Hàng chính hãng 100% ",
                          style: TextStyle(fontSize: 15, color: Colors.green),
                        ),
                        SizedBox(
                          child: Text("|"),
                          width: 10,
                        ),
                        Icon(
                          Icons.local_shipping,
                          color: Colors.green,
                        ),
                        Text(
                          "Giao hàng miễn phí ",
                          style: TextStyle(fontSize: 15, color: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Mô tả sản phẩm ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: DecriptionText(
                        text: product.description,
                      ),
                    ),
                    Divider(),
                    ExpansionTileCard(
                      title: Text('Thành phần sản phẩm'),
                      children: <Widget>[
                        Divider(height: 1.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              product.material,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No data found.'));
              }
            },
          ),
          Divider(height: 1.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Đánh giá sản phẩm ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CommentList()),
                  );
                },
                child: Row(
                  children: [
                    const Text(
                      "Xem tất cả ",
                      style: TextStyle(fontSize: 17, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.grey,
                child: Text('AH'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    const Text(
                      "Phạm Hà ",
                      style: TextStyle(fontSize: 20),
                    ),
                    AbsorbPointer(
                      absorbing: true,
                      child: RatingBar.builder(
                        initialRating: 3.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Sản phẩm tốt",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/instagram.png',
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/instagram.png',
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Sản phẩm gợi ý ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: Colors.white,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return AddToCartSheet(
                        attributes: product.attributes,
                        product: product,
                        userId: userId ?? '',
                      );
                    },
                  );
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.add_shopping_cart,
                      size: 25,
                    ),
                    Text(
                      'Thêm vào giỏ hàng',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? userId = prefs.getString('userId');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoppingCartPage(
                        userId: userId ?? 'Null',
                      ),
                    ),
                  );
                },
                child: Text(
                  'Mua ngay',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color(0xFFA2AA7B)),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
