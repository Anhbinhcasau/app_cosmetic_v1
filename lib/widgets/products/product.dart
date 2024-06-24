// list_product.dart
import 'package:app_cosmetic/widgets/products/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_cosmetic/model/product.model.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  ProductListViewModel productListViewModel = ProductListViewModel();

  @override
  void initState() {
    super.initState();
    productListViewModel.fetchProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => productListViewModel,
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    return Consumer<ProductListViewModel>(
      builder: (context, value, child) => ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        padding: const EdgeInsets.all(8),
        itemCount: value.products.length,
        itemBuilder: (BuildContext context, int index) {
          Product? product = value.products[index];
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
                      child: Image.network(product?.imageUrl ?? ""),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product?.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${product?.brand ?? ''} - ${product?.price?.toStringAsFixed(2) ?? ''} \$',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý sự kiện khi nhấn vào nút
                    },
                    child: Text('Change'),
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