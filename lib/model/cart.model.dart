import 'package:flutter/material.dart';

class Cart {
  final String? cartId;
  String user;
  List<ItemCart> itemsCart;
  int countItemCart;
  double totalPriceCart;
  double? percentSale;
  double? priceSale;

  Cart({
    this.cartId,
    required this.user,
    required this.itemsCart,
    required this.countItemCart,
    required this.totalPriceCart,
    this.percentSale,
    this.priceSale,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items_cart'] as List;
    List<ItemCart> itemsCartList =
        itemsList.map((i) => ItemCart.fromJson(i)).toList();

    return Cart(
      cartId: json['_id'] ?? '',
      user: json['user'],
      itemsCart: itemsCartList,
      countItemCart: json['count_item_cart'],
      totalPriceCart: json['total_price_cart'].toDouble(),
      percentSale: json['percent_sale']?.toDouble(),
      priceSale: json['price_sale']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': cartId,
      'user': user,
      'items_cart': itemsCart.map((e) => e.toJson()).toList(),
      'count_item_cart': countItemCart,
      'total_price_cart': totalPriceCart,
      'percent_sale': percentSale,
      'price_sale': priceSale,
    };
  }
}

class ItemCart {
  String productId; // ID của sản phẩm
  int? id; // ID của mục giỏ hàng, thường được hệ thống quản lý giỏ hàng tạo ra
  String userId; // ID của người dùng
  String typeProduct; // Loại sản phẩm
  int quantity; // Số lượng sản phẩm
  double price; // Giá của sản phẩm
  String image; // Đường dẫn hình ảnh của sản phẩm

  ItemCart({
    required this.productId,
    this.id, // ID không bắt buộc khi tạo mới, nhưng cần thiết khi cập nhật hoặc xóa
    required this.userId,
    required this.typeProduct,
    required this.quantity,
    required this.price,
    required this.image,
  });

  factory ItemCart.fromJson(Map<String, dynamic> json) {
    return ItemCart(
      productId: json['productId'],
      id: json['id'], // Đọc ID từ JSON
      userId: json['userId'],
      typeProduct: json['type_product'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'id': id, // Gửi ID trong JSON
      'userId': userId,
      'type_product': typeProduct,
      'quantity': quantity,
      'price': price,
      'image': image,
    };
  }
}
