class Comment{
  final String id;
  final String idProduct;
  final String idUser;
  final double rating;
  final String comment;
  final List<String> image;
  final String date;
   Comment({
    required this.id,
    required this.idUser,
    required this.idProduct,
    required this.date,
    required this.rating,
    required this.comment,
    required this.image,
    
  });
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      idUser: json['idUser'],
      idProduct: json['idProduct'],
      date: json['date'],
      rating: json['rating'],
      comment: json['comment'],
      image: List<String>.from(json['image'])
      
    );
  }

}