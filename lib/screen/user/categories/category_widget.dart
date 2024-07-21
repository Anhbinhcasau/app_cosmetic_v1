import 'dart:io';
import 'package:app_cosmetic/model/category.model.dart';
import 'package:app_cosmetic/screen/admin/categories/category_view_model.dart';
import 'package:app_cosmetic/screen/user/Product/category.dart';
import 'package:app_cosmetic/screen/user/categories/listcate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  CategoryListViewModel categoryListViewModel = CategoryListViewModel();
  Category? category;

  @override
  void initState() {
    super.initState();
    categoryListViewModel.getCategoriesList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => categoryListViewModel,
      child: Consumer<CategoryListViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Category',
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...viewModel.categories
                            .take(5)
                            .map((category) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Chip(
                                    label:
                                        Text(category!.nameCate.toUpperCase()),
                                  ),
                                ))
                            .toList(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Listcate()),
                            );
                          },
                          child: Text('View all'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
