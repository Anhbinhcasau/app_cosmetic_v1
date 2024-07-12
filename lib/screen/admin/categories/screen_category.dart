import 'package:app_cosmetic/model/category.model.dart';
import 'package:app_cosmetic/widgets/admin_widgets/categories/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final Category? category;

  CategoryScreen({this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late TextEditingController _categoryController;
  late File? _imageFile;
  late String _currentName;
  late String _currentImage;

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController(text: widget.category?.nameCate ?? '');
    _currentName = widget.category?.nameCate ?? '';
    _currentImage = widget.category?.image ?? 'assets/basic.jpg';
    _imageFile = widget.category?.image != null && !widget.category!.image.startsWith('http') ? File(widget.category!.image) : null;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        _currentImage = _imageFile!.path;
      }
    });
  }

  Future<void> _saveCategory() async {
    final String categoryName = _categoryController.text.trim();
    final String categoryImage = _imageFile?.path ?? _currentImage;

    if (categoryName.isEmpty || categoryImage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide category name and image')),
      );
      return;
    }

    try {
      if (widget.category == null) {
        // Add category
        await Provider.of<CategoryListViewModel>(context, listen: false).addCategories(categoryName, categoryImage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Category created successfully')),
        );
      } else {
        // Edit category
        await Provider.of<CategoryListViewModel>(context, listen: false).editCategories(widget.category!.id, categoryName, categoryImage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Category updated successfully')),
        );
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save category')),
      );
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
        title: Text(widget.category == null ? 'Thêm Danh Mục' : 'Chỉnh sửa Danh Mục'),
      ),
      body: SingleChildScrollView(
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
              child: _currentImage.isNotEmpty
                  ? (_currentImage.startsWith('http')
                      ? Image.network(_currentImage, height: 450, fit: BoxFit.cover)
                      : Image.file(File(_currentImage), height: 450, fit: BoxFit.cover))
                  : Image.asset('assets/basic.jpg', height: 450),
            ),
            SizedBox(height: 16),
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