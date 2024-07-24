import 'package:app_cosmetic/widgets/orders/order_detail.dart';
import 'package:app_cosmetic/widgets/orders/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderListScreen extends StatelessWidget {
  final int status;

  const OrderListScreen({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    final orderListViewModel = Provider.of<OrderListViewModel>(context);
    final List<Icon> _iconStatus = [
      const Icon(
        Icons.schedule,
        size: 50,
        color: Colors.blue,
      ),
      const Icon(
        Icons.local_shipping,
        size: 50,
        color: Colors.amber,
      ),
      const Icon(
        Icons.verified,
        size: 50,
        color: Colors.green,
      ),
      const Icon(
        Icons.cancel,
        size: 50,
        color: Colors.red,
      ),
    ];

    // Fetch orders by status when the widget is built
    orderListViewModel.fetchOrdersByStatus(status);

    return Scaffold(
      body: Consumer<OrderListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.orders.isEmpty) {
            return const Center(
                child: Text(
              'Không có đơn hàng nào ở đây',
              style: TextStyle(fontSize: 20),
            ));
          }

          return ListView.builder(
            itemCount: viewModel.orders.length,
            itemBuilder: (context, index) {
              final order = viewModel.orders[index];
              int orderStatus = order?.status ?? 0;
              orderStatus =
                  (orderStatus >= 1 && orderStatus <= 5) ? orderStatus - 1 : 0;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailPage(order: order, userId: order.userId,),
                    ),
                  );
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Color(0xFFE3E7D3),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            _iconStatus[orderStatus],
                            SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                '${order?.totalPrice ?? 0}',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${order?.id ?? ''}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined, size: 20),
                                  SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      '${order?.createdAt.hour}:${order?.createdAt.minute} - ${order?.createdAt.day}/${order?.createdAt.month}/${order?.createdAt.year}',
                                      style: TextStyle(fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        order.status != 3
                            ? TextButton(
                                onPressed: () async {
                                  final userId = order.userId;
                                  final orderId = order.id;
                                  if (order != null) {
                                    try {
                                      if (order.status == 1) {
                                        await orderListViewModel
                                            .updateOrderStatusToDelivering(
                                                orderId, userId);
                                      } else if (order.status == 2) {
                                        await orderListViewModel
                                            .updateOrderStatusToCompleted(
                                                orderId, userId);
                                      }
                                      // Refresh the list or navigate away
                                      orderListViewModel
                                          .fetchOrdersByStatus(status);
                                    } catch (e) {
                                      // Handle exception
                                      print('Error updating order status: $e');
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.skip_next_outlined,
                                  size: 50,
                                  color: Colors.green,
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
