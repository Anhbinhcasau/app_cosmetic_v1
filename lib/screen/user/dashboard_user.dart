import 'package:app_cosmetic/widgets/user/user.dart';
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
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: ListUser(),
      
    );
  }
}
