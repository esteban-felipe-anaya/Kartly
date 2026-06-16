import '../../core/network/api_guard.dart';
import '../api/kartly_api.dart';
import '../models/order.dart';

class OrderRepository {
  OrderRepository(this._api);

  final KartlyApi _api;

  Future<Order> place(Map<String, dynamic> body) => guard(() => _api.createOrder(body));

  Future<List<Order>> fetchAll() => guard(() => _api.getOrders());

  Future<Order> fetchOne(String id) => guard(() => _api.getOrder(id));
}
