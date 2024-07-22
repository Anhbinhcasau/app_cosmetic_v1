class Checkout {
  String cartId;
  String userId;
  double totalPrice;
  String fullName;
  String email;
  String address;
  String phoneNumber;
  double? priceSale;
  double? percentSale;

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
      cartId: json['cartId'],
      userId: json['userId'],
      totalPrice: json['total_price'],
      fullName: json['full_name'],
      email: json['email'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      priceSale: json['price_sale'],
      percentSale: json['percent_sale'],
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
