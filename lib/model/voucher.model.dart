class VoucherDto {
  final String id;
  final int percent_sale;
  final List<String> userUsed;
  final String nameVoucher;
  final String description;
  final int maxPriceSale;
  final int quantity;
  final String codeVoucher;

  VoucherDto({
    required this.id,
    required this.percent_sale,
    required this.userUsed,
    required this.nameVoucher,
    required this.description,
    required this.maxPriceSale,
    required this.quantity,
    required this.codeVoucher,
  });

  factory VoucherDto.fromJson(Map<String, dynamic> json) {
    return VoucherDto(
      id: json['_id'],
      percent_sale: json['priceSale'] is double
          ? (json['priceSale'] as double).toInt()
          : json['priceSale'],
      userUsed: List<String>.from(json['userUsed']),
      nameVoucher: json['nameVoucher'],
      description: json['description'],
      maxPriceSale: json['maxPriceSale'] is double
          ? (json['maxPriceSale'] as double).toInt()
          : json['maxPriceSale'],
      quantity: json['quantity'],
      codeVoucher: json['codeVoucher'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'priceSale': percent_sale,
      'userUsed': userUsed,
      'nameVoucher': nameVoucher,
      'description': description,
      'maxPriceSale': maxPriceSale,
      'quantity': quantity,
      'codeVoucher': codeVoucher,
    };
  }
}
