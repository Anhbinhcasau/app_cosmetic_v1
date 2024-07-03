import 'package:app_cosmetic/model/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class UserProfileScreen extends StatefulWidget {
  late UserItem? userItem;
  UserProfileScreen({super.key, UserItem? item}) {
    userItem = item;
  }

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
                child: ClipOval(
                    child:
                        Image.network(widget.userItem?.picture?.large ?? ""))),
            Text(widget.userItem?.name?.first ?? "")
          ],
        ),
      ),
    );
  }
}
