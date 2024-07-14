import 'dart:convert';

import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:http/http.dart' as http;


class UserServices {
  static Future<User?> signUp(User data) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 202) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to Sign Up: ${response.statusCode}');
      return data;
    }
  }
}