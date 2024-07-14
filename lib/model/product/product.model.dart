import 'package:app_cosmetic/model/product/atribute.model.dart';

class Product {
  final String idPro;
  final String name;
  final String brand;
  final double price;
  final String description;
  final String material;
  final String category;
  final List<String> imageBase;
  final List<String> imageDetail;
  final List<Attribute> attributes;
  final double evaluate;
  final int reviews;
  final int sold;
  final int quantity;

  Product({
    required this.idPro,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.material,
    required this.category,
    required this.imageBase,
    required this.imageDetail,
    required this.attributes,
    required this.evaluate,
    required this.reviews,
    required this.sold,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idPro: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      brand: json['brand'] ?? 'Unknown',
      price: json['price']?.toDouble() ?? 0.0,
      description: json['description'] ?? 'No description',
      material: json['material'] ?? 'Unknown',
      category: json['category'] ?? 'Unknown',
      imageBase:List<String>.from(json['main_image'] ?? []),
      imageDetail: List<String>.from(json['imageDetail'] ?? []),
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((attribute) => Attribute.fromJson(attribute))
              .toList() ??
          [],
      evaluate: json['evaluate']?.toDouble() ?? 0.0,
      reviews: json['reviews'] ?? 0,
      sold: json['sold'] ?? 0,
      quantity: json['quantity'] ?? 0,
    );
  }
}
