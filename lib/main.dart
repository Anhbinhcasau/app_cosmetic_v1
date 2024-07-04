import 'package:app_cosmetic/screen/admin/navbar_admin.dart';
import 'package:app_cosmetic/screen/user/splashscreen/splashscreen1.dart';
import 'package:app_cosmetic/widgets/admin_widgets/comment/comment_view.dart';
import 'package:app_cosmetic/widgets/admin_widgets/orders/order_view_model.dart';
import 'package:app_cosmetic/widgets/navbar_user.dart';
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
        body: MainScreen(),
      ),
    );
  }
}
