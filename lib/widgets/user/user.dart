import 'package:app_cosmetic/widgets/user/profile.dart';
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
    // TODO: implement initState
    super.initState();
    userListViewModel.fetchUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    UserProfileScreen(item: value.users[index]),
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            UserProfileScreen(item: value.users[index]),
                      ));
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                            child: Image.network(
                                value.users[index]?.picture?.thumbnail ?? ""))),
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
                        '${value.users[index]?.name?.getDisplayName()}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${value.users[index]?.email}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('change'),
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
