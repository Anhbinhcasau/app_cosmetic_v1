import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/order.model.dart';
import 'package:app_cosmetic/model/product/product.model.dart';
import 'package:app_cosmetic/services/product_service.dart';
import 'package:app_cosmetic/services/user_service.dart';
import 'package:app_cosmetic/widgets/orders/order_view_model.dart';
import 'package:app_cosmetic/widgets/products/product_order_detail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OrderDetailPage extends StatefulWidget {
  final Order? order;
  final String? userId;

  const OrderDetailPage({required this.order, required this.userId, Key? key})
      : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  String? userId;
  String? role;
  Map<String, Product> productDetails = {};

  @override
  void initState() {
    super.initState();
    _loadUser();
    _fetchProductDetails();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    final user = await UserServices.getDetail(userId!);
    setState(() {
      role = user!.userName;
    });
  }

  Future<void> _fetchProductDetails() async {
    for (var product in widget.order!.products) {
      final productDetail =
          await ProductService().getProductDetail(product.productId);
      setState(() {
        productDetails[product.productId] = productDetail;
      });
    }
  }

  OrderListViewModel orderListViewModel = OrderListViewModel();

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'CHI TIẾT ĐƠN HÀNG',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mã đơn: ${order?.id}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(
                    Icons.local_shipping,
                    size: 25,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Thông tin vận chuyển',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Padding(
                padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  'Nhanh',
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.textHint,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              const Padding(
                padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  'SPX Express - SPXVN20212025',
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.textHint,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              if (role == 'admin' && order!.status != 3)
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          order.status == 1 ? Colors.blue : Colors.amber,
                    ),
                    onPressed: () async {
                      final userId = order.userId;
                      final orderId = order.id;
                      if (order != null) {
                        try {
                          if (order.status == 1) {
                            await orderListViewModel
                                .updateOrderStatusToDelivering(orderId, userId);
                          } else if (order.status == 2) {
                            await orderListViewModel
                                .updateOrderStatusToCompleted(orderId, userId);
                          }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailPage(order: order, userId: userId),
                            ),
                          );
                        } catch (e) {
                          // Handle exception
                          print('Error updating order status: $e');
                        }
                      }
                    },
                    child: Text(
                      order.status == 1 ? 'Xác nhận' : 'Giao hàng',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                )
              else if (order!.status == 3)
                const Center(
                  child: Text(
                    'Đơn hàng đã hoàn thành',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.green,
                    ),
                  ),
                ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  'Ngày tạo đơn: ${order.createdAt}',
                  style:
                      const TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  'Ngày nhận: ${order.updatedAt}',
                  style:
                      const TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              const SizedBox(height: 16.0),
              const Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 25,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Địa chỉ nhận hàng',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  order.fullName,
                  style:
                      const TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  '(+84)${order.phoneNumber}',
                  style:
                      const TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  order.address,
                  style:
                      const TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              const SizedBox(height: 16.0),
              const Row(
                children: [
                  Icon(
                    Icons.shopping_bag,
                    size: 25,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Chi tiết đơn hàng',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: ListView.builder(
                  itemCount: order.products.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product = order.products[index];
                    final productDetail = productDetails[product.productId];
                    return ListTile(
                      leading: productDetail != null
                          ? Image.network(productDetail.imageBase.first)
                          : const CircularProgressIndicator(),
                      title: Text(
                        productDetail != null
                            ? productDetail.name.length > 20
                                ? '${productDetail.name.substring(0, 20)}...'
                                : productDetail.name
                            : 'Loading...',
                        style: const TextStyle(
                            fontSize: 20, color: AppColors.textHint),
                      ),
                      subtitle: Text(
                        '${product.quantity} x ${product.price}đ',
                        style: const TextStyle(
                            fontSize: 17, color: AppColors.textHint),
                      ),
                      trailing: Text(
                        '${product.quantity * product.price}đ',
                        style: const TextStyle(
                            fontSize: 17, color: AppColors.textHint),
                      ),
                      onTap: productDetail != null
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                      product: productDetail),
                                ),
                              );
                            }
                          : null,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              const Row(
                children: [
                  Icon(
                    Icons.payment,
                    size: 25,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Thông tin thanh toán',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tổng tiền hàng:',
                      style: TextStyle(fontSize: 17, color: AppColors.textHint),
                    ),
                    Text(
                      '${order.totalPrice}đ',
                      style: const TextStyle(
                          fontSize: 17, color: AppColors.textHint),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Giảm giá:',
                      style: TextStyle(fontSize: 17, color: AppColors.textHint),
                    ),
                    Text(
                      '${order.priceSale}đ',
                      style: const TextStyle(
                          fontSize: 17, color: AppColors.textHint),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tổng tiền thanh toán:',
                      style: TextStyle(fontSize: 17, color: AppColors.textHint),
                    ),
                    Text(
                      '${order.totalPrice - order.priceSale}đ',
                      style: const TextStyle(
                          fontSize: 17, color: AppColors.textHint),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
