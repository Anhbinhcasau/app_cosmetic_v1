import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_cosmetic/screen/admin/products/admin_product.dart';
import 'package:app_cosmetic/screen/user/Product/product_item.dart';
import 'package:app_cosmetic/widgets/appbar_home.dart';
import 'package:app_cosmetic/widgets/brand_widget.dart';
import 'package:app_cosmetic/widgets/category_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> bannerImages = [
    'https://i.pinimg.com/564x/fd/eb/21/fdeb21f500f0305214d74f1dee813c7d.jpg',
    'https://i.pinimg.com/564x/01/cc/05/01cc0529b91c88759bcc9e98064458f8.jpg',
    'https://i.pinimg.com/564x/78/bd/88/78bd88af7a5e24fc9cdbebbbdbbf2c2a.jpg',
    'https://i.pinimg.com/564x/76/10/ab/7610ab20bec83a39dad2a27cc49cb73c.jpg',
  ];

  String? userId;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarHome(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userId != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'User ID: $userId',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
              ),
              items: bannerImages.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            BorderRadius.circular(10.0), // Thêm border-radius
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10.0), // Thêm border-radius
                        child: Image.network(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            BrandWidget(),
            const SizedBox(height: 10),
            CategoryWidget(),
            ProductItem(),
          ],
        ),
      ),
    );
  }
}
