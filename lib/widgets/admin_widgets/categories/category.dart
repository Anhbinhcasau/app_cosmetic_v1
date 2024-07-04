import 'package:app_cosmetic/model/category.model.dart';
import 'package:app_cosmetic/screen/admin/categories/edit_category.dart';
import 'package:app_cosmetic/screen/admin/categories/add_category.dart';
import 'package:app_cosmetic/widgets/admin_widgets/categories/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCategory extends StatefulWidget {
  const ListCategory({super.key});

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  CategoryListViewModel categoryListViewModel = CategoryListViewModel();

  @override
  void initState() {
    super.initState();
    categoryListViewModel.fetchCategoriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          centerTitle: true,
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
              builder: (context) => AddCategoryScreen(),
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
                    child: ClipOval(
                      child: Image.network(category?.image ?? ""),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category?.nameCate ?? '',
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
                                  EditCategoryScreen(category: category!),
                            ),
                          );
                        },
                        child: Icon(Icons.edit),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showDeleteDialog(context, category!);
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
              Image.network(
                category.image,
                height: 200,
              ),
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
              onPressed: () {
                // Handle the delete action here
                Navigator.of(context).pop();
              },
              child: Text('Xác nhận', style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }
}
