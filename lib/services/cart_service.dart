import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/cart.model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  // Future<Cart?> getCartByUserId(String userId) async {
  //   final response =
  //       await http.get(Uri.parse('${Api.DB_URI}/cart/findCart/$userId'));

  //   if (response.statusCode == 200) {
  //     return Cart.fromJson(jsonDecode(response.body));
  //   } else {
  //     print('Failed to load cart');
  //     return null;
  //   }
  // }
  Future<Cart?> getCartByUserId(String userId) async {
    final response =
        await http.get(Uri.parse('${Api.DB_URI}/cart/findCart/$userId'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final cart = Cart.fromJson(jsonResponse);

      // Lưu _id vào SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('_id', jsonResponse['_id']);

      return cart;
    } else {
      print('Failed to load cart');
      return null;
    }
  }

  Future<Cart?> addToCart(ItemCart item) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    );
    print('Request body: ${jsonEncode(item.toJson())}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Cart.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to add item to cart');
      return null;
    }
  }

  Future<Cart?> updateItemInCart(Map<String, dynamic> infoUpdate) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/cart/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(infoUpdate),
    );

    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to update item in cart');
      return null;
    }
  }

  // Future<Cart?> removeItemFromCart(Map<String, dynamic> deleteItem) async {
  //   final response = await http.post(
  //     Uri.parse('${Api.DB_URI}/cart/delete'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(deleteItem),
  //   );

  //   if (response.statusCode == 200) {
  //     return Cart.fromJson(jsonDecode(response.body));
  //   } else {
  //     print('Failed to remove item from cart');
  //     return null;
  //   }
  // }

  Future<void> deleteItemCart(
      String userId, String cartId, Map<String, dynamic> product) async {
    final url = Uri.parse('${Api.DB_URI}/cart/deleteItemCart');
    final body = jsonEncode({
      'userId': userId,
      'cartId': cartId,
      'product': product,
    });

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Handle success response
      print('Item deleted successfully');
    } else {
      // Handle error response
      final error = jsonDecode(response.body);
      throw Exception('Failed to delete item: ${error['message']}');
    }
  }

  Future<Cart?> createNewCart(Map<String, dynamic> newCart) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/cart/newCart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newCart),
    );

    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to create new cart');
      return null;
    }
  }
}
