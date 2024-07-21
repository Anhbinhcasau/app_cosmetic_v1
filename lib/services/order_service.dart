import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/widgets/orders/order_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:app_cosmetic/model/order.model.dart';

class OrderService {
  Future<List<Order>> fetchOrdersByStatus(int status) async {
    OrderListViewModel orderListViewModel = OrderListViewModel();
    try {
      final response = await http.get(Uri.parse('${Api.DB_URI}/orderDetail/getAll'));
      if (response.statusCode == 200) {
        // Parse JSON response
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Order> orders =
            jsonResponse.map((item) => Order.fromJson(item)).toList();

        List<Order> filteredOrders =
          orders.where((order) => order.status == status).toList();

        orderListViewModel.orders = orders;
        orderListViewModel.notifyListeners();

        print('done $orders');
        return filteredOrders;
      } else {
        print('Failed to load order list: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }
}
