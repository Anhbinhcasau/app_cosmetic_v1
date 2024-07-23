import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/screen/sign_in.dart';
import 'package:app_cosmetic/screen/user/profile/change_profile.dart';
import 'package:app_cosmetic/services/user_service.dart';
import 'package:app_cosmetic/widgets/navbar_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_cosmetic/screen/user/profile/forgot_pass.dart';
import 'package:app_cosmetic/screen/user/profile/process_oder.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userId;
  String? userName;
  String? email;
  String? address;
  String? avatar;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');

    if (userId != null) {
      final user = await UserServices.getDetail(userId!);
      setState(() {
        userName = user?.fullName ?? '';
        email = user?.email ?? '';
        address = user?.address ?? '';
        avatar = user?.avatar;
      });
    }
  }

  Future<void> _logOutUser() async {
    if (userId != null && userId!.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              avatar != null
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileScreen()),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 55,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(avatar!),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.blueGrey,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://i.pinimg.com/236x/b1/df/5c/b1df5c0fd9ac7073b1710ece19b81407.jpg'),
                      ),
                    ),
              SizedBox(height: 16),
              userId != null && userId!.isNotEmpty
                  ? Column(
                      children: [
                        Text(
                          userName!,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.email, color: Colors.brown),
                          title: Text(
                            email!,
                            style: TextStyle(fontSize: AppTexts.size_text),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.home, color: Colors.brown),
                          title: Text(
                            address!,
                            style: TextStyle(fontSize: AppTexts.size_text),
                          ),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.shopping_bag, color: Colors.brown),
                          title: Text(
                            'Đơn hàng',
                            style: TextStyle(fontSize: AppTexts.size_text),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProcessOrder(userId: userId!)),
                            );
                          },
                        ),
                      ],
                    )
                  : Text(
                      'Chưa đăng nhập',
                      style: TextStyle(fontSize: 20),
                    ),
              Divider(),
              ListTile(
                leading: Icon(Icons.payment, color: Colors.brown),
                title: Text(
                  'Phương thức thanh toán',
                  style: TextStyle(fontSize: AppTexts.size_text),
                ),
                onTap: () {
                  // Handle navigation to "Payment Methods"
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.brown),
                title: Text(
                  'Mật khẩu',
                  style: TextStyle(fontSize: AppTexts.size_text),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassPage()),
                  );
                },
              ),
              Divider(),
              userId != null && userId!.isNotEmpty
                  ? ListTile(
                      leading: Icon(Icons.logout, color: Colors.brown),
                      title: Text(
                        'Đăng xuất',
                        style: TextStyle(fontSize: AppTexts.size_text),
                      ),
                      onTap: _logOutUser,
                    )
                  : ListTile(
                      leading: Icon(Icons.logout, color: Colors.brown),
                      title: Text(
                        'Đăng nhập',
                        style: TextStyle(fontSize: AppTexts.size_text),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
