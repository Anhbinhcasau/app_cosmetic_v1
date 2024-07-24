import 'package:flutter/material.dart';
import 'package:app_cosmetic/model/order.model.dart';
import 'package:app_cosmetic/services/order_service.dart';

class OrderListViewModel extends ChangeNotifier {
  List<Order> orders = [];
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

   Future<List<Order>> fetchOrderHistory(String userId) async {
    try {
      final fetchedOrders = await _orderService.fetchOrderHistory(userId);
      orders = fetchedOrders;
      notifyListeners();
      return fetchedOrders;
    } catch (e) {
      print('Error fetching order history: $e');
      // Handle error if needed
      return [];
    }
  }

  Future<Order> fetchOrderDetail(String orderId) async {
    try {
      return await _orderService.fetchOrderDetail(orderId);
    } catch (e) {
      print('Error fetching order detail: $e');
      // Handle error if needed
      throw e;
    }
  }

  Future<void> updateOrderStatusToCompleted(String orderId, String userId) async {
    try {
      final updatedOrder = await _orderService.updateOrderStatusToCompleted(orderId, userId);
      // Optionally update the local list of orders
      orders = orders.map((order) => order.id == orderId ? updatedOrder : order).toList();
      notifyListeners();
    } catch (e) {
      print('Error updating order status to completed: $e');
      // Handle error if needed
    }
  }

  Future<void> updateOrderStatusToDelivering(String orderId, String userId) async {
    try {
      final updatedOrder = await _orderService.updateOrderStatusToDelivering(orderId, userId);
      // Optionally update the local list of orders
      orders = orders.map((order) => order.id == orderId ? updatedOrder : order).toList();
      notifyListeners();
    } catch (e) {
      print('Error updating order status to delivering: $e');
      // Handle error if needed
    }
  }

  Future<void> cancelOrderDetail(String orderId, String userId) async {
    try {
      final updatedOrder = await _orderService.cancelOrderDetail(orderId, userId);
      // Optionally update the local list of orders
      orders = orders.map((order) => order.id == orderId ? updatedOrder : order).toList();
      notifyListeners();
    } catch (e) {
      print('Error canceling order detail: $e');
      // Handle error if needed
    }
  }
}