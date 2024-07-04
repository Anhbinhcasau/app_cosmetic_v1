import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  bottomRight: Radius.circular(12),
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
