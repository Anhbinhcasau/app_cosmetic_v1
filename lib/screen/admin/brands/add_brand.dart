import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:app_cosmetic/widgets/admin_widgets/brands/brand_view_model.dart';

class AddBrandScreen extends StatefulWidget {
  @override
  _AddBrandScreenState createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen> {
  late TextEditingController _brandController;
  String _imageFile = '';
  final String placeholderImage = 'assets/basic.jpg';
  BrandListViewModel brandListViewModel = BrandListViewModel();

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile.path; // Assign path to _imageFile
      }
    });
  }

  Future<void> _saveBrand() async {
    final String brandName = _brandController.text;
    if (brandName.isEmpty || _imageFile.isEmpty) {
      // Show error message if brand name or image is not provided
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please provide brand name and image')));
      return;
    }
    try {
      // Call your method to create brand with _imageFile here
      await brandListViewModel.createBrands(brandName, _imageFile);
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Brand created successfully')));
      // Clear text field and image file after successful creation
      _brandController.clear();
      setState(() {
        _imageFile = ''; // Reset _imageFile after successful creation
      });
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create brand')));
    }
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
        title: Text('Thêm Thương Hiệu'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 30),
              controller: _brandController,
              decoration: InputDecoration(
                labelText: 'Brand Name',
                labelStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: _imageFile.isNotEmpty // Check if _imageFile is not empty
                  ? Image.file(File(_imageFile), height: 450) // Use File constructor to show image
                  : Image.asset(placeholderImage, height: 400),
            ),
            SizedBox(height: 16),
            Text('Select an image for the brand'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveBrand,
              child: Text('Save', style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}