class User {
  String userName;
  String password;
  String email;
  String fullName;
  String avatar;
  String? address;

  User({
    required this.userName,
    required this.password,
    required this.email,
    this.fullName = 'Chưa đặt tên',
    this.avatar = 'https://simpleicon.com/wp-content/uploads/user1.png',
    this.address,
  });

  // Tạo một factory constructor để chuyển đổi từ JSON sang đối tượng User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'],
      password: json['password'],
      email: json['email'],
      fullName: json['fullName'] ?? 'Chưa đặt tên',
      avatar: json['avatar'] ??
          'https://simpleicon.com/wp-content/uploads/user1.png',
      address: json['address'],
    );
  }

  // Chuyển đổi đối tượng User thành JSON
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      'email': email,
      'fullName': fullName,
      'avatar': avatar,
      'address': address,
    };
  }
}
