// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      tableNumber: (json['tableNumber'] as num).toInt(),
      waiterId: (json['waiterId'] as num).toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      drinks: (json['drinks'] as List<dynamic>?)
          ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstMeals: (json['firstMeals'] as List<dynamic>?)
          ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainMeals: (json['mainMeals'] as List<dynamic>?)
          ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tableNumber': instance.tableNumber,
      'drinks': instance.drinks?.map((e) => e.toJson()).toList(),
      'firstMeals': instance.firstMeals?.map((e) => e.toJson()).toList(),
      'mainMeals': instance.mainMeals?.map((e) => e.toJson()).toList(),
      'waiterId': instance.waiterId,
      'totalPrice': instance.totalPrice,
    };
