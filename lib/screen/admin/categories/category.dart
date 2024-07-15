import 'dart:io';
import 'package:app_cosmetic/model/category.model.dart';
import 'package:app_cosmetic/screen/admin/categories/category_view_model.dart';
import 'package:app_cosmetic/screen/admin/categories/screen_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCategory extends StatefulWidget {
  const ListCategory({super.key});

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  CategoryListViewModel categoryListViewModel = CategoryListViewModel();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    categoryListViewModel.getCategoriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF13131A),
        title: const Text(
          '# DANH MỤC',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => categoryListViewModel,
          child: body(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green, // Customize the color
      ),
    );
  }

  Widget body() {
    return Consumer<CategoryListViewModel>(
      builder: (context, value, child) => ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        padding: const EdgeInsets.all(8),
        itemCount: value.categories.length,
        itemBuilder: (BuildContext context, int index) {
          Category? category = value.categories[index];
          if (category == null || category.image == null) {
            return SizedBox();
          }

          Widget categoryImage;
          if (category.image!.startsWith('http')) {
            // Network image
            categoryImage = Image.network(
              category.image!,
              fit: BoxFit.cover,
            );
          } else {
            // Local file image
            categoryImage = Image.file(
              File(category.image!),
              fit: BoxFit.cover,
            );
          }

          return GestureDetector(
            onTap: () {
              // Handle the tap event here
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: categoryImage,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.nameCate ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryScreen(category: category),
                            ),
                          );
                        },
                        child: Icon(Icons.edit),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showDeleteDialog(context, category);
                        },
                        child: Icon(Icons.delete),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Category category) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Xóa Danh mục'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bạn chắc chắn muốn xóa danh mục này?',
                style: TextStyle(color: Colors.amber),
              ),
              SizedBox(height: 16),
              Text('ID: ${category.id}', style: TextStyle(fontSize: 20)),
              Text('Name: ${category.nameCate}',
                  style: TextStyle(fontSize: 20)),
              _buildCategoryImage(category)
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy', style: TextStyle(fontSize: 20)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                // Perform the deletion and handle the result
                bool isDeleted = await Provider.of<CategoryListViewModel>(
                        context,
                        listen: false)
                    .deleteCategory(category.id);
                if (isDeleted) {
                  _scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(content: Text('Category deleted successfully')),
                  );
                } else {
                  _scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(content: Text('Failed to delete category')),
                  );
                }
              },
              child: Text('Xác nhận', style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoryImage(Category category) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
        child: category.image.startsWith('http')
            ? Image.network(
                category.image,
                fit: BoxFit.cover,
              )
            : Image.file(
                File(category.image),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
