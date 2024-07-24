import 'dart:io';
import 'package:app_cosmetic/model/product/comment.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:app_cosmetic/screen/user/cart/cart.dart';
import 'package:app_cosmetic/screen/user/comment/comment.dart';
import 'package:app_cosmetic/services/user_service.dart';
import 'package:app_cosmetic/widgets/products/product_card.dart';
import 'package:app_cosmetic/widgets/products/showbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/services/product_service.dart';
import 'package:app_cosmetic/widgets/appbar_home.dart';
import 'package:app_cosmetic/widgets/products/decription_text.dart';

class ProductDetail extends StatefulWidget {
  final String productId;

  ProductDetail({super.key, required this.productId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late Future<Product> products;
  late Product product;
  late String? userId;
  late List<Comment> comments;
  late Future<User?> user;
  Map<String, String> userNames = {};

  @override
  void initState() {
    super.initState();
    _getUserId();
    products = ProductService().getProductDetail(widget.productId);
    products.then((product) {
      comments = product.reviews ?? [];
      _getUserNames(comments); // Lấy tên người dùng cho các bình luận
    });
  }

  double _calculateAverageRating(List<Comment> comments) {
    if (comments.isEmpty) return 0.0;
    double totalRating =
        comments.fold(0, (sum, comment) => sum + comment.rating);
    return totalRating / comments.length;
  }

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
      print('User ID from SharedPreferences: $userId');
    });
  }

  Future<void> _getUserNames(List<Comment> comments) async {
    for (Comment comment in comments) {
      if (!userNames.containsKey(comment.userId)) {
        final User? user = await UserServices.getDetail(comment.userId);
        if (user != null) {
          setState(() {
            userNames[comment.userId] =
                user.userName; // Giả sử User model có thuộc tính name
          });
        }
      }
    }
  }

  String _formatMoney(double amount) {
    final formatter = NumberFormat.decimalPattern('vi_VN');
    return formatter.format(amount);
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
                double averageRating = _calculateAverageRating(product.reviews);

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
                      '${_formatMoney(product!.price)} đ',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${averageRating.toStringAsFixed(1)}/5',
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
                    MaterialPageRoute(
                        builder: (context) => CommentList(
                              comments: product.reviews ?? [],
                              idProduct: product.idPro,
                              idUser: userId,
                            )), // Đường dẫn mới cho CommentList và truyền danh sách bình luận
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
                    ...product.reviews!.take(1).map((comment) {
                      // Hiển thị chỉ hai bình luận đầu tiên
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userNames[comment.userId] ??
                                            comment
                                                .userId, // Hiển thị tên người dùng nếu có
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      AbsorbPointer(
                                        absorbing: true,
                                        child: RatingBar.builder(
                                          initialRating:
                                              comment.rating.toDouble(),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 1.0),
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
                                comment.comment,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            if (comment.images != null &&
                                comment.images!.isNotEmpty)
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: comment.images!.length,
                                itemBuilder: (context, index) {
                                  final imagePath = comment.images![index];
                                  return imagePath.startsWith('http')
                                      ? Image.network(
                                          imagePath,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(imagePath),
                                          fit: BoxFit.cover,
                                        );
                                },
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                );
              } else {
                return const Center(child: Text('No data found.'));
              }
            },
          ),
          Text(
            "Sản phẩm gợi ý ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ProductCard()
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
