import 'package:app_cosmetic/services/user_service.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:flutter/material.dart';


class UserListViewModel extends ChangeNotifier {
  List<User?> users = [];
  
  Future<void> signUpUser(User user) async {
    try {
      final newUser = await UserServices.signUp(user);

      if (newUser != null) {
        users.add(newUser);
        notifyListeners();
        print('Sign Up successfully');
      } else {
        print('Failed to Sign Up');
      }
    } catch (e) {
      print('Error Sign Up: $e');
    }
  }
}