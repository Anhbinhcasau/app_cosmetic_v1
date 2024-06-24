import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_cosmetic/screen/sign_in.dart';
import 'package:flutter/widgets.dart';

class SignUpPageApp extends StatelessWidget {
  const SignUpPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công @')),
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
        appBar: AppBar(elevation: 0,),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align all children to the left
                children: <Widget>[
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Đăng ký',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(height: 50),
                  //Name
                  TextFormField(
                    controller: _nameController,  
                    decoration: const InputDecoration(
                      hintText: 'Tên',
                      prefixIcon:
                          Icon(Icons.people), // Sử dụng prefixIcon để đặt icon
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xFFE3E7D3),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hãy nhập tên !';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),
                  //email
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email', 
                      prefixIcon:
                          Icon(Icons.mail),
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
                        return 'Hãy nhập email !!!';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Hãy nhập địa chỉ email hợp lệ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  // password
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Mật khẩu', 
                      prefixIcon:
                          Icon(Icons.key),
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
                        return 'Hãy nhập mật khẩu';
                      } else if (value.length < 6) {
                        return 'Mật khẩu phải có 6 ký tự';
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
                        'Đăng ký',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bạn đã có tài khoản?',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          'Đăng Nhập',
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
                          "Or",
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
