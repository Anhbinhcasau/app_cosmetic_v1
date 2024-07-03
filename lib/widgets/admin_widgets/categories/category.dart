// list_product.dart
import 'package:app_cosmetic/model/category.model.dart';
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
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => categoryListViewModel,
          child: body(),
        ),
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
              // Xử lý sự kiện khi người dùng nhấn vào sản phẩm
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
                          // Xử lý sự kiện khi nhấn vào nút
                        },
                        child: Icon(Icons.edit),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Xử lý sự kiện khi nhấn vào nút
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
}