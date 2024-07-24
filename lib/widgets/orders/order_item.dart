import 'package:app_cosmetic/services/order_service.dart';
import 'package:app_cosmetic/widgets/orders/order_detail.dart';
import 'package:app_cosmetic/widgets/orders/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/order.model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late OrderListViewModel orderListViewModel;
  late OrderService orderService;
  late String statusText;
  late Color statusColor;
  Widget? actionButton;
  String? userId;

  @override
  void initState() {
    super.initState();
    orderListViewModel =
        Provider.of<OrderListViewModel>(context, listen: false);
    orderService = OrderService();
    _initializeOrderStatus();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }

  void _initializeOrderStatus() {
    switch (widget.order.status) {
      case 1:
        statusText = 'Đang chờ xác nhận';
        statusColor = Colors.orange;
        actionButton = TextButton(
          onPressed: () async {
            try {
              await orderListViewModel.cancelOrderDetail(
                  widget.order.id, widget.order.userId);
              orderService.fetchOrdersUserByStatus(
                  widget.order.userId, widget.order.status);
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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OrderDetailPage(order: widget.order, userId: userId),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#${widget.order.id}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text('${widget.order.products.length} sản phẩm',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Giảm giá:'),
                  Text('${widget.order.priceSale}đ'),
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
                    '${widget.order.totalPrice}đ',
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
                  if (actionButton != null) actionButton!,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
