import 'package:app_cosmetic/screen/cart.dart';
import 'package:app_cosmetic/screen/category.dart';
import 'package:app_cosmetic/screen/coupon.dart';
import 'package:app_cosmetic/screen/profile_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(
          // Changed to Poppins
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'The Ordinary',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCartPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Browse by categories',
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
                      child: CategoryChip(label: 'Trending', selected: true),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CategoryChip(label: 'New Products'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CategoryChip(label: 'Highly Rated'),
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CouponsScreen()),
                        );
                      },
                      child: Text('Coupon'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            ProductCard(
              imageUrl:
                  'https://edited.beautybay.com/wp-content/uploads/2023/01/1-EDITED-ARTICLE-1.jpg',
              name: 'Granactive Retinoid 5%',
              price: '₹699',
              description:
                  'This water-free solution contains a 5% concentration of retinoid.',
            ),
            ProductCard(
              imageUrl:
                  'https://product.hstatic.net/1000006063/product/bthe_2e4d05fa682a48e186a60839f42bd311_1024x1024.jpg',
              name: 'Granactive Retinoid 2%',
              price: '₹499',
              description:
                  'This water-free solution contains a 2% concentration of retinoid.',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Add to favorites action
                    },
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
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    price,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
