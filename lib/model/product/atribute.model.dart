import 'package:flutter/material.dart';

class Attribute {
  final String name;
  final int quantity; 
  final double price;
  final String image;

  Attribute({required this.name,required this.image,required this.price,required this.quantity});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      name: json['type_product'] ?? 'Unknown',
      quantity:json['quantity']?? 0,
      price:json['price'].toDouble() ?? 0.0,
      image: json['image'] ?? 'Unknow',
    );
  }
}
