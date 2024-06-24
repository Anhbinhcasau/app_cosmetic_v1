class Product {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final double evaluate;
  final int reviews;
  final int sold;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.evaluate,
    required this.reviews,
    required this.sold,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      evaluate: json['evaluate'].toDouble(),
      reviews: json['reviews'],
      sold: json['sold'],
    );
  }
}