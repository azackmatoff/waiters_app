import 'package:waiters_app/app/data/models/waiter_model.dart';

abstract class WaiterRepository {
  Future<void> addWaiter(WaiterModel waiter);
  Future<List<WaiterModel>> getWaiters();
}
