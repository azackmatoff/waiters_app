import 'package:get_it/get_it.dart';
import 'package:waiters_app/app/data/repositories/order_repository_impl.dart';
import 'package:waiters_app/app/data/repositories/waiter_repository_impl.dart';
import 'package:waiters_app/app/data/sources/local_sources/sql/slq_local_sources.dart';
import 'package:waiters_app/app/domain/repositories/order_repository.dart';
import 'package:waiters_app/app/domain/repositories/waiter_repository.dart';
import 'package:waiters_app/core/services/data_services/sqf_lite_services/sqf_lite_services.dart';

final sl = GetIt.instance;

/// init DI modules
void init() {
  _coreServices();
  _dataSources();
  _repositories();
}

void _coreServices() {
  sl.registerLazySingleton<SqfLiteServices>(() => SqfLiteServices.instance);
}

void _dataSources() {
  sl.registerLazySingleton<SqlLocalDataSource>(() => SqlLocalDataSource(databaseHelper: sl.get<SqfLiteServices>()));
}

void _repositories() {
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      localDataSource: sl.get<SqlLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<WaiterRepository>(
    () => WaiterRepositoryImpl(
      localDataSource: sl.get<SqlLocalDataSource>(),
    ),
  );
}
