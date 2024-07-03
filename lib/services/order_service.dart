import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:app_cosmetic/model/order.model.dart';

class OrderService {
  // Future<List<Order>> fetchOrders() async {
  //   try {
  //     // Đọc nội dung của tệp từ tài nguyên nội bộ
  //     final response = await rootBundle.loadString('assets/order.js');

  //     // Giải mã dữ liệu JSON
  //     List<dynamic> data = json.decode(response);

  //     // Chuyển đổi dữ liệu thành danh sách các đối tượng Order
  //     List<Order> orders = data.map((item) => Order.fromJson(item)).toList();

  //     return orders;
  //   } catch (e) {
  //     throw Exception('Failed to load orders: $e');
  //   }
  // }

  Future<List<Order>> fetchOrdersByStatus(int status) async {
    try {
      // Đọc nội dung của tệp từ tài nguyên nội bộ
      final response = await rootBundle.loadString('assets/order.js');

      // Giải mã dữ liệu JSON
      List<dynamic> data = json.decode(response);

      // Chuyển đổi dữ liệu thành danh sách các đối tượng Order
      List<Order> orders = data.map((item) => Order.fromJson(item)).toList();

      // Lọc các đơn hàng theo status
      List<Order> filteredOrders =
          orders.where((order) => order.status == status).toList();

      return filteredOrders;
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }
}
