import 'package:app_cosmetic/model/category.model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditCategoryScreen extends StatefulWidget {
  final Category category;

  EditCategoryScreen({required this.category});

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  late TextEditingController _categoryController;
  late File? _imageFile;

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController(text: widget.category.nameCate);
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
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa danh mục'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 30),
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Tên danh mục',
                labelStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: _imageFile != null
                  ? Image.file(_imageFile!, height: 450)
                  : Image.network(widget.category.image, height: 450),
            ),
            SizedBox(height: 16),
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