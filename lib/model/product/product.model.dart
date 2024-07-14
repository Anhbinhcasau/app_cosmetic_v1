import 'package:app_cosmetic/model/product/atribute.model.dart';

class Product {
  final String? idPro;
  final String name;
  final String brand;
  final double price;
  final String description;
  final String material;
  final String category;
  final List<String> imageBase;

  final List<Attribute> attributes;

  final int reviews;
  final int sold;
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
    required this.sold,
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
      'comments': reviews,
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

      reviews: json['reviews'] ?? 0,
      sold: json['sold'] ?? 0,
      quantity: json['quantity'] ?? 0,
    );
  }
  
}
