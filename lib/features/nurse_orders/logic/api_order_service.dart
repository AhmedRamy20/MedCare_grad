import 'package:dio/dio.dart';
import 'package:medical_app/features/nurse_orders/data/order_model.dart';

class OrderService {
  final Dio _dio = Dio();

  Future<List<Order>> fetchOrders() async {
    try {
      Response response = await _dio
          .get('http://DawayaHealthCare70.somee.com/Nurse/Get-Appointment');
      List<Order> orders = (response.data as List)
          .map((order) => Order.fromJson(order))
          .toList();
      return orders;
    } catch (e) {
      throw Exception('Failed to load orders');
    }
  }
}
