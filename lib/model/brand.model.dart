class Brand {
  final String id;
  final String brand;
  final String image;

  Brand({
    required this.id,
    required this.brand,
    required this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      brand: json['brand'],
      image: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'img': image,
    };
  }
}