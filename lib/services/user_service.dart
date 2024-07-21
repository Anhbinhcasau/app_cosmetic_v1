import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:http/http.dart' as http;


class UserServices {

  static Future<User?> signUp(User user) async {
    Map<String, dynamic> userJson = user.toJson();
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userJson),
    );
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to Sign Up: ${response.statusCode}');
      return null;
    }
  }
}