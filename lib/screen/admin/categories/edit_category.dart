import 'package:app_cosmetic/model/category.model.dart';
import 'package:app_cosmetic/widgets/admin_widgets/categories/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class EditCategoryScreen extends StatefulWidget {
  final Category category;

  EditCategoryScreen({required this.category});

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  late TextEditingController _categoryController;
  late File? _imageFile;
  late String _currentName;
  late String _currentImage;

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController(text: widget.category.nameCate);
    _currentName = widget.category.nameCate;
    _currentImage = widget.category.image;
    if (widget.category.image.startsWith('http')) {
      _imageFile = null;
    } else {
      _imageFile = File(widget.category.image);
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

  Future<void> _saveChanges() async {
    String newName = _categoryController.text.trim();
    String newImagePath =
        _imageFile != null ? _imageFile!.path : widget.category.image;

    try {
      await Provider.of<CategoryListViewModel>(context, listen: false)
          .editCategories(
        widget.category.id,
        newName,
        newImagePath,
      );

      setState(() {
        _currentName = newName;
        _currentImage = newImagePath;
      });

      Navigator.pop(context);
    } catch (e) {
      print('Error updating category: $e');
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
                  ? Image.file(_imageFile!, height: 450, fit: BoxFit.cover)
                  : _currentImage.startsWith('http')
                      ? Image.network(
                          _currentImage,
                          height: 450,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(_currentImage),
                          height: 450,
                          fit: BoxFit.cover,
                        ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Xác nhận', style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
