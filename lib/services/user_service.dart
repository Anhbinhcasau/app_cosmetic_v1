import 'dart:async';
import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static Future<User?> getDetail(String id) async {
    final response =
        await http.get(Uri.parse('${Api.DB_URI}/user/profileById/$id'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load detail user: ${response.statusCode}');
      return null;
    }
  }

  static Future<User?> updateFavorite(String userId, Product product) async {
    Map<String, dynamic> productJson = product.productJson();
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/user/favorite'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, ...productJson}),
    );

    if (response.statusCode == 200 || response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to update favorite: ${response.statusCode}');
      return null;
    }
  }
  static Future<User?> remove(String userId, Product product) async {
    Map<String, dynamic> productJson = product.productJson();
    final response = await http.delete(
      Uri.parse('${Api.DB_URI}/user/deletefavorite'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, ...productJson}),
    );

    if (response.statusCode == 200 || response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to update favorite: ${response.statusCode}');
      return null;
    }
  }
}
