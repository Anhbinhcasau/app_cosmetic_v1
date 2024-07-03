import 'package:app_cosmetic/model/comment.model.dart';
import 'package:app_cosmetic/screen/admin/navbar_admin.dart';
import 'package:app_cosmetic/screen/admin/products/addproduct.dart';
import 'package:app_cosmetic/screen/admin/products/admin_product.dart';
import 'package:app_cosmetic/screen/admin/comment/comment.dart';
import 'package:app_cosmetic/screen/process_oder.dart';
import 'package:app_cosmetic/screen/productdeatail.dart';
import 'package:app_cosmetic/services/comment_service.dart';
import 'package:app_cosmetic/widgets/admin_widgets/comment/comment_view.dart';
import 'package:app_cosmetic/widgets/admin_widgets/orders/order_view_model.dart';
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
        body: NavBar(),
      ),
    );
  }
}