import 'dart:io';

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

class CreateProductPage extends StatefulWidget {
  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _materialController = TextEditingController();
  final _evaluateController = TextEditingController();
  final _reviewsController = TextEditingController();
  final _soldController = TextEditingController();
  final _quantityController = TextEditingController();

  List<String> _imageBase = [];
  List<Attribute> _attributes = [];
  String? _selectedBrand;
  String? _selectCate;

  void _handleImagesSelected(List<String> images) {
    setState(() {
      _imageBase = images;
    });
  }

  late Product product;
  late Future<Product> products;
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
      product = await ProductService.createProduct(product);

      // Handle the created product (e.g., send it to a server or store locally)
      print(product.productJson());
    }
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
          title: Text('Add Attribute'),
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
  void initState() {
    super.initState();
    Provider.of<BrandListViewModel>(context, listen: false).fetchBrandsList();
    Provider.of<CategoryListViewModel>(context, listen: false)
        .getCategoriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
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
                    decoration: InputDecoration(labelText: 'Category'),
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
                        return 'Please select a brand';
                      }
                      return null;
                    },
                  );
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
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
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _materialController,
                decoration: InputDecoration(labelText: 'Material'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the material';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Attributes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ..._attributes.map((attribute) => ListTile(
                    title: Text(attribute.name),
                    subtitle: Text(
                        'Quantity: ${attribute.quantity}, Price: ${attribute.price}'),
                    trailing: Image.network(attribute.image, width: 50),
                  )),
              ElevatedButton(
                onPressed: _addAttribute,
                child: Text('Add Attribute'),
              ),
              AddImage(
                  onImagesSelected: (List<String> paths) =>
                      _handleImagesSelected(paths)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: Text('Save Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
