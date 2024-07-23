import 'package:app_cosmetic/widgets/user/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  UserListViewModel userListViewModel = UserListViewModel();
  @override
  void initState() {
    super.initState();
    userListViewModel.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF13131A),
        title: const Text(
          '# NGƯỜI DÙNG',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Center(
          child: ChangeNotifierProvider(
        create: (context) => userListViewModel,
        child: body(),
      )),
    );
  }

  Widget body() {
    return Consumer<UserListViewModel>(
      builder: (context, value, child) => ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        padding: const EdgeInsets.all(8),
        itemCount: value.users.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 35,
                  child: ClipOval(
                    child: Image.network(value.users[index]?.avatar ?? ""),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${value.users[index]?.id}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '${value.users[index]?.fullName}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.key_off),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
