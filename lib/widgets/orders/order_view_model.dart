import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/order.model.dart';
import 'package:app_cosmetic/services/order_service.dart';

class OrderListViewModel extends ChangeNotifier {
  List<Order?> orders = [];
  final OrderService _orderService = OrderService();

  Future<void> fetchOrdersByStatus(int status) async {
    try {
      orders = await _orderService.fetchOrdersByStatus(status);
      notifyListeners();
    } catch (e) {
      print('Error fetching orders by status: $e');
      // Handle error if needed
    }
  }
}