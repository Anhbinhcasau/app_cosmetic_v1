import 'dart:async';
import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
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
}
