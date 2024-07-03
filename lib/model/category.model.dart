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
      id: json['id'],
      nameCate: json['cate'],
      image: json['image']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cate': nameCate,
      'image': image,
    };
  }
}