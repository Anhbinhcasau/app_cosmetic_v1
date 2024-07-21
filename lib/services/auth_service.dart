import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/auth.model.dart';
import 'package:http/http.dart' as http;
import 'package:app_cosmetic/model/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
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

  static Future<User?> signIn(String userName, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.DB_URI}/auth/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userName': userName, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final userId = data['metadata']['user']['_id'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', userId);
        final user = User.fromJson(data);
        return user;
      } else {
        print('Failed to Sign In: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception during signIn: $e');
      return null;
    }
  }
}
