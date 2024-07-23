import 'package:app_cosmetic/widgets/navbar_user.dart';
import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/order.model.dart';
import 'package:app_cosmetic/services/order_service.dart';
import 'package:app_cosmetic/widgets/orders/order_item.dart';

class ProcessOrder extends StatefulWidget {
  final String userId;

  const ProcessOrder({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProcessOrder> createState() => _ProcessOrderState();
}

class _ProcessOrderState extends State<ProcessOrder> {
  final OrderService _orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "ĐƠN HÀNG",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
              },
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.green,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.hourglass_empty,
                  color: Colors.blue,
                  size: 30,
                )),
                Tab(
                    icon: Icon(
                  Icons.local_shipping,
                  color: Colors.amber,
                  size: 30,
                )),
                Tab(
                    icon: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                )),
                Tab(
                    icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 30,
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildOrderListView(1), // Chờ xác nhận
              _buildOrderListView(2), // Đang giao hàng
              _buildOrderListView(3), // Thành công
              _buildOrderListView(4), // Hoàn thành
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderListView(int status) {
    return FutureBuilder<List<Order>>(
      future: _orderService.fetchOrdersUserByStatus(widget.userId, status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Không có đơn hàng'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return OrderItem(order: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}
