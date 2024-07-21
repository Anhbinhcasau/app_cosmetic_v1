import 'dart:io';

import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/brand.model.dart';
import 'package:app_cosmetic/model/product/atribute.model.dart';
import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/screen/admin/brands/brand_view_model.dart';
import 'package:app_cosmetic/screen/admin/categories/category_view_model.dart';
import 'package:app_cosmetic/screen/admin/products/add_image.dart';
import 'package:app_cosmetic/screen/user/comment/picker_image.dart';
import 'package:app_cosmetic/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UpdateProduct extends StatefulWidget {
  final Product? productToEdit; // Dùng để truyền sản phẩm cần cập nhật

  UpdateProduct({this.productToEdit});

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _materialController = TextEditingController();
  final _quantityController = TextEditingController();

  List<String> _imageBase = [];
  List<Attribute> _attributes = [];
  String? _selectedBrand;
  String? _selectCate;

  late bool isEditing;
  late Product? productToEdit;

  @override
  void initState() {
    super.initState();
    isEditing = widget.productToEdit != null;
    productToEdit = widget.productToEdit;

    if (isEditing) {
      _initializeFields();
    }

    Provider.of<BrandListViewModel>(context, listen: false).fetchBrandsList();
    Provider.of<CategoryListViewModel>(context, listen: false)
        .getCategoriesList();
  }

  void _initializeFields() {
    _nameController.text = productToEdit!.name;
    _priceController.text = productToEdit!.price.toString();
    _descriptionController.text = productToEdit!.description;
    _materialController.text = productToEdit!.material;
    _quantityController.text = productToEdit!.quantity.toString();
    _imageBase = productToEdit!.imageBase;
    _attributes = productToEdit!.attributes;
    _selectedBrand = productToEdit!.brand;
    _selectCate = productToEdit!.category;
  }

  void _handleImagesSelected(List<String> images) {
    setState(() {
      _imageBase = images;
    });
  }

  late Product product;
  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      product = Product(
        name: _nameController.text,
        brand: _selectedBrand ?? '',
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        material: _materialController.text,
        category: _selectCate ?? '',
        imageBase: _imageBase,
        attributes: _attributes,
        reviews: 5,
        sold: 5,
        quantity: int.parse(_quantityController.text),
      );

      if (isEditing) {
        product.idPro =
            productToEdit!.idPro; // Giả sử Product có id để cập nhật
        product = await ProductService.updateProduct(
            product); // Hàm cập nhật sản phẩm
      } else {
        return;
      }

      // Handle the created/updated product (e.g., send it to a server or store locally)
      print(product.productJson());
      Navigator.pop(context);
    }
  }

  void _deleteProduct() async {
    try {
      // Hiển thị hộp thoại xác nhận trước khi xóa
      final shouldDelete = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Bạn có chắc chắn muốn xóa sản phẩm này???'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Xóa'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Hủy'),
            ),
          ],
        ),
      );

      if (shouldDelete == true) {
        // Gọi hàm xóa sản phẩm
        await ProductService.deleteProduct(productToEdit?.idPro ?? '');

        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xóa thành công ')),
        );

        // Quay lại trang trước (hoặc trang danh sách sản phẩm)
        Navigator.pop(context);
      }
    } catch (e) {
      // Hiển thị thông báo lỗi nếu có
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product. Error: $e')),
      );
    }
  }

  void _editAttribute(Attribute attribute, int index) {
    final _nameController = TextEditingController(text: attribute.name);
    final _quantityController =
        TextEditingController(text: attribute.quantity.toString());
    final _priceController =
        TextEditingController(text: attribute.price.toString());
    final _imageController = TextEditingController(text: attribute.image);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Attribute'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _attributes[index] = Attribute(
                    name: _nameController.text,
                    quantity: int.parse(_quantityController.text),
                    price: double.parse(_priceController.text),
                    image: _imageController.text,
                  );
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addAttribute() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _nameController = TextEditingController();
        final _quantityController = TextEditingController();
        final _priceController = TextEditingController();
        final _imageController = TextEditingController();

        return AlertDialog(
          title: const Text('Add Attribute'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _attributes.add(Attribute(
                    name: _nameController.text,
                    quantity: int.parse(_quantityController.text),
                    price: double.parse(_priceController.text),
                    image: _imageController.text,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              Consumer<BrandListViewModel>(
                builder: (context, brandsProvider, child) {
                  return DropdownButtonFormField<String>(
                    value: _selectedBrand,
                    menuMaxHeight: 300,
                    borderRadius: BorderRadius.circular(30),
                    decoration: InputDecoration(labelText: 'Brand'),
                    items: brandsProvider.brands.map((brand) {
                      return DropdownMenuItem<String>(
                        value: brand!.name,
                        child: Text(brand.name),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBrand = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a brand';
                      }
                      return null;
                    },
                  );
                },
              ),
              Consumer<CategoryListViewModel>(
                builder: (context, cateProvider, child) {
                  return DropdownButtonFormField<String>(
                    value: _selectCate,
                    menuMaxHeight: 300,
                    borderRadius: BorderRadius.circular(30),
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: cateProvider.categories.map((cate) {
                      return DropdownMenuItem<String>(
                        value: cate!.nameCate,
                        child: Text(cate.nameCate),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectCate = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  );
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _materialController,
                decoration: const InputDecoration(labelText: 'Material'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the material';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Attributes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ..._attributes.asMap().entries.map((entry) {
                int index = entry.key;
                Attribute attribute = entry.value;
                return ListTile(
                  title: Text(attribute.name),
                  subtitle: Text(
                      'Quantity: ${attribute.quantity}, Price: ${attribute.price}'),
                  trailing: Image.network(attribute.image, width: 50),
                  onTap: () => _editAttribute(attribute, index),
                );
              }).toList(),
              ElevatedButton(
                onPressed: _addAttribute,
                child: const Text(
                  'Add Attribute',
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: productToEdit!.imageBase.isNotEmpty
                    ? productToEdit!.imageBase[0].startsWith('http')
                        ? Image.network(
                            productToEdit!.imageBase[0],
                            //height: 150.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(productToEdit!.imageBase[0]),
                            height: 150.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                    : Placeholder(), // Display a placeholder if the list is empty
              ),
              AddImage(
                  onImagesSelected: (List<String> paths) =>
                      _handleImagesSelected(paths)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Bo góc nút
                      ),
                    ),
                    onPressed: _saveProduct,
                    child: const Text(
                      'Update Product',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Bo góc nút
                      ),
                    ),
                    onPressed: _deleteProduct,
                    child: const Text(
                      'Delate Product',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
