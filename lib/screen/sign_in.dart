import 'package:app_cosmetic/screen/forgot_pass.dart';
import 'package:app_cosmetic/screen/sign_up.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xin chào !!')),
      );
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
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.people),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none, // Remove the border
                      ),
                      filled: true,
                      fillColor: Color(0xFFE3E7D3),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hãy nhập email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Email không hợp lệ';
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
                      fillColor: Color(0xFFE3E7D3),
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
                              }),
                          const Text('Nhớ mật khẩu',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              )),
                        ],
                      ),
                      IconButton(
                        iconSize: 35,
                        icon: const Icon(Icons.vpn_key),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassPage()),
                          );
                        },
                      )
                    ],
                  ),
                  //const SizedBox(height: 10),
                  const SizedBox(height: 20),
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
                        'Đăng nhập',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 50),

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
                                builder: (context) => const SignUpPage()),
                          );
                        },
                        child: const Text(
                          'Đăng ký',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFA2AA7B),
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
                      ]),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Image.asset(
                        'assets/facebook.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
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
