import 'dart:io';
import 'package:app_cosmetic/model/brand.model.dart';
import 'package:app_cosmetic/screen/admin/brands/brand_view_model.dart';
import 'package:app_cosmetic/screen/admin/brands/screen_brand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListBrand extends StatefulWidget {
  const ListBrand({super.key});

  @override
  State<ListBrand> createState() => _ListBrandState();
}

class _ListBrandState extends State<ListBrand> {
  BrandListViewModel brandListViewModel = BrandListViewModel();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    brandListViewModel.fetchBrandsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF13131A),
        title: const Text(
          '# THƯƠNG HIỆU',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => brandListViewModel,
          child: body(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BrandScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
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
          // Check if brand or brand.image is null
          if (brand == null || brand.image == null) {
            return SizedBox();
          }

          Widget brandImage;
          if (brand.image!.startsWith('http')) {
            // Network image
            brandImage = Image.network(
              brand.image!,
              fit: BoxFit.cover,
            );
          } else {
            // Local file image
            brandImage = Image.file(
              File(brand.image!),
              fit: BoxFit.cover,
            );
          }

          return GestureDetector(
            onTap: () {
              // Handle the tap event here
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: brandImage,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brand.name ?? '',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BrandScreen(brand: brand),
                            ),
                          );
                        },
                        child: Icon(Icons.edit),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showDeleteDialog(context, brand);
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

  void _showDeleteDialog(BuildContext context, Brand brand) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Xóa Brand'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bạn chắc chắn muốn xóa thương hiệu này?',
                style: TextStyle(color: Colors.amber),
              ),
              SizedBox(height: 16),
              Text('ID: ${brand.id}', style: TextStyle(fontSize: 20)),
              Text('Name: ${brand.name}', style: TextStyle(fontSize: 20)),
              _buildBrandImage(brand), // Display brand image based on type
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy', style: TextStyle(fontSize: 20)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                // Perform the deletion and handle the result
                bool isDeleted = await Provider.of<BrandListViewModel>(context,
                        listen: false)
                    .deleteBrand(brand.id);
                if (isDeleted) {
                  _scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(content: Text('Brand deleted successfully')),
                  );
                } else {
                  _scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(content: Text('Failed to delete brand')),
                  );
                }
              },
              child: Text('Xác nhận', style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBrandImage(Brand brand) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
        child: brand.image.startsWith('http')
            ? Image.network(
                brand.image,
                fit: BoxFit.cover,
              )
            : Image.file(
                File(brand.image),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
