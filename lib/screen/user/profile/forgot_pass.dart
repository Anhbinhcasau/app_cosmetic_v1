import 'dart:convert';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:app_cosmetic/screen/sign_in.dart';
import 'package:app_cosmetic/screen/user/profile/profile_user.dart';
import 'package:app_cosmetic/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repassController = TextEditingController();
  bool isChecked = false;
  String? userId;
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
    if (userId != null) {
      user = await UserServices.getDetail(userId!);
      setState(() {
        _oldPassController.text =
            user?.password ?? ''; // Assuming user model has a password field
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Check if the new passwords match and meet the criteria
      if (_passwordController.text == _repassController.text &&
          _passwordController.text.length >= 6) {
        try {
          User updatedUser = User(
              id: user!.id,
              userName: user!.userName,
              email: user!.email,
              password: _passwordController.text,
              active: true,
              role: 'user');

          final responseUser =
              await UserServices().changeProfileUser(updatedUser);
              Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đổi mật khẩu thành công')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update password')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mật khẩu không hợp lệ')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Đổi mật khẩu'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Vui lòng đăng nhập để thay đổi mật khẩu',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()),
                        );
                },
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: (() {
          FocusManager.instance.primaryFocus?.unfocus();
        }),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Thay đổi mật khẩu',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: _oldPassController,
                      decoration: const InputDecoration(
                        hintText: 'Nhập mật khẩu hiện tại',
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFE3E7D3),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hãy nhập thông tin';
                        } else if (value != user?.password) {
                          return 'Mật khẩu hiện tại không đúng';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Nhập mật khẩu mới',
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFE3E7D3),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hãy nhập thông tin';
                        } else if (value.length < 6) {
                          return 'Mật khẩu không hợp lệ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _repassController,
                      decoration: const InputDecoration(
                        hintText: 'Nhập lại mật khẩu',
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFE3E7D3),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hãy nhập thông tin';
                        } else if (value != _passwordController.text) {
                          return 'Mật khẩu không khớp';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFA2AA7B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 52,
                      child: TextButton(
                        onPressed: _submitForm,
                        child: const Text(
                          'Xác Nhận',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
