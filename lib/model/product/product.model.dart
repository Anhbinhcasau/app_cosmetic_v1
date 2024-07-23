
import 'package:app_cosmetic/model/product/atribute.model.dart';
import 'package:app_cosmetic/model/product/comment.dart';
import 'package:http/http.dart';

class Product {
  late String? idPro;
  final String name;
  final String brand;
  final double price;
  final String description;
  final String material;
  final String category;
  final List<String> imageBase;
  final List<Attribute> attributes;
  final List<Comment> reviews;
  final int quantity;

  Product({
    this.idPro,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.material,
    required this.category,
    required this.imageBase,
    required this.attributes,
    required this.reviews,
    required this.quantity,
  });

  Map<String, dynamic> productJson() {
    return {
      '_id': idPro,
      'name': name,
      'brand': brand,
      'price': price,
      'description': description,
      'material': material,
      'category': category,
      'main_image': imageBase,
      'attributes': attributes
          .map((attribute) => {
                'type_product': attribute.name,
                'quantity': attribute.quantity,
                'price': attribute.price,
                'image': attribute.image,
              })
          .toList(),
      'comments': reviews
          .map((review) => {
                'userId': review.userId,
                'productId': review.productId,
                'date': review.date,
                'rating': review.rating,
                'comment': review.comment,
                'image': review.images,
              })
          .toList(),
      'quantity_sold': quantity,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idPro: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      brand: json['brand'] ?? 'Unknown',
      price: json['price']?.toDouble() ?? 0.0,
      description: json['description'] ?? 'No description',
      material: json['material'] ?? 'Unknown',
      category: json['category'] ?? 'Unknown',
      imageBase: List<String>.from(json['main_image'] ?? []),
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((attribute) => Attribute.fromJson(attribute))
              .toList() ??
          [],
      reviews: (json['comments'] as List<dynamic>?)
              ?.map((review) => Comment.fromJson(review))
              .toList() ??
          [],
      quantity: json['quantity_sold'] ?? 0,
    );
  }
}
