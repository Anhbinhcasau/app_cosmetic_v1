import 'package:app_cosmetic/screen/admin/comment/comment.dart';
import 'package:app_cosmetic/screen/cart.dart';
import 'package:app_cosmetic/screen/checkout.dart';
import 'package:app_cosmetic/widgets/admin_widgets/comment/rating_star.dart';
import 'package:app_cosmetic/widgets/admin_widgets/products/decription_text.dart';
import 'package:app_cosmetic/widgets/admin_widgets/products/product_card.dart';
import 'package:app_cosmetic/widgets/admin_widgets/products/showbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final List<Product> products = [
    Product(
      imageUrl:
          'https://i.pinimg.com/564x/e6/75/1b/e6751bb5a46ac866e8bea8848773dcb2.jpg',
      name: 'Granactive Retinoid 5%',
      price: '699 VND',
      description:
          'This water-free solution contains a 5% concentration of retinoid.',
    ),
    Product(
      imageUrl:
          'https://i.pinimg.com/564x/0c/8c/f6/0c8cf6a694d4eeb9a168740170af7f41.jpg',
      name: 'Granactive Retinoid 2%',
      price: '499 VND',
      description:
          'This water-free solution contains a 2% concentration of retinoid.',
    ),
    Product(
      imageUrl:
          'https://i.pinimg.com/736x/a6/9b/96/a69b969e541bf2acd971dd43090ce5c5.jpg',
      name: 'Granactive Retinoid 2%',
      price: '499 VND',
      description:
          'This water-free solution contains a 2% concentration of retinoid.',
    ),
    Product(
      imageUrl:
          'https://i.pinimg.com/564x/12/b4/3c/12b43c39dc7c8799bb40bb4bec702d62.jpg',
      name: 'Granactive Retinoid 2%',
      price: '499 VND',
      description:
          'This water-free solution contains a 2% concentration of retinoid.',
    ),
    Product(
      imageUrl:
          'https://i.pinimg.com/564x/87/47/c0/8747c00c9bc9cbbcbc466d97fe157d6b.jpg',
      name: 'Granactive Retinoid 2%',
      price: '499 VND',
      description:
          'This water-free solution contains a 2% concentration of retinoid.',
    ),
    // Add more products here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: Icon(Icons.shopping_bag),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          ImageSlideshow(
            height: 300,
            autoPlayInterval: null,
            indicatorColor: Colors.blue,
            onPageChanged: (value) {
              debugPrint('Page changed: $value');
            },
            isLoop: false,
            children: [
              Image.network(
                "https://media.hcdn.vn/catalog/product/f/a/facebook-dynamic-kem-duong-la-roche-posay-giup-phuc-hoi-da-da-cong-dung-40ml-1716439945_img_800x800_eb97c5_fit_center.jpg",
                fit: BoxFit.cover,
              ),
              Image.network(
                "https://media.hcdn.vn/catalog/product/p/r/promotions-auto-kem-duong-la-roche-posay-giup-phuc-hoi-da-da-cong-dung-40ml_2mALK46d83RhR9S2.png",
                fit: BoxFit.cover,
              ),
              Image.network(
                "https://media.hcdn.vn/catalog/product/k/e/kem-duong-la-roche-posay-giup-phuc-hoi-da-da-cong-dung-40ml-5-1716439966_img_800x800_eb97c5_fit_center.jpg",
                fit: BoxFit.cover,
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '256,000 VNĐ',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ],
          ),
          const Text(
            "Kem Dưỡng La Roche-Posay Giúp Phục Hồi Da Đa Công Dụng 40ml",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "4.9/5.0",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              const Text(
                "Đã bán 50",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          const Divider(),
          const Row(
            children: [
              Icon(
                Icons.verified_user,
                color: Colors.green,
              ),
              const Text(
                "Hàng chính hãng 100% ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                child: Text(
                  "|",
                ),
                width: 10,
              ),
              Icon(
                Icons.local_shipping,
                color: Colors.green,
              ),
              Text(
                "Giao hàng miễn phí ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Mô tả sản phẩm ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
              child: new DecriptionText(
                  text:
                      'Bắt đầu từ độ tuổi 25 trở đi,làn da của chúng ta bước vào thời kì lão hóa tự nhiên của cơ thể, cộng thêm những tác nhân gây hại từ bên ngoài như ánh nắng mặt trời & ô nhiễm môi trường, từ đó hình thành nên các dấu hiệu lão hóa da bao gồm: nếp nhăn và rãnh nhăn, vết thâm nám, da kém săn chắc, da sạm, tối xỉn & không đều màu, lỗ chân lông phình to…Thấu hiểu được mong muốn của chị em phụ nữ trong việc duy trì làn da tươi trẻ và mịn màng, Olay đã cho ra đời dòng sản phẩm Total Effects 7 in One giúp ngăn ngừa 7 dấu hiệu lão hóa của làn da. Đây sẽ là giải pháp lý tưởng dành cho những làn da ở độ tuổi trưởng thành, giúp cung cấp Vitamin và khoáng chất nhằm nuôi dưỡng làn da trong suốt cả ngày dài, mang lại làn da tươi trẻ và rạng rỡ hơn bao giờ hết.')),
          Divider(),
          ExpansionTileCard(
            title: const Text('Thành phần sản phẩm'),
            children: <Widget>[
              const Divider(
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile. Use me any time you think your app could benefit from being just a bit more Material.These buttons control the next card down!""",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 1.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Đánh giá sản phẩm ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                        icon: const Icon(Icons.chevron_right)),
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
                child: const Text('AH'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Text(
                      "Phạm Hà ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
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
                        itemBuilder: (context, _) => const Icon(
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
              // This next line does the trick.
              scrollDirection: Axis.horizontal,

              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(right: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                    'assets/instagram.png',
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(right: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                    'assets/instagram.png',
                  ),
                ),
              ],
            ),
          ),
          const Text(
            "Sản phẩm gợi ý ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: products
                  .map((product) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetail()),
                          );
                        },
                        child: ProductCard(
                          imageUrl: product.imageUrl,
                          name: product.name,
                          price: product.price,
                          description: product.description,
                        ),
                      ))
                  .toList(),
            ),
          ),
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
                  ////diều kiện nhé
                },
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return AddToCartSheet();
                      },
                    );
                  },
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
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
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutPage()),
                  );
                },
                child: Text(
                  'Mua ngay',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xFFA2AA7B)),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 15, horizontal: 40))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Product {
  final String imageUrl;
  final String name;
  final String price;
  final String description;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
  });
}
