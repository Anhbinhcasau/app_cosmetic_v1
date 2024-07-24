import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/screen/admin/products/admin_product.dart';
import 'package:app_cosmetic/screen/user/Product/product_item.dart';
import 'package:app_cosmetic/screen/user/Product/product_view.dart';
import 'package:app_cosmetic/screen/user/Product/productdetail.dart';
import 'package:app_cosmetic/services/product_service.dart';
import 'package:app_cosmetic/widgets/appbar_home.dart';
import 'package:app_cosmetic/widgets/brand_widget.dart';
import 'package:app_cosmetic/screen/user/categories/category_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> bannerImages = [
    'https://i.pinimg.com/564x/fd/eb/21/fdeb21f500f0305214d74f1dee813c7d.jpg',
    'https://i.pinimg.com/564x/01/cc/05/01cc0529b91c88759bcc9e98064458f8.jpg',
    'https://i.pinimg.com/564x/78/bd/88/78bd88af7a5e24fc9cdbebbbdbbf2c2a.jpg',
    'https://i.pinimg.com/564x/76/10/ab/7610ab20bec83a39dad2a27cc49cb73c.jpg',
  ];

  List<Product?> allProducts = [];
  List<Product?> filteredProducts = [];
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productListViewModel =
          Provider.of<ProductListViewModel>(context, listen: false);
      productListViewModel.getProductList();
    });

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _removeOverlay();
      }
    });
  }

  void _filterProducts(String query) {
    final productListViewModel =
        Provider.of<ProductListViewModel>(context, listen: false);
    setState(() {
      if (query.isEmpty) {
        filteredProducts = List.from(productListViewModel.products);
        _removeOverlay();
      } else {
        filteredProducts = productListViewModel.products.where((product) {
          return product!.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
        _showOverlay();
      }
    });
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 32,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, 56.0),
          child: Material(
            elevation: 4.0,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: filteredProducts.map((product) {
                return ListTile(
                  leading: product!.imageBase.isNotEmpty
                      ? Image.network(
                          product.imageBase[0],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.image, size: 50),
                  title: Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetail(productId: product.idPro ?? ''),
                      ),
                    );
                    // Handle product selection
                    print('Selected: ${product.name}');
                    _focusNode.unfocus();
                    _removeOverlay();
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productListViewModel = Provider.of<ProductListViewModel>(context);
    allProducts = productListViewModel.products.cast<Product>();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (_overlayEntry != null && _focusNode.hasFocus) {
          _focusNode.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: AppBarHome(),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CompositedTransformTarget(
                  link: _layerLink,
                  child: TextField(
                    focusNode: _focusNode,
                    onChanged: _filterProducts,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm sản phẩm',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  enlargeCenterPage: true,
                ),
                items: bannerImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              BrandWidget(),
              const SizedBox(height: 10),
              CategoryWidget(),
              SizedBox(
                height: 20,
              ),
              Text(
                'Product Collection',
                style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ProductItem(),
            ],
          ),
        ),
      ),
    );
  }
}
