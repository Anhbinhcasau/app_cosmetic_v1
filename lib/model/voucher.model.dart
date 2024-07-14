class VoucherDto {
  final double priceSale;
  final List<String> userUsed;
  final String nameVoucher;
  final String description;
  final double maxPriceSale;
  final int quantity;
  final String codeVoucher;

  VoucherDto({
    required this.priceSale,
    required this.userUsed,
    required this.nameVoucher,
    required this.description,
    required this.maxPriceSale,
    required this.quantity,
    required this.codeVoucher,
  });

  factory VoucherDto.fromJson(Map<String, dynamic> json) {
    return VoucherDto(
      priceSale: json['priceSale'].toDouble(),
      userUsed: List<String>.from(json['userUsed']),
      nameVoucher: json['nameVoucher'],
      description: json['description'],
      maxPriceSale: json['maxPriceSale'].toDouble(),
      quantity: json['quantity'],
      codeVoucher: json['codeVoucher'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'priceSale': priceSale,
      'userUsed': userUsed,
      'nameVoucher': nameVoucher,
      'description': description,
      'maxPriceSale': maxPriceSale,
      'quantity': quantity,
      'codeVoucher': codeVoucher,
    };
  }
}
