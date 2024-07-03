class Product {
  final String idPro;
  final String name;
  final String brand;
  final double price;
  final String description;
  final String category;
  final String imageBase;
  final List<String> imageDetail;
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
    required this.category,
    required this.imageBase,
    required this.imageDetail,
    required this.evaluate,
    required this.reviews,
    required this.sold,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idPro: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      imageBase: json['imageBase'],
      imageDetail: List<String>.from(json['imageDetail']),
      evaluate: json['evaluate'].toDouble(),
      reviews: json['reviews'],
      sold: json['sold'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idPro,
      'name': name,
      'brand': brand,
      'price': price,
      'description': description,
      'category': category,
      'imageBase': imageBase,
      'imageDetail': imageDetail,
      'evaluate': evaluate,
      'reviews': reviews,
      'sold': sold,
      'quantity': quantity,
    };
  }
}