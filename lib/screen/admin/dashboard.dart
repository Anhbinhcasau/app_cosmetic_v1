import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/services/order_service.dart';
import 'package:app_cosmetic/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class DashboardMenu extends StatefulWidget {
  const DashboardMenu({super.key});

  @override
  State<DashboardMenu> createState() => _DashboardMenuState();
}

class _DashboardMenuState extends State<DashboardMenu> {
  int completedOrders = 0;
  int totalCompletedOrderPrice = 0;
  int pendingOrders = 0;
  int waittingOrder = 0;
  int canceledOrders = 0;
  int totalUsers = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  String _formatMoney(int amount) {
    final formatter = NumberFormat.decimalPattern('vi_VN');
    return formatter.format(amount);
  }

  Future<void> _loadData() async {
    await OrderService().fetchOrdersByStatus(3).then((orders) {
      setState(() {
        completedOrders = orders.length;
        totalCompletedOrderPrice =
            orders.fold(0, (sum, order) => sum + order.totalPrice.toInt());
      });
    });

    await OrderService().fetchOrdersByStatus(1).then((orders) {
      setState(() {
        waittingOrder += orders.length;
      });
    });

    await OrderService().fetchOrdersByStatus(2).then((orders) {
      setState(() {
        pendingOrders += orders.length;
      });
    });

    await OrderService().fetchOrdersByStatus(4).then((orders) {
      setState(() {
        canceledOrders = orders.length;
      });
    });

    await OrderService().fetchOrdersByStatus(3).then((orders) {
      setState(() {
        completedOrders = orders.length;
      });
    });

    await UserServices.fetchUserList().then((users) {
      setState(() {
        totalUsers = users.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textHint,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tổng quan',
                style: TextStyle(
                    color: AppColors.text,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoCard(
                      'Doanh thu',
                      '${_formatMoney(totalCompletedOrderPrice)} đ',
                      Colors.green),
                  _buildInfoCard('Đơn hàng', '${pendingOrders + waittingOrder}',
                      Colors.green),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoCard('Đơn hủy', '$canceledOrders', Colors.red),
                  _buildInfoCard('Người dùng', '$totalUsers', Colors.green),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Trạng thái đơn hàng',
                style: TextStyle(
                    color: AppColors.text,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Container(
                height: 300,
                child: PieChart(
                  swapAnimationCurve: Curves.bounceIn,
                  PieChartData(
                    sections: _getPieChartSections(),
                    sectionsSpace: 2,
                    centerSpaceRadius: 60,
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _getPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: waittingOrder.toDouble(),
        radius: 100,
        title: 'Chờ xác nhận',
        titleStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: completedOrders.toDouble(),
        radius: 100,
        title: 'Hoàn thành',
        titleStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: pendingOrders.toDouble(),
        radius: 100,
        title: 'Đang giao',
        titleStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: canceledOrders.toDouble(),
        radius: 100,
        title: 'Đơn hủy',
        titleStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  Widget _buildInfoCard(String title, String value, Color percentageColor) {
    return Expanded(
      child: Card(
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                    color: percentageColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
