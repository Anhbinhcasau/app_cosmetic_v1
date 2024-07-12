class Category {
  final String id;
  final String nameCate;
  final String image;

  Category({
    required this.id,
    required this.nameCate,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      nameCate: json['name'],
      image: json['logo']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': nameCate,
      'logo': image,
    };
  }
}