import 'package:waiters_app/app/data/sources/local_sources/sql/slq_local_sources.dart';

import '../../domain/repositories/waiter_repository.dart';

import '../models/waiter_model.dart';

class WaiterRepositoryImpl implements WaiterRepository {
  final SqlLocalDataSource localDataSource;

  WaiterRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addWaiter(WaiterModel waiter) async {
    await localDataSource.insertWaiter(waiter);
  }

  @override
  Future<List<WaiterModel>> getWaiters() async {
    return await localDataSource.getAllWaiters();
  }
}
