import 'package:app_cosmetic/services/auth_service.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:flutter/material.dart';

class UserListViewModel extends ChangeNotifier {
  List<User?> users = [];

  Future<void> signUpUser(User user) async {
    try {
      final newUser = await AuthService.signUp(user);

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

  // Future<void> signInUser(String name, String pass) async {
  //   try {
  //     final signUser = await AuthService.signIn(name, pass);

  //     if (signUser != null) {
  //       users.add(signUser);
  //       print('Sign In successfully');
  //       notifyListeners();
  //     } else {
  //       print('Failed to Sign In');
  //     }
  //   } catch (e) {
  //     print('Error Sign In: $e');
  //   }
  // }
}
