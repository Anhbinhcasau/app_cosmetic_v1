import 'package:app_cosmetic/screen/admin/brands/brand_view_model.dart';
import 'package:app_cosmetic/screen/user/brand/productlistbrand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Brandlist extends StatefulWidget {
  const Brandlist({super.key});

  @override
  State<Brandlist> createState() => _BrandlistState();
}

class _BrandlistState extends State<Brandlist> {
  @override
  Widget build(BuildContext context) {
    final brandListViewModel = Provider.of<BrandListViewModel>(context);
    brandListViewModel.fetchBrandsList();
    final brands = brandListViewModel.brands;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thương hiệu'),
      ),
      body: brands == null
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: brands.length,
              itemBuilder: (ctx, i) => BrandItem(
                brandImage: brands[i]?.image ?? '',
                brandName: brands[i]?.name ?? '',
              ),
            ),
    );
  }
}

class BrandItem extends StatelessWidget {
  final String brandImage;
  final String brandName;

  const BrandItem({
    Key? key,
    required this.brandImage,
    required this.brandName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Productlistbrand(brandName: brandName),
                  ),
                );
              },
              child: Image.network(
                brandImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              brandName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
