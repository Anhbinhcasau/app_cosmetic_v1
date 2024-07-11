import 'dart:io';
import 'package:app_cosmetic/widgets/admin_widgets/brands/brand_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_cosmetic/model/brand.model.dart';
import 'package:provider/provider.dart';

class BrandEditScreen extends StatefulWidget {
  final Brand brand;

  BrandEditScreen({required this.brand});

  @override
  _BrandEditScreenState createState() => _BrandEditScreenState();
}

class _BrandEditScreenState extends State<BrandEditScreen> {
  late TextEditingController _brandController;
  File? _imageFile;
  late String _currentName;
  late String _currentImage;

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: widget.brand.name);
    _currentName = widget.brand.name;
    _currentImage = widget.brand.image;
    if (widget.brand.image.startsWith('http')) {
      _imageFile = null;
    } else {
      _imageFile = File(widget.brand.image);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _saveChanges() async {
    String newName = _brandController.text.trim();
    String newImagePath = _imageFile != null ? _imageFile!.path : widget.brand.image;

    try {
      await Provider.of<BrandListViewModel>(context, listen: false).updateBrands(
        widget.brand.id,
        newName,
        newImagePath,
      );

      setState(() {
        _currentName = newName;
        _currentImage = newImagePath;
      });

      Navigator.pop(context);
    } catch (e) {
      print('Error updating brand: $e');
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
        title: Text('Chỉnh sửa thương hiệu'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                style: TextStyle(fontSize: 30),
                controller: _brandController,
                decoration: InputDecoration(
                  labelText: 'Tên thương hiệu',
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
                child: Text(
                  'Xác nhận',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}