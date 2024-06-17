import 'package:waiters_app/app/data/models/order_model.dart';
import 'package:waiters_app/app/data/sources/local_sources/sql/slq_local_sources.dart';
import 'package:waiters_app/app/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final SqlLocalDataSource localDataSource;

  OrderRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addOrder(OrderModel order) async {
    await localDataSource.insertOrder(order);
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    return await localDataSource.getAllOrders();
  }
}
