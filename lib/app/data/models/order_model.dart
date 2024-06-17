import 'package:json_annotation/json_annotation.dart';

import 'package:waiters_app/app/data/models/menu_item.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  final int id;
  final int tableNumber;
  final List<MenuItem>? drinks;
  final List<MenuItem>? firstMeals;
  final List<MenuItem>? mainMeals;
  final int waiterId;
  final int? totalPrice;

  OrderModel({
    required this.id,
    required this.tableNumber,
    required this.waiterId,
    this.totalPrice,
    this.drinks,
    this.firstMeals,
    this.mainMeals,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  factory OrderModel.initial() {
    return OrderModel(
      id: 0, // Or whatever default ID you prefer
      tableNumber: 0, // Or a default table number
      waiterId: 0, // Or a default waiter ID
      totalPrice: 0, // Or null if you want
      drinks: [],
      firstMeals: [],
      mainMeals: [],
    );
  }

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderModel copyWith({
    int? id,
    int? tableNumber,
    int? waiterId,
    int? totalPrice,
    List<MenuItem>? drinks,
    List<MenuItem>? firstMeals,
    List<MenuItem>? mainMeals,
  }) {
    return OrderModel(
      id: id ?? this.id,
      tableNumber: tableNumber ?? this.tableNumber,
      waiterId: waiterId ?? this.waiterId,
      totalPrice: totalPrice ?? this.totalPrice,
      drinks: drinks ?? this.drinks,
      firstMeals: firstMeals ?? this.firstMeals,
      mainMeals: mainMeals ?? this.mainMeals,
    );
  }
}
