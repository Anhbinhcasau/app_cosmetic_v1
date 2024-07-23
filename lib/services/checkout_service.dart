import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:http/http.dart' as http;
import 'package:app_cosmetic/model/checkout.model.dart';

class CheckoutService {
  Future<String> checkoutOrder(Checkout checkout) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/checkout'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(checkout.toJson()),
    );

    print('Response body: ${response.body}');

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);

        // Kiểm tra các trường có thể bị null
        final userId = responseData['userId'];
        final products = responseData['products'];
        final totalPrice = responseData['total_price'];
        final fullName = responseData['full_name'];
        final email = responseData['email'];
        final address = responseData['address'];
        final phoneNumber = responseData['phone_number'];
        final status = responseData['status'];
        final priceSale = responseData['price_sale'];
        final percentSale = responseData['percent_sale'];

        // In giá trị các trường
        print('userId: $userId');
        print('products: $products');
        print('totalPrice: $totalPrice');
        print('fullName: $fullName');
        print('email: $email');
        print('address: $address');
        print('phoneNumber: $phoneNumber');
        print('status: $status');
        print('priceSale: $priceSale');
        print('percentSale: $percentSale');

        return Checkout.fromJson(responseData).toString();
      } else {
        // Xử lý các mã trạng thái khác nhau
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
