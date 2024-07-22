import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:http/http.dart' as http;
import 'package:app_cosmetic/model/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<String> signUp(User user) async {
    Map<String, dynamic> userJson = user.toJson();
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userJson),
    );

    if (response.statusCode == 201) {
      return 'Sign Up Successful';
    } else if (response.statusCode == 409) {
      return 'Account already exists';
    } else if (response.statusCode == 500) {
      return 'Internal server error';
    } else {
      return 'Failed to Sign Up: ${response.statusCode}';
    }
  }

  static Future<String> signIn(String userName, String password) async {
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
        await prefs.setString('userId', userId);
        return 'Sign In Successful';
      } else if (response.statusCode == 403) {
        return 'Incorrect username or password';
      } else {
        print('Failed to Sign In: ${response.statusCode}');
        print('Response body: ${response.body}');
        return 'Failed to Sign In: ${response.statusCode}';
      }
    } catch (e) {
      print('Exception during signIn: $e');
      return 'Exception during signIn: $e';
    }
  }

  static Future<bool> logOut(User users) async {
    try {
      final response = await http.post(
        Uri.parse('${Api.DB_URI}/auth/logout'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user': users}),
      );

      if (response.statusCode == 200) {
        print('Log out: ${response.statusCode}');
        return true;
      } else {
        print('Failed to log out: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during log out: $e');
      return false;
    }
  }
}
