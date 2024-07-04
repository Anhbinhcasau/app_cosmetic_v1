import 'package:app_cosmetic/model/brand.model.dart';
import 'package:app_cosmetic/screen/admin/brands/edit_brand.dart';
import 'package:app_cosmetic/screen/admin/brands/add_brand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_cosmetic/widgets/admin_widgets/brands/brand_view_model.dart';

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
      appBar: AppBar(
          centerTitle: true,
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
              builder: (context) => AddBrandScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green, // You can customize the color
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BrandEditScreen(brand: brand!),
                            ),
                          );
                        },
                        child: Icon(Icons.edit),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showDeleteDialog(context, brand!);
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
              Text('Name: ${brand.brand}', style: TextStyle(fontSize: 20)),
              Image.network(
                brand.image,
                height: 200,
              ),
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
              onPressed: () {
                // Handle the delete action here
                Navigator.of(context).pop();
              },
              child: Text('Xác nhận', style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }
}