import 'package:app_cosmetic/widgets/admin_widgets/categories/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  late TextEditingController _categoryController;
  String _imageFile = '';
  final String placeholderImage = 'assets/basic.jpg';
  CategoryListViewModel categoryListViewModel = CategoryListViewModel();

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile.path; // Assign path to _imageFile
      }
    });
  }

  Future<void> _saveCategory() async {
    final String categoryName = _categoryController.text;
    if (categoryName.isEmpty || _imageFile.isEmpty) {
      // Show error message if brand name or image is not provided
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please provide category name and image')));
      return;
    }
    try {
      // Call your method to create brand with _imageFile here
      await categoryListViewModel.addCategories(categoryName, _imageFile);
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Category created successfully')));
      // Clear text field and image file after successful creation
      _categoryController.clear();
      setState(() {
        _imageFile = ''; // Reset _imageFile after successful creation
      });
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to create category')));
    }
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
        title: Text('Thêm Danh Mục'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 30),
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Category Name',
                labelStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: _imageFile.isNotEmpty // Check if _imageFile is not empty
                  ? Image.file(File(_imageFile),
                      height: 450) // Use File constructor to show image
                  : Image.asset(placeholderImage, height: 450),
            ),
            SizedBox(height: 16),
            Text('Select an image for the category'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveCategory,
              child: Text('Save', style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
