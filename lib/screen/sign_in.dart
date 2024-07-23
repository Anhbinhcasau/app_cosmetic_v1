import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/screen/user/profile/forgot_pass.dart';
import 'package:app_cosmetic/screen/sign_up.dart';
import 'package:app_cosmetic/screen/user/profile/profile_user.dart';
import 'package:app_cosmetic/services/auth_service.dart';
import 'package:app_cosmetic/widgets/navbar_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageApp extends StatelessWidget {
  const LoginPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      String userName = _nameController.text.trim();
      String password = _passwordController.text.trim();

      try {
        final signInResponse = await AuthService.signIn(userName, password);

        if (signInResponse == 'Sign In Successful') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Xin chào')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ),
          );
        } else if (signInResponse == 'Incorrect username or password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Tên tài khoản của bạn hoặc Mật khẩu không đúng')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(signInResponse)),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng nhập thất bại: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      'Đăng nhập',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Tên đăng nhập',
                      prefixIcon: Icon(Icons.people),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none, // Remove the border
                      ),
                      filled: true,
                      fillColor: AppColors.secondsColor,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hãy nhập tên người dùng';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Mật khẩu',
                      prefixIcon: Icon(Icons.key),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none, // Remove the border
                      ),
                      filled: true,
                      fillColor: AppColors.secondsColor,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hãy nhập mật khẩu!';
                      } else if (value.length < 6) {
                        return 'Mật khẩu phải có 6 ký tự';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          const Text(
                            'Nhớ mật khẩu',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        iconSize: 35,
                        icon: const Icon(Icons.vpn_key),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassPage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 52,
                    child: TextButton(
                      onPressed: _submitForm,
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bạn chưa có tài khoản?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Đăng ký',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "OR",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 30),
                      Image.asset(
                        'assets/facebook.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 30),
                      Image.asset(
                        'assets/twitter.png',
                        width: 40,
                        height: 40,
                      ),
                    ],
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
