import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:http/http.dart' as http;
import 'package:app_cosmetic/model/checkout.model.dart';

class CheckoutService {
  static Future<String> checkoutOrder(Checkout checkout) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.DB_URI}/checkout'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(checkout.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.statusCode.toString();
      } else {
        switch (response.statusCode) {
          case 400:
            throw Exception('Bad request: ${response.statusCode}');
          case 401:
            throw Exception('Unauthorized: ${response.statusCode}');
          case 403:
            throw Exception('Forbidden: ${response.statusCode}');
          case 404:
            throw Exception('Not found: ${response.statusCode}');
          case 500:
            throw Exception('Internal server error: ${response.statusCode}');
          default:
            throw Exception('Failed to checkout order: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error parsing response: $e');
      throw Exception('Failed to parse response');
    }
  }
}
