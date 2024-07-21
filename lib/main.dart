import 'package:app_cosmetic/screen/admin/brands/brand_view_model.dart';
import 'package:app_cosmetic/screen/admin/categories/category_view_model.dart';
import 'package:app_cosmetic/screen/user/Home/home.dart';
import 'package:app_cosmetic/screen/user/Product/product_view.dart';
import 'package:app_cosmetic/screen/user/splashscreen/splashscreen1.dart';
import 'package:app_cosmetic/widgets/comment/comment_view.dart';
import 'package:app_cosmetic/widgets/orders/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CommentListViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderListViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => BrandListViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryListViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductListViewModel(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Splashscreen1(),
      ),
    );
  }
}
