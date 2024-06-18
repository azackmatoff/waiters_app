import 'package:waiters_app/app/data/models/order_model.dart';

abstract class OrderRepository {
  Future<void> placeOrder(OrderModel order);
  Future<List<OrderModel>> getOrders();
}
