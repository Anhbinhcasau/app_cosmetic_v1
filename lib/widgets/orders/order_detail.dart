import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/order.model.dart';
import 'package:app_cosmetic/widgets/orders/order_view_model.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  final Order? order;

  const OrderDetailPage({required this.order, Key? key}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
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
              order!.status != 3
                  ? Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: order.status == 1
                              ? Colors.blue
                              : Colors.amber,
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
                                  builder: (context) => OrderDetailPage(order: order),
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
                  : const Center(
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
                  'Ngày tạo đơn: ${order?.createdAt}',
                  style: const TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  'Ngày nhận: ${order?.updatedAt}',
                  style: const TextStyle(fontSize: 17, color: AppColors.textHint),
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
                  style: const TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  '(+84)${order.phoneNumber}',
                  style: const TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text(
                  order?.address ?? '',
                  style: const TextStyle(fontSize: 17, color: AppColors.textHint),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(color: AppColors.primaryColor, thickness: 2),
              ...order.products.map((product) {
                return Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Image.network(
                        product.image,
                        width: 80.0,
                        height: 90.0,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productId,
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              product.typeProduct,
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text('x${product.quantity}'),
                          ],
                        ),
                      ),
                      Text(
                        '${product.price}  ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              const Divider(color: AppColors.primaryColor, thickness: 2),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Phụ phí:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${order?.priceSale}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Giảm giá:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${order?.percentSale}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Thành tiền:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '${order?.totalPrice}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}