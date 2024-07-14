class User {
  String id;
  String userName;
  String password;
  String email;
  String fullName;
  String avatar;
  String? address;
  bool active;
  String role;

  User({
    required this.id,
    required this.userName,
    required this.password,
    required this.email,
    this.fullName = 'Chưa đặt tên',
    this.avatar = 'https://simpleicon.com/wp-content/uploads/user1.png',
    this.address,
    this.active = true,
    this.role = 'user',
  });

  // Tạo một factory constructor để chuyển đổi từ JSON sang đối tượng User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      password: json['password'],
      email: json['email'],
      fullName: json['fullName'] ?? 'Chưa đặt tên',
      avatar: json['avatar'] ??
          'https://simpleicon.com/wp-content/uploads/user1.png',
      address: json['address'],
      active: json['active'] ?? true,
      role: json['role'] ?? 'user',
    );
  }

  // Chuyển đổi đối tượng User thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'email': email,
      'fullName': fullName,
      'avatar': avatar,
      'address': address,
      'active': active,
      'role': role,
    };
  }
}
