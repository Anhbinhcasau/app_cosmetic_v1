import 'dart:io';

import 'package:app_cosmetic/model/category.model.dart';
import 'package:app_cosmetic/screen/admin/categories/category_view_model.dart';
import 'package:app_cosmetic/screen/user/Product/product_item.dart';
import 'package:app_cosmetic/screen/user/categories/productlistcate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Listcate extends StatefulWidget {
  const Listcate({super.key});

  @override
  State<Listcate> createState() => _ListcateState();
}

class _ListcateState extends State<Listcate> {
  @override
  Widget build(BuildContext context) {
    final cateListViewModel = Provider.of<CategoryListViewModel>(context);
    cateListViewModel.getCategoriesList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Danh mục sản phẩm'),
      ),
      body: Consumer<CategoryListViewModel>(
        builder: (context, model, child) {
          if (model.categories.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.only(left: 15, right: 20),
            itemCount: model.categories.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              Category? category = model.categories[index];
              String imageUrl = category?.image?.trim() ?? '';
              bool isNetworkImage = imageUrl.startsWith('http');

              return ListTile(
                leading: imageUrl.isNotEmpty
                    ? Container(
                        child: isNetworkImage
                            ? Image.network(
                                imageUrl,
                                width: 50.0,
                                height: 50.0,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(imageUrl),
                                width: 50.0,
                                height: 50.0,
                                fit: BoxFit.cover,
                              ),
                      )
                    : Container(
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          color: Colors.grey,
                          child: Icon(Icons.image, color: Colors.white),
                        ),
                      ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    category!.nameCate,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductItemCate(
                        categoryName: category.nameCate,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
