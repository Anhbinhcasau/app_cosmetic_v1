import 'dart:io';
import 'package:app_cosmetic/screen/admin/brands/brand_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:app_cosmetic/model/brand.model.dart';

class BrandScreen extends StatefulWidget {
  final Brand? brand;

  BrandScreen({this.brand});

  @override
  _BrandScreenState createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  late TextEditingController _brandController;
  File? _imageFile;
  late String _currentName;
  late String _currentImage;
  final String placeholderImage = 'assets/basic.jpg';
  BrandListViewModel brandListViewModel = BrandListViewModel();

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: widget.brand?.name ?? '');
    _currentName = widget.brand?.name ?? '';
    _currentImage = widget.brand?.image ?? placeholderImage;
    if (widget.brand != null && widget.brand!.image.startsWith('http')) {
      _imageFile = null;
    } else if (widget.brand != null) {
      _imageFile = File(widget.brand!.image);
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

  Future<void> _saveBrand() async {
    final String brandName = _brandController.text.trim();
    final String imagePath =
        _imageFile != null ? _imageFile!.path : placeholderImage;

    if (brandName.isEmpty || _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please provide brand name and image')));
      return;
    }

    try {
      if (widget.brand == null) {
        // Add brand
        await brandListViewModel.createBrands(brandName, imagePath);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Brand created successfully')));
      } else {
        // Update brand
        await Provider.of<BrandListViewModel>(context, listen: false)
            .updateBrands(
          widget.brand!.id,
          brandName,
          imagePath,
        );
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Brand updated successfully')));
      }

      _brandController.clear();
      setState(() {
        _imageFile = null;
      });

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to save brand')));
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
        title: Text(widget.brand == null
            ? 'Thêm Thương Hiệu'
            : 'Chỉnh sửa thương hiệu'),
      ),
      body: SingleChildScrollView(
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
                      : Image.asset(
                          placeholderImage,
                          height: 450,
                          fit: BoxFit.cover,
                        ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveBrand,
              child: Text(
                widget.brand == null ? 'Lưu' : 'Xác nhận',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
