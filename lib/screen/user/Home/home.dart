import 'package:app_cosmetic/screen/user/cart/cart.dart';
import 'package:app_cosmetic/screen/user/Product/category.dart';
import 'package:app_cosmetic/screen/user/coupon/coupon.dart';
import 'package:app_cosmetic/screen/user/Product/productdetail.dart';
import 'package:app_cosmetic/screen/user/profile/profile_user.dart';
import 'package:app_cosmetic/widgets/appbar_home.dart';
import 'package:app_cosmetic/widgets/navbar_user.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
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

  final List<String> bannerImages = [
    'https://i.pinimg.com/564x/fd/eb/21/fdeb21f500f0305214d74f1dee813c7d.jpg',
    'https://i.pinimg.com/564x/01/cc/05/01cc0529b91c88759bcc9e98064458f8.jpg',
    'https://i.pinimg.com/564x/78/bd/88/78bd88af7a5e24fc9cdbebbbdbbf2c2a.jpg',
    'https://i.pinimg.com/564x/76/10/ab/7610ab20bec83a39dad2a27cc49cb73c.jpg',
  ];

  final List<String> brandImages = [
    'https://i.pinimg.com/564x/f8/1d/b3/f81db3b4c959e750381f01e2aeb330de.jpg',
    'https://i.pinimg.com/564x/c3/4e/f4/c34ef4c5b543e1701cc00adf40210b0f.jpg',
    'https://i.pinimg.com/564x/28/9e/1f/289e1f83727c48e2beb7e01a825e6d7f.jpg',
    'https://i.pinimg.com/564x/5e/18/4f/5e184f8a711ff50799360a625b423893.jpg',
  ];

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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Brand',
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: brandImages
                      .map((imgPath) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                // Thực hiện hành động khi người dùng nhấp vào ảnh
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    imgPath,
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Category',
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child:
                          CategoryChip(label: 'Kem chống nắng', selected: true),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CategoryChip(label: 'Trang điểm mặt'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CategoryChip(label: 'Sữa rửa mặt'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesScreen()),
                        );
                      },
                      child: Text('View all'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Best seller ',
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
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
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Product Collection',
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 400,
                child: SingleChildScrollView(
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  child: Image.network(
                                    product.imageUrl,
                                    height: 150.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    product.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        product.price,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                    Container()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;

  CategoryChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (bool value) {},
      selectedColor: Colors.orange[200],
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black,
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

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String description;

  ProductCard({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  imageUrl,
                  width: 260,
                  height: 180,
                  fit: BoxFit.cover,
                ),
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
                      Icons.favorite_border,
                      color: Colors.red.shade400,
                    ),
                    onPressed: () {
                      // Add to favorites action
                    },
                  ),
                ),
              )
            ],
          ),
          Container(
            width: 260,
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
                  name,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
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
        ],
      ),
    );
  }
}
