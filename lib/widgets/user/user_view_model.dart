import 'package:app_cosmetic/services/auth_service.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:flutter/material.dart';

class UserListViewModel extends ChangeNotifier {
  List<User?> users = [];

  Future<String> signUpUser(User user) async {
    try {
      final result = await AuthService.signUp(user);

      if (result == 'Sign Up Successful') {
        users.add(user); // Assuming the user is added locally for now
        notifyListeners();
        return result;
      } else {
        return result;
      }
    } catch (e) {
      return 'Error Sign Up: $e';
    }
  }
}
