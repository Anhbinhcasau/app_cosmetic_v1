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

  static Future<List<User?>> fetchUserList() async {
    try {
      final response = await http.get(Uri.parse('${Api.DB_URI}/user/list'));

      if (response.statusCode == 200) {
        // Parse JSON response
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        List<User> users =
            jsonResponse.map((item) => User.fromJson(item)).toList();

        return users;
      } else {
        print('Failed to load user list: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception while fetching user list: $e');
      return [];
    }
  }

  Future<User> changeProfileUser(User user) async {
    final url = Uri.parse('${Api.DB_URI}/user/edit');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update user profile');
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
