import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/model/order.model.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<List<Order>> fetchOrders() async {
    final response =
        await http.get(Uri.parse('${Api.DB_URI}/orderDetail/getAll'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Order> orders =
          data.map((orderJson) => Order.fromJson(orderJson)).toList();
      return orders;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<List<Order>> fetchOrdersByStatus(int status) async {
    List<Order> allOrders = await fetchOrders();
    return allOrders.where((order) => order.status == status).toList();
  }

  Future<List<Order>> fetchOrderHistory(String userId) async {
    final response =
        await http.get(Uri.parse('${Api.DB_URI}/orderDetail/$userId'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Order> orders =
          body.map((dynamic item) => Order.fromJson(item)).toList();
      return orders.where((order) => order.userId == userId).toList();
    } else {
      throw Exception('Failed to load order history');
    }
  }

  Future<List<Order>> fetchOrdersUserByStatus(String userId, int status) async {
    List<Order> allOrders = await fetchOrderHistory(userId);
    return allOrders.where((order) => order.status == status).toList();
  }

  Future<Order> fetchOrderDetail(String orderId) async {
    final response =
        await http.get(Uri.parse('${Api.DB_URI}/orderDetail/$orderId'));

    if (response.statusCode == 200) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load order detail');
    }
  }

  Future<Order> updateOrderStatusToCompleted(
      String orderId, String userId) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/orderDetail/completed'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'userId': userId,
        '_id': orderId,
      }),
    );

    if (response.statusCode == 201) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update order status to completed');
    }
  }

  Future<Order> updateOrderStatusToDelivering(
      String orderId, String userId) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/orderDetail/delivering'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'userId': userId,
        '_id': orderId,
      }),
    );

    if (response.statusCode == 201) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update order status to delivering');
    }
  }

  // Cancel order
  Future<Order> cancelOrderDetail(String orderId, String userId) async {
    final response = await http.post(
      Uri.parse('${Api.DB_URI}/orderDetail/cancel'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'userId': userId,
        '_id': orderId,
      }),
    );

    if (response.statusCode == 201) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to cancel order detail');
    }
  }
}
