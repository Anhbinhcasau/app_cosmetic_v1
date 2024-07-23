class Checkout {
  String cartId;
  String userId;
  int totalPrice;
  String fullName;
  String email;
  String address;
  String phoneNumber;
  int? priceSale;
  int? percentSale;

  Checkout({
    required this.cartId,
    required this.userId,
    required this.totalPrice,
    required this.fullName,
    required this.email,
    required this.address,
    required this.phoneNumber,
    this.priceSale,
    this.percentSale,
  });

  factory Checkout.fromJson(Map<String, dynamic> json) {
    return Checkout(
      cartId: json['cartId'] as String,
      userId: json['userId'] as String,
      totalPrice: json['total_price'] as int,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phoneNumber: json['phone_number'] as String,
      priceSale: json['price_sale'] ?? 0,
      percentSale: json['percent_sale'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'userId': userId,
      'total_price': totalPrice,
      'full_name': fullName,
      'email': email,
      'address': address,
      'phone_number': phoneNumber,
      'price_sale': priceSale,
      'percent_sale': percentSale,
    };
  }
}
