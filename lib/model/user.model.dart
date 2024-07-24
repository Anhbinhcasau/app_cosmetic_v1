import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class User {
  final String id;
  final String userName;
  final String password;
  final String email;
  final String fullName;
  final String avatar;
  final String address;
  final bool active;
  final String role;
  final List<Product> favorite;

  User({
    required this.id,
    required this.userName,
    required this.password,
    required this.email,
    this.fullName = 'Chưa đặt tên',
    this.avatar = 'https://simpleicon.com/wp-content/uploads/user1.png',
    this.address = 'Vô gia cư',
    required this.active,
    required this.role,
    this.favorite = const [],
  });

  // Tạo một factory constructor để chuyển đổi từ JSON sang đối tượng User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id']?.toString() ??
          '', // Chuyển đổi ObjectId thành String nếu cần
      userName: json['userName'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? 'Chưa đặt tên',
      avatar: json['avatar'] ??
          'https://simpleicon.com/wp-content/uploads/user1.png',
      address: json['address'] ?? 'Vô gia cư',
      active: json['active'] ?? true,
      role: json['role'] ?? 'user',
       favorite: (json['favorite'] as List<dynamic>?)
          ?.map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  // Chuyển đổi đối tượng User thành JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userName': userName,
      'password': password,
      'email': email,
      'fullName': fullName,
      'avatar': avatar,
      'address': address,
      'active': active,
      'role': role,
     'favorite': favorite
          .map((product) => product.productJson())
          .toList(), // Đảm bảo rằng danh sách yêu thích được đưa vào JSON
    };
  }
}
