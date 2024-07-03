import 'package:app_cosmetic/services/user_service.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:flutter/material.dart';


class UserListViewModel extends ChangeNotifier {
  List<UserItem?> users = [];
  void fetchUserList() async {
    users = await UserServices.fetchUserList();
    notifyListeners();
  }
}