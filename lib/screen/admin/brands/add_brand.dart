import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddBrandScreen extends StatefulWidget {
  @override
  _AddBrandScreenState createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen> {
  late TextEditingController _brandController;
  late File? _imageFile;
  final String placeholderImage = 'assets/splash_screen_3.jpg';

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController();
    _imageFile = null;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  void dispose() {
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm thương hiệu mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 30),
              controller: _brandController,
              decoration: InputDecoration(labelText: 'Tên thương hiệu', labelStyle: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: _imageFile != null
                  ? Image.file(_imageFile!, height: 450)
                  : Image.asset(placeholderImage, height: 450),
            ),
            SizedBox(height: 16),
            Text('Hãy chọn ảnh cho thương hiệu'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle the save action here
              },
              child: Text('Xác nhận', style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}