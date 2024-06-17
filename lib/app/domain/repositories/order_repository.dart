import 'package:waiters_app/app/data/models/order_model.dart';

abstract class OrderRepository {
  Future<void> addOrder(OrderModel order);
  Future<List<OrderModel>> getOrders();
}
