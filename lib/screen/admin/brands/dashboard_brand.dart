import 'package:app_cosmetic/widgets/admin_widgets/brands/brand.dart';
import 'package:flutter/material.dart';

class DashboardBrand extends StatefulWidget {
  const DashboardBrand({super.key});

  @override
  State<DashboardBrand> createState() => _DashboardBrandState();
}

class _DashboardBrandState extends State<DashboardBrand> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListBrand(), 
    );
  }
}
