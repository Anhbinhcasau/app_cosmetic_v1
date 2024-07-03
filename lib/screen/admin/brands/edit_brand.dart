import 'package:app_cosmetic/model/brand.model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BrandEditScreen extends StatefulWidget {
  final Brand brand;

  BrandEditScreen({required this.brand});

  @override
  _BrandEditScreenState createState() => _BrandEditScreenState();
}

class _BrandEditScreenState extends State<BrandEditScreen> {
  late TextEditingController _brandController;
  late File? _imageFile;

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: widget.brand.brand);
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
        title: Text('Chỉnh sửa thương hiệu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 30),
              controller: _brandController,
              decoration: InputDecoration(labelText: 'Tên thương hiệu',labelStyle: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 16),
            
            GestureDetector(
              onTap: _pickImage,
              child: _imageFile != null
                  ? Image.file(_imageFile!, height: 450)
                  : Image.network(widget.brand.image, height: 450),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                // Handle the save action here
              },
              child: Text('Xác nhận',style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}