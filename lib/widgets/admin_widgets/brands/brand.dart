// list_product.dart
import 'package:app_cosmetic/model/brand.model.dart';
import 'package:app_cosmetic/widgets/admin_widgets/brands/brand_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListBrand extends StatefulWidget {
  const ListBrand({super.key});

  @override
  State<ListBrand> createState() => _ListBrandState();
}

class _ListBrandState extends State<ListBrand> {
  BrandListViewModel brandListViewModel = BrandListViewModel();

  @override
  void initState() {
    super.initState();
    brandListViewModel.fetchBrandsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => brandListViewModel,
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    return Consumer<BrandListViewModel>(
      builder: (context, value, child) => ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        padding: const EdgeInsets.all(8),
        itemCount: value.brands.length,
        itemBuilder: (BuildContext context, int index) {
          Brand? brand = value.brands[index];
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
                      child: Image.network(brand?.image ?? ""),
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
                        brand?.brand ?? '',
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