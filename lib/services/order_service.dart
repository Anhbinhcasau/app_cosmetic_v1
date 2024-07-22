import 'dart:convert';
import 'package:app_cosmetic/data/config.app.dart';
import 'package:app_cosmetic/widgets/orders/order_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:app_cosmetic/model/order.model.dart';

class OrderService {

  Future<List<Order>> fetchOrdersByStatus(int status) async {
    OrderListViewModel orderListViewModel = OrderListViewModel();
    try {
      final response =
          await http.get(Uri.parse('${Api.DB_URI}/orderDetail/getAll'));

      if (response.statusCode == 200) {
        // Phân tích JSON response
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        print(response.body);
        // Chuyển đổi JSON thành danh sách các đơn hàng
        List<Order> orders =
            jsonResponse.map((item) => Order.fromJson(item)).toList();
        print('Danh sách đơn hàng: $orders');

        // Lọc danh sách đơn hàng theo trạng thái
        List<Order> filteredOrders =
            orders.where((order) => order.status == status).toList();

        // Cập nhật danh sách đơn hàng vào OrderListViewModel
        orderListViewModel.orders = orders;
        orderListViewModel.notifyListeners();

        print('Danh sách đơn hàng sau khi lọc: $filteredOrders');
        return filteredOrders;
      } else {
        print('Không thể tải danh sách đơn hàng: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      throw Exception('Lỗi khi tải đơn hàng: $e');
    }
  }
}
