import 'package:app_cosmetic/widgets/admin_widgets/categories/category.dart';
import 'package:flutter/material.dart';

class DashboardCategory extends StatefulWidget {
  const DashboardCategory({super.key});

  @override
  State<DashboardCategory> createState() => _DashboardCategoryState();
}

class _DashboardCategoryState extends State<DashboardCategory> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListCategory(), 
    );
  }
}
