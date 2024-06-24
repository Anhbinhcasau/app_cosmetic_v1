import 'package:app_cosmetic/screen/forgot_pass.dart';
import 'package:app_cosmetic/screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/screen/sign_up.dart';

class DashboardMenu extends StatefulWidget {
  const DashboardMenu({super.key});

  @override
  State<DashboardMenu> createState() => _DashboardMenuState();
}

class _DashboardMenuState extends State<DashboardMenu> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
              );
            },
            child: const Text('Đăng ký'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text('Đăng nhập'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgotPassPage()),
              );
            },
            child: const Text('Quên mật khẩu'),
          ),
        ],
      ),
    );
  }
}
