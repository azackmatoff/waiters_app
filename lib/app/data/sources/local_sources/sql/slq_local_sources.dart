import 'dart:convert';

import 'package:waiters_app/app/common/constants/texts/app_texts.dart';
import 'package:waiters_app/app/data/models/menu_item.dart';
import 'package:waiters_app/app/data/models/order_model.dart';
import 'package:waiters_app/app/data/models/waiter_model.dart';
import 'package:waiters_app/core/services/data_services/sqf_lite_services/sqf_lite_services.dart';

class SqlLocalDataSource {
  final SqfLiteServices _sqlLiteServices;

  SqlLocalDataSource({required SqfLiteServices databaseHelper}) : _sqlLiteServices = databaseHelper;

  Future<int> insertWaiter(WaiterModel waiter) async {
    return await _sqlLiteServices.insert(AppTexts.waiters, waiter.toJson());
  }

  Future<List<WaiterModel>> getAllWaiters() async {
    final maps = await _sqlLiteServices.queryAll(AppTexts.waiter);

    return maps.map((i) => WaiterModel.fromJson(i)).toList();
  }

  Future<int> insertOrder(OrderModel order) async {
    final orderMap = order.toJson();
    orderMap[AppTexts.drinks] = jsonEncode(order.drinks?.map((drink) => drink.toJson()).toList()); // Encode as JSON
    orderMap[AppTexts.firstMeals] = jsonEncode(order.firstMeals?.map((firstMeal) => firstMeal.toJson()).toList());
    orderMap[AppTexts.mainMeals] = jsonEncode(order.mainMeals?.map((mainMeal) => mainMeal.toJson()).toList());
    orderMap[AppTexts.totalPrice] = order.totalPrice?.toInt() ?? 0; // Convert to int
    return await _sqlLiteServices.insert(AppTexts.orders, orderMap);
  }

  Future<List<OrderModel>> getAllOrders() async {
    final maps = await _sqlLiteServices.queryAll(AppTexts.orders);

    return maps.map((map) {
      return OrderModel.fromJson(map).copyWith(
        drinks: (jsonDecode(map[AppTexts.drinks] ?? '[]') as List).map((item) => MenuItem.fromJson(item)).toList(),
        firstMeals:
            (jsonDecode(map[AppTexts.firstMeals] ?? '[]') as List).map((item) => MenuItem.fromJson(item)).toList(),
        mainMeals:
            (jsonDecode(map[AppTexts.mainMeals] ?? '[]') as List).map((item) => MenuItem.fromJson(item)).toList(),
      );
    }).toList();
  }
}
