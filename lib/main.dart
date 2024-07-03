import 'package:app_cosmetic/model/comment.model.dart';
import 'package:app_cosmetic/screen/products/addproduct.dart';
import 'package:app_cosmetic/screen/products/admin_product.dart';
import 'package:app_cosmetic/screen/comment/comment.dart';
import 'package:app_cosmetic/screen/process_oder.dart';
import 'package:app_cosmetic/screen/products/productdeatail.dart';
import 'package:app_cosmetic/services/comment_service.dart';
import 'package:app_cosmetic/widgets/comment/comment_view.dart';
import 'package:app_cosmetic/widgets/navbar_admin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CommentListViewModel(),
        )
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
        body: ProductList(),
      ),
    );
  }
}
