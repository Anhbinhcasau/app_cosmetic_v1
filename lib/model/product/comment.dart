class Comment {
  String userId;
  String productId;
  String date;
  double rating;
  String comment;
  List<String> images;

  Comment({
    required this.userId,
    required this.productId,
    required this.date,
    required this.rating,
    required this.comment,
    required this.images,
  });

  // Factory constructor to create a Comment object from a JSON map
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['userId'] ?? "null",
      productId: json['productId'] ?? 'null',
      date: json['date'] ?? 'null',
      rating: json['rating'].toDouble() ?? 0.0,
      comment: json['comment'] ?? 'null',
      images: List<String>.from(json['image']),
    );
  }

  // Method to convert a Comment object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'date': date,
      'rating': rating,
      'comment': comment,
      'image': images,
    };
  }
}
