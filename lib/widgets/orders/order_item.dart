import 'package:app_cosmetic/services/order_service.dart';
import 'package:app_cosmetic/widgets/orders/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/order.model.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderListViewModel = Provider.of<OrderListViewModel>(context);
    OrderService orderService = OrderService();
    String statusText;
    Color statusColor;
    Widget? actionButton;

    switch (order.status) {
      case 1:
        statusText = 'Đang chờ xác nhận';
        statusColor = Colors.orange;
        actionButton = TextButton(
          onPressed: () async {
            try {
              await orderListViewModel.cancelOrderDetail(
                  order.id, order.userId);
              orderService.fetchOrdersUserByStatus(order.userId, order.status);
            } catch (e) {
              // Handle exception
              print('Error updating order status: $e');
            }
          },
          child: Text(
            'Hủy đơn hàng',
            style: TextStyle(color: Colors.white),
          ),
          style: TextButton.styleFrom(backgroundColor: Colors.red),
        );
        break;
      case 2:
        statusText = 'Đang giao hàng';
        statusColor = Colors.blue;
        break;
      case 3:
        statusText = 'Đã hoàn thành';
        statusColor = Colors.green;
        break;
      case 4:
        statusText = 'Đơn bị hủy';
        statusColor = Colors.red;
        break;
      default:
        statusText = 'Không xác định';
        statusColor = Colors.grey;
    }

    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#${order.id}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${order.products.length} sản phẩm',
                    style: TextStyle(fontSize: 18)),
                Text('${order.totalPrice}đ'),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Giảm giá:'),
                Text('${order.priceSale}đ'),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng tiền:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${order.totalPrice}đ',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 18,
                    color: statusColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                if (actionButton != null) actionButton,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
