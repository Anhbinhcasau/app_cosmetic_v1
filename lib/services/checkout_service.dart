import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:http/http.dart' as http;
import 'package:app_cosmetic/model/checkout.model.dart';

class CheckoutService {
  Future<void> checkoutOrder(Checkout checkout) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/checkout'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(checkout.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create checkout');
    }
  }
}
