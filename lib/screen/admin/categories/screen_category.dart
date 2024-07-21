import 'package:app_cosmetic/model/category.model.dart';
import 'package:app_cosmetic/screen/admin/categories/category_view_model.dart';
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
  File? _imageFile;
  late String _currentName;
  late String _currentImage;
  final String placeholderImage = 'assets/basic.jpg';
  CategoryListViewModel categoryListViewModel = CategoryListViewModel();

  @override
  void initState() {
    super.initState();
    _categoryController =
        TextEditingController(text: widget.category?.nameCate ?? '');
    _currentName = widget.category?.nameCate ?? '';
    _currentImage = widget.category?.image ?? placeholderImage;
    if (widget.category != null && widget.category!.image.startsWith('http')) {
      _imageFile = null;
    } else if (widget.category != null) {
      _imageFile = File(widget.category!.image);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _saveCategory() async {
    final String categoryName = _categoryController.text.trim();
    final String categoryImage =
        _imageFile != null ? _imageFile!.path : placeholderImage;

    if (categoryName.isEmpty || categoryImage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide category name and image')),
      );
      return;
    }

    try {
      if (widget.category == null) {
        // Add category
        await categoryListViewModel.addCategories(categoryName, categoryImage);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Category created successfully')));
      } else {
        // Edit category
        await Provider.of<CategoryListViewModel>(context, listen: false)
            .editCategories(
          widget.category!.id,
          categoryName,
          categoryImage,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Category updated successfully')),
        );
      }

      _categoryController.clear();
      setState(() {
        _imageFile = null;
      });

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to save category')));
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
        title: Text(
            widget.category == null ? 'Thêm Danh Mục' : 'Chỉnh sửa Danh Mục'),
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
              child: _imageFile != null
                  ? Image.file(_imageFile!, height: 450, fit: BoxFit.cover)
                  : _currentImage.startsWith('http')
                      ? Image.network(
                          _currentImage,
                          height: 450,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          placeholderImage,
                          height: 450,
                          fit: BoxFit.cover,
                        ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveCategory,
              child: Text(
                widget.category == null ? 'Lưu' : 'Xác nhận',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
