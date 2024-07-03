import 'package:app_cosmetic/model/product.model.dart';

class Order {
  final String id;
  final String userId;
  final List<Product> products;
  final double totalPrice;
  final String fullName;
  final String email;
  final String address;
  final int phoneNumber;
  final int status;
  final double priceSale;
  final double percentSale;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String paymentMethod;

  Order({
    required this.id,
    required this.userId,
    required this.products,
    required this.totalPrice,
    required this.fullName,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.status,
    required this.priceSale,
    required this.percentSale,
    required this.createdAt,
    required this.updatedAt,
    required this.paymentMethod,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<Product> products = (json['products'] as List<dynamic>).map<Product>((productJson) => Product.fromJson(productJson)).toList();
    return Order(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      products: products,
      totalPrice: json['total_price'].toDouble() ?? 0.0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? 0,
      status: json['status'] ?? 1,
      priceSale: json['price_sale'].toDouble() ?? 0.0,
      percentSale: json['percent_sale'].toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createAt']['\$date']),
      updatedAt: DateTime.parse(json['updateAt']['\$date']),
      paymentMethod: json['payment_method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'products': products.map((product) => product.toJson()).toList(),
      'total_price': totalPrice,
      'full_name': fullName,
      'email': email,
      'address': address,
      'phone_number': phoneNumber,
      'status': status,
      'price_sale': priceSale,
      'percent_sale': percentSale,
      'createAt': {'\$date': createdAt.toIso8601String()},
      'updateAt': {'\$date': updatedAt.toIso8601String()},
      'payment_method': paymentMethod,
    };
  }
}