import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String idPro = '';
  String name = '';
  String brand = '';
  double price = 0.0;
  String description = '';
  String category = '';
  List<String> imageDetail = [];
  int sold = 0;
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm sản phẩm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Tên sản phẩm'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên sản phẩm';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'ID Sản Phẩm'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập ID sản phẩm';
                  }
                  return null;
                },
                onSaved: (value) {
                  idPro = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Thương hiệu'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập thương hiệu';
                  }
                  return null;
                },
                onSaved: (value) {
                  brand = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Giá'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập giá';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Vui lòng nhập một số hợp lệ';
                  }
                  return null;
                },
                onSaved: (value) {
                  price = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mô tả'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Danh mục'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập danh mục';
                  }
                  return null;
                },
                onSaved: (value) {
                  category = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Ảnh chi tiết (dùng dấu phẩy để phân tách)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập ảnh chi tiết';
                  }
                  return null;
                },
                onSaved: (value) {
                  imageDetail = value!.split(',');
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Số lượng'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số lượng';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Vui lòng nhập một số hợp lệ';
                  }
                  return null;
                },
                onSaved: (value) {
                  quantity = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   _formKey.currentState!.save();
                  //   Product newProduct = Product(
                  //     idPro: idPro,
                  //     name: name,
                  //     brand: brand,
                  //     price: price,
                  //     description: description,
                  //     category: category,
                  //     imageDetail: imageDetail,
                  //     sold: sold,
                  //     quantity: quantity,
                  //   );
                  //   // Xử lý lưu sản phẩm mới
                  // }
                },
                child: Text('Thêm sản phẩm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
