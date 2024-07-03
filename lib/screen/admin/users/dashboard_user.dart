
import 'package:app_cosmetic/widgets/admin_widgets/user/user.dart';
import 'package:flutter/material.dart';

class UserListDB extends StatefulWidget {
  const UserListDB({super.key});

  @override
  State<UserListDB> createState() => _UserListDBState();
}

class _UserListDBState extends State<UserListDB> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListUser(),
      
    );
  }
}
