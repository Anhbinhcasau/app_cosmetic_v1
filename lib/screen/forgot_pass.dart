import 'package:flutter/material.dart';

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

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đổi mật khẩu thành công')),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Thay đổi mật khẩu',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: _oldPassController,
                    decoration: const InputDecoration(
                      hintText: 'Nhập mật khẩu hiện tại',
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
                        return 'Hãy nhập thông tin';
                      } else if (value.length < 6) {
                        return 'Mật khẩu không hợp lệ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Nhập mật khẩu mới',
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
                        return 'Hãy nhập thông tin';
                      } else if (value != _passwordController.text) {
                        return 'Mật khẩu không hợp lệ';
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