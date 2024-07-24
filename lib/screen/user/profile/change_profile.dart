import 'dart:io';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/user.model.dart';
import 'package:app_cosmetic/screen/user/profile/profile_user.dart';
import 'package:app_cosmetic/services/user_service.dart';
import 'package:app_cosmetic/widgets/navbar_user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  File? avatar;
  String? userId;
  User? user;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');

    if (userId != null) {
      user = await UserServices.getDetail(userId!);
      setState(() {
        nameController.text = user?.fullName ?? '';
        emailController.text = user?.email ?? '';
        addressController.text = user?.address ?? '';
        passwordController.text = user?.password ?? '';
        avatar = user?.avatar != null ? File(user!.avatar) : null;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    if (userId != null) {
      User updatedUser = User(
        id: userId!,
        userName: user?.userName ?? '',
        password: passwordController.text,
        email: emailController.text,
        fullName: nameController.text,
        avatar: avatar?.path ?? user?.avatar ?? '',
        address: addressController.text,
        active: user?.active ?? true,
        role: user?.role ?? 'user',
      );

      try {
        User responseUser = await UserServices().changeProfileUser(updatedUser);
        if (responseUser != null) {
          print('Cập nhật thông tin thành công');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
      } catch (e) {
        print('Lỗi khi cập nhật thông tin');
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        avatar = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '# SỬA THÔNG TIN',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: avatar != null
                          ? (user?.avatar != null
                              ? NetworkImage(user!.avatar)
                              : FileImage(avatar!)) as ImageProvider
                          : null,
                    ),
                  ),
                ),
                Text(
                  nameController.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tên người dùng:'),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Nhập tên người dùng',
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(),
                        Text('Email:'),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Nhập email',
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(),
                        Text('Địa chỉ:'),
                        TextField(
                          controller: addressController,
                          decoration: InputDecoration(
                            hintText: 'Nhập địa chỉ',
                            border: InputBorder.none,
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: _updateUserProfile,
                            child: Text(
                              'Cập nhật thông tin',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
