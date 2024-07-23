import 'package:app_cosmetic/model/cart.model.dart';

class Order {
  final String id;
  final String userId;
  final List<ItemCart> products;
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
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      products: (json['products'] as List<dynamic>?)
              ?.map((productJson) => ItemCart.fromJson(productJson))
              .toList() ??
          [],
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0.0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: (json['phone_number'] as int?) ?? 0,
      status: (json['status'] as int?) ?? 1,
      priceSale: (json['price_sale'] as num?)?.toDouble() ?? 0.0,
      percentSale: (json['percent_sale'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createAt']),
      updatedAt: DateTime.parse(json['updateAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'products': products
          .map((products) => {
                'productId': products.productId,
                'id': products.id,
                'userId': products.userId,
                'type_product': products.typeProduct,
                'quantity': products.quantity,
                'price': products.price,
                'image': products.image,
              })
          .toList(),
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
    };
  }
}
